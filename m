Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 20:08:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:19709 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225201AbUKXUHy>; Wed, 24 Nov 2004 20:07:54 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAOK7qdh015984;
	Wed, 24 Nov 2004 12:07:52 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAOK7q9I015982;
	Wed, 24 Nov 2004 12:07:52 -0800
Date: Wed, 24 Nov 2004 12:07:52 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Cleanup for TX4927 code
Message-ID: <20041124200752.GA15973@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch does cleanup for the IRQ code for TX4927. Please review and/or
apply ;)

Thanks for the suggestions
Manish Lachwani


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-tx4927-minor

--- arch/mips/tx4927/common/tx4927_irq.c.orig	2004-11-24 09:40:22.000000000 -0800
+++ arch/mips/tx4927/common/tx4927_irq.c	2004-11-24 12:03:38.000000000 -0800
@@ -48,8 +48,6 @@
 /*
  * DEBUG
  */
-#define TX4927_IRQ_CHECK_CP0
-#define TX4927_IRQ_CHECK_PIC
 
 #undef TX4927_IRQ_DEBUG
 
@@ -239,16 +237,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_STARTUP, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_cp0_enable(irq);
 
 	return (0);
@@ -258,16 +246,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_SHUTDOWN, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_cp0_disable(irq);
 
 	return;
@@ -279,16 +257,6 @@
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENABLE, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	spin_lock_irqsave(&tx4927_cp0_lock, flags);
 
 	tx4927_irq_cp0_modify(CCP0_STATUS, 0, tx4927_irq_cp0_mask(irq));
@@ -304,16 +272,6 @@
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_DISABLE, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	spin_lock_irqsave(&tx4927_cp0_lock, flags);
 
 	tx4927_irq_cp0_modify(CCP0_STATUS, tx4927_irq_cp0_mask(irq), 0);
@@ -327,16 +285,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_MASK, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_cp0_disable(irq);
 
 	return;
@@ -346,16 +294,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENDIRQ, "irq=%d \n", irq);
 
-#ifdef TX4927_IRQ_CHECK_CP0
-	{
-		if (irq < TX4927_IRQ_CP0_BEG || irq > TX4927_IRQ_CP0_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4927_irq_cp0_enable(irq);
 	}
@@ -516,16 +454,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_STARTUP, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_pic_enable(irq);
 
 	return (0);
@@ -535,16 +463,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_SHUTDOWN, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_pic_disable(irq);
 
 	return;
@@ -556,16 +474,6 @@
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENABLE, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	spin_lock_irqsave(&tx4927_pic_lock, flags);
 
 	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq), 0,
@@ -582,16 +490,6 @@
 
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_DISABLE, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	spin_lock_irqsave(&tx4927_pic_lock, flags);
 
 	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq),
@@ -606,16 +504,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_MASK, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	tx4927_irq_pic_disable(irq);
 
 	return;
@@ -625,16 +513,6 @@
 {
 	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENDIRQ, "irq=%d\n", irq);
 
-#ifdef TX4927_IRQ_CHECK_PIC
-	{
-		if (irq < TX4927_IRQ_PIC_BEG || irq > TX4927_IRQ_PIC_END) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_EROR,
-					   "bad irq=%d \n", irq);
-			panic("\n");
-		}
-	}
-#endif
-
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
 		tx4927_irq_pic_enable(irq);
 	}

--KsGdsel6WgEHnImy--
