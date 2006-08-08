Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:51:16 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:16055 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041133AbWHHMtS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:18 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240928nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eKAAjy9YdeaI95BHpFND2LCz/amlYScMbQFPYazwncsDq29HksLAjf/wiG+oLlOjqTOOBr5cXefxMw4M4spyvir7SKTscQXYutQ0QTZGpZqZKimsqRhGsQa6MZyUNaCm0WkNzB2uN1tz1RFyXxMHA3tVsVwvMwqogmn1CL+SgG0=
Received: by 10.48.163.19 with SMTP id l19mr323470nfe;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id c1sm756353nfe.2006.08.08.05.49.13;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 1154D23F76F; Tue,  8 Aug 2006 14:48:32 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
Date:	Tue,  8 Aug 2006 14:48:28 +0200
Message-Id: <11550413123888-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

NUMA specific code could rely on them too.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |  145 ++++++++++++++++++++++++++++------------------
 1 files changed, 87 insertions(+), 58 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e331e63..45cba98 100644
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
@@ -263,49 +268,94 @@ #endif
 	return 0;
 }
 
+static unsigned long __init init_initrd(void)
+{
+	unsigned long tmp, end;
+	u32 *initrd_header;
+
+	ROOT_DEV = Root_RAM0;
+	if (parse_rd_cmdline(&initrd_start, &initrd_end))
+		return initrd_end;
+
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
+	unsigned long initrd_size = 
+		(unsigned long)initrd_end - (unsigned long)initrd_start;
+
+	if (initrd_size == 0) {
+		printk(KERN_INFO "Initrd not found or empty");
+		goto check_ko;
+	}
+	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		printk("Initrd extends beyond end of memory");
+		goto check_ko;
+	}
+
+	reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
+	initrd_below_start_ok = 1;
+
+	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
+	       (void *)initrd_start, initrd_size);
+	return;
+check_ko:
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
@@ -388,35 +438,14 @@ #endif
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
1.4.2.rc2
