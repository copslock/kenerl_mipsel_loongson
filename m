Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:36:06 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:24204 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230144AbYJWQgE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:36:04 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGa07s006745;Fri, 24 Oct 2008 01:36:00 +0900 (JST)
Message-ID: <4900A7EF.3080304@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:35:59 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 11/12] MIPS: Markeins: Extract ll_emma2rh_* functions
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

These functions are completely ineffective.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

Oops, there are more patches upto 12.  The first [PATCH 00/10] is typo.

 arch/mips/emma/markeins/irq.c |   83 +++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 03a663a..9d6c866 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -55,44 +55,36 @@
  *
  */
 
-void ll_emma2rh_irq_enable(int emma2rh_irq)
+static void emma2rh_irq_enable(unsigned int irq)
 {
 	u32 reg_value;
 	u32 reg_bitmask;
 	u32 reg_index;
 
+	irq -= EMMA2RH_IRQ_BASE;
+
 	reg_index = EMMA2RH_BHIF_INT_EN_0 +
-		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) *
-		    (emma2rh_irq / 32);
+		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) * (irq / 32);
 	reg_value = emma2rh_in32(reg_index);
-	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	reg_bitmask = 0x1 << (irq % 32);
 	emma2rh_out32(reg_index, reg_value | reg_bitmask);
 }
 
-void ll_emma2rh_irq_disable(int emma2rh_irq)
+static void emma2rh_irq_disable(unsigned int irq)
 {
 	u32 reg_value;
 	u32 reg_bitmask;
 	u32 reg_index;
 
+	irq -= EMMA2RH_IRQ_BASE;
+
 	reg_index = EMMA2RH_BHIF_INT_EN_0 +
-		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) *
-		    (emma2rh_irq / 32);
+		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) * (irq / 32);
 	reg_value = emma2rh_in32(reg_index);
-	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	reg_bitmask = 0x1 << (irq % 32);
 	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
 }
 
-static void emma2rh_irq_enable(unsigned int irq)
-{
-	ll_emma2rh_irq_enable(irq - EMMA2RH_IRQ_BASE);
-}
-
-static void emma2rh_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_irq_disable(irq - EMMA2RH_IRQ_BASE);
-}
-
 struct irq_chip emma2rh_irq_controller = {
 	.name = "emma2rh_irq",
 	.ack = emma2rh_irq_disable,
@@ -111,34 +103,28 @@ void emma2rh_irq_init(void)
 					 handle_level_irq);
 }
 
-void ll_emma2rh_sw_irq_enable(int irq)
+static void emma2rh_sw_irq_enable(unsigned int irq)
 {
 	u32 reg;
 
+	irq -= EMMA2RH_SW_IRQ_BASE;
+
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
 }
 
-void ll_emma2rh_sw_irq_disable(int irq)
+static void emma2rh_sw_irq_disable(unsigned int irq)
 {
 	u32 reg;
 
+	irq -= EMMA2RH_SW_IRQ_BASE;
+
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
 }
 
-static void emma2rh_sw_irq_enable(unsigned int irq)
-{
-	ll_emma2rh_sw_irq_enable(irq - EMMA2RH_SW_IRQ_BASE);
-}
-
-static void emma2rh_sw_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_sw_irq_disable(irq - EMMA2RH_SW_IRQ_BASE);
-}
-
 struct irq_chip emma2rh_sw_irq_controller = {
 	.name = "emma2rh_sw_irq",
 	.ack = emma2rh_sw_irq_disable,
@@ -157,45 +143,52 @@ void emma2rh_sw_irq_init(void)
 					 handle_level_irq);
 }
 
-void ll_emma2rh_gpio_irq_enable(int irq)
+static void emma2rh_gpio_irq_enable(unsigned int irq)
 {
 	u32 reg;
 
+	irq -= EMMA2RH_GPIO_IRQ_BASE;
+
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
-void ll_emma2rh_gpio_irq_disable(int irq)
+static void emma2rh_gpio_irq_disable(unsigned int irq)
 {
 	u32 reg;
 
+	irq -= EMMA2RH_GPIO_IRQ_BASE;
+
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
-static void emma2rh_gpio_irq_enable(unsigned int irq)
-{
-	ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
-}
-
-static void emma2rh_gpio_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_gpio_irq_disable(irq - EMMA2RH_GPIO_IRQ_BASE);
-}
-
 static void emma2rh_gpio_irq_ack(unsigned int irq)
 {
+	u32 reg;
+
 	irq -= EMMA2RH_GPIO_IRQ_BASE;
 	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
-	ll_emma2rh_gpio_irq_disable(irq);
+
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
 static void emma2rh_gpio_irq_end(unsigned int irq)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
+	u32 reg;
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+
+		irq -= EMMA2RH_GPIO_IRQ_BASE;
+
+		reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+		reg |= 1 << irq;
+		emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
+	}
 }
 
 struct irq_chip emma2rh_gpio_irq_controller = {
