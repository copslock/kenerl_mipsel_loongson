Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:53:55 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.206]:18253 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044824AbWHKPwh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:52:37 +0100
Received: by nz-out-0102.google.com with SMTP id i1so238193nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:52:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bVvSvYa7NVgJOtA+kC2V35NXg7VvZAtEl2RswAyARGC4lstzzh+9P7QcjOqeN/b1rHmDFhOFsaZ1ehY3nNrjDC3o/wqkCJub0Tn7BhCQRiHcZtz/BG1NkBZ9vivaV2Em+BqWrsmJV/MZ85cPgQZK6AV5eYyRabllQexixCHrZnY=
Received: by 10.65.116.7 with SMTP id t7mr4118838qbm;
        Fri, 11 Aug 2006 08:52:32 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id d5sm1554744qbd.2006.08.11.08.52.29;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 571FC23F759; Fri, 11 Aug 2006 17:51:53 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
Date:	Fri, 11 Aug 2006 17:51:49 +0200
Message-Id: <11553115132069-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
References: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

NUMA specific code could rely on them too.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |  144 +++++++++++++++++++++++++++-------------------
 1 files changed, 86 insertions(+), 58 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e331e63..ee9e355 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -200,7 +200,12 @@ static inline void parse_cmdline_early(v
 	}
 }
 
-static inline int parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
+/*
+ * Manage initrd
+ */
+#ifdef CONFIG_BLK_DEV_INITRD
+
+static int __init parse_rd_cmdline(unsigned long *rd_start, unsigned long *rd_end)
 {
 	/*
 	 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
@@ -263,49 +268,93 @@ #endif
 	return 0;
 }
 
+static unsigned long __init init_initrd(void)
+{
+	unsigned long tmp, end;
+	u32 *initrd_header;
+
+	ROOT_DEV = Root_RAM0;
+
+	if (parse_rd_cmdline(&initrd_start, &initrd_end))
+		return initrd_end;
+	/* 
+	 * Board specific code should have set up initrd_start 
+	 * and initrd_end...
+	 */
+	end = (unsigned long)&_end;
+	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
+	if (tmp < end)
+		tmp += PAGE_SIZE;
+	
+	initrd_header = (u32 *)tmp;
+	if (initrd_header[0] == 0x494E5244) {
+		initrd_start = (unsigned long)&initrd_header[2];
+		initrd_end = initrd_start + initrd_header[1];
+	}
+	return initrd_end;
+}
+
+static void __init finalize_initrd(void)
+{
+	unsigned long size = initrd_end - initrd_start;
+
+	if (size == 0) {
+		printk(KERN_INFO "Initrd not found or empty");
+		goto disable;
+	}
+	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		printk("Initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	reserve_bootmem(CPHYSADDR(initrd_start), size);
+	initrd_below_start_ok = 1;
+
+	printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
+	       initrd_start, size);
+	return;
+disable:
+	printk(" - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
+#else  /* !CONFIG_BLK_DEV_INITRD */
+
+#define init_initrd()		0
+#define finalize_initrd()	do {} while (0)
+
+#endif
+
 /*
  * Initialize the bootmem allocator. It also setup initrd related data
  * if needed.
  */
+#ifdef CONFIG_SGI_IP27
+
 static void __init bootmem_init(void)
 {
-	unsigned long reserved_end = (unsigned long)&_end;
-#ifndef CONFIG_SGI_IP27
+	init_initrd();
+	finalize_initrd();
+}
+
+#else  /* !CONFIG_SGI_IP27 */
+
+static void __init bootmem_init(void)
+{
+	unsigned long reserved_end;
 	unsigned long highest = 0;
 	unsigned long mapstart = -1UL;
 	unsigned long bootmap_size;
 	int i;
-#endif
-#ifdef CONFIG_BLK_DEV_INITRD
-	int initrd_reserve_bootmem = 0;
-
-	/* Board specific code should have set up initrd_start and initrd_end */
- 	ROOT_DEV = Root_RAM0;
-	if (parse_rd_cmdline(&initrd_start, &initrd_end)) {
-		reserved_end = max(reserved_end, initrd_end);
-		initrd_reserve_bootmem = 1;
-	} else {
-		unsigned long tmp;
-		u32 *initrd_header;
-
-		tmp = PAGE_ALIGN(reserved_end) - sizeof(u32) * 2;
-		if (tmp < reserved_end)
-			tmp += PAGE_SIZE;
-		initrd_header = (u32 *)tmp;
-		if (initrd_header[0] == 0x494E5244) {
-			initrd_start = (unsigned long)&initrd_header[2];
-			initrd_end = initrd_start + initrd_header[1];
-			reserved_end = max(reserved_end, initrd_end);
-			initrd_reserve_bootmem = 1;
-		}
-	}
-#endif	/* CONFIG_BLK_DEV_INITRD */
 
-#ifndef CONFIG_SGI_IP27
 	/*
-	 * reserved_end is now a pfn
+	 * Init any data related to initrd. It's a nop if INITRD is
+	 * not selected. Once that done we can determine the low bound
+	 * of usable memory.
 	 */
-	reserved_end = PFN_UP(CPHYSADDR(reserved_end));
+	reserved_end = init_initrd();
+	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -388,35 +437,14 @@ #endif
 	 */
 	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size);
 
-#endif /* CONFIG_SGI_IP27 */
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_below_start_ok = 1;
-	if (initrd_start) {
-		unsigned long initrd_size = ((unsigned char *)initrd_end) -
-			((unsigned char *)initrd_start);
-		const int width = sizeof(long) * 2;
-
-		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *)initrd_start, initrd_size);
-
-		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
-			printk("initrd extends beyond end of memory "
-			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
-			       width,
-			       (unsigned long long) CPHYSADDR(initrd_end),
-			       width,
-			       (unsigned long long) PFN_PHYS(max_low_pfn));
-			initrd_start = initrd_end = 0;
-			initrd_reserve_bootmem = 0;
-		}
-
-		if (initrd_reserve_bootmem)
-			reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
-	}
-#endif /* CONFIG_BLK_DEV_INITRD  */
+	/*
+	 * Reserve initrd memory if needed.
+	 */
+	finalize_initrd();
 }
 
+#endif	/* CONFIG_SGI_IP27 */
+
 /*
  * arch_mem_init - initialize memory managment subsystem
  *
-- 
1.4.2.rc4
