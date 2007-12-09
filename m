Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 12:22:21 +0000 (GMT)
Received: from mo32.po.2iij.NET ([210.128.50.17]:57929 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026275AbXLIMWM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Dec 2007 12:22:12 +0000
Received: by mo.po.2iij.net (mo32) id lB9CMAxM079061; Sun, 9 Dec 2007 21:22:10 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox303) id lB9CM5vg003794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Dec 2007 21:22:05 +0900
Date:	Sun, 9 Dec 2007 21:22:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] set up Cobalt's mips_hpt_frequency
Message-Id: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Set up Cobalt's mips_hpt_frequency.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/time.c mips/arch/mips/cobalt/time.c
--- mips-orig/arch/mips/cobalt/time.c	2007-12-06 18:27:02.689043750 +0900
+++ mips/arch/mips/cobalt/time.c	2007-12-09 17:13:37.916769000 +0900
@@ -27,9 +27,28 @@
 
 void __init plat_time_init(void)
 {
+	u32 start, end;
+	int i = HZ / 10;
+
 	setup_pit_timer();
 
 	gt641xx_set_base_clock(GT641XX_BASE_CLOCK);
 
-	mips_timer_state = gt641xx_timer0_state;
+	/*
+	 * MIPS counter frequency is measured between 100msec 
+	 * using GT64111 timer0.
+	 */
+	while (!gt641xx_timer0_state())
+		;
+
+	start = read_c0_count();
+
+	while (i--)
+		while (!gt641xx_timer0_state())
+			;
+
+	end = read_c0_count();
+
+	mips_hpt_frequency = (end - start) * 10;
+	printk(KERN_INFO "MIPS counter frequency %dHz\n", mips_hpt_frequency);
 }
