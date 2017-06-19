Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:57:01 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58911 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993901AbdFSPuZFCY8H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 9CCFD1A2452;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 7BB7D1A4551;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 1/8] MIPS: cmdline: Add support for 'memmap' parameter
Date:   Mon, 19 Jun 2017 17:50:08 +0200
Message-Id: <1497887415-13825-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Implement support for parsing 'memmap' kernel command line parameter.

This patch covers parsing of the following two formats for 'memmap'
parameter values:

  - nn[KMG]@ss[KMG]
  - nn[KMG]$ss[KMG]

  ([KMG] = K M or G (kilo, mega, giga))

These two allowed formats for parameter value are already documented
in file kernel-parameters.txt in Documentation/admin-guide folder.
Some architectures already support them, but Mips did not prior to
this patch.

Excerpt from Documentation/admin-guide/kernel-parameters.txt:

memmap=nn[KMG]@ss[KMG]
    [KNL] Force usage of a specific region of memory.
    Region of memory to be used is from ss to ss+nn.

memmap=nn[KMG]$ss[KMG]
    Mark specific memory as reserved.
    Region of memory to be reserved is from ss to ss+nn.
    Example: Exclude memory from 0x18690000-0x1869ffff
        memmap=64K$0x18690000
        or
        memmap=0x10000$0x18690000

There is no need to update this documentation file with respect to
this patch.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/kernel/setup.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ccea90f..5a86da93 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -713,6 +713,46 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+static int __init early_parse_memmap(char *p)
+{
+	char *oldp;
+	u64 start_at, mem_size;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!strncmp(p, "exactmap", 8)) {
+		pr_err("\"memmap=exactmap\" invalid on MIPS\n");
+		return 0;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	if (*p == '@') {
+		start_at = memparse(p+1, &p);
+		add_memory_region(start_at, mem_size, BOOT_MEM_RAM);
+	} else if (*p == '#') {
+		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on MIPS\n");
+		return -EINVAL;
+	} else if (*p == '$') {
+		start_at = memparse(p+1, &p);
+		add_memory_region(start_at, mem_size, BOOT_MEM_RESERVED);
+	} else {
+		pr_err("\"memmap\" invalid format!\n");
+		return -EINVAL;
+	}
+
+	if (*p == '\0') {
+		usermem = 1;
+		return 0;
+	} else
+		return -EINVAL;
+}
+early_param("memmap", early_parse_memmap);
+
 #ifdef CONFIG_PROC_VMCORE
 unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
 static int __init early_parse_elfcorehdr(char *p)
-- 
2.7.4
