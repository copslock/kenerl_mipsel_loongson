Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2013 21:42:40 +0100 (CET)
Received: from vms173001pub.verizon.net ([206.46.173.1]:38400 "EHLO
        vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827610Ab3BLUmWNlrhZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Feb 2013 21:42:22 +0100
Received: from wf-rch.minyard.home ([unknown] [173.74.121.95])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI4001PXK5S7P35@vms173001.mailsrvcs.net>; Tue,
 12 Feb 2013 14:41:57 -0600 (CST)
Received: from i.minyard.home (i2.minyard.home [192.168.27.116])
        by wf-rch.minyard.home (Postfix) with ESMTP id 1F6401F957; Tue,
 12 Feb 2013 14:41:50 -0600 (CST)
Received: by i.minyard.home (Postfix, from userid 1000) id A625F80D94; Tue,
 12 Feb 2013 14:41:51 -0600 (CST)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] mips: reserve elfcorehdr
Date:   Tue, 12 Feb 2013 14:41:48 -0600
Message-id: <1360701708-21371-3-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.7.4.1
In-reply-to: <1360701708-21371-1-git-send-email-minyard@acm.org>
References: <1360701708-21371-1-git-send-email-minyard@acm.org>
X-archive-position: 35737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Corey Minyard <cminyard@mvista.com>

/proc/vmcore wasn't showing up in kdump kernels.  It turns that that
for Octeon, the memory used by elfcorehdr wasn't being set aside
properly and it was getting clobbered before /proc/vmcore could get
it.  So reserve the memory if it shows up in a memory area managed
by the kernel.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: David Daney  <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/kernel/setup.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 5346250..795f437 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -480,6 +480,37 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+#ifdef CONFIG_PROC_VMCORE
+unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
+static int __init early_parse_elfcorehdr(char *p)
+{
+	int i;
+
+	setup_elfcorehdr = memparse(p, &p);
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long start = boot_mem_map.map[i].addr;
+		unsigned long end = (boot_mem_map.map[i].addr +
+				     boot_mem_map.map[i].size);
+		if (setup_elfcorehdr >= start && setup_elfcorehdr < end) {
+			/*
+			 * Reserve from the elf core header to the end of
+			 * the memory segment, that should all be kdump
+			 * reserved memory.
+			 */
+			setup_elfcorehdr_size = end - setup_elfcorehdr;
+			break;
+		}
+	}
+	/*
+	 * If we don't find it in the memory map, then we shouldn't
+	 * have to worry about it, as the new kernel won't use it.
+	 */
+	return 0;
+}
+early_param("elfcorehdr", early_parse_elfcorehdr);
+#endif
+
 static void __init arch_mem_addpart(phys_t mem, phys_t end, int type)
 {
 	phys_t size;
@@ -547,6 +578,14 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 
 	bootmem_init();
+#ifdef CONFIG_PROC_VMCORE
+	if (setup_elfcorehdr && setup_elfcorehdr_size) {
+		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
+		       setup_elfcorehdr, setup_elfcorehdr_size);
+		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
+				BOOTMEM_DEFAULT);
+	}
+#endif
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
 		reserve_bootmem(crashk_res.start,
-- 
1.7.4.1
