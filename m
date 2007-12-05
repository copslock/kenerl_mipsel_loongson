Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 16:08:40 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:6684 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20025677AbXLEQIF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 16:08:05 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id CCCDB8816; Wed,  5 Dec 2007 21:08:04 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 1/2] Alchemy: replace ffs() with __ffs()
Date:	Wed, 5 Dec 2007 19:08:24 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200712051908.24027.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix havoc wrought by commit 56f621c7f6f735311eed3f36858b402013023c18 -- au_ffs()
and ffs() are equivalent, that patch should have just replaced one with another.
Now replace ffs() with __ffs() which returns an unbiased bit number.

 arch/mips/au1000/common/dbdma.c  |    2 +-
 arch/mips/au1000/common/irq.c    |    8 ++++----
 arch/mips/au1000/pb1200/irqmap.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbdma.c
+++ linux-2.6/arch/mips/au1000/common/dbdma.c
@@ -859,7 +859,7 @@ dbdma_interrupt(int irq, void *dev_id)
 
 	intstat = dbdma_gptr->ddma_intstat;
 	au_sync();
-	chan_index = ffs(intstat);
+	chan_index = __ffs(intstat);
 
 	ctp = chan_tab_ptr[chan_index];
 	cp = ctp->chan_ptr;
Index: linux-2.6/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/irq.c
+++ linux-2.6/arch/mips/au1000/common/irq.c
@@ -462,7 +462,7 @@ static void intc0_req0_irqdispatch(void)
 		return;
 	}
 #endif
-	bit = ffs(intc0_req0);
+	bit = __ffs(intc0_req0);
 	intc0_req0 &= ~(1 << bit);
 	do_IRQ(MIPS_CPU_IRQ_BASE + bit);
 }
@@ -478,7 +478,7 @@ static void intc0_req1_irqdispatch(void)
 	if (!intc0_req1)
 		return;
 
-	bit = ffs(intc0_req1);
+	bit = __ffs(intc0_req1);
 	intc0_req1 &= ~(1 << bit);
 	do_IRQ(bit);
 }
@@ -498,7 +498,7 @@ static void intc1_req0_irqdispatch(void)
 	if (!intc1_req0)
 		return;
 
-	bit = ffs(intc1_req0);
+	bit = __ffs(intc1_req0);
 	intc1_req0 &= ~(1 << bit);
 	do_IRQ(MIPS_CPU_IRQ_BASE + 32 + bit);
 }
@@ -514,7 +514,7 @@ static void intc1_req1_irqdispatch(void)
 	if (!intc1_req1)
 		return;
 
-	bit = ffs(intc1_req1);
+	bit = __ffs(intc1_req1);
 	intc1_req1 &= ~(1 << bit);
 	do_IRQ(MIPS_CPU_IRQ_BASE + 32 + bit);
 }
Index: linux-2.6/arch/mips/au1000/pb1200/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1200/irqmap.c
@@ -74,7 +74,7 @@ irqreturn_t pb1200_cascade_handler( int 
 	bcsr->int_status = bisr;
 	for( ; bisr; bisr &= (bisr-1) )
 	{
-		extirq_nr = PB1200_INT_BEGIN + ffs(bisr);
+		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
 		/* Ack and dispatch IRQ */
 		do_IRQ(extirq_nr);
 	}
