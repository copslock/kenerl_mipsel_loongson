Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 13:06:23 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:1152 "EHLO smtp14.dti.ne.jp")
	by ftp.linux-mips.org with ESMTP id S21368468AbZCUNGQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Mar 2009 13:06:16 +0000
Received: from [192.168.1.5] (PPPax1767.tokyo-ip.dti.ne.jp [210.159.179.17]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2LD6Eqm018597;Sat, 21 Mar 2009 22:06:14 +0900 (JST)
Message-ID: <49C4E646.7010309@ruby.dti.ne.jp>
Date:	Sat, 21 Mar 2009 22:06:14 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: EMMA2RH: Use handle_edge_irq() handler for GPIO interrupts
References: <49C4E5D5.4070408@ruby.dti.ne.jp>
In-Reply-To: <49C4E5D5.4070408@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

EMMA's GPIO interrupts are latched by GPIO interrupt status register.
In this case, we're encouraged to use handle_edge_irq() handler.

The following changes are made along with replacing set_irq_chip() with
set_irq_chip_and_handler_name(,,handle_edge_irq,"edge"):

* Fix emma2rh_gpio_irq_ack not to disable interrupts

  With handle_edge_irq(), we're not expected to disable interrupts
  when chip->ack is served, so fix it accordingly.  We also add a new
  emma2rh_gpio_irq_mask_ack() for chip->mask_ack operation, instead.

* Remove emma2rh_gpio_irq_end(), as chip->end is no longer served.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 263132d..1e6457c 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -149,37 +149,28 @@ static void emma2rh_gpio_irq_disable(unsigned int irq)
 
 static void emma2rh_gpio_irq_ack(unsigned int irq)
 {
-	u32 reg;
-
 	irq -= EMMA2RH_GPIO_IRQ_BASE;
 	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
-
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-	reg &= ~(1 << irq);
-	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
-static void emma2rh_gpio_irq_end(unsigned int irq)
+static void emma2rh_gpio_irq_mask_ack(unsigned int irq)
 {
 	u32 reg;
 
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-
-		irq -= EMMA2RH_GPIO_IRQ_BASE;
+	irq -= EMMA2RH_GPIO_IRQ_BASE;
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
 
-		reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-		reg |= 1 << irq;
-		emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
-	}
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
 struct irq_chip emma2rh_gpio_irq_controller = {
 	.name = "emma2rh_gpio_irq",
 	.ack = emma2rh_gpio_irq_ack,
 	.mask = emma2rh_gpio_irq_disable,
-	.mask_ack = emma2rh_gpio_irq_ack,
+	.mask_ack = emma2rh_gpio_irq_mask_ack,
 	.unmask = emma2rh_gpio_irq_enable,
-	.end = emma2rh_gpio_irq_end,
 };
 
 void emma2rh_gpio_irq_init(void)
@@ -187,8 +178,9 @@ void emma2rh_gpio_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ_GPIO; i++)
-		set_irq_chip(EMMA2RH_GPIO_IRQ_BASE + i,
-			     &emma2rh_gpio_irq_controller);
+		set_irq_chip_and_handler_name(EMMA2RH_GPIO_IRQ_BASE + i,
+					      &emma2rh_gpio_irq_controller,
+					      handle_edge_irq, "edge");
 }
 
 static struct irqaction irq_cascade = {
