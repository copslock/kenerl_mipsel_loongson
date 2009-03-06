Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:21:46 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366484AbZCFQUT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:19 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id C4D62EE76A5;
	Fri,  6 Mar 2009 09:42:10 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 02/10] Alchemy: Au1300 new interrupt controller
Date:	Fri,  6 Mar 2009 10:20:01 -0600
Message-Id: <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:09.0372 (UTC) FILETIME=[6B3545C0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

The Au1300 has a new interrupt controller (relative to the rest of the Alchemy
line).  The differences were great enough to justify adding a whole new module.
Included in this patch is the new interrupt controller, a new implementation of
the cascade interrupt controller on the DB1300 board and some code to drive
LEDs on the DB1300 that is used by the interrupt controller.

A small change was made to the existing interrupt controller; it is "ifdef'd
out" for Au1300.

Since the cascade interrupt controller is virtually indentical (with the
exception of some constants) between the DB1300 and DB1200, a future
optimization may be to use the same code for both boards.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/alchemy/Kconfig                    |    4 +
 arch/mips/alchemy/common/Makefile            |    4 +-
 arch/mips/alchemy/common/gpio_int.c          |  268 ++++++++++++++++++++++++++
 arch/mips/alchemy/common/irq.c               |    3 +
 arch/mips/alchemy/devboards/Makefile         |    5 +
 arch/mips/alchemy/devboards/cascade_irq.c    |  142 ++++++++++++++
 arch/mips/alchemy/devboards/leds.c           |   58 ++++++
 arch/mips/include/asm/mach-au1x00/gpio_int.h |  239 +++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/irq.h      |   34 ++++
 9 files changed, 756 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpio_int.c
 create mode 100644 arch/mips/alchemy/devboards/cascade_irq.c
 create mode 100644 arch/mips/alchemy/devboards/leds.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio_int.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/irq.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 7198a88..2e189c2 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -114,18 +114,22 @@ endchoice
 config SOC_AU1000
 	bool
 	select SOC_AU1X00
+	select AU_INT_CNTLR

 config SOC_AU1100
 	bool
 	select SOC_AU1X00
+	select AU_INT_CNTLR

 config SOC_AU1500
 	bool
 	select SOC_AU1X00
+	select AU_INT_CNTLR

 config SOC_AU1550
 	bool
 	select SOC_AU1X00
+	select AU_INT_CNTLR

 config SOC_AU1200
 	bool
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index d50d476..85ffa2e 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -7,7 +7,9 @@

 obj-y += prom.o irq.o puts.o time.o reset.o \
 	clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o gpio.o
+	sleeper.o dma.o dbdma.o gpio.o gpio_int.o
+
+obj-$(CONFIG_SOC_AU13XX) += au13xx_res.o

 obj-$(CONFIG_PCI)		+= pci.o

diff --git a/arch/mips/alchemy/common/gpio_int.c b/arch/mips/alchemy/common/gpio_int.c
new file mode 100644
index 0000000..c09b793
--- /dev/null
+++ b/arch/mips/alchemy/common/gpio_int.c
@@ -0,0 +1,268 @@
+/*
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef CONFIG_AU_GPIO_INT_CNTLR
+
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>		/* For functions called by do_IRQ */
+#include <asm/irq_cpu.h>
+
+#include <asm/mach-au1x00/gpio_int.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#include <dev_boards.h>
+
+volatile struct gpio_int_regs *const gpio_int =
+	(struct gpio_int_regs *)(GPIO_INT_CTRLR_BASE + KSEG1_OFFSET);
+
+static struct gpio_int_cfg __initdata basic_irqs[];
+
+#ifdef CONFIG_SOC_AU13XX
+static struct gpio_int_cfg __initdata basic_irqs[] = {
+	{ AU1300_IRQ_DDMA, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_RTC_TICK, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_TOY_TICK, 1, RISING, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_LCD, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_UART1, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_UART1, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_UART2, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_UART3, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_SD1, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_SD2, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_USB, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_BSA, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_MPE, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_ITE, 1, LEVEL_HIGH, HW_INT_1, DEV_CTRL },
+
+	{ AU1300_IRQ_RTCMATCH_1, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_RTCMATCH_1, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_RTCMATCH_2, 0, RISING, HW_INT_0, DEV_CTRL },
+
+	{ AU1300_IRQ_TOYMATCH_1, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_TOYMATCH_1, 1, RISING, HW_INT_1, DEV_CTRL },
+	{ AU1300_IRQ_TOYMATCH_2, 1, RISING, HW_INT_1, DEV_CTRL },
+
+
+	// KH: TODO - Move this to the board file.
+	{ 5, 0, LEVEL_HIGH, HW_INT_0, GPIO_IN },
+};
+
+/*
+ * KH: TODO - Consider moving to board specific location...
+ */
+static struct gpio_int_cfg __initdata basic_gpios[] = {
+	{ 32, 0, DISABLED, HW_INT_0, DEV_CTRL },
+	{ 33, 0, DISABLED, HW_INT_0, DEV_CTRL },
+	{ 34, 0, DISABLED, HW_INT_0, DEV_CTRL },
+	{ 35, 0, DISABLED, HW_INT_0, DEV_CTRL },
+	{ 36, 0, DISABLED, HW_INT_0, DEV_CTRL },
+	{ 37, 0, DISABLED, HW_INT_0, DEV_CTRL },
+};
+#endif
+
+int __initdata nr_basic_irqs = ARRAY_SIZE(basic_irqs);
+
+/*
+ ****************************************************************************
+ * Functions and delcaration for irq_chip
+ ****************************************************************************
+ */
+void gpio_int_ack(unsigned int irq)
+{
+	u32 intr = irq - GPINT_LINUX_IRQ_OFFSET;
+	u32 bank = GPINT_BANK_FROM_INT(intr);
+	u32 bit = GPINT_BIT_FROM_INT(bank, intr);
+
+	au_iowrite32(bit, &gpio_int->int_pend[bank]);
+}
+
+void gpio_int_mask(unsigned int irq)
+{
+	u32 intr = irq - GPINT_LINUX_IRQ_OFFSET;
+	u32 bank = GPINT_BANK_FROM_INT(intr);
+	u32 bit = GPINT_BIT_FROM_INT(bank, intr);
+
+	au_iowrite32(bit, &gpio_int->int_maskclr[bank]);
+}
+
+void gpio_int_unmask(unsigned int irq)
+{
+	u32 intr = irq - GPINT_LINUX_IRQ_OFFSET;
+	u32 bank = GPINT_BANK_FROM_INT(intr);
+	u32 bit = GPINT_BIT_FROM_INT(bank, intr);
+
+	au_iowrite32(bit, &gpio_int->int_mask[bank]);
+}
+
+void gpio_int_mask_ack(unsigned int irq)
+{
+	u32 intr = irq - GPINT_LINUX_IRQ_OFFSET;
+	u32 bank = GPINT_BANK_FROM_INT(intr);
+	u32 bit = GPINT_BIT_FROM_INT(bank, intr);
+
+	au_iowrite32(bit, &gpio_int->int_maskclr[bank]);
+	au_iowrite32(bit, &gpio_int->int_pend[bank]);
+}
+
+static struct irq_chip gpio_int_irq_type = {
+	.name 		= "Au GPIO/INT",
+	.ack		= gpio_int_ack,
+	.mask		= gpio_int_mask,
+	.unmask		= gpio_int_unmask,
+	.mask_ack	= gpio_int_mask_ack
+};
+/*****************************************************************************/
+
+void set_pin_cfg(const struct gpio_int_cfg *cfg)
+{
+	u32 tmp;
+	tmp = GPINT_PINCTL_N(cfg->pinctl);
+	tmp |= GPINT_INTLINE_N(cfg->intline);
+	tmp |= GPINT_INTCFG_N(cfg->intcfg);
+	tmp |= cfg->intwake ? GPINT_INTWAKE_ENABLE : 0;
+	au_iowrite32(tmp, &gpio_int->gp_int[cfg->number]);
+}
+
+void set_gpio(u8 gpio, u8 value)
+{
+	u32 bank = GPINT_BANK_FROM_GPIO(gpio);
+	u32 bit = GPINT_BIT_FROM_GPIO(bank, gpio);
+
+	if (value == 0)
+		au_iowrite32(1 << bit, &gpio_int->pin_valclr[bank]);
+	else
+		au_iowrite32(1 << bit, &gpio_int->pin_val[bank]);
+}
+
+u8 get_gpio(u8 gpio)
+{
+	u32 bank = GPINT_BANK_FROM_GPIO(gpio);
+	u32 bit = GPINT_BIT_FROM_GPIO(bank, gpio);
+	u32 tmp;
+
+	tmp = au_ioread32(&gpio_int->pin_val[bank]);
+	return tmp >> bit;
+}
+
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	/*
+	 * Initialize the basic MIPS interrupt components.
+	 */
+	mips_cpu_irq_init();
+
+	for (i = 0; i < GPINT_NUM_BANKS; ++i)
+		gpio_int->int_maskclr[i] = ~0UL;
+
+
+	for (i = 0; i < ARRAY_SIZE(basic_gpios); ++i) {
+		set_pin_cfg(&basic_gpios[i]);
+	}
+
+	for (i = 0; i < nr_basic_irqs; ++i) {
+		printk("Initializing IRQ %d\n", basic_irqs[i].number);
+		set_pin_cfg(&basic_irqs[i]);
+		if (basic_irqs[i].intcfg == LEVEL_LOW)
+			set_irq_chip_and_handler_name(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type,
+				handle_level_irq,
+				"lowlevel");
+		else if (basic_irqs[i].intcfg == LEVEL_HIGH)
+			set_irq_chip_and_handler_name(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type,
+				handle_level_irq,
+				"highlevel");
+		else if (basic_irqs[i].intcfg == FALLING)
+			set_irq_chip_and_handler_name(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type,
+				handle_edge_irq,
+				"fallingedge");
+		else if (basic_irqs[i].intcfg == RISING)
+			set_irq_chip_and_handler_name(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type,
+				handle_edge_irq,
+				"risingedge");
+		else if (basic_irqs[i].intcfg == ANY_CHANGE)
+			set_irq_chip_and_handler_name(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type,
+				handle_edge_irq,
+				"bothedge");
+		else
+			set_irq_chip(
+				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
+				&gpio_int_irq_type);
+	}
+
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4);
+
+	board_init_irq();
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int intr;
+	u32 bank;
+	u32 reg_msk;
+	unsigned int pending = read_c0_status() & read_c0_cause();
+	/*
+	 * C0 timer tick
+	 */
+	if (pending & CAUSEF_IP7)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	else if (pending & (CAUSEF_IP2 | CAUSEF_IP3)) {
+		intr = au_ioread32(&gpio_int->pri_enc);
+		bank = GPINT_BANK_FROM_INT(intr);
+		reg_msk = GPINT_BIT_FROM_INT(bank, intr);
+
+		if (intr != 127) {
+			if (pending & CAUSEF_IP3)
+				board_irq_dispatch(intr);
+
+			do_IRQ(GPINT_LINUX_IRQ_OFFSET + intr);
+		}
+	} else {
+		printk(KERN_WARNING
+			"ALCHEMY GPIO_INT: Unexpected cause was set. %08x\n",
+			pending);
+	}
+
+}
+
+#endif
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index c88c821..f8742dd 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -24,6 +24,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#ifdef CONFIG_AU_INT_CNTLR

 #include <linux/bitops.h>
 #include <linux/init.h>
@@ -609,3 +610,5 @@ void __init arch_init_irq(void)

 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
 }
+
+#endif
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 0d2d224..8cce4d0 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -17,3 +17,8 @@ obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
 obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
+
+# These two files are used only by DB1300 today but will be used by DB1200 and
+# possibly others in the future.
+obj-$(CONFIG_MIPS_DB1300) 	+= cascade_irq.o
+obj-$(CONFIG_MIPS_DB1300) 	+= leds.o
diff --git a/arch/mips/alchemy/devboards/cascade_irq.c b/arch/mips/alchemy/devboards/cascade_irq.c
new file mode 100644
index 0000000..6d0a965
--- /dev/null
+++ b/arch/mips/alchemy/devboards/cascade_irq.c
@@ -0,0 +1,142 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mips-boards/db1300.h>
+
+#include <asm/mach-au1x00/dev_boards.h>
+
+/*
+ * The following must be declared/defined in an included file:
+ * - volatile struct bcsr_regs (declared)
+ *   (which much include fields int_status, intset_mask, intclr_mask, intset,
+ *   and intclr)
+ * - volatile struct bcsr_regs *const bcsr (defined)
+ * - CASCADE_IRQ_MIN
+ * - CASCADE_IRQ_MAX
+ * - CASCADE_IRQ_TYPE_STRING
+ * - CASCADE_IRQ (System IRQ to which the cascade is connected)
+ */
+
+void __init board_init_irq(void);
+
+irqreturn_t cascade_handler(int irq, void *dev_id)
+{
+	u16 int_status = au_ioread16(&db_bcsr->int_status);
+	int irq_in_service;
+
+	au_iowrite16(int_status, &db_bcsr->int_status);
+	for ( ; int_status; int_status &= int_status - 1) {
+		irq_in_service = CASCADE_IRQ_MIN + __ffs(int_status);
+		db_set_hex((u8)(irq_in_service));
+		do_IRQ(irq_in_service);
+	}
+
+	return IRQ_RETVAL(1);
+}
+
+DEFINE_MUTEX(cascade_use_count_mutex);
+static int cascade_use_count = 0;
+
+static void cascade_mask(unsigned int irq)
+{
+	au_iowrite16(1 << (irq - CASCADE_IRQ_MIN), &db_bcsr->intclr_mask);
+}
+
+static void cascade_unmask(unsigned int irq)
+{
+	au_iowrite16(1 << (irq - CASCADE_IRQ_MIN), &db_bcsr->intset_mask);
+}
+
+static void cascade_enable(unsigned int irq)
+{
+	au_iowrite16(1 << (irq - CASCADE_IRQ_MIN), &db_bcsr->intset);
+	cascade_unmask(irq);
+}
+
+static void cascade_disable(unsigned int irq)
+{
+	au_iowrite16(1 << (irq - CASCADE_IRQ_MIN), &db_bcsr->intclr);
+	cascade_mask(irq);
+}
+
+
+static unsigned int cascade_startup(unsigned int irq)
+{
+	int retval = 0;
+
+	mutex_lock(&cascade_use_count_mutex);
+	++cascade_use_count;
+	if (cascade_use_count == 1)
+		retval = request_irq(CASCADE_IRQ,
+				&cascade_handler, 0, "Cascade",
+				&cascade_handler);
+	mutex_unlock(&cascade_use_count_mutex);
+
+	cascade_enable(irq);
+	cascade_unmask(irq);
+
+	return retval;
+}
+
+static void cascade_shutdown(unsigned int irq)
+{
+	cascade_mask(irq);
+	cascade_disable(irq);
+
+	mutex_lock(&cascade_use_count_mutex);
+	--cascade_use_count;
+	if (cascade_use_count == 0)
+		free_irq(CASCADE_IRQ, &cascade_handler);
+	mutex_unlock(&cascade_use_count_mutex);
+}
+
+static struct irq_chip cascade_irq_type = {
+	.name = CASCADE_IRQ_TYPE_STRING,
+	.startup = cascade_startup,
+	.shutdown = cascade_shutdown,
+	.mask = cascade_mask,
+	.enable = cascade_enable,
+	.disable = cascade_disable,
+	.unmask = cascade_unmask,
+	.mask_ack = cascade_mask
+};
+
+void __init board_init_irq(void)
+{
+	int irq;
+
+	for (irq = CASCADE_IRQ_MIN;
+			irq < CASCADE_IRQ_MAX; ++irq ) {
+		printk("Initializing IRQ %d\n", irq);
+		set_irq_chip_and_handler(irq, &cascade_irq_type,
+					 handle_level_irq);
+		cascade_disable(irq);
+	}
+}
diff --git a/arch/mips/alchemy/devboards/leds.c b/arch/mips/alchemy/devboards/leds.c
new file mode 100644
index 0000000..75be345
--- /dev/null
+++ b/arch/mips/alchemy/devboards/leds.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/dev_boards.h>
+
+/*
+ * Requires the following to be defined in the board-specifc .h file:
+ * - HEX_REGS_KSEG1_ADDR
+ * - struct hex_regs with members:
+ *   - hex (set the hex value)
+ * - BCSR_REGS_KSEG1_ADDR
+ * - struct bcsr_regs
+ */
+
+static volatile hex_regs *const hex = (hex_regs *)(HEX_REGS_KSEG1_ADDR);
+
+/*
+ * Takes a u8 because though the register is 16 bits, only 8 appear
+ */
+void db_set_hex(u8 val)
+{
+	au_iowrite16((u16)val, &hex->hex);
+}
+
+/*
+ * 2 dots use the least significant 2 bits
+ * Setting a bit lights the LED (opposite of the register)
+ */
+void db_set_hex_dots(u8 val)
+{
+	u16 leds = au_ioread16(&db_bcsr->disk_leds);
+	leds |= 0x3;
+	leds &= (~(val & 0x3));
+	au_iowrite16(leds, &db_bcsr->disk_leds);
+}
diff --git a/arch/mips/include/asm/mach-au1x00/gpio_int.h b/arch/mips/include/asm/mach-au1x00/gpio_int.h
new file mode 100644
index 0000000..85df296
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/gpio_int.h
@@ -0,0 +1,239 @@
+/*
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ * Defines and macros for the GPIO and Interrupt controller for Alchemy,
+ * introduced in the Au13xx series.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _GPIO_INT_H
+#define _GPIO_INT_H
+
+#include <linux/types.h>
+
+/*
+ *  There are a total 128 'channels' defined by the Au13xx databook. However,
+ *  this requires 4 sperate 32bit registers for programming. Each register is
+ *  called a 'bank' for ease of use.
+ */
+#define GPINT_BANK0	0
+#define GPINT_BANK1	1
+#define GPINT_BANK2	2
+#define GPINT_BANK3	3
+
+#define GPINT_NUM_BANKS	4 /* 0-3 */
+#define GPINT_MAX_BANK	(GPINT_BANK3)
+
+#define GPINT_GPIO_PER_BANK	32
+#define GPINT_INTS_PER_BANK	GPINT_GPIO_PER_BANK
+
+/* Total number of interrupts our architecture allows */
+#define GPINT_MAX_INTS		(GPINT_NUM_BANKS*GPINT_INTS_PER_BANK)
+
+/* Current maximum supported GPIO/INTERRUPTs */
+#define GPINT_NUM_GPIO		GPINT_MAX_INTS
+#define GPINT_NUM_INTERRUPTS	GPINT_MAX_INTS
+
+/* Starting GPIO/INTERRUPT for each bank */
+#define GPINT_BANK0_START       0
+#define GPINT_BANK1_START       32
+#define GPINT_BANK2_START       64
+#define GPINT_BANK3_START       96
+
+/* divide by 32 to get bank */
+#define GPINT_BANK_FROM_GPIO(n)   (n>>5)
+#define GPINT_BANK_FROM_INT(n)    GPINT_BANK_FROM_GPIO(n)
+/* multiply by 32 to get base */
+#define GPINT_BIT_FROM_GPIO(b, n) (1<<(n-(b<<5)))
+#define GPINT_BIT_FROM_INT(b, n)  GPINT_BIT_FROM_GPIO(b, n)
+
+struct gpio_int_regs {
+	/* R/W1S */
+	/* u32 pin_val0;    0x00 */
+	/* u32 pin_val1;    0x04 */
+	/* u32 pin_val2;    0x08 */
+	/* u32 pin_val3;    0x0C */
+	u32 pin_val[GPINT_NUM_BANKS];
+
+	/* W1C */
+	/* u32 pin_valclr0    0x10 */
+	/* u32 pin_valclr1;   0x14 */
+	/* u32 pin_valclr2;   0x18 */
+	/* u32 pin_valclr3;   0x1C */
+	u32 pin_valclr[GPINT_NUM_BANKS];
+
+	/* R/W1C */
+	/* u32 int_pend0;    0x20 */
+	/* u32 int_pend1;    0x24 */
+	/* u32 int_pend2;    0x28 */
+	/* u32 int_pend3;    0x2c */
+	u32 int_pend[GPINT_NUM_BANKS];
+
+	u32 pri_enc;  	  /* 0x30 */
+	u32 _resvd0[3];   /* 0x34-0x3c */
+
+	/* R/W1S */
+	/* u32 int_mask0;    0x40 */
+	/* u32 int_mask1;    0x44 */
+	/* u32 int_mask2;    0x48 */
+	/* u32 int_mask3;    0x4c */
+	u32 int_mask[GPINT_NUM_BANKS];
+
+	/* W1C */
+	/* u32 int_maskclr0;   0x50 */
+	/* u32 int_maskclr1;   0x54 */
+	/* u32 int_maskclr2;   0x58 */
+	/* u32 int_maskclr3;   0x5C */
+	u32 int_maskclr[GPINT_NUM_BANKS];
+
+	/* R/W */
+	u32 dma_sel;  	    /* 0x60 */
+	u32 _resvd1[(0x80-0x64)/4];  /* 0x64-0x7C */
+
+	/* W */
+	/* u32    dev_sel0;    0x80 */
+	/* u32    dev_sel1;    0x84 */
+	/* u32    dev_sel2;    0x88 */
+	/* u32    dev_sel3;    0x8C */
+	u32    dev_sel[GPINT_NUM_BANKS];
+
+	/* W */
+	/* u32    dev_selclr0;   0x90 */
+	/* u32    dev_selclr1;   0x94 */
+	/* u32    dev_selclr2;   0x98 */
+	/* u32    dev_selclr3;   0x9C */
+	u32    dev_selclr[GPINT_NUM_BANKS];
+
+	/* R */
+	/* u32    reset_val0;    0xA0 */
+	/* u32    reset_val1;    0xA4 */
+	/* u32    reset_val2;    0xA8 */
+	/* u32    reset_val3;    0xAC */
+	u32    reset_val[GPINT_NUM_BANKS];
+
+	/* 0xB0 - 0xFFC */
+	u32 _resvd2[(0x1000-0xB0)/4];
+
+	/* R/W -- when interrupt mask is clear */
+	/* R   -- when interrupt mask is set */
+	/* u32 gp_int0;    0x1000 */
+	/* u32 gp_int1;    0x1004 */
+	/* u32 gp_int2;    0x1008 */
+	/* u32 gp_int2;    0x100C */
+	/* u32 gp_intN;    0x1000 + (N*4) */
+	u32 gp_int[GPINT_MAX_INTS];
+};
+
+extern volatile struct gpio_int_regs *const gpio_int;
+
+#define GPINT_DMASEL_DMA0           (0)
+#define GPINT_DMASEL_DMA0_N(n)      (((n)&0xFF)<<GPINT_DMASEL_DMA0)
+#define GPINT_DMASEL_DMA1           (8)
+#define GPINT_DMASEL_DMA1_N(n)      (((n)&0xFF)<<GPINT_DMASEL_DMA1)
+
+#define GPINT_PINCTL                (0)
+#define GPINT_PINCTL_N(n)           (((n)&0x3)<<GPINT_PINCTL)
+#define GPINT_PINCTL_GPIOINPUT      GPINT_PINCTL_N(0)
+#define GPINT_PINCTL_INTERRUPT      GPINT_PINCTL_N(1)
+#define GPINT_PINCTL_GPIOOUT_0      GPINT_PINCTL_N(2)
+#define GPINT_PINCTL_GPIOOUT_1      GPINT_PINCTL_N(3)
+
+#define GPINT_INTLINE               (2)
+#define GPINT_INTLINE_N(n)          (((n)&0x3)<<GPINT_INTLINE)
+#define GPINT_INTLINE_CPUINT_0      GPINT_INTLINE_N(0)
+#define GPINT_INTLINE_CPUINT_1      GPINT_INTLINE_N(1)
+#define GPINT_INTLINE_CPUINT_2      GPINT_INTLINE_N(2)
+#define GPINT_INTLINE_CPUINT_3      GPINT_INTLINE_N(3)
+
+#define GPINT_INTCFG                (4)
+#define GPINT_INTCFG_N(n)           (((n)&0x7)<<GPINT_INTCFG)
+#define GPINT_INTCFG_DISABLE        GPINT_INTCFG_N(0)
+#define GPINT_INTCFG_LL             GPINT_INTCFG_N(1)
+#define GPINT_INTCFG_HL             GPINT_INTCFG_N(2)
+#define GPINT_INTCFG_FE             GPINT_INTCFG_N(5)
+#define GPINT_INTCFG_RE             GPINT_INTCFG_N(6)
+#define GPINT_INTCFG_CHANGE         GPINT_INTCFG_N(7)
+
+#define GPINT_INTWAKE               (7)
+#define GPINT_INTWAKE_ENABLE        ((1)<<GPINT_INTWAKE)
+
+/* GPIO */
+#define GPIO_N(N)                   (1 << (N))
+
+/*
+ * Take caution when reordering or changing values; used directly in pin
+ * configuration register
+ */
+enum intcfg_vals { DISABLED = 0, LEVEL_LOW, LEVEL_HIGH,
+		FALLING = 5, RISING, ANY_CHANGE };
+enum intline_vals { HW_INT_0 = 0, HW_INT_1, HW_INT_2, HW_INT_3 };
+enum pinctl_vals { GPIO_IN = 0, DEV_CTRL, GPIO_OUT_0, GPIO_OUT_1 };
+
+/*
+ * Defines the settings for a given interrupt "channel"
+ */
+struct gpio_int_cfg {
+	int			number;
+	bool			intwake;
+	enum intcfg_vals	intcfg;
+	enum intline_vals	intline;
+	enum pinctl_vals	pinctl;
+};
+
+/*
+ * Linux uses IRQ 0-7 for the 8 causes.  That means that all of our channel
+ * bits need to be offset by 8 either when passed to do_IRQ or when received
+ * through the irq_chip calls
+ */
+#define	GPINT_LINUX_IRQ_OFFSET		8
+
+void board_irq_dispatch(unsigned int irq);
+
+/*
+ * Configure a GPIO/Interrupt pin.  Many of the defined interrupt pins as
+ * decribed in the Au1300 data book are configured during platform
+ * initialization, however drivers may wish to repurpose those or other GPIO
+ * pins later.
+ *
+ * Changing the behavior of an interrupt pin after a handler has been
+ * installed is ill advised and should be avoided.
+ */
+void set_pin_cfg(const struct gpio_int_cfg *cfg);
+
+/*
+ * Set the GPIO to the specified value.  The value must be 0 or 1.  Any other
+ * value results in a no-op.
+ *
+ * This call will implicitly reconfigure the pin to be a GPIO if it is
+ * configured as a device pin.
+ */
+void set_gpio(u8 gpio, u8 value);
+
+/*
+ * Get the value of any GPIO pin (including those controlled by devices).
+ *
+ * This will not change the pin configuration
+ */
+u8 get_gpio(u8 gpio);
+
+#endif /* _GPIO_INT_H */
+
diff --git a/arch/mips/include/asm/mach-au1x00/irq.h b/arch/mips/include/asm/mach-au1x00/irq.h
new file mode 100644
index 0000000..91d06a5
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/irq.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ * Defines and macros for the GPIO and Interrupt controller for Alchemy,
+ * introduced in the Au13xx series.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _MACH_AU1X00_INT_H
+#define _MACH_AU1X00_INT_H
+
+#define NR_IRQS 255
+#define MIPS_CPU_IRQ_BASE 0
+
+#endif  /* _MACH_AU1X00_INT_H */
--
1.5.4.3
