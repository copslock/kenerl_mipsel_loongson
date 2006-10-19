Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:22:16 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:50144 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037895AbWJSLUK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:10 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027110nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=EF49mavkGrijGH6G5jAl7m97Xfmpdy3ml6D2xUh0/4J+Sm0rKHVqhneuF1lcK2lAfaKOl0NgVLNnUyjB4KFE+cDN9NxSuZM1Zh8wUaQsFBjeESdKpXNh3DHimF3dwEc/eUyLSmkmV20+Lt8zy4jHiLIIXxQXZ/SpwU2MHmCwrW4=
Received: by 10.49.91.6 with SMTP id t6mr5612834nfl;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id o53sm872388nfa.2006.10.19.04.20.08;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A5E8E23F773; Thu, 19 Oct 2006 13:20:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 6/7] setup.c: clean up initrd related code
Date:	Thu, 19 Oct 2006 13:20:04 +0200
Message-Id: <11612568061590-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   75 +++++++++++++++++++++++++++++-----------------
 arch/mips/mm/init.c      |    5 ---
 2 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b52cc97..89440a0 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -145,13 +145,12 @@ static int __init rd_start_early(char *p
 	unsigned long start = memparse(p, &p);
 
 #ifdef CONFIG_64BIT
-	/* HACK: Guess if the sign extension was forgotten */
-	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
-		start |= 0xffffffff00000000UL;
+	/* Guess if the sign extension was forgotten by bootloader */
+	if (start < XKPHYS)
+		start = (int)start;
 #endif
 	initrd_start = start;
 	initrd_end += start;
-
 	return 0;
 }
 early_param("rd_start", rd_start_early);
@@ -159,41 +158,64 @@ early_param("rd_start", rd_start_early);
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
+	unsigned long end;
 	u32 *initrd_header;
 
-	ROOT_DEV = Root_RAM0;
-
 	/*
 	 * Board specific code or command line parser should have
 	 * already set up initrd_start and initrd_end. In these cases
 	 * perfom sanity checks and use them if all looks good.
 	 */
-	size = initrd_end - initrd_start;
-	if (initrd_end == 0 || size == 0) {
-		initrd_start = 0;
-		initrd_end = 0;
-	} else
-		return initrd_end;
-
-	end = (unsigned long)&_end;
-	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
-	if (tmp < end)
-		tmp += PAGE_SIZE;
-
-	initrd_header = (u32 *)tmp;
-	if (initrd_header[0] == 0x494E5244) {
-		initrd_start = (unsigned long)&initrd_header[2];
-		initrd_end = initrd_start + initrd_header[1];
+	if (initrd_start && initrd_end > initrd_start)
+		goto sanitize;
+
+	/*
+	 * See if initrd has been added to the kernel image by
+	 * arch/mips/boot/addinitrd.c. In that case a header is
+	 * prepended to initrd and is made up by 8 bytes. The fisrt
+	 * word is a magic number and the second one is the size of
+	 * initrd.  Initrd start must be page aligned in any cases.
+	 */
+	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
+	if (initrd_header[0] != 0x494E5244)
+		goto disable;
+	initrd_start = (unsigned long)(initrd_header + 2);
+	initrd_end = initrd_start + initrd_header[1];
+
+sanitize:
+	if (initrd_start & ~PAGE_MASK) {
+		printk(KERN_ERR "initrd start must be page aligned\n");
+		goto disable;
 	}
-	return initrd_end;
+	if (initrd_start < PAGE_OFFSET) {
+		printk(KERN_ERR "initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
+	/*
+	 * Sanitize initrd addresses. For example firmware
+	 * can't guess if they need to pass them through
+	 * 64-bits values if the kernel has been built in pure
+	 * 32-bit. We need also to switch from KSEG0 to XKPHYS
+	 * addresses now, so the code can now safely use __pa().
+	 */
+	end = __pa(initrd_end);
+	initrd_end = (unsigned long)__va(end);
+	initrd_start = (unsigned long)__va(__pa(initrd_start));
+
+	ROOT_DEV = Root_RAM0;
+	return PFN_UP(end);
+disable:
+	initrd_start = 0;
+	initrd_end = 0;
+	return 0;
 }
 
 static void __init finalize_initrd(void)
@@ -259,8 +281,7 @@ static void __init bootmem_init(void)
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
