Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 12:05:36 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:43591 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20036268AbYGMLFN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 12:05:13 +0100
Received: by mo.po.2iij.net (mo30) id m6DB5Bnk001170; Sun, 13 Jul 2008 20:05:11 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox301) id m6DB58tT025873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jul 2008 20:05:08 +0900
Date:	Sun, 13 Jul 2008 20:01:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][3/5][MIPS] separate rbtx4927_arch_init() and
 rbtx4937_arch_init()
Message-Id: <20080713200104.02e6d163.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
References: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
	<20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Separate rbtx4927_arch_init() and rbtx4937_arch_init().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/rbtx4927/setup.c linux/arch/mips/txx9/rbtx4927/setup.c
--- linux-orig/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 16:49:44.924681441 +0900
+++ linux/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 16:50:54.684656833 +0900
@@ -170,13 +170,16 @@ static void __init tx4937_pci_setup(void
 
 static void __init rbtx4927_arch_init(void)
 {
-	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-		tx4937_pci_setup();
-	else
-		tx4927_pci_setup();
+	tx4927_pci_setup();
+}
+
+static void __init rbtx4937_arch_init(void)
+{
+	tx4937_pci_setup();
 }
 #else
 #define rbtx4927_arch_init NULL
+#define rbtx4937_arch_init NULL
 #endif /* CONFIG_PCI */
 
 static void __noreturn wait_forever(void)
@@ -433,7 +436,7 @@ struct txx9_board_vec rbtx4937_vec __ini
 	.irq_setup = rbtx4927_irq_setup,
 	.time_init = rbtx4927_time_init,
 	.device_init = rbtx4927_device_init,
-	.arch_init = rbtx4927_arch_init,
+	.arch_init = rbtx4937_arch_init,
 #ifdef CONFIG_PCI
 	.pci_map_irq = rbtx4927_pci_map_irq,
 #endif
