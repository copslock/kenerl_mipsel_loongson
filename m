Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 12:06:15 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:63244 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20036140AbYGMLFQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 12:05:16 +0100
Received: by mo.po.2iij.net (mo32) id m6DB5DMR009609; Sun, 13 Jul 2008 20:05:13 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox300) id m6DB59qj000558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jul 2008 20:05:09 +0900
Date:	Sun, 13 Jul 2008 20:04:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][5/5][MIPS] remove machtype for group Toshiba
Message-Id: <20080713200418.591614aa.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080713200213.6cea0cca.yoichi_yuasa@tripeaks.co.jp>
References: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
	<20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
	<20080713200104.02e6d163.yoichi_yuasa@tripeaks.co.jp>
	<20080713200213.6cea0cca.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove machtype for group Toshiba.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/jmr3927/setup.c linux/arch/mips/txx9/jmr3927/setup.c
--- linux-orig/arch/mips/txx9/jmr3927/setup.c	2008-07-13 15:59:38.884682499 +0900
+++ linux/arch/mips/txx9/jmr3927/setup.c	2008-07-13 17:43:27.789224724 +0900
@@ -366,7 +366,6 @@ static void __init jmr3927_device_init(v
 }
 
 struct txx9_board_vec jmr3927_vec __initdata = {
-	.type = MACH_TOSHIBA_JMR3927,
 	.system = "Toshiba JMR_TX3927",
 	.prom_init = jmr3927_prom_init,
 	.mem_setup = jmr3927_mem_setup,
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/rbtx4927/setup.c linux/arch/mips/txx9/rbtx4927/setup.c
--- linux-orig/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 17:40:52.452372581 +0900
+++ linux/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 17:43:39.193874641 +0900
@@ -428,7 +428,6 @@ static void __init rbtx4927_device_init(
 }
 
 struct txx9_board_vec rbtx4927_vec __initdata = {
-	.type = MACH_TOSHIBA_RBTX4927,
 	.system = "Toshiba RBTX4927",
 	.prom_init = rbtx4927_prom_init,
 	.mem_setup = rbtx4927_mem_setup,
@@ -441,7 +440,6 @@ struct txx9_board_vec rbtx4927_vec __ini
 #endif
 };
 struct txx9_board_vec rbtx4937_vec __initdata = {
-	.type = MACH_TOSHIBA_RBTX4937,
 	.system = "Toshiba RBTX4937",
 	.prom_init = rbtx4927_prom_init,
 	.mem_setup = rbtx4927_mem_setup,
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/rbtx4938/setup.c linux/arch/mips/txx9/rbtx4938/setup.c
--- linux-orig/arch/mips/txx9/rbtx4938/setup.c	2008-07-13 15:59:38.888682728 +0900
+++ linux/arch/mips/txx9/rbtx4938/setup.c	2008-07-13 17:43:47.814365892 +0900
@@ -619,7 +619,6 @@ static void __init rbtx4938_device_init(
 }
 
 struct txx9_board_vec rbtx4938_vec __initdata = {
-	.type = MACH_TOSHIBA_RBTX4938,
 	.system = "Toshiba RBTX4938",
 	.prom_init = rbtx4938_prom_init,
 	.mem_setup = rbtx4938_mem_setup,
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux-orig/include/asm-mips/bootinfo.h	2008-07-13 15:59:46.073092146 +0900
+++ linux/include/asm-mips/bootinfo.h	2008-07-13 17:44:27.320617224 +0900
@@ -62,17 +62,6 @@
 #define  MACH_SGI_IP30		4	/* Octane, Octane2              */
 
 /*
- * Valid machtypes for group Toshiba
- */
-#define  MACH_PALLAS		0
-#define  MACH_TOPAS		1
-#define  MACH_JMR		2
-#define  MACH_TOSHIBA_JMR3927	3	/* JMR-TX3927 CPU/IO board */
-#define  MACH_TOSHIBA_RBTX4927	4
-#define  MACH_TOSHIBA_RBTX4937	5
-#define  MACH_TOSHIBA_RBTX4938	6
-
-/*
  * Valid machtype for group LASAT
  */
 #define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/txx9/generic.h linux/include/asm-mips/txx9/generic.h
--- linux-orig/include/asm-mips/txx9/generic.h	2008-07-13 15:59:46.285104227 +0900
+++ linux/include/asm-mips/txx9/generic.h	2008-07-13 17:44:15.759958419 +0900
@@ -22,7 +22,6 @@ extern unsigned int txx9_gbus_clock;
 
 struct pci_dev;
 struct txx9_board_vec {
-	unsigned long type;
 	const char *system;
 	void (*prom_init)(void);
 	void (*mem_setup)(void);
