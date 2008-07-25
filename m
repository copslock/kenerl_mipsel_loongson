Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 14:45:03 +0100 (BST)
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:12684 "EHLO
	smtpout.karoo.kcom.com") by ftp.linux-mips.org with ESMTP
	id S20031855AbYGYNpB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 14:45:01 +0100
X-IronPort-AV: E=Sophos;i="4.31,252,1215385200"; 
   d="scan'208";a="15247695"
Received: from deneb.mcrowe.com (HELO mcrowe.com) ([82.152.148.4])
  by smtpout.karoo.kcom.com with ESMTP; 25 Jul 2008 14:42:42 +0100
Received: from mac by mcrowe.com with local (Exim 4.63)
	(envelope-from <mac@mcrowe.com>)
	id 1KMNbK-00071t-UF
	for linux-mips@linux-mips.org; Fri, 25 Jul 2008 14:44:55 +0100
Date:	Fri, 25 Jul 2008 14:44:54 +0100
From:	Mike Crowe <mac@mcrowe.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Add severity levels to printk statements during kernel setup.
Message-ID: <20080725134454.GA26225@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <mac@mcrowe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mac@mcrowe.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 arch/mips/kernel/setup.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8af8486..fcb12b9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -78,7 +78,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
 
 	/* Sanity check */
 	if (start + size < start) {
-		printk("Trying to add an invalid memory region, skipped\n");
+		printk(KERN_WARNING "Trying to add an invalid memory region, skipped\n");
 		return;
 	}
 
@@ -92,7 +92,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
 	}
 
 	if (x == BOOT_MEM_MAP_MAX) {
-		printk("Ooops! Too many entries in the memory map!\n");
+		printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
 		return;
 	}
 
@@ -108,7 +108,7 @@ static void __init print_memory_map(void)
 	const int field = 2 * sizeof(unsigned long);
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		printk(" memory: %0*Lx @ %0*Lx ",
+		printk(KERN_INFO " memory: %0*Lx @ %0*Lx ",
 		       field, (unsigned long long) boot_mem_map.map[i].size,
 		       field, (unsigned long long) boot_mem_map.map[i].addr);
 
@@ -221,7 +221,7 @@ static void __init finalize_initrd(void)
 		goto disable;
 	}
 	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		printk("Initrd extends beyond end of memory");
+		printk(KERN_ERR "Initrd extends beyond end of memory");
 		goto disable;
 	}
 
@@ -232,7 +232,7 @@ static void __init finalize_initrd(void)
 	       initrd_start, size);
 	return;
 disable:
-	printk(" - disabling initrd\n");
+	printk(KERN_ERR " - disabling initrd\n");
 	initrd_start = 0;
 	initrd_end = 0;
 }
@@ -471,7 +471,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* call board setup routine */
 	plat_mem_setup();
 
-	printk("Determined physical RAM map:\n");
+	printk(KERN_INFO "Determined physical RAM map:\n");
 	print_memory_map();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
@@ -482,7 +482,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	parse_early_param();
 
 	if (usermem) {
-		printk("User-defined physical RAM map:\n");
+		printk(KERN_INFO "User-defined physical RAM map:\n");
 		print_memory_map();
 	}
 
-- 
1.5.6
