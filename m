Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:31:54 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:19852 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230043AbYJWQbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:31:47 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGViN6006683;Fri, 24 Oct 2008 01:31:44 +0900 (JST)
Message-ID: <4900A6EF.3060700@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:31:43 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 07/12] MIPS: EMMA2RH: Remove emma2rh_sw_irq_base
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20865
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
 arch/mips/emma/markeins/irq_markeins.c |   14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 86b9b6a..c0f9d46 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -53,7 +53,7 @@
  *
  */
 
-extern void emma2rh_sw_irq_init(u32 base);
+extern void emma2rh_sw_irq_init(void);
 extern void emma2rh_gpio_irq_init(u32 base);
 extern void emma2rh_irq_init(void);
 extern void emma2rh_irq_dispatch(void);
@@ -103,7 +103,7 @@ void __init arch_init_irq(void)
 
 	/* init all controllers */
 	emma2rh_irq_init();
-	emma2rh_sw_irq_init(EMMA2RH_SW_IRQ_BASE);
+	emma2rh_sw_irq_init();
 	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
 	mips_cpu_irq_init();
 
diff --git a/arch/mips/emma/markeins/irq_markeins.c b/arch/mips/emma/markeins/irq_markeins.c
index bbe0d71..1883421 100644
--- a/arch/mips/emma/markeins/irq_markeins.c
+++ b/arch/mips/emma/markeins/irq_markeins.c
@@ -30,7 +30,6 @@
 #include <asm/debug.h>
 #include <asm/emma/emma2rh.h>
 
-static int emma2rh_sw_irq_base = -1;
 static int emma2rh_gpio_irq_base = -1;
 
 void ll_emma2rh_sw_irq_enable(int reg);
@@ -40,12 +39,12 @@ void ll_emma2rh_gpio_irq_disable(int reg);
 
 static void emma2rh_sw_irq_enable(unsigned int irq)
 {
-	ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
+	ll_emma2rh_sw_irq_enable(irq - EMMA2RH_SW_IRQ_BASE);
 }
 
 static void emma2rh_sw_irq_disable(unsigned int irq)
 {
-	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
+	ll_emma2rh_sw_irq_disable(irq - EMMA2RH_SW_IRQ_BASE);
 }
 
 struct irq_chip emma2rh_sw_irq_controller = {
@@ -56,15 +55,14 @@ struct irq_chip emma2rh_sw_irq_controller = {
 	.unmask = emma2rh_sw_irq_enable,
 };
 
-void emma2rh_sw_irq_init(u32 irq_base)
+void emma2rh_sw_irq_init(void)
 {
 	u32 i;
 
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip_and_handler(i, &emma2rh_sw_irq_controller,
+	for (i = 0; i < NUM_EMMA2RH_IRQ_SW; i++)
+		set_irq_chip_and_handler(EMMA2RH_SW_IRQ_BASE + i,
+					 &emma2rh_sw_irq_controller,
 					 handle_level_irq);
-
-	emma2rh_sw_irq_base = irq_base;
 }
 
 void ll_emma2rh_sw_irq_enable(int irq)
