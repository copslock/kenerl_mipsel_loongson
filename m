Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jul 2004 16:32:49 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:17393 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225576AbUGDPco>;
	Sun, 4 Jul 2004 16:32:44 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA03358;
	Mon, 5 Jul 2004 00:32:41 +0900 (JST)
Received: 4UMDO00 id i64FWf024855; Mon, 5 Jul 2004 00:32:41 +0900 (JST)
Received: 4UMRO00 id i64FWeT5004765; Mon, 5 Jul 2004 00:32:40 +0900 (JST)
	from stratos (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 5 Jul 2004 00:32:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: fixes the initialization error in icu.c
Message-Id: <20040705003239.5433da3e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The following patch fixes the initialization error in arch/mips/vr41xx/common/icu.c.

Please apply this patch to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	Thu May 27 02:11:11 2004
+++ linux/arch/mips/vr41xx/common/icu.c	Mon Jul  5 00:10:57 2004
@@ -51,6 +51,12 @@
 static uint32_t icu1_base;
 static uint32_t icu2_base;
 
+static struct irqaction icu_cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 static unsigned char sysint1_assign[16] = {
 	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 static unsigned char sysint2_assign[16] = {
@@ -673,8 +679,6 @@
 early_initcall(vr41xx_icu_init);
 
 /*=======================================================================*/
-
-static struct irqaction icu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
 
 static inline void init_vr41xx_icu_irq(void)
 {
