Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 10:23:34 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:54849 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027653AbXJWJXZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 10:23:25 +0100
Received: by mo.po.2iij.net (mo32) id l9N9M70X074506; Tue, 23 Oct 2007 18:22:07 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l9N9M512011220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Oct 2007 18:22:06 +0900
Date:	Tue, 23 Oct 2007 18:19:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/2][MIPS] remove irqsave/irqrestore from spinlock for
 GT641xx clockevent
Message-Id: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


set_next_event() and set_mode() are always called with interrupt disabled.
irqsave and irqrestore are not necessary for spinlock.
Pointed out by Atsushi Nemoto.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cevt-gt641xx.c mips/arch/mips/kernel/cevt-gt641xx.c
--- mips-orig/arch/mips/kernel/cevt-gt641xx.c	2007-10-23 15:24:41.135068000 +0900
+++ mips/arch/mips/kernel/cevt-gt641xx.c	2007-10-23 16:15:57.040970000 +0900
@@ -49,10 +49,9 @@ int gt641xx_timer0_state(void)
 static int gt641xx_timer0_set_next_event(unsigned long delta,
 					 struct clock_event_device *evt)
 {
-	unsigned long flags;
 	u32 ctrl;
 
-	spin_lock_irqsave(&gt641xx_timer_lock, flags);
+	spin_lock(&gt641xx_timer_lock);
 
 	ctrl = GT_READ(GT_TC_CONTROL_OFS);
 	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
@@ -61,7 +60,7 @@ static int gt641xx_timer0_set_next_event
 	GT_WRITE(GT_TC0_OFS, delta);
 	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
 
-	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
+	spin_unlock(&gt641xx_timer_lock);
 
 	return 0;
 }
@@ -69,10 +68,9 @@ static int gt641xx_timer0_set_next_event
 static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
-	unsigned long flags;
 	u32 ctrl;
 
-	spin_lock_irqsave(&gt641xx_timer_lock, flags);
+	spin_lock(&gt641xx_timer_lock);
 
 	ctrl = GT_READ(GT_TC_CONTROL_OFS);
 	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
@@ -90,7 +88,7 @@ static void gt641xx_timer0_set_mode(enum
 
 	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
 
-	spin_unlock_irqrestore(&gt641xx_timer_lock, flags);
+	spin_unlock(&gt641xx_timer_lock);
 }
 
 static void gt641xx_timer0_event_handler(struct clock_event_device *dev)
