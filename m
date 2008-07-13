Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 12:05:56 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:20763 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20036270AbYGMLFN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 12:05:13 +0100
Received: by mo.po.2iij.net (mo31) id m6DB5BIm017225; Sun, 13 Jul 2008 20:05:11 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox303) id m6DB57i7007693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jul 2008 20:05:07 +0900
Date:	Sun, 13 Jul 2008 19:54:08 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/5][MIPS] txx9_cpu_clock setup move to
 rbtx4927_time_init()
Message-Id: <20080713195408.f3878fb2.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
References: <20080713195155.08c4285d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

txx9_cpu_clock setup move to rbtx4927_time_init().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/txx9/rbtx4927/setup.c linux/arch/mips/txx9/rbtx4927/setup.c
--- linux-orig/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 15:59:38.884682499 +0900
+++ linux/arch/mips/txx9/rbtx4927/setup.c	2008-07-13 16:36:03.473869625 +0900
@@ -252,55 +252,6 @@ static void __init rbtx4927_mem_setup(vo
 	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
 #endif
 
-	/*
-	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
-	   *
-	   * For TX4927:
-	   * PCIDIVMODE[12:11]'s initial value is given by S9[4:3] (ON:0, OFF:1).
-	   * CPU 166MHz: PCI 66MHz : PCIDIVMODE: 00 (1/2.5)
-	   * CPU 200MHz: PCI 66MHz : PCIDIVMODE: 01 (1/3)
-	   * CPU 166MHz: PCI 33MHz : PCIDIVMODE: 10 (1/5)
-	   * CPU 200MHz: PCI 33MHz : PCIDIVMODE: 11 (1/6)
-	   * i.e. S9[3]: ON (83MHz), OFF (100MHz)
-	   *
-	   * For TX4937:
-	   * PCIDIVMODE[12:11]'s initial value is given by S1[5:4] (ON:0, OFF:1)
-	   * PCIDIVMODE[10] is 0.
-	   * CPU 266MHz: PCI 33MHz : PCIDIVMODE: 000 (1/8)
-	   * CPU 266MHz: PCI 66MHz : PCIDIVMODE: 001 (1/4)
-	   * CPU 300MHz: PCI 33MHz : PCIDIVMODE: 010 (1/9)
-	   * CPU 300MHz: PCI 66MHz : PCIDIVMODE: 011 (1/4.5)
-	   * CPU 333MHz: PCI 33MHz : PCIDIVMODE: 100 (1/10)
-	   * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
-	   *
-	 */
-	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
-		switch ((unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg) &
-			TX4938_CCFG_PCIDIVMODE_MASK) {
-		case TX4938_CCFG_PCIDIVMODE_8:
-		case TX4938_CCFG_PCIDIVMODE_4:
-			txx9_cpu_clock = 266666666;	/* 266MHz */
-			break;
-		case TX4938_CCFG_PCIDIVMODE_9:
-		case TX4938_CCFG_PCIDIVMODE_4_5:
-			txx9_cpu_clock = 300000000;	/* 300MHz */
-			break;
-		default:
-			txx9_cpu_clock = 333333333;	/* 333MHz */
-		}
-	else
-		switch ((unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg) &
-			TX4927_CCFG_PCIDIVMODE_MASK) {
-		case TX4927_CCFG_PCIDIVMODE_2_5:
-		case TX4927_CCFG_PCIDIVMODE_5:
-			txx9_cpu_clock = 166666666;	/* 166MHz */
-			break;
-		default:
-			txx9_cpu_clock = 200000000;	/* 200MHz */
-		}
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
 	/* CCFG */
 	/* do reset on watchdog */
 	tx4927_ccfg_set(TX4927_CCFG_WR);
@@ -349,6 +300,55 @@ static void __init rbtx4927_mem_setup(vo
 
 static void __init rbtx4927_time_init(void)
 {
+	/*
+	 * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
+	 *
+	 * For TX4927:
+	 * PCIDIVMODE[12:11]'s initial value is given by S9[4:3] (ON:0, OFF:1).
+	 * CPU 166MHz: PCI 66MHz : PCIDIVMODE: 00 (1/2.5)
+	 * CPU 200MHz: PCI 66MHz : PCIDIVMODE: 01 (1/3)
+	 * CPU 166MHz: PCI 33MHz : PCIDIVMODE: 10 (1/5)
+	 * CPU 200MHz: PCI 33MHz : PCIDIVMODE: 11 (1/6)
+	 * i.e. S9[3]: ON (83MHz), OFF (100MHz)
+	 *
+	 * For TX4937:
+	 * PCIDIVMODE[12:11]'s initial value is given by S1[5:4] (ON:0, OFF:1)
+	 * PCIDIVMODE[10] is 0.
+	 * CPU 266MHz: PCI 33MHz : PCIDIVMODE: 000 (1/8)
+	 * CPU 266MHz: PCI 66MHz : PCIDIVMODE: 001 (1/4)
+	 * CPU 300MHz: PCI 33MHz : PCIDIVMODE: 010 (1/9)
+	 * CPU 300MHz: PCI 66MHz : PCIDIVMODE: 011 (1/4.5)
+	 * CPU 333MHz: PCI 33MHz : PCIDIVMODE: 100 (1/10)
+	 * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
+	 */
+	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+		switch ((unsigned long)__raw_readq(&tx4938_ccfgptr->ccfg) &
+			TX4938_CCFG_PCIDIVMODE_MASK) {
+		case TX4938_CCFG_PCIDIVMODE_8:
+		case TX4938_CCFG_PCIDIVMODE_4:
+			txx9_cpu_clock = 266666666;	/* 266MHz */
+			break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			txx9_cpu_clock = 300000000;	/* 300MHz */
+			break;
+		default:
+			txx9_cpu_clock = 333333333;	/* 333MHz */
+		}
+	else
+		switch ((unsigned long)__raw_readq(&tx4927_ccfgptr->ccfg) &
+			TX4927_CCFG_PCIDIVMODE_MASK) {
+		case TX4927_CCFG_PCIDIVMODE_2_5:
+		case TX4927_CCFG_PCIDIVMODE_5:
+			txx9_cpu_clock = 166666666;	/* 166MHz */
+			break;
+		default:
+			txx9_cpu_clock = 200000000;	/* 200MHz */
+		}
+
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
 	mips_hpt_frequency = txx9_cpu_clock / 2;
 	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_TINTDIS)
 		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
