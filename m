Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 15:31:53 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:15777 "EHLO
	smtp14.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S20037526AbZCMPbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Mar 2009 15:31:47 +0000
Received: from shinya-kuribayashis-macbook.local (PPPa360.tokyo-ip.dti.ne.jp [210.159.231.110]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2DFVXeE015241;Sat, 14 Mar 2009 00:31:33 +0900 (JST)
Message-ID: <49BA7C55.5020600@ruby.dti.ne.jp>
Date:	Sat, 14 Mar 2009 00:31:33 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: MIPS: EMMA2RH: Use handle_edge_irq() handler for GPIO interrupts
References: <20090311112806.GA24541@linux-mips.org>
In-Reply-To: <20090311112806.GA24541@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22075
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
  when chip->ack is served, so fix it accordingly.  We also add a
  new emma2rh_gpio_irq_mask_ack() for chip->mask_ack operation.

* Remove emma2rh_gpio_irq_end() as chip->end is no longer served.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

Ralf Baechle wrote:
> __do_IRQ() is deprecated since a long time and there are plans to remove
> it for 2.6.30.  The MIPS platforms seem to fall into three classes:
[snip]
>  o Platforms that still seem to rely on __do_IRQ():
>      o All Sibyte platforms:
> 	bigsur_defconfig and sb1250-swarm_defconfig
> 
>      o All Alchemy platforms:
> 	db1000_defconfig, db1100_defconfig, db1200_defconfig, db1500_defconfig,
> 	db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
> 	and pb1550_defconfig
> 
>      o malta_defconfig.  The platform code itself is ok but irq-gic.c,
> 	irq-msc01.c, irq-msc01.c and irq_cpu.c are still using set_irq_chip
> 	and need fixing.
> 
>      o And the rest:
> 	decstation_defconfig, emma2rh_defconfig, ip32_defconfig,
> 	yosemite_defconfig, mipssim_defconfig and rm200_defconfig.

Here's a patch for EMMA2RH not to call __do_IRQ(). Please review.

Thanks,

  Shinya

 arch/mips/emma/markeins/irq.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index ce8f5f2..d15556c 100644
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
