Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jul 2004 16:30:07 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:8956 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225576AbUGDPaC>;
	Sun, 4 Jul 2004 16:30:02 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA19669;
	Mon, 5 Jul 2004 00:29:58 +0900 (JST)
Received: 4UMDO00 id i64FTv024833; Mon, 5 Jul 2004 00:29:58 +0900 (JST)
Received: 4UMRO00 id i64FTuT5004528; Mon, 5 Jul 2004 00:29:57 +0900 (JST)
	from stratos (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 5 Jul 2004 00:29:56 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: fixes the compile error in giu.c
Message-Id: <20040705002956.20bbcc5c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The following patch fixes the compile error in arch/mips/vr41xx/common/giu.c.

Please apply this patch to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux-orig/arch/mips/vr41xx/common/giu.c	Mon Jun 28 11:12:23 2004
+++ linux/arch/mips/vr41xx/common/giu.c	Mon Jul  5 00:11:01 2004
@@ -63,6 +63,12 @@
 
 static uint32_t giu_base;
 
+static struct irqaction giu_cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 #define read_giuint(offset)		readw(giu_base + (offset))
 #define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
@@ -303,7 +309,6 @@
 };
 
 static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
-static struct irqaction giu_cascade = {no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 static int no_irq_number(int irq)
 {
