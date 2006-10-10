Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 08:56:17 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:36359 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038662AbWJJH4P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 08:56:15 +0100
Received: by mo.po.2iij.net (mo30) id k9A7uCn1096889; Tue, 10 Oct 2006 16:56:12 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id k9A7uAqM051471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 10 Oct 2006 16:56:11 +0900 (JST)
Date:	Tue, 10 Oct 2006 16:56:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fix timer setup for Jazz
Message-Id: <20061010165611.2ee77306.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed timer setup function name for Jazz.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/jazz/setup.c mips/arch/mips/jazz/setup.c
--- mips-orig/arch/mips/jazz/setup.c	2006-10-10 11:36:15.066873500 +0900
+++ mips/arch/mips/jazz/setup.c	2006-10-10 15:01:30.833109250 +0900
@@ -37,7 +37,7 @@ extern void jazz_machine_restart(char *c
 extern void jazz_machine_halt(void);
 extern void jazz_machine_power_off(void);
 
-void __init plat_time_init(struct irqaction *irq)
+void __init plat_timer_setup(struct irqaction *irq)
 {
 	/* set the clock to 100 Hz */
 	r4030_write_reg32(JAZZ_TIMER_INTERVAL, 9);
