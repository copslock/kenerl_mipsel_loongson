Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:32:25 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:20620 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230053AbYJWQcQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:32:16 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGWBmh006701;Fri, 24 Oct 2008 01:32:12 +0900 (JST)
Message-ID: <4900A70B.4040401@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:32:11 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 08/12] MIPS: EMMA2RH: Remove emma2rh_gpio_irq_base
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Let's use immediate value, instead.  This also saves memory footprint,
and probably a little bit faster.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c          |    4 ++--
 arch/mips/emma/markeins/irq_markeins.c |   19 ++++++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index c0f9d46..3577fd5 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -54,7 +54,7 @@
  */
 
 extern void emma2rh_sw_irq_init(void);
-extern void emma2rh_gpio_irq_init(u32 base);
+extern void emma2rh_gpio_irq_init(void);
 extern void emma2rh_irq_init(void);
 extern void emma2rh_irq_dispatch(void);
 
@@ -104,7 +104,7 @@ void __init arch_init_irq(void)
 	/* init all controllers */
 	emma2rh_irq_init();
 	emma2rh_sw_irq_init();
-	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
+	emma2rh_gpio_irq_init();
 	mips_cpu_irq_init();
 
 	/* setup cascade interrupts */
diff --git a/arch/mips/emma/markeins/irq_markeins.c b/arch/mips/emma/markeins/irq_markeins.c
index 1883421..ea27ec5 100644
--- a/arch/mips/emma/markeins/irq_markeins.c
+++ b/arch/mips/emma/markeins/irq_markeins.c
@@ -30,8 +30,6 @@
 #include <asm/debug.h>
 #include <asm/emma/emma2rh.h>
 
-static int emma2rh_gpio_irq_base = -1;
-
 void ll_emma2rh_sw_irq_enable(int reg);
 void ll_emma2rh_sw_irq_disable(int reg);
 void ll_emma2rh_gpio_irq_enable(int reg);
@@ -91,17 +89,17 @@ void ll_emma2rh_sw_irq_disable(int irq)
 
 static void emma2rh_gpio_irq_enable(unsigned int irq)
 {
-	ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
+	ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
 }
 
 static void emma2rh_gpio_irq_disable(unsigned int irq)
 {
-	ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base);
+	ll_emma2rh_gpio_irq_disable(irq - EMMA2RH_GPIO_IRQ_BASE);
 }
 
 static void emma2rh_gpio_irq_ack(unsigned int irq)
 {
-	irq -= emma2rh_gpio_irq_base;
+	irq -= EMMA2RH_GPIO_IRQ_BASE;
 	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
 	ll_emma2rh_gpio_irq_disable(irq);
 }
@@ -109,7 +107,7 @@ static void emma2rh_gpio_irq_ack(unsigned int irq)
 static void emma2rh_gpio_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
+		ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
 }
 
 struct irq_chip emma2rh_gpio_irq_controller = {
@@ -121,14 +119,13 @@ struct irq_chip emma2rh_gpio_irq_controller = {
 	.end = emma2rh_gpio_irq_end,
 };
 
-void emma2rh_gpio_irq_init(u32 irq_base)
+void emma2rh_gpio_irq_init(void)
 {
 	u32 i;
 
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++)
-		set_irq_chip(i, &emma2rh_gpio_irq_controller);
-
-	emma2rh_gpio_irq_base = irq_base;
+	for (i = 0; i < NUM_EMMA2RH_IRQ_GPIO; i++)
+		set_irq_chip(EMMA2RH_GPIO_IRQ_BASE + i,
+			     &emma2rh_gpio_irq_controller);
 }
 
 void ll_emma2rh_gpio_irq_enable(int irq)
