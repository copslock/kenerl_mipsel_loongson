Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:45:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52556 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835117Ab3DOKpjIaN8l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 12:45:39 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/7] MIPS: add detect_memory_region()
Date:   Mon, 15 Apr 2013 12:41:28 +0200
Message-Id: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add a generic way of detecting the available RAM. This function is based on the
implementation already used by ath79.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/bootinfo.h |    1 +
 arch/mips/kernel/setup.c         |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index b71dd5b..4d2cdea 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -104,6 +104,7 @@ struct boot_mem_map {
 extern struct boot_mem_map boot_mem_map;
 
 extern void add_memory_region(phys_t start, phys_t size, long type);
+extern void detect_memory_region(phys_t start, phys_t sz_min,  phys_t sz_max);
 
 extern void prom_init(void);
 extern void prom_free_prom_memory(void);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4c774d5..dfe776a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/pfn.h>
 #include <linux/debugfs.h>
 #include <linux/kexec.h>
+#include <linux/sizes.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -122,6 +123,25 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
 	boot_mem_map.nr_map++;
 }
 
+void __init detect_memory_region(phys_t start, phys_t sz_min,  phys_t sz_max)
+{
+	phys_t size;
+
+	for (size = sz_min; size < sz_max; size <<= 1) {
+		if (!memcmp(detect_memory_region,
+				detect_memory_region + size, 1024))
+			break;
+	}
+
+	pr_debug("Memory: %lluMB of RAM detected at 0x%llx (min: %lluMB, max: %lluMB)\n",
+		((unsigned long long) size) / SZ_1M,
+		(unsigned long long) start,
+		((unsigned long long) sz_min) / SZ_1M,
+		((unsigned long long) sz_max) / SZ_1M);
+
+	add_memory_region(start, size, BOOT_MEM_RAM);
+}
+
 static void __init print_memory_map(void)
 {
 	int i;
-- 
1.7.10.4
