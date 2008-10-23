Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:29:29 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:17036 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230016AbYJWQ3Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:29:25 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGTHRO006643;Fri, 24 Oct 2008 01:29:17 +0900 (JST)
Message-ID: <4900A65C.4000201@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:29:16 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 03/12] MIPS: Move arch/mips/emma2rh/ into arch/mips/emma/
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

git mv arch/mips/{emma2rh,emma} and fixups Makefiles.  We'll put all NEC
EMMA series based machines there in the future.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/Makefile                        |    6 -
 arch/mips/emma/common/Makefile            |   13 ++
 arch/mips/emma/common/irq.c               |  105 ++++++++++++++++
 arch/mips/emma/common/irq_emma2rh.c       |  106 ++++++++++++++++
 arch/mips/emma/common/prom.c              |   72 +++++++++++
 arch/mips/emma/markeins/Makefile          |   13 ++
 arch/mips/emma/markeins/irq.c             |  132 ++++++++++++++++++++
 arch/mips/emma/markeins/irq_markeins.c    |  158 ++++++++++++++++++++++++
 arch/mips/emma/markeins/led.c             |   60 +++++++++
 arch/mips/emma/markeins/platform.c        |  191 +++++++++++++++++++++++++++++
 arch/mips/emma/markeins/setup.c           |  135 ++++++++++++++++++++
 arch/mips/emma2rh/common/Makefile         |   13 --
 arch/mips/emma2rh/common/irq.c            |  105 ----------------
 arch/mips/emma2rh/common/irq_emma2rh.c    |  106 ----------------
 arch/mips/emma2rh/common/prom.c           |   72 -----------
 arch/mips/emma2rh/markeins/Makefile       |   13 --
 arch/mips/emma2rh/markeins/irq.c          |  132 --------------------
 arch/mips/emma2rh/markeins/irq_markeins.c |  158 ------------------------
 arch/mips/emma2rh/markeins/led.c          |   60 ---------
 arch/mips/emma2rh/markeins/platform.c     |  191 -----------------------------
 arch/mips/emma2rh/markeins/setup.c        |  135 --------------------
 21 files changed, 988 insertions(+), 988 deletions(-)
 create mode 100644 arch/mips/emma/common/Makefile
 create mode 100644 arch/mips/emma/common/irq.c
 create mode 100644 arch/mips/emma/common/irq_emma2rh.c
 create mode 100644 arch/mips/emma/common/prom.c
 create mode 100644 arch/mips/emma/markeins/Makefile
 create mode 100644 arch/mips/emma/markeins/irq.c
 create mode 100644 arch/mips/emma/markeins/irq_markeins.c
 create mode 100644 arch/mips/emma/markeins/led.c
 create mode 100644 arch/mips/emma/markeins/platform.c
 create mode 100644 arch/mips/emma/markeins/setup.c
 delete mode 100644 arch/mips/emma2rh/common/Makefile
 delete mode 100644 arch/mips/emma2rh/common/irq.c
 delete mode 100644 arch/mips/emma2rh/common/irq_emma2rh.c
 delete mode 100644 arch/mips/emma2rh/common/prom.c
 delete mode 100644 arch/mips/emma2rh/markeins/Makefile
 delete mode 100644 arch/mips/emma2rh/markeins/irq.c
 delete mode 100644 arch/mips/emma2rh/markeins/irq_markeins.c
 delete mode 100644 arch/mips/emma2rh/markeins/led.c
 delete mode 100644 arch/mips/emma2rh/markeins/platform.c
 delete mode 100644 arch/mips/emma2rh/markeins/setup.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a1d1f77..1bd4fe7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -402,15 +402,15 @@ libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/nxp/pnx8550/stb810/
 load-$(CONFIG_PNX8550_STB810)	+= 0xffffffff80060000
 
 #
-# NEC EMMA2RH boards
+# Common NEC EMMAXXX
 #
-core-$(CONFIG_SOC_EMMA2RH)	+= arch/mips/emma2rh/common/
+core-$(CONFIG_SOC_EMMA)		+= arch/mips/emma/common/
 cflags-$(CONFIG_SOC_EMMA2RH)	+= -I$(srctree)/arch/mips/include/asm/mach-emma2rh
 
 #
 # NEC EMMA2RH Mark-eins
 #
-core-$(CONFIG_NEC_MARKEINS)	+= arch/mips/emma2rh/markeins/
+core-$(CONFIG_NEC_MARKEINS)	+= arch/mips/emma/markeins/
 load-$(CONFIG_NEC_MARKEINS)	+= 0xffffffff88100000
 
 #
diff --git a/arch/mips/emma/common/Makefile b/arch/mips/emma/common/Makefile
new file mode 100644
index 0000000..cb0fd32
--- /dev/null
+++ b/arch/mips/emma/common/Makefile
@@ -0,0 +1,13 @@
+#
+#  arch/mips/emma2rh/common/Makefile
+#       Makefile for the common code of NEC EMMA2RH based board.
+#
+#  Copyright (C) NEC Electronics Corporation 2005-2006
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+
+obj-$(CONFIG_NEC_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
diff --git a/arch/mips/emma/common/irq.c b/arch/mips/emma/common/irq.c
new file mode 100644
index 0000000..91cbd95
--- /dev/null
+++ b/arch/mips/emma/common/irq.c
@@ -0,0 +1,105 @@
+/*
+ *  arch/mips/emma2rh/common/irq.c
+ *      This file is common irq dispatcher.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/*
+ * the first level int-handler will jump here if it is a emma2rh irq
+ */
+void emma2rh_irq_dispatch(void)
+{
+	u32 intStatus;
+	u32 bitmask;
+	u32 i;
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_0)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_0);
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
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_1)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_1);
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
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_2)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_2);
+
+	for (i = 64, bitmask = 1; i < 96; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i);
+			return;
+		}
+	}
+}
diff --git a/arch/mips/emma/common/irq_emma2rh.c b/arch/mips/emma/common/irq_emma2rh.c
new file mode 100644
index 0000000..96df37b
--- /dev/null
+++ b/arch/mips/emma/common/irq_emma2rh.c
@@ -0,0 +1,106 @@
+/*
+ *  arch/mips/emma2rh/common/irq_emma2rh.c
+ *      This file defines the irq handler for EMMA2RH.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * EMMA2RH defines 64 IRQs.
+ *
+ * This file exports one function:
+ *	emma2rh_irq_init(u32 irq_base);
+ */
+
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/* number of total irqs supported by EMMA2RH */
+#define	NUM_EMMA2RH_IRQ		96
+
+static int emma2rh_irq_base = -1;
+
+void ll_emma2rh_irq_enable(int);
+void ll_emma2rh_irq_disable(int);
+
+static void emma2rh_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_irq_enable(irq - emma2rh_irq_base);
+}
+
+static void emma2rh_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
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
+void emma2rh_irq_init(u32 irq_base)
+{
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++)
+		set_irq_chip_and_handler(i, &emma2rh_irq_controller,
+					 handle_level_irq);
+
+	emma2rh_irq_base = irq_base;
+}
+
+void ll_emma2rh_irq_enable(int emma2rh_irq)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	reg_index = EMMA2RH_BHIF_INT_EN_0
+	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
+	    * (emma2rh_irq / 32);
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
+	reg_index = EMMA2RH_BHIF_INT_EN_0
+	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
+	    * (emma2rh_irq / 32);
+	reg_value = emma2rh_in32(reg_index);
+	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	db_assert((reg_value & reg_bitmask) != 0);
+	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
+}
diff --git a/arch/mips/emma/common/prom.c b/arch/mips/emma/common/prom.c
new file mode 100644
index 0000000..97bf29e
--- /dev/null
+++ b/arch/mips/emma/common/prom.c
@@ -0,0 +1,72 @@
+/*
+ *  arch/mips/emma2rh/common/prom.c
+ *      This file is prom file.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/common/prom.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/emma2rh/emma2rh.h>
+
+const char *get_system_type(void)
+{
+#ifdef CONFIG_NEC_MARKEINS
+	return "NEC EMMA2RH Mark-eins";
+#else
+#error  Unknown NEC board
+#endif
+}
+
+/* [jsun@junsun.net] PMON passes arguments in C main() style */
+void __init prom_init(void)
+{
+	int argc = fw_arg0;
+	char **arg = (char **)fw_arg1;
+	int i;
+
+	/* if user passes kernel args, ignore the default one */
+	if (argc > 1)
+		arcs_cmdline[0] = '\0';
+
+	/* arg[0] is "g", the rest is boot parameters */
+	for (i = 1; i < argc; i++) {
+		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+
+#ifdef CONFIG_NEC_MARKEINS
+	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
+#else
+#error  Unknown NEC board
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/emma/markeins/Makefile b/arch/mips/emma/markeins/Makefile
new file mode 100644
index 0000000..3c8b864
--- /dev/null
+++ b/arch/mips/emma/markeins/Makefile
@@ -0,0 +1,13 @@
+#
+#  arch/mips/emma2rh/markeins/Makefile
+#       Makefile for the common code of NEC EMMA2RH based board.
+#
+#  Copyright (C) NEC Electronics Corporation 2005-2006
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+
+obj-$(CONFIG_NEC_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
new file mode 100644
index 0000000..6bcf6a0
--- /dev/null
+++ b/arch/mips/emma/markeins/irq.c
@@ -0,0 +1,132 @@
+/*
+ *  arch/mips/emma2rh/markeins/irq.c
+ *      This file defines the irq handler for EMMA2RH.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/delay.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/debug.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/*
+ * IRQ mapping
+ *
+ *  0-7: 8 CPU interrupts
+ *	0 -	software interrupt 0
+ *	1 - 	software interrupt 1
+ *	2 - 	most Vrc5477 interrupts are routed to this pin
+ *	3 - 	(optional) some other interrupts routed to this pin for debugg
+ *	4 - 	not used
+ *	5 - 	not used
+ *	6 - 	not used
+ *	7 - 	cpu timer (used by default)
+ *
+ */
+
+extern void emma2rh_sw_irq_init(u32 base);
+extern void emma2rh_gpio_irq_init(u32 base);
+extern void emma2rh_irq_init(u32 base);
+extern void emma2rh_irq_dispatch(void);
+
+static struct irqaction irq_cascade = {
+	   .handler = no_action,
+	   .flags = 0,
+	   .mask = CPU_MASK_NONE,
+	   .name = "cascade",
+	   .dev_id = NULL,
+	   .next = NULL,
+};
+
+void __init arch_init_irq(void)
+{
+	u32 reg;
+
+	db_run(printk("markeins_irq_setup invoked.\n"));
+
+	/* by default, interrupts are disabled. */
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_0, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_1, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_2, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_0, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_1, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_2, 0);
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, 0);
+
+	clear_c0_status(0xff00);
+	set_c0_status(0x0400);
+
+#define GPIO_PCI (0xf<<15)
+	/* setup GPIO interrupt for PCI interface */
+	/* direction input */
+	reg = emma2rh_in32(EMMA2RH_GPIO_DIR);
+	emma2rh_out32(EMMA2RH_GPIO_DIR, reg & ~GPIO_PCI);
+	/* disable interrupt */
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg & ~GPIO_PCI);
+	/* level triggerd */
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MODE);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MODE, reg | GPIO_PCI);
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_CND_A);
+	emma2rh_out32(EMMA2RH_GPIO_INT_CND_A, reg & (~GPIO_PCI));
+	/* interrupt clear */
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~GPIO_PCI);
+
+	/* init all controllers */
+	emma2rh_irq_init(EMMA2RH_IRQ_BASE);
+	emma2rh_sw_irq_init(EMMA2RH_SW_IRQ_BASE);
+	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
+	mips_cpu_irq_init();
+
+	/* setup cascade interrupts */
+	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
+	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_GPIO_CASCADE, &irq_cascade);
+	setup_irq(CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+        unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (pending & STATUSF_IP7)
+		do_IRQ(CPU_IRQ_BASE + 7);
+	else if (pending & STATUSF_IP2)
+		emma2rh_irq_dispatch();
+	else if (pending & STATUSF_IP1)
+		do_IRQ(CPU_IRQ_BASE + 1);
+	else if (pending & STATUSF_IP0)
+		do_IRQ(CPU_IRQ_BASE + 0);
+	else
+		spurious_interrupt();
+}
+
+
diff --git a/arch/mips/emma/markeins/irq_markeins.c b/arch/mips/emma/markeins/irq_markeins.c
new file mode 100644
index 0000000..fba5c15
--- /dev/null
+++ b/arch/mips/emma/markeins/irq_markeins.c
@@ -0,0 +1,158 @@
+/*
+ *  arch/mips/emma2rh/markeins/irq_markeins.c
+ *      This file defines the irq handler for Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+#include <asm/emma2rh/emma2rh.h>
+
+static int emma2rh_sw_irq_base = -1;
+static int emma2rh_gpio_irq_base = -1;
+
+void ll_emma2rh_sw_irq_enable(int reg);
+void ll_emma2rh_sw_irq_disable(int reg);
+void ll_emma2rh_gpio_irq_enable(int reg);
+void ll_emma2rh_gpio_irq_disable(int reg);
+
+static void emma2rh_sw_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
+}
+
+static void emma2rh_sw_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
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
+void emma2rh_sw_irq_init(u32 irq_base)
+{
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++)
+		set_irq_chip_and_handler(i, &emma2rh_sw_irq_controller,
+					 handle_level_irq);
+
+	emma2rh_sw_irq_base = irq_base;
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
+static void emma2rh_gpio_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
+}
+
+static void emma2rh_gpio_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base);
+}
+
+static void emma2rh_gpio_irq_ack(unsigned int irq)
+{
+	irq -= emma2rh_gpio_irq_base;
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
+	ll_emma2rh_gpio_irq_disable(irq);
+}
+
+static void emma2rh_gpio_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
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
+void emma2rh_gpio_irq_init(u32 irq_base)
+{
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++)
+		set_irq_chip(i, &emma2rh_gpio_irq_controller);
+
+	emma2rh_gpio_irq_base = irq_base;
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
diff --git a/arch/mips/emma/markeins/led.c b/arch/mips/emma/markeins/led.c
new file mode 100644
index 0000000..b65254c
--- /dev/null
+++ b/arch/mips/emma/markeins/led.c
@@ -0,0 +1,60 @@
+/*
+ *  arch/mips/emma2rh/markeins/led.c
+ *      This file defines the led display for Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/emma2rh/emma2rh.h>
+
+const unsigned long clear = 0x20202020;
+
+#define LED_BASE 0xb1400038
+
+void markeins_led_clear(void)
+{
+	emma2rh_out32(LED_BASE, clear);
+	emma2rh_out32(LED_BASE + 4, clear);
+}
+
+void markeins_led(const char *str)
+{
+	int i;
+	int len = strlen(str);
+
+	markeins_led_clear();
+	if (len > 8)
+		len = 8;
+
+	if (emma2rh_in32(0xb0000800) & (0x1 << 18))
+		for (i = 0; i < len; i++)
+			emma2rh_out8(LED_BASE + i, str[i]);
+	else
+		for (i = 0; i < len; i++)
+			emma2rh_out8(LED_BASE + (i & 4) + (3 - (i & 3)),
+				     str[i]);
+}
+
+void markeins_led_hex(u32 val)
+{
+	char str[10];
+
+	sprintf(str, "%08x", val);
+	markeins_led(str);
+}
diff --git a/arch/mips/emma/markeins/platform.c b/arch/mips/emma/markeins/platform.c
new file mode 100644
index 0000000..fb9cda2
--- /dev/null
+++ b/arch/mips/emma/markeins/platform.c
@@ -0,0 +1,191 @@
+/*
+ *  arch/mips/emma2rh/markeins/platofrm.c
+ *      This file sets up platform devices for EMMA2RH Mark-eins.
+ *
+ *  Copyright(C) MontaVista Software Inc, 2006
+ *
+ *  Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/serial_8250.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/bcache.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/traps.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+
+#define I2C_EMMA2RH "emma2rh-iic" /* must be in sync with IIC driver */
+
+static struct resource i2c_emma_resources_0[] = {
+	{
+		.name	= NULL,
+		.start	= EMMA2RH_IRQ_PIIC0,
+		.end	= EMMA2RH_IRQ_PIIC0,
+		.flags	= IORESOURCE_IRQ
+	}, {
+		.name	= NULL,
+		.start	= EMMA2RH_PIIC0_BASE,
+		.end	= EMMA2RH_PIIC0_BASE + 0x1000,
+		.flags	= 0
+	},
+};
+
+struct resource i2c_emma_resources_1[] = {
+	{
+		.name	= NULL,
+		.start	= EMMA2RH_IRQ_PIIC1,
+		.end	= EMMA2RH_IRQ_PIIC1,
+		.flags	= IORESOURCE_IRQ
+	}, {
+		.name	= NULL,
+		.start	= EMMA2RH_PIIC1_BASE,
+		.end	= EMMA2RH_PIIC1_BASE + 0x1000,
+		.flags	= 0
+	},
+};
+
+struct resource i2c_emma_resources_2[] = {
+	{
+		.name	= NULL,
+		.start	= EMMA2RH_IRQ_PIIC2,
+		.end	= EMMA2RH_IRQ_PIIC2,
+		.flags	= IORESOURCE_IRQ
+	}, {
+		.name	= NULL,
+		.start	= EMMA2RH_PIIC2_BASE,
+		.end	= EMMA2RH_PIIC2_BASE + 0x1000,
+		.flags	= 0
+	},
+};
+
+struct platform_device i2c_emma_devices[] = {
+	[0] = {
+		.name = I2C_EMMA2RH,
+		.id = 0,
+		.resource = i2c_emma_resources_0,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_0),
+	},
+	[1] = {
+		.name = I2C_EMMA2RH,
+		.id = 1,
+		.resource = i2c_emma_resources_1,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_1),
+	},
+	[2] = {
+		.name = I2C_EMMA2RH,
+		.id = 2,
+		.resource = i2c_emma_resources_2,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_2),
+	},
+};
+
+#define EMMA2RH_SERIAL_CLOCK 18544000
+#define EMMA2RH_SERIAL_FLAGS UPF_BOOT_AUTOCONF | UPF_SKIP_TEST
+
+static struct  plat_serial8250_port platform_serial_ports[] = {
+	[0] = {
+		.membase= (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3),
+		.irq = EMMA2RH_IRQ_PFUR0,
+		.uartclk = EMMA2RH_SERIAL_CLOCK,
+		.regshift = 4,
+		.iotype = UPIO_MEM,
+		.flags = EMMA2RH_SERIAL_FLAGS,
+       }, [1] = {
+		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3),
+		.irq = EMMA2RH_IRQ_PFUR1,
+		.uartclk = EMMA2RH_SERIAL_CLOCK,
+		.regshift = 4,
+		.iotype = UPIO_MEM,
+		.flags = EMMA2RH_SERIAL_FLAGS,
+       }, [2] = {
+		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR2_BASE + 3),
+		.irq = EMMA2RH_IRQ_PFUR2,
+		.uartclk = EMMA2RH_SERIAL_CLOCK,
+		.regshift = 4,
+		.iotype = UPIO_MEM,
+		.flags = EMMA2RH_SERIAL_FLAGS,
+       }, [3] = {
+		.flags = 0,
+       },
+};
+
+static struct  platform_device serial_emma = {
+	.name = "serial8250",
+	.dev = {
+		.platform_data = &platform_serial_ports,
+	},
+};
+
+static struct platform_device *devices[] = {
+	&i2c_emma_devices[0],
+	&i2c_emma_devices[1],
+	&i2c_emma_devices[2],
+	&serial_emma,
+};
+
+static struct mtd_partition markeins_parts[] = {
+	[0] = {
+		.name = "RootFS",
+		.offset = 0x00000000,
+		.size = 0x00c00000,
+	},
+	[1] = {
+		.name = "boot code area",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00100000,
+	},
+	[2] = {
+		.name = "kernel image",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00300000,
+	},
+	[3] = {
+		.name = "RootFS2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00c00000,
+	},
+	[4] = {
+		.name = "boot code area2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00100000,
+	},
+	[5] = {
+		.name = "kernel image2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+static int __init platform_devices_setup(void)
+{
+	physmap_set_partitions(markeins_parts, ARRAY_SIZE(markeins_parts));
+	return platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+arch_initcall(platform_devices_setup);
+
diff --git a/arch/mips/emma/markeins/setup.c b/arch/mips/emma/markeins/setup.c
new file mode 100644
index 0000000..b6a23ad
--- /dev/null
+++ b/arch/mips/emma/markeins/setup.c
@@ -0,0 +1,135 @@
+/*
+ *  arch/mips/emma2rh/markeins/setup.c
+ *      This file is setup for EMMA2RH Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/setup.c.
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/time.h>
+#include <asm/reboot.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+#define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
+
+extern void markeins_led(const char *);
+
+static int bus_frequency = 0;
+
+static void markeins_machine_restart(char *command)
+{
+	static void (*back_to_prom) (void) = (void (*)(void))0xbfc00000;
+
+	printk("cannot EMMA2RH Mark-eins restart.\n");
+	markeins_led("restart.");
+	back_to_prom();
+}
+
+static void markeins_machine_halt(void)
+{
+	printk("EMMA2RH Mark-eins halted.\n");
+	markeins_led("halted.");
+	while (1) ;
+}
+
+static void markeins_machine_power_off(void)
+{
+	printk("EMMA2RH Mark-eins halted. Please turn off the power.\n");
+	markeins_led("poweroff.");
+	while (1) ;
+}
+
+static unsigned long __initdata emma2rh_clock[4] = {
+	166500000, 187312500, 199800000, 210600000
+};
+
+static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
+{
+	u32 reg;
+
+	/* detect from boot strap */
+	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
+	reg = (reg >> 4) & 0x3;
+
+	return emma2rh_clock[reg];
+}
+
+void __init plat_time_init(void)
+{
+	u32 reg;
+	if (bus_frequency == 0)
+		bus_frequency = detect_bus_frequency(0);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
+	if ((reg & 0x3) == 0)
+		reg = (reg >> 6) & 0x3;
+	else {
+		reg = emma2rh_in32(EMMA2RH_BHIF_MAIN_CTRL);
+		reg = (reg >> 4) & 0x3;
+	}
+	mips_hpt_frequency = (bus_frequency * (4 + reg)) / 4 / 2;
+}
+
+static void markeins_board_init(void);
+extern void markeins_irq_setup(void);
+
+static void inline __init markeins_sio_setup(void)
+{
+}
+
+void __init plat_mem_setup(void)
+{
+	/* initialize board - we don't trust the loader */
+	markeins_board_init();
+
+	set_io_port_base(KSEG1ADDR(EMMA2RH_PCI_IO_BASE));
+
+	_machine_restart = markeins_machine_restart;
+	_machine_halt = markeins_machine_halt;
+	pm_power_off = markeins_machine_power_off;
+
+	/* setup resource limits */
+	ioport_resource.start = EMMA2RH_PCI_IO_BASE;
+	ioport_resource.end = EMMA2RH_PCI_IO_BASE + EMMA2RH_PCI_IO_SIZE - 1;
+	iomem_resource.start = EMMA2RH_IO_BASE;
+	iomem_resource.end = EMMA2RH_ROM_BASE - 1;
+
+	/* Reboot on panic */
+	panic_timeout = 180;
+
+	markeins_sio_setup();
+}
+
+static void __init markeins_board_init(void)
+{
+	u32 val;
+
+	val = emma2rh_in32(EMMA2RH_PBRD_INT_EN);	/* open serial interrupts. */
+	emma2rh_out32(EMMA2RH_PBRD_INT_EN, val | 0xaa);
+	val = emma2rh_in32(EMMA2RH_PBRD_CLKSEL);	/* set serial clocks. */
+	emma2rh_out32(EMMA2RH_PBRD_CLKSEL, val | 0x5);	/* 18MHz */
+	emma2rh_out32(EMMA2RH_PCI_CONTROL, 0);
+
+	markeins_led("MVL E2RH");
+}
diff --git a/arch/mips/emma2rh/common/Makefile b/arch/mips/emma2rh/common/Makefile
deleted file mode 100644
index cb0fd32..0000000
--- a/arch/mips/emma2rh/common/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-#  arch/mips/emma2rh/common/Makefile
-#       Makefile for the common code of NEC EMMA2RH based board.
-#
-#  Copyright (C) NEC Electronics Corporation 2005-2006
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-
-obj-$(CONFIG_NEC_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
diff --git a/arch/mips/emma2rh/common/irq.c b/arch/mips/emma2rh/common/irq.c
deleted file mode 100644
index 91cbd95..0000000
--- a/arch/mips/emma2rh/common/irq.c
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
-#include <asm/emma2rh/emma2rh.h>
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
diff --git a/arch/mips/emma2rh/common/irq_emma2rh.c b/arch/mips/emma2rh/common/irq_emma2rh.c
deleted file mode 100644
index 96df37b..0000000
--- a/arch/mips/emma2rh/common/irq_emma2rh.c
+++ /dev/null
@@ -1,106 +0,0 @@
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
-#include <asm/emma2rh/emma2rh.h>
-
-/* number of total irqs supported by EMMA2RH */
-#define	NUM_EMMA2RH_IRQ		96
-
-static int emma2rh_irq_base = -1;
-
-void ll_emma2rh_irq_enable(int);
-void ll_emma2rh_irq_disable(int);
-
-static void emma2rh_irq_enable(unsigned int irq)
-{
-	ll_emma2rh_irq_enable(irq - emma2rh_irq_base);
-}
-
-static void emma2rh_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
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
-void emma2rh_irq_init(u32 irq_base)
-{
-	u32 i;
-
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++)
-		set_irq_chip_and_handler(i, &emma2rh_irq_controller,
-					 handle_level_irq);
-
-	emma2rh_irq_base = irq_base;
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
diff --git a/arch/mips/emma2rh/common/prom.c b/arch/mips/emma2rh/common/prom.c
deleted file mode 100644
index 97bf29e..0000000
--- a/arch/mips/emma2rh/common/prom.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- *  arch/mips/emma2rh/common/prom.c
- *      This file is prom file.
- *
- *  Copyright (C) NEC Electronics Corporation 2004-2006
- *
- *  This file is based on the arch/mips/ddb5xxx/common/prom.c
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
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <asm/emma2rh/emma2rh.h>
-
-const char *get_system_type(void)
-{
-#ifdef CONFIG_NEC_MARKEINS
-	return "NEC EMMA2RH Mark-eins";
-#else
-#error  Unknown NEC board
-#endif
-}
-
-/* [jsun@junsun.net] PMON passes arguments in C main() style */
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **arg = (char **)fw_arg1;
-	int i;
-
-	/* if user passes kernel args, ignore the default one */
-	if (argc > 1)
-		arcs_cmdline[0] = '\0';
-
-	/* arg[0] is "g", the rest is boot parameters */
-	for (i = 1; i < argc; i++) {
-		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, arg[i]);
-		strcat(arcs_cmdline, " ");
-	}
-
-#ifdef CONFIG_NEC_MARKEINS
-	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
-#else
-#error  Unknown NEC board
-#endif
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/emma2rh/markeins/Makefile b/arch/mips/emma2rh/markeins/Makefile
deleted file mode 100644
index 3c8b864..0000000
--- a/arch/mips/emma2rh/markeins/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-#  arch/mips/emma2rh/markeins/Makefile
-#       Makefile for the common code of NEC EMMA2RH based board.
-#
-#  Copyright (C) NEC Electronics Corporation 2005-2006
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-
-obj-$(CONFIG_NEC_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
diff --git a/arch/mips/emma2rh/markeins/irq.c b/arch/mips/emma2rh/markeins/irq.c
deleted file mode 100644
index 6bcf6a0..0000000
--- a/arch/mips/emma2rh/markeins/irq.c
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- *  arch/mips/emma2rh/markeins/irq.c
- *      This file defines the irq handler for EMMA2RH.
- *
- *  Copyright (C) NEC Electronics Corporation 2004-2006
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
-#include <linux/ptrace.h>
-#include <linux/delay.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/system.h>
-#include <asm/mipsregs.h>
-#include <asm/debug.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-
-#include <asm/emma2rh/emma2rh.h>
-
-/*
- * IRQ mapping
- *
- *  0-7: 8 CPU interrupts
- *	0 -	software interrupt 0
- *	1 - 	software interrupt 1
- *	2 - 	most Vrc5477 interrupts are routed to this pin
- *	3 - 	(optional) some other interrupts routed to this pin for debugg
- *	4 - 	not used
- *	5 - 	not used
- *	6 - 	not used
- *	7 - 	cpu timer (used by default)
- *
- */
-
-extern void emma2rh_sw_irq_init(u32 base);
-extern void emma2rh_gpio_irq_init(u32 base);
-extern void emma2rh_irq_init(u32 base);
-extern void emma2rh_irq_dispatch(void);
-
-static struct irqaction irq_cascade = {
-	   .handler = no_action,
-	   .flags = 0,
-	   .mask = CPU_MASK_NONE,
-	   .name = "cascade",
-	   .dev_id = NULL,
-	   .next = NULL,
-};
-
-void __init arch_init_irq(void)
-{
-	u32 reg;
-
-	db_run(printk("markeins_irq_setup invoked.\n"));
-
-	/* by default, interrupts are disabled. */
-	emma2rh_out32(EMMA2RH_BHIF_INT_EN_0, 0);
-	emma2rh_out32(EMMA2RH_BHIF_INT_EN_1, 0);
-	emma2rh_out32(EMMA2RH_BHIF_INT_EN_2, 0);
-	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_0, 0);
-	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_1, 0);
-	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_2, 0);
-	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, 0);
-
-	clear_c0_status(0xff00);
-	set_c0_status(0x0400);
-
-#define GPIO_PCI (0xf<<15)
-	/* setup GPIO interrupt for PCI interface */
-	/* direction input */
-	reg = emma2rh_in32(EMMA2RH_GPIO_DIR);
-	emma2rh_out32(EMMA2RH_GPIO_DIR, reg & ~GPIO_PCI);
-	/* disable interrupt */
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
-	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg & ~GPIO_PCI);
-	/* level triggerd */
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MODE);
-	emma2rh_out32(EMMA2RH_GPIO_INT_MODE, reg | GPIO_PCI);
-	reg = emma2rh_in32(EMMA2RH_GPIO_INT_CND_A);
-	emma2rh_out32(EMMA2RH_GPIO_INT_CND_A, reg & (~GPIO_PCI));
-	/* interrupt clear */
-	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~GPIO_PCI);
-
-	/* init all controllers */
-	emma2rh_irq_init(EMMA2RH_IRQ_BASE);
-	emma2rh_sw_irq_init(EMMA2RH_SW_IRQ_BASE);
-	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
-	mips_cpu_irq_init();
-
-	/* setup cascade interrupts */
-	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
-	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_GPIO_CASCADE, &irq_cascade);
-	setup_irq(CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-        unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP7)
-		do_IRQ(CPU_IRQ_BASE + 7);
-	else if (pending & STATUSF_IP2)
-		emma2rh_irq_dispatch();
-	else if (pending & STATUSF_IP1)
-		do_IRQ(CPU_IRQ_BASE + 1);
-	else if (pending & STATUSF_IP0)
-		do_IRQ(CPU_IRQ_BASE + 0);
-	else
-		spurious_interrupt();
-}
-
-
diff --git a/arch/mips/emma2rh/markeins/irq_markeins.c b/arch/mips/emma2rh/markeins/irq_markeins.c
deleted file mode 100644
index fba5c15..0000000
--- a/arch/mips/emma2rh/markeins/irq_markeins.c
+++ /dev/null
@@ -1,158 +0,0 @@
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
-#include <asm/emma2rh/emma2rh.h>
-
-static int emma2rh_sw_irq_base = -1;
-static int emma2rh_gpio_irq_base = -1;
-
-void ll_emma2rh_sw_irq_enable(int reg);
-void ll_emma2rh_sw_irq_disable(int reg);
-void ll_emma2rh_gpio_irq_enable(int reg);
-void ll_emma2rh_gpio_irq_disable(int reg);
-
-static void emma2rh_sw_irq_enable(unsigned int irq)
-{
-	ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
-}
-
-static void emma2rh_sw_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
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
-void emma2rh_sw_irq_init(u32 irq_base)
-{
-	u32 i;
-
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip_and_handler(i, &emma2rh_sw_irq_controller,
-					 handle_level_irq);
-
-	emma2rh_sw_irq_base = irq_base;
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
-	ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
-}
-
-static void emma2rh_gpio_irq_disable(unsigned int irq)
-{
-	ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base);
-}
-
-static void emma2rh_gpio_irq_ack(unsigned int irq)
-{
-	irq -= emma2rh_gpio_irq_base;
-	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
-	ll_emma2rh_gpio_irq_disable(irq);
-}
-
-static void emma2rh_gpio_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
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
-void emma2rh_gpio_irq_init(u32 irq_base)
-{
-	u32 i;
-
-	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++)
-		set_irq_chip(i, &emma2rh_gpio_irq_controller);
-
-	emma2rh_gpio_irq_base = irq_base;
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
diff --git a/arch/mips/emma2rh/markeins/led.c b/arch/mips/emma2rh/markeins/led.c
deleted file mode 100644
index b65254c..0000000
--- a/arch/mips/emma2rh/markeins/led.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *  arch/mips/emma2rh/markeins/led.c
- *      This file defines the led display for Mark-eins.
- *
- *  Copyright (C) NEC Electronics Corporation 2004-2006
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
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <asm/emma2rh/emma2rh.h>
-
-const unsigned long clear = 0x20202020;
-
-#define LED_BASE 0xb1400038
-
-void markeins_led_clear(void)
-{
-	emma2rh_out32(LED_BASE, clear);
-	emma2rh_out32(LED_BASE + 4, clear);
-}
-
-void markeins_led(const char *str)
-{
-	int i;
-	int len = strlen(str);
-
-	markeins_led_clear();
-	if (len > 8)
-		len = 8;
-
-	if (emma2rh_in32(0xb0000800) & (0x1 << 18))
-		for (i = 0; i < len; i++)
-			emma2rh_out8(LED_BASE + i, str[i]);
-	else
-		for (i = 0; i < len; i++)
-			emma2rh_out8(LED_BASE + (i & 4) + (3 - (i & 3)),
-				     str[i]);
-}
-
-void markeins_led_hex(u32 val)
-{
-	char str[10];
-
-	sprintf(str, "%08x", val);
-	markeins_led(str);
-}
diff --git a/arch/mips/emma2rh/markeins/platform.c b/arch/mips/emma2rh/markeins/platform.c
deleted file mode 100644
index fb9cda2..0000000
--- a/arch/mips/emma2rh/markeins/platform.c
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- *  arch/mips/emma2rh/markeins/platofrm.c
- *      This file sets up platform devices for EMMA2RH Mark-eins.
- *
- *  Copyright(C) MontaVista Software Inc, 2006
- *
- *  Author: dmitry pervushin <dpervushin@ru.mvista.com>
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
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
-#include <linux/serial_8250.h>
-#include <linux/mtd/physmap.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/addrspace.h>
-#include <asm/time.h>
-#include <asm/bcache.h>
-#include <asm/irq.h>
-#include <asm/reboot.h>
-#include <asm/traps.h>
-
-#include <asm/emma2rh/emma2rh.h>
-
-
-#define I2C_EMMA2RH "emma2rh-iic" /* must be in sync with IIC driver */
-
-static struct resource i2c_emma_resources_0[] = {
-	{
-		.name	= NULL,
-		.start	= EMMA2RH_IRQ_PIIC0,
-		.end	= EMMA2RH_IRQ_PIIC0,
-		.flags	= IORESOURCE_IRQ
-	}, {
-		.name	= NULL,
-		.start	= EMMA2RH_PIIC0_BASE,
-		.end	= EMMA2RH_PIIC0_BASE + 0x1000,
-		.flags	= 0
-	},
-};
-
-struct resource i2c_emma_resources_1[] = {
-	{
-		.name	= NULL,
-		.start	= EMMA2RH_IRQ_PIIC1,
-		.end	= EMMA2RH_IRQ_PIIC1,
-		.flags	= IORESOURCE_IRQ
-	}, {
-		.name	= NULL,
-		.start	= EMMA2RH_PIIC1_BASE,
-		.end	= EMMA2RH_PIIC1_BASE + 0x1000,
-		.flags	= 0
-	},
-};
-
-struct resource i2c_emma_resources_2[] = {
-	{
-		.name	= NULL,
-		.start	= EMMA2RH_IRQ_PIIC2,
-		.end	= EMMA2RH_IRQ_PIIC2,
-		.flags	= IORESOURCE_IRQ
-	}, {
-		.name	= NULL,
-		.start	= EMMA2RH_PIIC2_BASE,
-		.end	= EMMA2RH_PIIC2_BASE + 0x1000,
-		.flags	= 0
-	},
-};
-
-struct platform_device i2c_emma_devices[] = {
-	[0] = {
-		.name = I2C_EMMA2RH,
-		.id = 0,
-		.resource = i2c_emma_resources_0,
-		.num_resources = ARRAY_SIZE(i2c_emma_resources_0),
-	},
-	[1] = {
-		.name = I2C_EMMA2RH,
-		.id = 1,
-		.resource = i2c_emma_resources_1,
-		.num_resources = ARRAY_SIZE(i2c_emma_resources_1),
-	},
-	[2] = {
-		.name = I2C_EMMA2RH,
-		.id = 2,
-		.resource = i2c_emma_resources_2,
-		.num_resources = ARRAY_SIZE(i2c_emma_resources_2),
-	},
-};
-
-#define EMMA2RH_SERIAL_CLOCK 18544000
-#define EMMA2RH_SERIAL_FLAGS UPF_BOOT_AUTOCONF | UPF_SKIP_TEST
-
-static struct  plat_serial8250_port platform_serial_ports[] = {
-	[0] = {
-		.membase= (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3),
-		.irq = EMMA2RH_IRQ_PFUR0,
-		.uartclk = EMMA2RH_SERIAL_CLOCK,
-		.regshift = 4,
-		.iotype = UPIO_MEM,
-		.flags = EMMA2RH_SERIAL_FLAGS,
-       }, [1] = {
-		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3),
-		.irq = EMMA2RH_IRQ_PFUR1,
-		.uartclk = EMMA2RH_SERIAL_CLOCK,
-		.regshift = 4,
-		.iotype = UPIO_MEM,
-		.flags = EMMA2RH_SERIAL_FLAGS,
-       }, [2] = {
-		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR2_BASE + 3),
-		.irq = EMMA2RH_IRQ_PFUR2,
-		.uartclk = EMMA2RH_SERIAL_CLOCK,
-		.regshift = 4,
-		.iotype = UPIO_MEM,
-		.flags = EMMA2RH_SERIAL_FLAGS,
-       }, [3] = {
-		.flags = 0,
-       },
-};
-
-static struct  platform_device serial_emma = {
-	.name = "serial8250",
-	.dev = {
-		.platform_data = &platform_serial_ports,
-	},
-};
-
-static struct platform_device *devices[] = {
-	&i2c_emma_devices[0],
-	&i2c_emma_devices[1],
-	&i2c_emma_devices[2],
-	&serial_emma,
-};
-
-static struct mtd_partition markeins_parts[] = {
-	[0] = {
-		.name = "RootFS",
-		.offset = 0x00000000,
-		.size = 0x00c00000,
-	},
-	[1] = {
-		.name = "boot code area",
-		.offset = MTDPART_OFS_APPEND,
-		.size = 0x00100000,
-	},
-	[2] = {
-		.name = "kernel image",
-		.offset = MTDPART_OFS_APPEND,
-		.size = 0x00300000,
-	},
-	[3] = {
-		.name = "RootFS2",
-		.offset = MTDPART_OFS_APPEND,
-		.size = 0x00c00000,
-	},
-	[4] = {
-		.name = "boot code area2",
-		.offset = MTDPART_OFS_APPEND,
-		.size = 0x00100000,
-	},
-	[5] = {
-		.name = "kernel image2",
-		.offset = MTDPART_OFS_APPEND,
-		.size = MTDPART_SIZ_FULL,
-	},
-};
-
-static int __init platform_devices_setup(void)
-{
-	physmap_set_partitions(markeins_parts, ARRAY_SIZE(markeins_parts));
-	return platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-arch_initcall(platform_devices_setup);
-
diff --git a/arch/mips/emma2rh/markeins/setup.c b/arch/mips/emma2rh/markeins/setup.c
deleted file mode 100644
index b6a23ad..0000000
--- a/arch/mips/emma2rh/markeins/setup.c
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- *  arch/mips/emma2rh/markeins/setup.c
- *      This file is setup for EMMA2RH Mark-eins.
- *
- *  Copyright (C) NEC Electronics Corporation 2004-2006
- *
- *  This file is based on the arch/mips/ddb5xxx/ddb5477/setup.c.
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
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include <asm/time.h>
-#include <asm/reboot.h>
-
-#include <asm/emma2rh/emma2rh.h>
-
-#define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
-
-extern void markeins_led(const char *);
-
-static int bus_frequency = 0;
-
-static void markeins_machine_restart(char *command)
-{
-	static void (*back_to_prom) (void) = (void (*)(void))0xbfc00000;
-
-	printk("cannot EMMA2RH Mark-eins restart.\n");
-	markeins_led("restart.");
-	back_to_prom();
-}
-
-static void markeins_machine_halt(void)
-{
-	printk("EMMA2RH Mark-eins halted.\n");
-	markeins_led("halted.");
-	while (1) ;
-}
-
-static void markeins_machine_power_off(void)
-{
-	printk("EMMA2RH Mark-eins halted. Please turn off the power.\n");
-	markeins_led("poweroff.");
-	while (1) ;
-}
-
-static unsigned long __initdata emma2rh_clock[4] = {
-	166500000, 187312500, 199800000, 210600000
-};
-
-static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
-{
-	u32 reg;
-
-	/* detect from boot strap */
-	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
-	reg = (reg >> 4) & 0x3;
-
-	return emma2rh_clock[reg];
-}
-
-void __init plat_time_init(void)
-{
-	u32 reg;
-	if (bus_frequency == 0)
-		bus_frequency = detect_bus_frequency(0);
-
-	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
-	if ((reg & 0x3) == 0)
-		reg = (reg >> 6) & 0x3;
-	else {
-		reg = emma2rh_in32(EMMA2RH_BHIF_MAIN_CTRL);
-		reg = (reg >> 4) & 0x3;
-	}
-	mips_hpt_frequency = (bus_frequency * (4 + reg)) / 4 / 2;
-}
-
-static void markeins_board_init(void);
-extern void markeins_irq_setup(void);
-
-static void inline __init markeins_sio_setup(void)
-{
-}
-
-void __init plat_mem_setup(void)
-{
-	/* initialize board - we don't trust the loader */
-	markeins_board_init();
-
-	set_io_port_base(KSEG1ADDR(EMMA2RH_PCI_IO_BASE));
-
-	_machine_restart = markeins_machine_restart;
-	_machine_halt = markeins_machine_halt;
-	pm_power_off = markeins_machine_power_off;
-
-	/* setup resource limits */
-	ioport_resource.start = EMMA2RH_PCI_IO_BASE;
-	ioport_resource.end = EMMA2RH_PCI_IO_BASE + EMMA2RH_PCI_IO_SIZE - 1;
-	iomem_resource.start = EMMA2RH_IO_BASE;
-	iomem_resource.end = EMMA2RH_ROM_BASE - 1;
-
-	/* Reboot on panic */
-	panic_timeout = 180;
-
-	markeins_sio_setup();
-}
-
-static void __init markeins_board_init(void)
-{
-	u32 val;
-
-	val = emma2rh_in32(EMMA2RH_PBRD_INT_EN);	/* open serial interrupts. */
-	emma2rh_out32(EMMA2RH_PBRD_INT_EN, val | 0xaa);
-	val = emma2rh_in32(EMMA2RH_PBRD_CLKSEL);	/* set serial clocks. */
-	emma2rh_out32(EMMA2RH_PBRD_CLKSEL, val | 0x5);	/* 18MHz */
-	emma2rh_out32(EMMA2RH_PCI_CONTROL, 0);
-
-	markeins_led("MVL E2RH");
-}
