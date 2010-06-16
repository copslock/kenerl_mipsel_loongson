Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2010 09:53:11 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64642 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492108Ab0FPHwo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jun 2010 09:52:44 +0200
Received: by pwj6 with SMTP id 6so4225113pwj.36
        for <multiple recipients>; Wed, 16 Jun 2010 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EUidjWEjT/wbqT2aWvr6Px6c1MKZQENZGWNUNGYO9OI=;
        b=vq7iCQtCddF78QA9pgDf27aT7k4ykOA9bkF+zlsXjTF0yfiYLKYMbndaV5NCrthmto
         TgjrtkTPp8YJxatG7vxE0PJ+oEIL5SV6DaIfL5XvGd148V4OpKRr+0uMCepivB4fdxGD
         G8dVBX9P4qdtK0MHaD+ErixI0d1To46M9YI2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c6fK5MRwpDwgl9Yd5twCI2oJ8GxE7Umb3923JfDvzhlw5nwbk+75SpMcJ4jKvuQaFr
         QfEJVNBD2z5iR0vXj1HdlbmE8b+h1c2WqRusZd0uLdd9iQYDgWSbX0aCuobXgrHzNm2a
         t53SGL7qaYt7NJGAHx9WSGxp+AD0xob/gcPJg=
Received: by 10.114.236.2 with SMTP id j2mr6754275wah.110.1276674756180;
        Wed, 16 Jun 2010 00:52:36 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id c1sm78670395wam.7.2010.06.16.00.52.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 00:52:35 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Clean up arch/mips/boot/compressed/decompress.c
Date:   Wed, 16 Jun 2010 15:52:20 +0800
Message-Id: <1276674753-30240-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
References: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
X-archive-position: 27142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11029

From: Wu Zhangjin <wuzhangjin@gmail.com>

- Remove several lines of out-of-date comments
- Clear the definition of zimage_start and zimage_size and the related
usage

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/decompress.c |   38 +++++++++++--------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5db43c5..5cad0fa 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -1,9 +1,6 @@
 /*
- * Misc. bootloader code for many machines.
- *
  * Copyright 2001 MontaVista Software Inc.
- * Author: Matt Porter <mporter@mvista.com> Derived from
- * arch/ppc/boot/prep/misc.c
+ * Author: Matt Porter <mporter@mvista.com>
  *
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
@@ -19,12 +16,12 @@
 
 #include <asm/addrspace.h>
 
-/* These two variables specify the free mem region
+/*
+ * These two variables specify the free mem region
  * that can be used for temporary malloc area
  */
 unsigned long free_mem_ptr;
 unsigned long free_mem_end_ptr;
-char *zimage_start;
 
 /* The linker tells us where the image is. */
 extern unsigned char __image_begin, __image_end;
@@ -83,38 +80,31 @@ void *memset(void *s, int c, size_t n)
 
 void decompress_kernel(unsigned long boot_heap_start)
 {
-	int zimage_size;
-
-	/*
-	 * We link ourself to an arbitrary low address.  When we run, we
-	 * relocate outself to that address.  __image_beign points to
-	 * the part of the image where the zImage is. -- Tom
-	 */
-	zimage_start = (char *)(unsigned long)(&__image_begin);
+	unsigned long zimage_start, zimage_size;
+
+	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
 
-	/*
-	 * The zImage and initrd will be between start and _end, so they've
-	 * already been moved once.  We're good to go now. -- Tom
-	 */
 	puts("zimage at:     ");
-	puthex((unsigned long)zimage_start);
+	puthex(zimage_start);
 	puts(" ");
-	puthex((unsigned long)(zimage_size + zimage_start));
+	puthex(zimage_size + zimage_start);
 	puts("\n");
 
-	/* this area are prepared for mallocing when decompressing */
+	/* This area are prepared for mallocing when decompressing */
 	free_mem_ptr = boot_heap_start;
 	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
 
-	/* Display standard Linux/MIPS boot prompt for kernel args */
+	/* Display standard Linux/MIPS boot prompt */
 	puts("Uncompressing Linux at load address ");
 	puthex(VMLINUX_LOAD_ADDRESS_ULL);
 	puts("\n");
+
 	/* Decompress the kernel with according algorithm */
-	decompress(zimage_start, zimage_size, 0, 0,
+	decompress((char *)zimage_start, zimage_size, 0, 0,
 		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, error);
-	/* FIXME: is there a need to flush cache here? */
+
+	/* FIXME: should we flush cache here? */
 	puts("Now, booting the kernel...\n");
 }
-- 
1.7.0.4
