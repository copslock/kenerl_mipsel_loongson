Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:33:27 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:21900 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230089AbYJWQdQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:33:16 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGXAMj006715;Fri, 24 Oct 2008 01:33:11 +0900 (JST)
Message-ID: <4900A746.7010605@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:33:10 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 10/12] MIPS: Markeins: Remove runtime debug prints
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Remove runtime db_* macros as we don't need them any more.  In general,
such helpers are useful for initial porting, but once approved, they are
not indispensable.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index ada33d8..03a663a 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -32,7 +32,6 @@
 #include <asm/irq_cpu.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
-#include <asm/debug.h>
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
@@ -67,7 +66,6 @@ void ll_emma2rh_irq_enable(int emma2rh_irq)
 		    (emma2rh_irq / 32);
 	reg_value = emma2rh_in32(reg_index);
 	reg_bitmask = 0x1 << (emma2rh_irq % 32);
-	db_assert((reg_value & reg_bitmask) == 0);
 	emma2rh_out32(reg_index, reg_value | reg_bitmask);
 }
 
@@ -82,7 +80,6 @@ void ll_emma2rh_irq_disable(int emma2rh_irq)
 		    (emma2rh_irq / 32);
 	reg_value = emma2rh_in32(reg_index);
 	reg_bitmask = 0x1 << (emma2rh_irq % 32);
-	db_assert((reg_value & reg_bitmask) != 0);
 	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
 }
 
@@ -118,9 +115,6 @@ void ll_emma2rh_sw_irq_enable(int irq)
 {
 	u32 reg;
 
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_SW);
-
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
@@ -130,9 +124,6 @@ void ll_emma2rh_sw_irq_disable(int irq)
 {
 	u32 reg;
 
-	db_assert(irq >= 0);
-	db_assert(irq < 32);
-
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
@@ -170,9 +161,6 @@ void ll_emma2rh_gpio_irq_enable(int irq)
 {
 	u32 reg;
 
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
-
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
@@ -182,9 +170,6 @@ void ll_emma2rh_gpio_irq_disable(int irq)
 {
 	u32 reg;
 
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
-
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
@@ -314,8 +299,6 @@ void __init arch_init_irq(void)
 {
 	u32 reg;
 
-	db_run(printk("markeins_irq_setup invoked.\n"));
-
 	/* by default, interrupts are disabled. */
 	emma2rh_out32(EMMA2RH_BHIF_INT_EN_0, 0);
 	emma2rh_out32(EMMA2RH_BHIF_INT_EN_1, 0);
