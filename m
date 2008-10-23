Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:32:52 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:21132 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230079AbYJWQcq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:32:46 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGWfdF006705;Fri, 24 Oct 2008 01:32:41 +0900 (JST)
Message-ID: <4900A728.7010103@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:32:40 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 09/12] MIPS: Fold arch/mips/emma/{common,markeins}/irq*.c
 into markeins/irq.c
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Current EMMA2RH irq code is mess.  Before cleaning it up, gather them
in one place as a first step.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/common/Makefile         |    2 
 arch/mips/emma/common/irq.c            |  105 -------------
 arch/mips/emma/common/irq_emma2rh.c    |  103 -------------
 arch/mips/emma/markeins/Makefile       |    2 
 arch/mips/emma/markeins/irq.c          |  251 +++++++++++++++++++++++++++++++-
 arch/mips/emma/markeins/irq_markeins.c |  153 --------------------
 6 files changed, 249 insertions(+), 367 deletions(-)
 delete mode 100644 arch/mips/emma/common/irq.c
 delete mode 100644 arch/mips/emma/common/irq_emma2rh.c
 delete mode 100644 arch/mips/emma/markeins/irq_markeins.c

diff --git a/arch/mips/emma/common/Makefile b/arch/mips/emma/common/Makefile
index cb0fd32..c392d28 100644
--- a/arch/mips/emma/common/Makefile
+++ b/arch/mips/emma/common/Makefile
@@ -10,4 +10,4 @@
 #  (at your option) any later version.
 #
 
-obj-$(CONFIG_NEC_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
+obj-$(CONFIG_NEC_MARKEINS)	+= prom.o
diff --git a/arch/mips/emma/common/irq.c b/arch/mips/emma/common/irq.c
deleted file mode 100644
index 4158f80..0000000
--- a/arch/mips/emma/common/irq.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- *  arch/mips/emma2rh/common/irq.c
- *      This file is common irq dispatcher.
- *
- *  Copyright (C) NEC Electronics Corporation 2005-2006
- *
- *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq.c
- *
- *	Copyright 2001 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-
-#include <asm/emma/emma2rh.h>
-
-/*
- * the first level int-handler will jump here if it is a emma2rh irq
- */
-void emma2rh_irq_dispatch(void)
-{
-	u32 intStatus;
-	u32 bitmask;
-	u32 i;
-
-	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_0)
-	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_0);
-
-#ifdef EMMA2RH_SW_CASCADE
-	if (intStatus &
-	    (1 << ((EMMA2RH_SW_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
-		u32 swIntStatus;
-		swIntStatus = emma2rh_in32(EMMA2RH_BHIF_SW_INT)
-		    & emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
-		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
-			if (swIntStatus & bitmask) {
-				do_IRQ(EMMA2RH_SW_IRQ_BASE + i);
-				return;
-			}
-		}
-	}
-#endif
-
-	for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
-		if (intStatus & bitmask) {
-			do_IRQ(EMMA2RH_IRQ_BASE + i);
-			return;
-		}
-	}
-
-	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_1)
-	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_1);
-
-#ifdef EMMA2RH_GPIO_CASCADE
-	if (intStatus &
-	    (1 << ((EMMA2RH_GPIO_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
-		u32 gpioIntStatus;
-		gpioIntStatus = emma2rh_in32(EMMA2RH_GPIO_INT_ST)
-		    & emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
-			if (gpioIntStatus & bitmask) {
-				do_IRQ(EMMA2RH_GPIO_IRQ_BASE + i);
-				return;
-			}
-		}
-	}
-#endif
-
-	for (i = 32, bitmask = 1; i < 64; i++, bitmask <<= 1) {
-		if (intStatus & bitmask) {
-			do_IRQ(EMMA2RH_IRQ_BASE + i);
-			return;
-		}
-	}
-
-	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_2)
-	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_2);
-
-	for (i = 64, bitmask = 1; i < 96; i++, bitmask <<= 1) {
-		if (intStatus & bitmask) {
-			do_IRQ(EMMA2RH_IRQ_BASE + i);
-			return;
-		}
-	}
-}
diff --git a/arch/mips/emma/common/irq_emma2rh.c b/arch/mips/emma/common/irq_emma2rh.c
deleted file mode 100644
index 4f84fed..0000000
--- a/arch/mips/emma/common/irq_emma2rh.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- *  arch/mips/emma2rh/common/irq_emma2rh.c
- *      This file defines the irq handler for EMMA2RH.
- *
- *  Copyright (C) NEC Electronics Corporation 2005-2006
- *
- *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
- *
- *	Copyright 2001 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * EMMA2RH defines 64 IRQs.
- *
- * This file exports one function:
- *	emma2rh_irq_init(u32 irq_base);
- */
-
-#include <linux/interrupt.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-
-#include <asm/debug.h>
-
-#include <asm/emma/emma2rh.h>
-
-/* number of total irqs supported by EMMA2RH */
-#define	NUM_EMMA2RH_IRQ		96
-
-void ll_emma2rh_irq_enable(int);
-void ll_emma2rh_irq_disable(int);
-
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
-struct irq_chip emma2rh_irq_controller = {
-	.name = "emma2rh_irq",
-	.ack = emma2rh_irq_disable,
-	.mask = emma2rh_irq_disable,
-	.mask_ack = emma2rh_irq_disable,
-	.unmask = emma2rh_irq_enable,
-};
-
-void emma2rh_irq_init(void)
-{
-	u32 i;
-
-	for (i = 0; i < NUM_EMMA2RH_IRQ; i++)
-		set_irq_chip_and_handler(EMMA2RH_IRQ_BASE + i,
-					 &emma2rh_irq_controller,
-					 handle_level_irq);
-}
-
-void ll_emma2rh_irq_enable(int emma2rh_irq)
-{
-	u32 reg_value;
-	u32 reg_bitmask;
-	u32 reg_index;
-
-	reg_index = EMMA2RH_BHIF_INT_EN_0
-	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
-	    * (emma2rh_irq / 32);
-	reg_value = emma2rh_in32(reg_index);
-	reg_bitmask = 0x1 << (emma2rh_irq % 32);
-	db_assert((reg_value & reg_bitmask) == 0);
-	emma2rh_out32(reg_index, reg_value | reg_bitmask);
-}
-
-void ll_emma2rh_irq_disable(int emma2rh_irq)
-{
-	u32 reg_value;
-	u32 reg_bitmask;
-	u32 reg_index;
-
-	reg_index = EMMA2RH_BHIF_INT_EN_0
-	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
-	    * (emma2rh_irq / 32);
-	reg_value = emma2rh_in32(reg_index);
-	reg_bitmask = 0x1 << (emma2rh_irq % 32);
-	db_assert((reg_value & reg_bitmask) != 0);
-	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
-}
diff --git a/arch/mips/emma/markeins/Makefile b/arch/mips/emma/markeins/Makefile
index 3c8b864..16e0017 100644
--- a/arch/mips/emma/markeins/Makefile
+++ b/arch/mips/emma/markeins/Makefile
@@ -10,4 +10,4 @@
 #  (at your option) any later version.
 #
 
-obj-$(CONFIG_NEC_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
+obj-$(CONFIG_NEC_MARKEINS) += irq.o setup.o led.o platform.o
diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 3577fd5..ada33d8 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -38,6 +38,9 @@
 
 #include <asm/emma/emma2rh.h>
 
+/* number of total irqs supported by EMMA2RH */
+#define	NUM_EMMA2RH_IRQ		96
+
 /*
  * IRQ mapping
  *
@@ -53,10 +56,180 @@
  *
  */
 
-extern void emma2rh_sw_irq_init(void);
-extern void emma2rh_gpio_irq_init(void);
-extern void emma2rh_irq_init(void);
-extern void emma2rh_irq_dispatch(void);
+void ll_emma2rh_irq_enable(int emma2rh_irq)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	reg_index = EMMA2RH_BHIF_INT_EN_0 +
+		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) *
+		    (emma2rh_irq / 32);
+	reg_value = emma2rh_in32(reg_index);
+	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	db_assert((reg_value & reg_bitmask) == 0);
+	emma2rh_out32(reg_index, reg_value | reg_bitmask);
+}
+
+void ll_emma2rh_irq_disable(int emma2rh_irq)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	reg_index = EMMA2RH_BHIF_INT_EN_0 +
+		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) *
+		    (emma2rh_irq / 32);
+	reg_value = emma2rh_in32(reg_index);
+	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	db_assert((reg_value & reg_bitmask) != 0);
+	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
+}
+
+static void emma2rh_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_irq_enable(irq - EMMA2RH_IRQ_BASE);
+}
+
+static void emma2rh_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_irq_disable(irq - EMMA2RH_IRQ_BASE);
+}
+
+struct irq_chip emma2rh_irq_controller = {
+	.name = "emma2rh_irq",
+	.ack = emma2rh_irq_disable,
+	.mask = emma2rh_irq_disable,
+	.mask_ack = emma2rh_irq_disable,
+	.unmask = emma2rh_irq_enable,
+};
+
+void emma2rh_irq_init(void)
+{
+	u32 i;
+
+	for (i = 0; i < NUM_EMMA2RH_IRQ; i++)
+		set_irq_chip_and_handler(EMMA2RH_IRQ_BASE + i,
+					 &emma2rh_irq_controller,
+					 handle_level_irq);
+}
+
+void ll_emma2rh_sw_irq_enable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_SW);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+	reg |= 1 << irq;
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
+}
+
+void ll_emma2rh_sw_irq_disable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < 32);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
+}
+
+static void emma2rh_sw_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_enable(irq - EMMA2RH_SW_IRQ_BASE);
+}
+
+static void emma2rh_sw_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_disable(irq - EMMA2RH_SW_IRQ_BASE);
+}
+
+struct irq_chip emma2rh_sw_irq_controller = {
+	.name = "emma2rh_sw_irq",
+	.ack = emma2rh_sw_irq_disable,
+	.mask = emma2rh_sw_irq_disable,
+	.mask_ack = emma2rh_sw_irq_disable,
+	.unmask = emma2rh_sw_irq_enable,
+};
+
+void emma2rh_sw_irq_init(void)
+{
+	u32 i;
+
+	for (i = 0; i < NUM_EMMA2RH_IRQ_SW; i++)
+		set_irq_chip_and_handler(EMMA2RH_SW_IRQ_BASE + i,
+					 &emma2rh_sw_irq_controller,
+					 handle_level_irq);
+}
+
+void ll_emma2rh_gpio_irq_enable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
+
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg |= 1 << irq;
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
+}
+
+void ll_emma2rh_gpio_irq_disable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
+
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
+}
+
+static void emma2rh_gpio_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
+}
+
+static void emma2rh_gpio_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_disable(irq - EMMA2RH_GPIO_IRQ_BASE);
+}
+
+static void emma2rh_gpio_irq_ack(unsigned int irq)
+{
+	irq -= EMMA2RH_GPIO_IRQ_BASE;
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
+	ll_emma2rh_gpio_irq_disable(irq);
+}
+
+static void emma2rh_gpio_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
+}
+
+struct irq_chip emma2rh_gpio_irq_controller = {
+	.name = "emma2rh_gpio_irq",
+	.ack = emma2rh_gpio_irq_ack,
+	.mask = emma2rh_gpio_irq_disable,
+	.mask_ack = emma2rh_gpio_irq_ack,
+	.unmask = emma2rh_gpio_irq_enable,
+	.end = emma2rh_gpio_irq_end,
+};
+
+void emma2rh_gpio_irq_init(void)
+{
+	u32 i;
+
+	for (i = 0; i < NUM_EMMA2RH_IRQ_GPIO; i++)
+		set_irq_chip(EMMA2RH_GPIO_IRQ_BASE + i,
+			     &emma2rh_gpio_irq_controller);
+}
 
 static struct irqaction irq_cascade = {
 	   .handler = no_action,
@@ -67,6 +240,76 @@ static struct irqaction irq_cascade = {
 	   .next = NULL,
 };
 
+/*
+ * the first level int-handler will jump here if it is a emma2rh irq
+ */
+void emma2rh_irq_dispatch(void)
+{
+	u32 intStatus;
+	u32 bitmask;
+	u32 i;
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_0) &
+		    emma2rh_in32(EMMA2RH_BHIF_INT_EN_0);
+
+#ifdef EMMA2RH_SW_CASCADE
+	if (intStatus &
+	    (1 << ((EMMA2RH_SW_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+		u32 swIntStatus;
+		swIntStatus = emma2rh_in32(EMMA2RH_BHIF_SW_INT)
+		    & emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+			if (swIntStatus & bitmask) {
+				do_IRQ(EMMA2RH_SW_IRQ_BASE + i);
+				return;
+			}
+		}
+	}
+#endif
+
+	for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i);
+			return;
+		}
+	}
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_1) &
+		    emma2rh_in32(EMMA2RH_BHIF_INT_EN_1);
+
+#ifdef EMMA2RH_GPIO_CASCADE
+	if (intStatus &
+	    (1 << ((EMMA2RH_GPIO_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+		u32 gpioIntStatus;
+		gpioIntStatus = emma2rh_in32(EMMA2RH_GPIO_INT_ST)
+		    & emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+			if (gpioIntStatus & bitmask) {
+				do_IRQ(EMMA2RH_GPIO_IRQ_BASE + i);
+				return;
+			}
+		}
+	}
+#endif
+
+	for (i = 32, bitmask = 1; i < 64; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i);
+			return;
+		}
+	}
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_2) &
+		    emma2rh_in32(EMMA2RH_BHIF_INT_EN_2);
+
+	for (i = 64, bitmask = 1; i < 96; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i);
+			return;
+		}
+	}
+}
+
 void __init arch_init_irq(void)
 {
 	u32 reg;
diff --git a/arch/mips/emma/markeins/irq_markeins.c b/arch/mips/emma/markeins/irq_markeins.c
deleted file mode 100644
index ea27ec5..0000000
--- a/arch/mips/emma/markeins/irq_markeins.c
+++ /dev/null
@@ -1,153 +0,0 @@
-/*
- *  arch/mips/emma2rh/markeins/irq_markeins.c
- *      This file defines the irq handler for Mark-eins.
- *
- *  Copyright (C) NEC Electronics Corporation 2004-2006
- *
- *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
- *
- *	Copyright 2001 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-
-#include <asm/debug.h>
-#include <asm/emma/emma2rh.h>
-
-void ll_emma2rh_sw_irq_enable(int reg);
-void ll_emma2rh_sw_irq_disable(int reg);
-void ll_emma2rh_gpio_irq_enable(int reg);
-void ll_emma2rh_gpio_irq_disable(int reg);
-
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
-struct irq_chip emma2rh_sw_irq_controller = {
-	.name = "emma2rh_sw_irq",
-	.ack = emma2rh_sw_irq_disable,
-	.mask = emma2rh_sw_irq_disable,
-	.mask_ack = emma2rh_sw_irq_disable,
-	.unmask = emma2rh_sw_irq_enable,
-};
-
-void emma2rh_sw_irq_init(void)
-{
-	u32 i;
-
-	for (i = 0; i < NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip_and_handler(EMMA2RH_SW_IRQ_BASE + i,
-					 &emma2rh_sw_irq_controller,
-					 handle_level_irq);
-}
-
-void ll_emma2rh_sw_irq_enable(int irq)
-{
-	u32 reg;
-
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_SW);
-
-	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
-	reg |= 1 << irq;
-	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
-}
-
-void ll_emma2rh_sw_irq_disable(int irq)
-{
-	u32 reg;
-
-	db_assert(irq >= 0);
-	db_assert(irq < 32);
-
-	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
-	reg &= ~(1 << irq);
-	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
-}
-
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
-static void emma2rh_gpio_irq_ack(unsigned int irq)
-{
-	irq -= EMMA2RH_GPIO_IRQ_BASE;
-	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
-	ll_emma2rh_gpio_irq_disable(irq);
-}
-
-static void emma2rh_gpio_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE);
-}
-
-struct irq_chip emma2rh_gpio_irq_controller = {
-	.name = "emma2rh_gpio_irq",
-	.ack = emma2rh_gpio_irq_ack,
-	.mask = emma2rh_gpio_irq_disable,
-	.mask_ack = emma2rh_gpio_irq_ack,
-	.unmask = emma2rh_gpio_irq_enable,
-	.end = emma2rh_gpio_irq_end,
-};
-
-void emma2rh_gpio_irq_init(void)
-{
-	u32 i;
-
-	for (i = 0; i < NUM_EMMA2RH_IRQ_GPIO; i++)
-		set_irq_chip(EMMA2RH_GPIO_IRQ_BASE + i,
-			     &emma2rh_gpio_irq_controller);
-}
-
-void ll_emma2rh_gpio_irq_enable(int irq)
-{
-	u32 reg;
-
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
-
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-	reg |= 1 << irq;
-	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
-}
-
-void ll_emma2rh_gpio_irq_disable(int irq)
-{
-	u32 reg;
-
-	db_assert(irq >= 0);
-	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
-
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-	reg &= ~(1 << irq);
-	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
-}
