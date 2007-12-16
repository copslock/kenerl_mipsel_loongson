Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Dec 2007 13:57:56 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:35890 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20025214AbXLPN5R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Dec 2007 13:57:17 +0000
Received: by mo.po.2iij.net (mo31) id lBGDtvPu047041; Sun, 16 Dec 2007 22:55:57 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox302) id lBGDtttv023716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 16 Dec 2007 22:55:55 +0900
Date:	Sun, 16 Dec 2007 22:53:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/2][MIPS] remove unused struct bootloader_header
Message-Id: <20071216225300.6069fe55.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Removed unused struct bootloader_header.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lasat/image/head.S mips/arch/mips/lasat/image/head.S
--- mips-orig/arch/mips/lasat/image/head.S	2007-11-05 08:41:37.923119250 +0900
+++ mips/arch/mips/lasat/image/head.S	2007-11-05 08:31:39.865743000 +0900
@@ -1,4 +1,5 @@
-#include <asm/lasat/head.h>
+#define LASAT_K_MAGIC0_VAL	0xfedeabba
+#define LASAT_K_MAGIC1_VAL	0xbedead
 
 	.text
 	.section .text.start, "ax"
@@ -21,7 +22,6 @@
 	.word	_kernel_entry
 
 	/* Here we have room for future flags */
-
 	.org	0x40
 reldate:
 	.word	TIMESTAMP
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/lasat/head.h mips/include/asm-mips/lasat/head.h
--- mips-orig/include/asm-mips/lasat/head.h	2007-11-05 08:41:37.991123500 +0900
+++ mips/include/asm-mips/lasat/head.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,22 +0,0 @@
-/*
- * Image header stuff
- */
-#ifndef _HEAD_H
-#define _HEAD_H
-
-#define LASAT_K_MAGIC0_VAL	0xfedeabba
-#define LASAT_K_MAGIC1_VAL	0x00bedead
-
-#ifndef _LANGUAGE_ASSEMBLY
-#include <linux/types.h>
-struct bootloader_header {
-	u32 magic[2];
-	u32 version;
-	u32 image_start;
-	u32 image_size;
-	u32 kernel_start;
-	u32 kernel_entry;
-};
-#endif
-
-#endif /* _HEAD_H */
