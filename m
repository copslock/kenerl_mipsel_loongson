Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2004 15:16:37 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:33526 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226298AbUFCOQc>;
	Thu, 3 Jun 2004 15:16:32 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA15948;
	Thu, 3 Jun 2004 23:16:29 +0900 (JST)
Received: 4UMDO00 id i53EGTl16288; Thu, 3 Jun 2004 23:16:29 +0900 (JST)
Received: 4UMRO00 id i53EGS625840; Thu, 3 Jun 2004 23:16:29 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 3 Jun 2004 23:16:27 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH]  fix vrc4173 base driver
Message-Id: <20040603231627.28e332cd.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I found my mistake about vrc4173 base driver.

Please apply this patch to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/vrc4173.c linux/arch/mips/vr41xx/common/vrc4173.c
--- linux-orig/arch/mips/vr41xx/common/vrc4173.c	Thu May 27 08:14:29 2004
+++ linux/arch/mips/vr41xx/common/vrc4173.c	Mon May 31 00:51:02 2004
@@ -461,7 +461,7 @@
 	.name		= "NEC VRC4173",
 	.probe		= vrc4173_probe,
 	.remove		= vrc4173_remove,
-	.id_table	= vrc4173_table,
+	.id_table	= vrc4173_id_table,
 };
 
 static int __devinit vrc4173_init(void)
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux-orig/include/asm-mips/vr41xx/vrc4173.h	Thu May 27 08:14:44 2004
+++ linux/include/asm-mips/vr41xx/vrc4173.h	Mon May 31 00:50:13 2004
@@ -77,7 +77,7 @@
 /*
  * Clock Mask Unit
  */
-enum vrc4173_clock {
+typedef enum vrc4173_clock {
 	VRC4173_PIU_CLOCK,
 	VRC4173_KIU_CLOCK,
 	VRC4173_AIU_CLOCK,
@@ -98,7 +98,7 @@
 /*
  * General-Purpose I/O Unit
  */
-enum vrc4173_function {
+typedef enum vrc4173_function {
 	PS2_CHANNEL1,
 	PS2_CHANNEL2,
 	TOUCHPANEL,
