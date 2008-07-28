Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 13:13:07 +0100 (BST)
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:38824 "EHLO
	smtpout.karoo.kcom.com") by ftp.linux-mips.org with ESMTP
	id S20029188AbYG1MNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jul 2008 13:13:00 +0100
X-IronPort-AV: E=Sophos;i="4.31,265,1215385200"; 
   d="scan'208";a="15509545"
Received: from deneb.mcrowe.com (HELO mcrowe.com) ([82.152.148.4])
  by smtpout.karoo.kcom.com with ESMTP; 28 Jul 2008 13:09:54 +0100
Received: from mac by mcrowe.com with local (Exim 4.63)
	(envelope-from <mac@mcrowe.com>)
	id 1KNRau-0004gh-32; Mon, 28 Jul 2008 13:12:52 +0100
Date:	Mon, 28 Jul 2008 13:12:52 +0100
From:	Mike Crowe <mac@mcrowe.com>
To:	linux-mips@linux-mips.org
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS: Convert printk statements during kernel setup to use severity levels
Message-ID: <20080728121251.GA17679@mcrowe.com>
References: <20080725134454.GA26225@mcrowe.com> <Pine.LNX.4.64.0807252002490.11082@anakin> <20080726125925.GB32426@mcrowe.com> <Pine.LNX.4.64.0807261517160.14397@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807261517160.14397@anakin>
X-url:	http://www.mcrowe.com/
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <mac@mcrowe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mac@mcrowe.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---

I've modified my original patch to use pr_* where appropriate. I've
left the two groups that rely on KERN_CONT using printk directly
because there is (understandably) no pr_cont.


diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8af8486..2aae76b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -78,7 +78,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
 
 	/* Sanity check */
 	if (start + size < start) {
-		printk("Trying to add an invalid memory region, skipped\n");
+		pr_warning("Trying to add an invalid memory region, skipped\n");
 		return;
 	}
 
@@ -92,7 +92,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
 	}
 
 	if (x == BOOT_MEM_MAP_MAX) {
-		printk("Ooops! Too many entries in the memory map!\n");
+		pr_err("Ooops! Too many entries in the memory map!\n");
 		return;
 	}
 
@@ -108,22 +108,22 @@ static void __init print_memory_map(void)
 	const int field = 2 * sizeof(unsigned long);
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		printk(" memory: %0*Lx @ %0*Lx ",
+		printk(KERN_INFO " memory: %0*Lx @ %0*Lx ",
 		       field, (unsigned long long) boot_mem_map.map[i].size,
 		       field, (unsigned long long) boot_mem_map.map[i].addr);
 
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
-			printk("(usable)\n");
+			printk(KERN_CONT "(usable)\n");
 			break;
 		case BOOT_MEM_ROM_DATA:
-			printk("(ROM data)\n");
+			printk(KERN_CONT "(ROM data)\n");
 			break;
 		case BOOT_MEM_RESERVED:
-			printk("(reserved)\n");
+			printk(KERN_CONT "(reserved)\n");
 			break;
 		default:
-			printk("type %lu\n", boot_mem_map.map[i].type);
+			printk(KERN_CONT "type %lu\n", boot_mem_map.map[i].type);
 			break;
 		}
 	}
@@ -185,11 +185,11 @@ static unsigned long __init init_initrd(void)
 
 sanitize:
 	if (initrd_start & ~PAGE_MASK) {
-		printk(KERN_ERR "initrd start must be page aligned\n");
+		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
 	if (initrd_start < PAGE_OFFSET) {
-		printk(KERN_ERR "initrd start < PAGE_OFFSET\n");
+		pr_err("initrd start < PAGE_OFFSET\n");
 		goto disable;
 	}
 
@@ -221,18 +221,18 @@ static void __init finalize_initrd(void)
 		goto disable;
 	}
 	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		printk("Initrd extends beyond end of memory");
+		printk(KERN_ERR "Initrd extends beyond end of memory");
 		goto disable;
 	}
 
 	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
 	initrd_below_start_ok = 1;
 
-	printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
-	       initrd_start, size);
+	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
+		initrd_start, size);
 	return;
 disable:
-	printk(" - disabling initrd\n");
+	printk(KERN_CONT " - disabling initrd\n");
 	initrd_start = 0;
 	initrd_end = 0;
 }
@@ -310,14 +310,12 @@ static void __init bootmem_init(void)
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
-		printk(KERN_INFO
-		       "Wasting %lu bytes for tracking %lu unused pages\n",
-		       (min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
-		       min_low_pfn - ARCH_PFN_OFFSET);
+		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
+			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
+			min_low_pfn - ARCH_PFN_OFFSET);
 	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
-		printk(KERN_INFO
-		       "%lu free pages won't be used\n",
-		       ARCH_PFN_OFFSET - min_low_pfn);
+		pr_info("%lu free pages won't be used\n",
+			ARCH_PFN_OFFSET - min_low_pfn);
 	}
 	min_low_pfn = ARCH_PFN_OFFSET;
 
@@ -471,7 +469,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* call board setup routine */
 	plat_mem_setup();
 
-	printk("Determined physical RAM map:\n");
+	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
@@ -482,7 +480,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	parse_early_param();
 
 	if (usermem) {
-		printk("User-defined physical RAM map:\n");
+		pr_info("User-defined physical RAM map:\n");
 		print_memory_map();
 	}
 
-- 
1.5.6
