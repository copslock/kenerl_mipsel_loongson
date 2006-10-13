Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:41:12 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:17900 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038814AbWJMMjL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:11 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860039nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=oG5H5FNTNsvzSkmIYR5jTOEktms4bi+JHt5jNR8sTjA73C586u26w2RNrnxCGzkAhEL6y83UIylMF1aX18xc+mkeLB//tXvKln8SupK6rVZrcZyBYRaiiLtkTA++JdG7ce2rv1CuymM5kHc7p8n5rI/iCQL6druSVubWuG3n6l8=
Received: by 10.48.254.1 with SMTP id b1mr6950091nfi;
        Fri, 13 Oct 2006 05:39:10 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l22sm888824nfc.2006.10.13.05.39.10;
        Fri, 13 Oct 2006 05:39:10 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id EC6B723F773; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 6/7] setup.c: clean up initrd related code
Date:	Fri, 13 Oct 2006 14:39:05 +0200
Message-Id: <1160743146503-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11607431461469-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   43 +++++++++++++++++++++++++------------------
 arch/mips/mm/init.c      |    5 -----
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 84faa4b..811a8fd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -144,14 +144,12 @@ static int __init rd_start_early(char *p
 {
 	unsigned long start = memparse(p, &p);
 
-#ifdef CONFIG_64BIT
-	/* HACK: Guess if the sign extension was forgotten */
-	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
-		start |= 0xffffffff00000000UL;
-#endif
+	/*
+	 * No sanity checkings are needed here, they're going to be
+	 * done by init_initrd() soon.
+	 */
 	initrd_start = start;
 	initrd_end += start;
-
 	return 0;
 }
 early_param("rd_start", rd_start_early);
@@ -159,14 +157,14 @@ early_param("rd_start", rd_start_early);
 static int __init rd_size_early(char *p)
 {
 	initrd_end += memparse(p, &p);
-
 	return 0;
 }
 early_param("rd_size", rd_size_early);
 
+/* it returns the next free pfn after initrd */
 static unsigned long __init init_initrd(void)
 {
-	unsigned long tmp, end, size;
+	unsigned long tmp, end;
 	u32 *initrd_header;
 
 	ROOT_DEV = Root_RAM0;
@@ -176,24 +174,34 @@ static unsigned long __init init_initrd(
 	 * already set up initrd_start and initrd_end. In these cases
 	 * perfom sanity checks and use them if all looks good.
 	 */
-	size = initrd_end - initrd_start;
-	if (initrd_end == 0 || size == 0) {
-		initrd_start = 0;
-		initrd_end = 0;
-	} else
-		return initrd_end;
+	if (initrd_end > initrd_start)
+		goto sanitize;
 
 	end = (unsigned long)&_end;
 	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
 	if (tmp < end)
 		tmp += PAGE_SIZE;
 
+	initrd_start = 0;
+	initrd_end = 0;
+	end = 0;
 	initrd_header = (u32 *)tmp;
 	if (initrd_header[0] == 0x494E5244) {
 		initrd_start = (unsigned long)&initrd_header[2];
 		initrd_end = initrd_start + initrd_header[1];
+sanitize:
+		/*
+		 * Sanitize initrd addresses. For example firmware
+		 * can't guess if they need to pass them through
+		 * 64-bits values if the kernel has been built in pure
+		 * 32-bit. We need also to switch from KSEG0 to XKPHYS
+		 * addresses now, so the code can now safely use __pa().
+		 */
+		end = __pa(initrd_end);
+		initrd_end = (unsigned long)__va(end);
+		initrd_start = (unsigned long)__va(__pa(initrd_start));
 	}
-	return initrd_end;
+	return PFN_UP(end);
 }
 
 static void __init finalize_initrd(void)
@@ -223,7 +231,7 @@ disable:
 
 #else  /* !CONFIG_BLK_DEV_INITRD */
 
-#define init_initrd()		0
+#define init_initrd()		0UL
 #define finalize_initrd()	do {} while (0)
 
 #endif
@@ -255,8 +263,7 @@ static void __init bootmem_init(void)
 	 * not selected. Once that done we can determine the low bound
 	 * of usable memory.
 	 */
-	reserved_end = init_initrd();
-	reserved_end = PFN_UP(max(__pa(reserved_end), __pa_symbol(&_end)));
+	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4431ea0..072b3b0 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -502,11 +502,6 @@ void free_init_pages(char *what, unsigne
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-#ifdef CONFIG_64BIT
-	/* Switch from KSEG0 to XKPHYS addresses */
-	start = (unsigned long)phys_to_virt(CPHYSADDR(start));
-	end = (unsigned long)phys_to_virt(CPHYSADDR(end));
-#endif
 	free_init_pages("initrd memory", start, end);
 }
 #endif
-- 
1.4.2.3
