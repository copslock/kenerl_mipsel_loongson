Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 12:21:08 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:12295 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026275AbXLIMVA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Dec 2007 12:21:00 +0000
Received: by mo.po.2iij.net (mo31) id lB9CJdG4059733; Sun, 9 Dec 2007 21:19:39 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox301) id lB9CJbKS031840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Dec 2007 21:19:37 +0900
Date:	Sun, 9 Dec 2007 21:19:36 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove mips_timer_state()
Message-Id: <20071209211936.05b97163.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove mips_timer_state().
It is not used at all.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/dec/time.c mips/arch/mips/dec/time.c
--- mips-orig/arch/mips/dec/time.c	2007-12-06 18:27:03.461092000 +0900
+++ mips/arch/mips/dec/time.c	2007-12-09 20:55:08.231255000 +0900
@@ -161,7 +161,6 @@ static cycle_t dec_ioasic_hpt_read(void)
 
 void __init plat_time_init(void)
 {
-	mips_timer_state = dec_timer_state;
 	mips_timer_ack = dec_timer_ack;
 
 	if (!cpu_has_counter && IOASIC)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/time.c mips/arch/mips/kernel/time.c
--- mips-orig/arch/mips/kernel/time.c	2007-12-06 18:27:04.629165000 +0900
+++ mips/arch/mips/kernel/time.c	2007-12-09 20:52:04.111748250 +0900
@@ -50,8 +50,6 @@ int update_persistent_clock(struct times
 	return rtc_mips_set_mmss(now.tv_sec);
 }
 
-int (*mips_timer_state)(void);
-
 int null_perf_irq(void)
 {
 	return 0;
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/time.h mips/include/asm-mips/time.h
--- mips-orig/include/asm-mips/time.h	2007-12-06 18:30:02.548284250 +0900
+++ mips/include/asm-mips/time.h	2007-12-09 20:54:28.116748000 +0900
@@ -31,20 +31,13 @@ extern int rtc_mips_set_time(unsigned lo
 extern int rtc_mips_set_mmss(unsigned long);
 
 /*
- * Timer interrupt functions.
- * mips_timer_state is needed for high precision timer calibration.
- */
-extern int (*mips_timer_state)(void);
-
-/*
  * board specific routines required by time_init().
  */
 extern void plat_time_init(void);
 
 /*
  * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
- * counter as a timer interrupt source; otherwise it can be set up
- * automagically with an aid of mips_timer_state.
+ * counter as a timer interrupt source.
  */
 extern unsigned int mips_hpt_frequency;
 
