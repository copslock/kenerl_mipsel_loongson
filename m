Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 12:05:16 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:55367 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20036084AbYGMLFM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 12:05:12 +0100
Received: by mo.po.2iij.net (mo32) id m6DB59b9009574; Sun, 13 Jul 2008 20:05:09 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox302) id m6DB56VA006089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jul 2008 20:05:07 +0900
Date:	Sun, 13 Jul 2008 19:51:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/5][MIPS] txx9_board_vec set directly without
 mips_machtype
Message-Id: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

txx9_board_vec set directly without mips_machtype.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/generic/setup.c linux/arch/mips/txx9/generic/setup.c
--- linux-orig/arch/mips/txx9/generic/setup.c	2008-07-13 15:59:38.884682499 +0900
+++ linux/arch/mips/txx9/generic/setup.c	2008-07-13 16:00:06.436034688 +0900
@@ -99,19 +99,6 @@ extern struct txx9_board_vec rbtx4927_ve
 extern struct txx9_board_vec rbtx4937_vec;
 extern struct txx9_board_vec rbtx4938_vec;
 
-/* board definitions */
-static struct txx9_board_vec *board_vecs[] __initdata = {
-#ifdef CONFIG_TOSHIBA_JMR3927
-	&jmr3927_vec,
-#endif
-#ifdef CONFIG_TOSHIBA_RBTX4927
-	&rbtx4927_vec,
-	&rbtx4937_vec,
-#endif
-#ifdef CONFIG_TOSHIBA_RBTX4938
-	&rbtx4938_vec,
-#endif
-};
 struct txx9_board_vec *txx9_board_vec __initdata;
 static char txx9_system_type[32];
 
@@ -134,31 +121,26 @@ void __init prom_init_cmdline(void)
 
 void __init prom_init(void)
 {
-	int i;
-
 #ifdef CONFIG_CPU_TX39XX
-	mips_machtype = MACH_TOSHIBA_JMR3927;
+	txx9_board_vec = &jmr3927_vec;
 #endif
 #ifdef CONFIG_CPU_TX49XX
 	switch (TX4938_REV_PCODE()) {
 	case 0x4927:
-		mips_machtype = MACH_TOSHIBA_RBTX4927;
+		txx9_board_vec = &rbtx4927_vec;
 		break;
 	case 0x4937:
-		mips_machtype = MACH_TOSHIBA_RBTX4937;
+		txx9_board_vec = &rbtx4937_vec;
 		break;
 	case 0x4938:
-		mips_machtype = MACH_TOSHIBA_RBTX4938;
+		txx9_board_vec = &rbtx4938_vec;
 		break;
 	}
 #endif
-	for (i = 0; i < ARRAY_SIZE(board_vecs); i++) {
-		if (board_vecs[i]->type == mips_machtype) {
-			txx9_board_vec = board_vecs[i];
-			strcpy(txx9_system_type, txx9_board_vec->system);
-			return txx9_board_vec->prom_init();
-		}
-	}
+
+	strcpy(txx9_system_type, txx9_board_vec->system);
+
+	return txx9_board_vec->prom_init();
 }
 
 void __init prom_free_prom_memory(void)
