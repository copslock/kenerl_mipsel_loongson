Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Feb 2008 11:16:58 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.180]:63645 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S28587552AbYB0LQx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Feb 2008 11:16:53 +0000
Received: by py-out-1112.google.com with SMTP id a73so2951649pye.22
        for <linux-mips@linux-mips.org>; Wed, 27 Feb 2008 03:16:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=ptJHVtCH+wm/r4ffqemB3BRUXMDW8kK+NBsj890uzoI=;
        b=QqCiGMinR8I4+niODuL3zv+XX9t5DSOFyNK5BjPi++oPRy7DfleuUrcKuACLjPcnVZ2A/mP8SoNo0s8n/uySj0U5Kd1XuWX/9lj1DZWyBRUDiaDLPb5vaCW5DE8kJ24GZv1mRPmXDggptJibNw+quum/RaSffBp0GtkzDiuEJ7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=U/z8z1PcZ6lFc5dfWmIkTf36cJVW2zUj0wEUWT4i3k6Z6pLEgooIzx9mJzfxzjKVNJLRbBm9QsCMqUtoS9RL1q23IgwM7XC/T2wgs5jLdreCGef9UJTGfnmWhTmxzI4QDUjbt641/JImU37xcrKPjtMKzxte5h3ktqcEGTeWI6g=
Received: by 10.64.179.12 with SMTP id b12mr3298440qbf.96.1204111010484;
        Wed, 27 Feb 2008 03:16:50 -0800 (PST)
Received: by 10.65.141.5 with HTTP; Wed, 27 Feb 2008 03:16:50 -0800 (PST)
Message-ID: <64660ef00802270316s7164fcf6x5baf67c48029b730@mail.gmail.com>
Date:	Wed, 27 Feb 2008 11:16:50 +0000
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH: linux-mips 2.6.24.2]: Move arch/mips/philips to arch/mips/nxp
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: b25291d21763e777
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

The following patch moves arch/mips/philips to arch/mips/nxp along
with the supporting changes:
This is required before I can start posting new chipset support.

 arch/mips/Kconfig                              |    4
 arch/mips/Makefile                             |   12 -
 arch/mips/kernel/cpu-probe.c                   |   10 -
 arch/mips/nxp/pnx8550/common/Makefile          |   29 +++
 arch/mips/nxp/pnx8550/common/gdb_hook.c        |  109 +++++++++++
 arch/mips/nxp/pnx8550/common/int.c             |  238 +++++++++++++++++++++++++
 arch/mips/nxp/pnx8550/common/pci.c             |  133 +++++++++++++
 arch/mips/nxp/pnx8550/common/platform.c        |  132 +++++++++++++
 arch/mips/nxp/pnx8550/common/proc.c            |  112 +++++++++++
 arch/mips/nxp/pnx8550/common/prom.c            |  129 +++++++++++++
 arch/mips/nxp/pnx8550/common/reset.c           |   49 +++++
 arch/mips/nxp/pnx8550/common/setup.c           |  157 ++++++++++++++++
 arch/mips/nxp/pnx8550/common/time.c            |  163 +++++++++++++++++
 arch/mips/nxp/pnx8550/jbs/Makefile             |    4
 arch/mips/nxp/pnx8550/jbs/board_setup.c        |   65 ++++++
 arch/mips/nxp/pnx8550/jbs/init.c               |   56 +++++
 arch/mips/nxp/pnx8550/jbs/irqmap.c             |   36 +++
 arch/mips/nxp/pnx8550/stb810/Makefile          |    4
 arch/mips/nxp/pnx8550/stb810/board_setup.c     |   49 +++++
 arch/mips/nxp/pnx8550/stb810/irqmap.c          |   23 ++
 arch/mips/nxp/pnx8550/stb810/prom_init.c       |   48 +++++
 arch/mips/philips/pnx8550/common/Makefile      |   29 ---
 arch/mips/philips/pnx8550/common/gdb_hook.c    |  109 -----------
 arch/mips/philips/pnx8550/common/int.c         |  238 -------------------------
 arch/mips/philips/pnx8550/common/pci.c         |  133 -------------
 arch/mips/philips/pnx8550/common/platform.c    |  132 -------------
 arch/mips/philips/pnx8550/common/proc.c        |  112 -----------
 arch/mips/philips/pnx8550/common/prom.c        |  129 -------------
 arch/mips/philips/pnx8550/common/reset.c       |   49 -----
 arch/mips/philips/pnx8550/common/setup.c       |  157 ----------------
 arch/mips/philips/pnx8550/common/time.c        |  163 -----------------
 arch/mips/philips/pnx8550/jbs/Makefile         |    4
 arch/mips/philips/pnx8550/jbs/board_setup.c    |   65 ------
 arch/mips/philips/pnx8550/jbs/init.c           |   56 -----
 arch/mips/philips/pnx8550/jbs/irqmap.c         |   36 ---
 arch/mips/philips/pnx8550/stb810/Makefile      |    4
 arch/mips/philips/pnx8550/stb810/board_setup.c |   49 -----
 arch/mips/philips/pnx8550/stb810/irqmap.c      |   23 --
 arch/mips/philips/pnx8550/stb810/prom_init.c   |   48 -----
 drivers/serial/Kconfig                         |    4
 include/asm-mips/bootinfo.h                    |    8
 include/asm-mips/cpu.h                         |    2
 42 files changed, 1558 insertions(+), 1554 deletions(-)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN linux-2.6.24.2.orig/arch/mips/Kconfig linux-2.6.24.2/arch/mips/Kconfig
--- linux-2.6.24.2.orig/arch/mips/Kconfig	2008-02-26 08:22:58.000000000 +0000
+++ linux-2.6.24.2/arch/mips/Kconfig	2008-02-26 08:32:25.000000000 +0000
@@ -312,12 +312,12 @@
 	select GENERIC_HARDIRQS_NO__DO_IRQ

 config PNX8550_JBS
-	bool "Philips PNX8550 based JBS board"
+	bool "NXP PNX8550 based JBS board"
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN

 config PNX8550_STB810
-	bool "Philips PNX8550 based STB810 board"
+	bool "NXP PNX8550 based STB810 board"
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN

diff -urN linux-2.6.24.2.orig/arch/mips/kernel/cpu-probe.c
linux-2.6.24.2/arch/mips/kernel/cpu-probe.c
--- linux-2.6.24.2.orig/arch/mips/kernel/cpu-probe.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/kernel/cpu-probe.c	2008-02-26
08:36:32.000000000 +0000
@@ -771,7 +771,7 @@
 	}
 }

-static inline void cpu_probe_philips(struct cpuinfo_mips *c)
+static inline void cpu_probe_nxp(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
 	switch (c->processor_id & 0xff00) {
@@ -780,7 +780,7 @@
 		c->isa_level = MIPS_CPU_ISA_M32R1;
 		break;
 	default:
-		panic("Unknown Philips Core!"); /* REVISIT: die? */
+		panic("Unknown NXP Core!"); /* REVISIT: die? */
 		break;
 	}
 }
@@ -878,7 +878,7 @@
 	case CPU_SR71000:	name = "Sandcraft SR71000"; break;
 	case CPU_BCM3302:	name = "Broadcom BCM3302"; break;
 	case CPU_BCM4710:	name = "Broadcom BCM4710"; break;
-	case CPU_PR4450:	name = "Philips PR4450"; break;
+	case CPU_PR4450:	name = "NXP PR4450"; break;
 	case CPU_LOONGSON2:	name = "ICT Loongson-2"; break;
 	default:
 		BUG();
@@ -916,8 +916,8 @@
 	case PRID_COMP_SANDCRAFT:
 		cpu_probe_sandcraft(c);
 		break;
- 	case PRID_COMP_PHILIPS:
-		cpu_probe_philips(c);
+ 	case PRID_COMP_NXP:
+		cpu_probe_nxp(c);
 		break;
 	default:
 		c->cputype = CPU_UNKNOWN;
diff -urN linux-2.6.24.2.orig/arch/mips/Makefile
linux-2.6.24.2/arch/mips/Makefile
--- linux-2.6.24.2.orig/arch/mips/Makefile	2008-02-26 08:22:58.000000000 +0000
+++ linux-2.6.24.2/arch/mips/Makefile	2008-02-26 08:36:21.000000000 +0000
@@ -410,21 +410,21 @@
 load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000

 #
-# Common Philips PNX8550
+# Common NXP PNX8550
 #
-core-$(CONFIG_SOC_PNX8550)	+= arch/mips/philips/pnx8550/common/
+core-$(CONFIG_SOC_PNX8550)	+= arch/mips/nxp/pnx8550/common/
 cflags-$(CONFIG_SOC_PNX8550)	+= -Iinclude/asm-mips/mach-pnx8550

 #
-# Philips PNX8550 JBS board
+# NXP PNX8550 JBS board
 #
-libs-$(CONFIG_PNX8550_JBS)	+= arch/mips/philips/pnx8550/jbs/
+libs-$(CONFIG_PNX8550_JBS)	+= arch/mips/nxp/pnx8550/jbs/
 #cflags-$(CONFIG_PNX8550_JBS)	+= -Iinclude/asm-mips/mach-pnx8550
 load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff80060000

-# Philips PNX8550 STB810 board
+# NXP PNX8550 STB810 board
 #
-libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/philips/pnx8550/stb810/
+libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/nxp/pnx8550/stb810/
 load-$(CONFIG_PNX8550_STB810)	+= 0xffffffff80060000

 # NEC EMMA2RH boards
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/gdb_hook.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/gdb_hook.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/gdb_hook.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/gdb_hook.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,109 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * This is the interface to the remote debugger stub.
+ *
+ */
+#include <linux/types.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_ip3106.h>
+
+#include <asm/serial.h>
+#include <asm/io.h>
+
+#include <uart.h>
+
+static struct serial_state rs_table[IP3106_NR_PORTS] = {
+};
+static struct async_struct kdb_port_info = {0};
+
+void rs_kgdb_hook(int tty_no)
+{
+	struct serial_state *ser = &rs_table[tty_no];
+
+	kdb_port_info.state = ser;
+	kdb_port_info.magic = SERIAL_MAGIC;
+	kdb_port_info.port  = tty_no;
+	kdb_port_info.flags = ser->flags;
+
+	/*
+	 * Clear all interrupts
+	 */
+	/* Clear all the transmitter FIFO counters (pointer and status) */
+	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_TX_RST;
+	/* Clear all the receiver FIFO counters (pointer and status) */
+	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_RX_RST;
+	/* Clear all interrupts */
+	ip3106_iclr(UART_BASE, tty_no) = IP3106_UART_INT_ALLRX |
+		IP3106_UART_INT_ALLTX;
+
+	/*
+	 * Now, initialize the UART
+	 */
+	ip3106_lcr(UART_BASE, tty_no) = IP3106_UART_LCR_8BIT;
+	ip3106_baud(UART_BASE, tty_no) = 5; // 38400 Baud
+}
+
+int putDebugChar(char c)
+{
+	/* Wait until FIFO not full */
+	while (((ip3106_fifo(UART_BASE, kdb_port_info.port) &
IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
+		;
+	/* Send one char */
+	ip3106_fifo(UART_BASE, kdb_port_info.port) = c;
+
+	return 1;
+}
+
+char getDebugChar(void)
+{
+	char ch;
+
+	/* Wait until there is a char in the FIFO */
+	while (!((ip3106_fifo(UART_BASE, kdb_port_info.port) &
+					IP3106_UART_FIFO_RXFIFO) >> 8))
+		;
+	/* Read one char */
+	ch = ip3106_fifo(UART_BASE, kdb_port_info.port) &
+		IP3106_UART_FIFO_RBRTHR;
+	/* Advance the RX FIFO read pointer */
+	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_NEXT;
+	return (ch);
+}
+
+void rs_disable_debug_interrupts(void)
+{
+	ip3106_ien(UART_BASE, kdb_port_info.port) = 0; /* Disable all interrupts */
+}
+
+void rs_enable_debug_interrupts(void)
+{
+	/* Clear all the transmitter FIFO counters (pointer and status) */
+	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_TX_RST;
+	/* Clear all the receiver FIFO counters (pointer and status) */
+	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_RST;
+	/* Clear all interrupts */
+	ip3106_iclr(UART_BASE, kdb_port_info.port) = IP3106_UART_INT_ALLRX |
+		IP3106_UART_INT_ALLTX;
+	ip3106_ien(UART_BASE, kdb_port_info.port)  = IP3106_UART_INT_ALLRX;
/* Enable RX interrupts */
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/int.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/int.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/int.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/int.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,238 @@
+/*
+ *
+ * Copyright (C) 2005 Embedded Alley Solutions, Inc
+ * Ported to 2.6.
+ *
+ * Per Hallsmark, per.hallsmark@mvista.com
+ * Copyright (C) 2000, 2001 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
+ *
+ * Cleaned up and bug fixing: Pete Popov, ppopov@embeddedalley.com
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/random.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/gdb-stub.h>
+#include <int.h>
+#include <uart.h>
+
+/* default prio for interrupts */
+/* first one is a no-no so therefore always prio 0 (disabled) */
+static char gic_prio[PNX8550_INT_GIC_TOTINT] = {
+	0, 1, 1, 1, 1, 15, 1, 1, 1, 1,	//   0 -  9
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  10 - 19
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  20 - 29
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  30 - 39
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  40 - 49
+	1, 1, 1, 1, 1, 1, 1, 1, 2, 1,	//  50 - 59
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  60 - 69
+	1			//  70
+};
+
+static void hw0_irqdispatch(int irq)
+{
+	/* find out which interrupt */
+	irq = PNX8550_GIC_VECTOR_0 >> 3;
+
+	if (irq == 0) {
+		printk("hw0_irqdispatch: irq 0, spurious interrupt?\n");
+		return;
+	}
+	do_IRQ(PNX8550_INT_GIC_MIN + irq);
+}
+
+
+static void timer_irqdispatch(int irq)
+{
+	irq = (0x01c0 & read_c0_config7()) >> 6;
+
+	if (unlikely(irq == 0)) {
+		printk("timer_irqdispatch: irq 0, spurious interrupt?\n");
+		return;
+	}
+
+	if (irq & 0x1)
+		do_IRQ(PNX8550_INT_TIMER1);
+	if (irq & 0x2)
+		do_IRQ(PNX8550_INT_TIMER2);
+	if (irq & 0x4)
+		do_IRQ(PNX8550_INT_TIMER3);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (pending & STATUSF_IP2)
+		hw0_irqdispatch(2);
+	else if (pending & STATUSF_IP7) {
+		if (read_c0_config7() & 0x01c0)
+			timer_irqdispatch(7);
+	} else
+		spurious_interrupt();
+}
+
+static inline void modify_cp0_intmask(unsigned clr_mask, unsigned set_mask)
+{
+	unsigned long status = read_c0_status();
+
+	status &= ~((clr_mask & 0xFF) << 8);
+	status |= (set_mask & 0xFF) << 8;
+
+	write_c0_status(status);
+}
+
+static inline void mask_gic_int(unsigned int irq_nr)
+{
+	/* interrupt disabled, bit 26(WE_ENABLE)=1 and bit 16(enable)=0 */
+	PNX8550_GIC_REQ(irq_nr) = 1<<28; /* set priority to 0 */
+}
+
+static inline void unmask_gic_int(unsigned int irq_nr)
+{
+	/* set prio mask to lower four bits and enable interrupt */
+	PNX8550_GIC_REQ(irq_nr) = (1<<26 | 1<<16) | (1<<28) | gic_prio[irq_nr];
+}
+
+static inline void mask_irq(unsigned int irq_nr)
+{
+	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
+		modify_cp0_intmask(1 << irq_nr, 0);
+	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
+		(irq_nr <= PNX8550_INT_GIC_MAX)) {
+		mask_gic_int(irq_nr - PNX8550_INT_GIC_MIN);
+	} else if ((PNX8550_INT_TIMER_MIN <= irq_nr) &&
+		(irq_nr <= PNX8550_INT_TIMER_MAX)) {
+		modify_cp0_intmask(1 << 7, 0);
+	} else {
+		printk("mask_irq: irq %d doesn't exist!\n", irq_nr);
+	}
+}
+
+static inline void unmask_irq(unsigned int irq_nr)
+{
+	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
+		modify_cp0_intmask(0, 1 << irq_nr);
+	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
+		(irq_nr <= PNX8550_INT_GIC_MAX)) {
+		unmask_gic_int(irq_nr - PNX8550_INT_GIC_MIN);
+	} else if ((PNX8550_INT_TIMER_MIN <= irq_nr) &&
+		(irq_nr <= PNX8550_INT_TIMER_MAX)) {
+		modify_cp0_intmask(0, 1 << 7);
+	} else {
+		printk("mask_irq: irq %d doesn't exist!\n", irq_nr);
+	}
+}
+
+int pnx8550_set_gic_priority(int irq, int priority)
+{
+	int gic_irq = irq-PNX8550_INT_GIC_MIN;
+	int prev_priority = PNX8550_GIC_REQ(gic_irq) & 0xf;
+
+        gic_prio[gic_irq] = priority;
+	PNX8550_GIC_REQ(gic_irq) |= (0x10000000 | gic_prio[gic_irq]);
+
+	return prev_priority;
+}
+
+static struct irq_chip level_irq_type = {
+	.name =		"PNX Level IRQ",
+	.ack =		mask_irq,
+	.mask =		mask_irq,
+	.mask_ack =	mask_irq,
+	.unmask =	unmask_irq,
+};
+
+static struct irqaction gic_action = {
+	.handler =	no_action,
+	.flags =	IRQF_DISABLED,
+	.name =		"GIC",
+};
+
+static struct irqaction timer_action = {
+	.handler =	no_action,
+	.flags =	IRQF_DISABLED,
+	.name =		"Timer",
+};
+
+void __init arch_init_irq(void)
+{
+	int i;
+	int configPR;
+
+	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+		mask_irq(i);	/* mask the irq just in case  */
+	}
+
+	/* init of GIC/IPC interrupts */
+	/* should be done before cp0 since cp0 init enables the GIC int */
+	for (i = PNX8550_INT_GIC_MIN; i <= PNX8550_INT_GIC_MAX; i++) {
+		int gic_int_line = i - PNX8550_INT_GIC_MIN;
+		if (gic_int_line == 0 )
+			continue;	// don't fiddle with int 0
+		/*
+		 * enable change of TARGET, ENABLE and ACTIVE_LOW bits
+		 * set TARGET        0 to route through hw0 interrupt
+		 * set ACTIVE_LOW    0 active high  (correct?)
+		 *
+		 * We really should setup an interrupt description table
+		 * to do this nicely.
+		 * Note, PCI INTA is active low on the bus, but inverted
+		 * in the GIC, so to us it's active high.
+		 */
+		PNX8550_GIC_REQ(i - PNX8550_INT_GIC_MIN) = 0x1E000000;
+
+		/* mask/priority is still 0 so we will not get any
+		 * interrupts until it is unmasked */
+
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+	}
+
+	/* Priority level 0 */
+	PNX8550_GIC_PRIMASK_0 = PNX8550_GIC_PRIMASK_1 = 0;
+
+	/* Set int vector table address */
+	PNX8550_GIC_VECTOR_0 = PNX8550_GIC_VECTOR_1 = 0;
+
+	set_irq_chip_and_handler(MIPS_CPU_GIC_IRQ, &level_irq_type,
+				 handle_level_irq);
+	setup_irq(MIPS_CPU_GIC_IRQ, &gic_action);
+
+	/* init of Timer interrupts */
+	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++)
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+
+	/* Stop Timer 1-3 */
+	configPR = read_c0_config7();
+	configPR |= 0x00000038;
+	write_c0_config7(configPR);
+
+	set_irq_chip_and_handler(MIPS_CPU_TIMER_IRQ, &level_irq_type,
+				 handle_level_irq);
+	setup_irq(MIPS_CPU_TIMER_IRQ, &timer_action);
+}
+
+EXPORT_SYMBOL(pnx8550_set_gic_priority);
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/Makefile
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/Makefile
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/Makefile	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,29 @@
+#
+# Per Hallsmark, per.hallsmark@mvista.com
+#
+# ########################################################################
+#
+# This program is free software; you can distribute it and/or modify it
+# under the terms of the GNU General Public License (Version 2) as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+#
+# #######################################################################
+#
+# Makefile for the PNX8550 specific kernel interface routines
+# under Linux.
+#
+
+obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
+obj-$(CONFIG_PCI) += pci.o
+obj-$(CONFIG_KGDB) += gdb_hook.o
+
+EXTRA_CFLAGS += -Werror
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/pci.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/pci.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/pci.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/pci.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,133 @@
+/*
+ *
+ * BRIEF MODULE DESCRIPTION
+ *
+ * Author: source@mvista.com
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <pci.h>
+#include <glb.h>
+#include <nand.h>
+
+static struct resource pci_io_resource = {
+	.start	= PNX8550_PCIIO + 0x1000,	/* reserve regacy I/O space */
+	.end	= PNX8550_PCIIO + PNX8550_PCIIO_SIZE,
+	.name	= "pci IO space",
+	.flags	= IORESOURCE_IO
+};
+
+static struct resource pci_mem_resource = {
+	.start	= PNX8550_PCIMEM,
+	.end	= PNX8550_PCIMEM + PNX8550_PCIMEM_SIZE - 1,
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM
+};
+
+extern struct pci_ops pnx8550_pci_ops;
+
+static struct pci_controller pnx8550_controller = {
+	.pci_ops	= &pnx8550_pci_ops,
+	.io_resource	= &pci_io_resource,
+	.mem_resource	= &pci_mem_resource,
+};
+
+/* Return the total size of DRAM-memory, (RANK0 + RANK1) */
+static inline unsigned long get_system_mem_size(void)
+{
+	/* Read IP2031_RANK0_ADDR_LO */
+	unsigned long dram_r0_lo = inl(PCI_BASE | 0x65010);
+	/* Read IP2031_RANK1_ADDR_HI */
+	unsigned long dram_r1_hi = inl(PCI_BASE | 0x65018);
+
+	return dram_r1_hi - dram_r0_lo + 1;
+}
+
+static int __init pnx8550_pci_setup(void)
+{
+	int pci_mem_code;
+	int mem_size = get_system_mem_size() >> 20;
+
+	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
+	   Bit 1:Enable DAC Powerdown
+	  -> 0:DACs are enabled and are working normally
+	     1:DACs are powerdown
+	   Bit 0:Enable of PCI inta output
+	  -> 0 = Disable PCI inta output
+	     1 = Enable PCI inta output
+	*/
+	PNX8550_GLB2_ENAB_INTA_O = 0;
+
+	/* Calc the PCI mem size code */
+	if (mem_size >= 128)
+		pci_mem_code = SIZE_128M;
+	else if (mem_size >= 64)
+		pci_mem_code = SIZE_64M;
+	else if (mem_size >= 32)
+		pci_mem_code = SIZE_32M;
+	else
+		pci_mem_code = SIZE_16M;
+
+	/* Set PCI_XIO registers */
+	outl(pci_mem_resource.start, PCI_BASE | PCI_BASE1_LO);
+	outl(pci_mem_resource.end + 1, PCI_BASE | PCI_BASE1_HI);
+	outl(pci_io_resource.start, PCI_BASE | PCI_BASE2_LO);
+	outl(pci_io_resource.end, PCI_BASE | PCI_BASE2_HI);
+
+	/* Send memory transaction via PCI_BASE2 */
+	outl(0x00000001, PCI_BASE | PCI_IO);
+
+	/* Unlock the setup register */
+	outl(0xca, PCI_BASE | PCI_UNLOCKREG);
+
+	/*
+	 * BAR0 of PNX8550 (pci base 10) must be zero in order for ide
+	 * to work, and in order for bus_to_baddr to work without any
+	 * hacks.
+	 */
+	outl(0x00000000, PCI_BASE | PCI_BASE10);
+
+	/*
+	 *These two bars are set by default or the boot code.
+	 * However, it's safer to set them here so we're not boot
+	 * code dependent.
+	 */
+	outl(0x1be00000, PCI_BASE | PCI_BASE14);  /* PNX MMIO */
+	outl(PNX8550_NAND_BASE_ADDR, PCI_BASE | PCI_BASE18);  /* XIO      */
+
+	outl(PCI_EN_TA |
+	     PCI_EN_PCI2MMI |
+	     PCI_EN_XIO |
+	     PCI_SETUP_BASE18_SIZE(SIZE_32M) |
+	     PCI_SETUP_BASE18_EN |
+	     PCI_SETUP_BASE14_EN |
+	     PCI_SETUP_BASE10_PREF |
+	     PCI_SETUP_BASE10_SIZE(pci_mem_code) |
+	     PCI_SETUP_CFGMANAGE_EN |
+	     PCI_SETUP_PCIARB_EN,
+	     PCI_BASE |
+	     PCI_SETUP);	/* PCI_SETUP */
+	outl(0x00000000, PCI_BASE | PCI_CTRL);	/* PCI_CONTROL */
+
+	register_pci_controller(&pnx8550_controller);
+
+	return 0;
+}
+
+arch_initcall(pnx8550_pci_setup);
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/platform.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/platform.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/platform.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/platform.c	2008-02-26
08:36:50.000000000 +0000
@@ -0,0 +1,132 @@
+/*
+ * Platform device support for NXP PNX8550 SoCs
+ *
+ * Copyright 2005, Embedded Alley Solutions, Inc
+ *
+ * Based on arch/mips/au1000/common/platform.c
+ * Platform device support for Au1x00 SoCs.
+ *
+ * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/serial.h>
+#include <linux/serial_pnx8xxx.h>
+#include <linux/platform_device.h>
+
+#include <int.h>
+#include <usb.h>
+#include <uart.h>
+
+static struct resource pnx8550_usb_ohci_resources[] = {
+	[0] = {
+		.start		= PNX8550_USB_OHCI_OP_BASE,
+		.end		= PNX8550_USB_OHCI_OP_BASE +
+				  PNX8550_USB_OHCI_OP_LEN,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= PNX8550_INT_USB,
+		.end		= PNX8550_INT_USB,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource pnx8550_uart_resources[] = {
+	[0] = {
+		.start		= PNX8550_UART_PORT0,
+		.end		= PNX8550_UART_PORT0 + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= PNX8550_UART_INT(0),
+		.end		= PNX8550_UART_INT(0),
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= PNX8550_UART_PORT1,
+		.end		= PNX8550_UART_PORT1 + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	[3] = {
+		.start		= PNX8550_UART_INT(1),
+		.end		= PNX8550_UART_INT(1),
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+struct pnx8xxx_port pnx8xxx_ports[] = {
+	[0] = {
+		.port   = {
+			.type		= PORT_PNX8XXX,
+			.iotype		= UPIO_MEM,
+			.membase	= (void __iomem *)PNX8550_UART_PORT0,
+			.mapbase	= PNX8550_UART_PORT0,
+			.irq		= PNX8550_UART_INT(0),
+			.uartclk	= 3692300,
+			.fifosize	= 16,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+	},
+	[1] = {
+		.port   = {
+			.type		= PORT_PNX8XXX,
+			.iotype		= UPIO_MEM,
+			.membase	= (void __iomem *)PNX8550_UART_PORT1,
+			.mapbase	= PNX8550_UART_PORT1,
+			.irq		= PNX8550_UART_INT(1),
+			.uartclk	= 3692300,
+			.fifosize	= 16,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+	},
+};
+
+/* The dmamask must be set for OHCI to work */
+static u64 ohci_dmamask = ~(u32)0;
+
+static u64 uart_dmamask = ~(u32)0;
+
+static struct platform_device pnx8550_usb_ohci_device = {
+	.name		= "pnx8550-ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(pnx8550_usb_ohci_resources),
+	.resource	= pnx8550_usb_ohci_resources,
+};
+
+static struct platform_device pnx8550_uart_device = {
+	.name		= "pnx8xxx-uart",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &uart_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data = pnx8xxx_ports,
+	},
+	.num_resources	= ARRAY_SIZE(pnx8550_uart_resources),
+	.resource	= pnx8550_uart_resources,
+};
+
+static struct platform_device *pnx8550_platform_devices[] __initdata = {
+	&pnx8550_usb_ohci_device,
+	&pnx8550_uart_device,
+};
+
+static int __init pnx8550_platform_init(void)
+{
+	return platform_add_devices(pnx8550_platform_devices,
+			            ARRAY_SIZE(pnx8550_platform_devices));
+}
+
+arch_initcall(pnx8550_platform_init);
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/proc.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/proc.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/proc.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/proc.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,112 @@
+/*
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/random.h>
+
+#include <asm/io.h>
+#include <asm/gdb-stub.h>
+#include <int.h>
+#include <uart.h>
+
+
+static int pnx8550_timers_read(char* page, char** start, off_t
offset, int count, int* eof, void* data)
+{
+        int len = 0;
+	int configPR = read_c0_config7();
+
+        if (offset==0) {
+		len += sprintf(&page[len], "Timer:       count,  compare, tc, status\n");
+                len += sprintf(&page[len], "    1: %11i, %8i,  %1i, %s\n",
+			       read_c0_count(), read_c0_compare(),
+			      (configPR>>6)&0x1, ((configPR>>3)&0x1)? "off":"on");
+                len += sprintf(&page[len], "    2: %11i, %8i,  %1i, %s\n",
+			       read_c0_count2(), read_c0_compare2(),
+			      (configPR>>7)&0x1, ((configPR>>4)&0x1)? "off":"on");
+                len += sprintf(&page[len], "    3: %11i, %8i,  %1i, %s\n",
+			       read_c0_count3(), read_c0_compare3(),
+			      (configPR>>8)&0x1, ((configPR>>5)&0x1)? "off":"on");
+        }
+
+        return len;
+}
+
+static int pnx8550_registers_read(char* page, char** start, off_t
offset, int count, int* eof, void* data)
+{
+        int len = 0;
+
+        if (offset==0) {
+                len += sprintf(&page[len], "config1:   %#10.8x\n",
read_c0_config1());
+                len += sprintf(&page[len], "config2:   %#10.8x\n",
read_c0_config2());
+                len += sprintf(&page[len], "config3:   %#10.8x\n",
read_c0_config3());
+                len += sprintf(&page[len], "configPR:  %#10.8x\n",
read_c0_config7());
+                len += sprintf(&page[len], "status:    %#10.8x\n",
read_c0_status());
+                len += sprintf(&page[len], "cause:     %#10.8x\n",
read_c0_cause());
+                len += sprintf(&page[len], "count:     %#10.8x\n",
read_c0_count());
+                len += sprintf(&page[len], "count_2:   %#10.8x\n",
read_c0_count2());
+                len += sprintf(&page[len], "count_3:   %#10.8x\n",
read_c0_count3());
+                len += sprintf(&page[len], "compare:   %#10.8x\n",
read_c0_compare());
+                len += sprintf(&page[len], "compare_2: %#10.8x\n",
read_c0_compare2());
+                len += sprintf(&page[len], "compare_3: %#10.8x\n",
read_c0_compare3());
+        }
+
+        return len;
+}
+
+static struct proc_dir_entry* pnx8550_dir        = NULL;
+static struct proc_dir_entry* pnx8550_timers     = NULL;
+static struct proc_dir_entry* pnx8550_registers  = NULL;
+
+static int pnx8550_proc_init( void )
+{
+
+	// Create /proc/pnx8550
+        pnx8550_dir = proc_mkdir("pnx8550", NULL);
+        if (!pnx8550_dir) {
+                printk(KERN_ERR "Can't create pnx8550 proc dir\n");
+                return -1;
+        }
+
+	// Create /proc/pnx8550/timers
+        pnx8550_timers = create_proc_read_entry(
+		"timers",
+		0,
+		pnx8550_dir,
+		pnx8550_timers_read,
+		NULL);
+
+        if (!pnx8550_timers)
+                printk(KERN_ERR "Can't create pnx8550 timers proc file\n");
+
+	// Create /proc/pnx8550/registers
+        pnx8550_registers = create_proc_read_entry(
+		"registers",
+		0,
+		pnx8550_dir,
+		pnx8550_registers_read,
+		NULL);
+
+        if (!pnx8550_registers)
+                printk(KERN_ERR "Can't create pnx8550 registers proc file\n");
+
+	return 0;
+}
+
+__initcall(pnx8550_proc_init);
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/prom.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/prom.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/prom.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/prom.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,129 @@
+/*
+ *
+ * Per Hallsmark, per.hallsmark@mvista.com
+ *
+ * Based on jmr3927/common/prom.c
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/serial_pnx8xxx.h>
+
+#include <asm/bootinfo.h>
+#include <uart.h>
+
+/* #define DEBUG_CMDLINE */
+
+extern int prom_argc;
+extern char **prom_argv, **prom_envp;
+
+typedef struct
+{
+    char *name;
+/*    char *val; */
+}t_env_var;
+
+
+char * prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+
+	arcs_cmdline[0] = '\0';
+	for (i = 0; i < prom_argc; i++) {
+		strcat(arcs_cmdline, prom_argv[i]);
+		strcat(arcs_cmdline, " ");
+	}
+}
+
+char *prom_getenv(char *envname)
+{
+	/*
+	 * Return a pointer to the given environment variable.
+	 * Environment variables are stored in the form of "memsize=64".
+	 */
+
+	t_env_var *env = (t_env_var *)prom_envp;
+	int i;
+
+	i = strlen(envname);
+
+	while(env->name) {
+		if(strncmp(envname, env->name, i) == 0) {
+			return(env->name + strlen(envname) + 1);
+		}
+		env++;
+	}
+	return(NULL);
+}
+
+inline unsigned char str2hexnum(unsigned char c)
+{
+	if(c >= '0' && c <= '9')
+		return c - '0';
+	if(c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if(c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return 0; /* foo */
+}
+
+inline void str2eaddr(unsigned char *ea, unsigned char *str)
+{
+	int i;
+
+	for(i = 0; i < 6; i++) {
+		unsigned char num;
+
+		if((*str == '.') || (*str == ':'))
+			str++;
+		num = str2hexnum(*str++) << 4;
+		num |= (str2hexnum(*str++));
+		ea[i] = num;
+	}
+}
+
+int get_ethernet_addr(char *ethernet_addr)
+{
+        char *ethaddr_str;
+
+        ethaddr_str = prom_getenv("ethaddr");
+	if (!ethaddr_str) {
+	        printk("ethaddr not set in boot prom\n");
+		return -1;
+	}
+	str2eaddr(ethernet_addr, ethaddr_str);
+	return 0;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+extern int pnx8550_console_port;
+
+/* used by early printk */
+void prom_putchar(char c)
+{
+	if (pnx8550_console_port != -1) {
+		/* Wait until FIFO not full */
+		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) &
PNX8XXX_UART_FIFO_TXFIFO) >> 16) >= 16)
+			;
+		/* Send one char */
+		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
+	}
+}
+
+EXPORT_SYMBOL(prom_getcmdline);
+EXPORT_SYMBOL(get_ethernet_addr);
+EXPORT_SYMBOL(str2eaddr);
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/reset.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/reset.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/reset.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/reset.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,49 @@
+/*.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * Reset the PNX8550 board.
+ *
+ */
+#include <linux/slab.h>
+#include <asm/reboot.h>
+#include <glb.h>
+
+void pnx8550_machine_restart(char *command)
+{
+	char head[] = "************* Machine restart *************";
+	char foot[] = "*******************************************";
+
+	printk("\n\n");
+	printk("%s\n", head);
+	if (command != NULL)
+		printk("* %s\n", command);
+	printk("%s\n", foot);
+
+	PNX8550_RST_CTL = PNX8550_RST_DO_SW_RST;
+}
+
+void pnx8550_machine_halt(void)
+{
+	printk("*** Machine halt. (Not implemented) ***\n");
+}
+
+void pnx8550_machine_power_off(void)
+{
+	printk("*** Machine power off.  (Not implemented) ***\n");
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/setup.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/setup.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/setup.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/setup.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,157 @@
+/*
+ *
+ * 2.6 port, Embedded Alley Solutions, Inc
+ *
+ *  Based on Per Hallsmark, per.hallsmark@mvista.com
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/serial_pnx8xxx.h>
+#include <linux/pm.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/reboot.h>
+#include <asm/pgtable.h>
+#include <asm/time.h>
+
+#include <glb.h>
+#include <int.h>
+#include <pci.h>
+#include <uart.h>
+#include <nand.h>
+
+extern void __init board_setup(void);
+extern void pnx8550_machine_restart(char *);
+extern void pnx8550_machine_halt(void);
+extern void pnx8550_machine_power_off(void);
+extern struct resource ioport_resource;
+extern struct resource iomem_resource;
+extern void rs_kgdb_hook(int tty_no);
+extern char *prom_getcmdline(void);
+
+struct resource standard_io_resources[] = {
+	{
+		.start	= 0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	},
+};
+
+#define STANDARD_IO_RESOURCES
(sizeof(standard_io_resources)/sizeof(struct resource))
+
+extern struct resource pci_io_resource;
+extern struct resource pci_mem_resource;
+
+/* Return the total size of DRAM-memory, (RANK0 + RANK1) */
+unsigned long get_system_mem_size(void)
+{
+	/* Read IP2031_RANK0_ADDR_LO */
+	unsigned long dram_r0_lo = inl(PCI_BASE | 0x65010);
+	/* Read IP2031_RANK1_ADDR_HI */
+	unsigned long dram_r1_hi = inl(PCI_BASE | 0x65018);
+
+	return dram_r1_hi - dram_r0_lo + 1;
+}
+
+int pnx8550_console_port = -1;
+
+void __init plat_mem_setup(void)
+{
+	int i;
+	char* argptr;
+
+	board_setup();  /* board specific setup */
+
+        _machine_restart = pnx8550_machine_restart;
+        _machine_halt = pnx8550_machine_halt;
+        pm_power_off = pnx8550_machine_power_off;
+
+	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
+	   Bit 1:Enable DAC Powerdown
+	  -> 0:DACs are enabled and are working normally
+	     1:DACs are powerdown
+	   Bit 0:Enable of PCI inta output
+	  -> 0 = Disable PCI inta output
+	     1 = Enable PCI inta output
+	*/
+	PNX8550_GLB2_ENAB_INTA_O = 0;
+
+	/* IO/MEM resources. */
+	set_io_port_base(KSEG1);
+	ioport_resource.start = 0;
+	ioport_resource.end = ~0;
+	iomem_resource.start = 0;
+	iomem_resource.end = ~0;
+
+	/* Request I/O space for devices on this board */
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources + i);
+
+	/* Place the Mode Control bit for GPIO pin 16 in primary function */
+	/* Pin 16 is used by UART1, UA1_TX                                */
+	outl((PNX8550_GPIO_MODE_PRIMOP << PNX8550_GPIO_MC_16_BIT) |
+			(PNX8550_GPIO_MODE_PRIMOP << PNX8550_GPIO_MC_17_BIT),
+			PNX8550_GPIO_MC1);
+
+	argptr = prom_getcmdline();
+	if ((argptr = strstr(argptr, "console=ttyS")) != NULL) {
+		argptr += strlen("console=ttyS");
+		pnx8550_console_port = *argptr == '0' ? 0 : 1;
+
+		/* We must initialize the UART (console) before early printk */
+		/* Set LCR to 8-bit and BAUD to 38400 (no 5)                */
+		ip3106_lcr(UART_BASE, pnx8550_console_port) =
+			PNX8XXX_UART_LCR_8BIT;
+		ip3106_baud(UART_BASE, pnx8550_console_port) = 5;
+	}
+
+#ifdef CONFIG_KGDB
+	argptr = prom_getcmdline();
+	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
+		int line;
+		argptr += strlen("kgdb=ttyS");
+		line = *argptr == '0' ? 0 : 1;
+		rs_kgdb_hook(line);
+		pr_info("KGDB: Using ttyS%i for session, "
+		        "please connect your debugger\n", line ? 1 : 0);
+	}
+#endif
+	return;
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/time.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/common/time.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/common/time.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/common/time.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,163 @@
+/*
+ * Copyright 2001, 2002, 2003 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
+ *
+ * Common time service routines for MIPS machines. See
+ * Documents/MIPS/README.txt.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/param.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/smp.h>
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/time.h>
+#include <asm/hardirq.h>
+#include <asm/div64.h>
+#include <asm/debug.h>
+
+#include <int.h>
+#include <cm.h>
+
+static unsigned long cpj;
+
+static cycle_t hpt_read(void)
+{
+	return read_c0_count2();
+}
+
+static struct clocksource pnx_clocksource = {
+	.name		= "pnx8xxx",
+	.rating		= 200,
+	.read		= hpt_read,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void timer_ack(void)
+{
+	write_c0_compare(cpj);
+}
+
+static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *c = dev_id;
+
+	/* clear MATCH, signal the event */
+	c->event_handler(c);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pnx8xxx_timer_irq = {
+	.handler	= pnx8xxx_timer_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "pnx8xxx_timer",
+};
+
+static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
+{
+	/* Timer 2 clear interrupt */
+	write_c0_compare2(-1);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction monotonic_irqaction = {
+	.handler = monotonic_interrupt,
+	.flags = IRQF_DISABLED,
+	.name = "Monotonic timer",
+};
+
+static int pnx8xxx_set_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	write_c0_compare(delta);
+	return 0;
+}
+
+static struct clock_event_device pnx8xxx_clockevent = {
+	.name		= "pnx8xxx_clockevent",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = pnx8xxx_set_next_event,
+};
+
+/*
+ * plat_time_init() - it does the following things:
+ *
+ * 1) plat_time_init() -
+ * 	a) (optional) set up RTC routines,
+ *      b) (optional) calibrate and set the mips_hpt_frequency
+ *	    (only needed if you intended to use cpu counter as timer interrupt
+ *	     source)
+ */
+
+__init void plat_time_init(void)
+{
+	unsigned int             configPR;
+	unsigned int             n;
+	unsigned int             m;
+	unsigned int             p;
+	unsigned int             pow2p;
+
+	clockevents_register_device(&pnx8xxx_clockevent);
+	clocksource_register(&pnx_clocksource);
+
+	setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
+	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
+
+	/* Timer 1 start */
+	configPR = read_c0_config7();
+	configPR &= ~0x00000008;
+	write_c0_config7(configPR);
+
+	/* Timer 2 start */
+	configPR = read_c0_config7();
+	configPR &= ~0x00000010;
+	write_c0_config7(configPR);
+
+	/* Timer 3 stop */
+	configPR = read_c0_config7();
+	configPR |= 0x00000020;
+	write_c0_config7(configPR);
+
+
+        /* PLL0 sets MIPS clock (PLL1 <=> TM1, PLL6 <=> TM2, PLL5 <=> mem) */
+        /* (but only if CLK_MIPS_CTL select value [bits 3:1] is 1:  FIXME) */
+
+        n = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_N_MASK) >> 16;
+        m = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_M_MASK) >> 8;
+        p = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_P_MASK) >> 2;
+	pow2p = (1 << p);
+
+	db_assert(m != 0 && pow2p != 0);
+
+        /*
+	 * Compute the frequency as in the PNX8550 User Manual 1.0, p.186
+	 * (a.k.a. 8-10).  Divide by HZ for a timer offset that results in
+	 * HZ timer interrupts per second.
+	 */
+	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
+	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
+	write_c0_count(0);
+	timer_ack();
+
+	/* Setup Timer 2 */
+	write_c0_count2(0);
+	write_c0_compare2(0xffffffff);
+
+}
+
+
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/board_setup.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/board_setup.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/board_setup.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/board_setup.c	2008-02-11
15:43:00.000000000 +0000
@@ -0,0 +1,65 @@
+/*
+ *  JBS Specific board startup routines.
+ *
+ *  Copyright 2005, Embedded Alley Solutions, Inc
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
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/mc146818rtc.h>
+#include <linux/delay.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/reboot.h>
+#include <asm/pgtable.h>
+
+#include <glb.h>
+
+/* CP0 hazard avoidance. */
+#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
+				     "nop; nop; nop; nop; nop; nop;\n\t" \
+				     ".set reorder\n\t")
+
+void __init board_setup(void)
+{
+	unsigned long config0, configpr;
+
+	config0 = read_c0_config();
+
+	/* clear all three cache coherency fields */
+	config0 &= ~(0x7 | (7<<25) | (7<<28));
+	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
+			(CONF_CM_DEFAULT<<28));
+	write_c0_config(config0);
+	BARRIER;
+
+	configpr = read_c0_config7();
+	configpr |= (1<<19); /* enable tlb */
+	write_c0_config7(configpr);
+	BARRIER;
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/init.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/init.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/init.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/init.c	2008-02-26
08:40:46.000000000 +0000
@@ -0,0 +1,56 @@
+/*
+ *
+ *  Copyright 2005 Embedded Alley Solutions, Inc
+ *  source@embeddedalley.com
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
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+int prom_argc;
+char **prom_argv, **prom_envp;
+extern void  __init prom_init_cmdline(void);
+extern char *prom_getenv(char *envname);
+
+const char *get_system_type(void)
+{
+	return "NXP PNX8550/JBS";
+}
+
+void __init prom_init(void)
+{
+
+	unsigned long memsize;
+
+	mips_machtype = MACH_NXP_JBS;
+
+	//memsize = 0x02800000; /* Trimedia uses memory above */
+	memsize = 0x08000000; /* Trimedia uses memory above */
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/irqmap.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/irqmap.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/irqmap.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/irqmap.c	2008-02-26
08:37:14.000000000 +0000
@@ -0,0 +1,36 @@
+/*
+ *  NXP JBS board irqmap.
+ *
+ *  Copyright 2005 Embedded Alley Solutions, Inc
+ *  source@embeddealley.com
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <int.h>
+
+char pnx8550_irq_tab[][5] __initdata = {
+	[8]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+	[9]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+	[17]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+};
+
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/Makefile
linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/Makefile
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/jbs/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/jbs/Makefile	2008-02-26
08:36:56.000000000 +0000
@@ -0,0 +1,4 @@
+
+# Makefile for the NXP JBS Board.
+
+lib-y := init.o board_setup.o irqmap.o
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/board_setup.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/board_setup.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/board_setup.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/board_setup.c	2008-02-26
08:33:25.000000000 +0000
@@ -0,0 +1,49 @@
+/*
+ *  STB810 specific board startup routines.
+ *
+ *  Based on the arch/mips/nxp/pnx8550/jbs/board_setup.c
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/mc146818rtc.h>
+#include <linux/delay.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/reboot.h>
+#include <asm/pgtable.h>
+
+#include <glb.h>
+
+void __init board_setup(void)
+{
+	unsigned long config0, configpr;
+
+	config0 = read_c0_config();
+
+	/* clear all three cache coherency fields */
+	config0 &= ~(0x7 | (7<<25) | (7<<28));
+	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
+			(CONF_CM_DEFAULT<<28));
+	write_c0_config(config0);
+
+	configpr = read_c0_config7();
+	configpr |= (1<<19); /* enable tlb */
+	write_c0_config7(configpr);
+}
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/irqmap.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/irqmap.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/irqmap.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/irqmap.c	2008-02-26
08:42:29.000000000 +0000
@@ -0,0 +1,23 @@
+/*
+ *  NXP STB810 board irqmap.
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <int.h>
+
+char pnx8550_irq_tab[][5] __initdata = {
+	[8]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+	[9]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+	[10]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+};
+
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/Makefile
linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/Makefile
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/Makefile	2008-02-26
08:37:19.000000000 +0000
@@ -0,0 +1,4 @@
+
+# Makefile for the NXP STB810 Board.
+
+lib-y := prom_init.o board_setup.o irqmap.o
diff -urN linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/prom_init.c
linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/prom_init.c
--- linux-2.6.24.2.orig/arch/mips/nxp/pnx8550/stb810/prom_init.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.24.2/arch/mips/nxp/pnx8550/stb810/prom_init.c	2008-02-26
08:42:42.000000000 +0000
@@ -0,0 +1,48 @@
+/*
+ *  STB810 specific prom routines
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+int prom_argc;
+char **prom_argv, **prom_envp;
+extern void  __init prom_init_cmdline(void);
+extern char *prom_getenv(char *envname);
+
+const char *get_system_type(void)
+{
+	return "NXP PNX8950/STB810";
+}
+
+void __init prom_init(void)
+{
+	unsigned long memsize;
+
+	prom_argc = (int) fw_arg0;
+	prom_argv = (char **) fw_arg1;
+	prom_envp = (char **) fw_arg2;
+
+	prom_init_cmdline();
+
+	mips_machtype = MACH_NXP_STB810;
+
+	memsize = 0x08000000; /* Trimedia uses memory above */
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/gdb_hook.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/gdb_hook.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/gdb_hook.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/gdb_hook.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,109 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * This is the interface to the remote debugger stub.
- *
- */
-#include <linux/types.h>
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <linux/serial_ip3106.h>
-
-#include <asm/serial.h>
-#include <asm/io.h>
-
-#include <uart.h>
-
-static struct serial_state rs_table[IP3106_NR_PORTS] = {
-};
-static struct async_struct kdb_port_info = {0};
-
-void rs_kgdb_hook(int tty_no)
-{
-	struct serial_state *ser = &rs_table[tty_no];
-
-	kdb_port_info.state = ser;
-	kdb_port_info.magic = SERIAL_MAGIC;
-	kdb_port_info.port  = tty_no;
-	kdb_port_info.flags = ser->flags;
-
-	/*
-	 * Clear all interrupts
-	 */
-	/* Clear all the transmitter FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_TX_RST;
-	/* Clear all the receiver FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_RX_RST;
-	/* Clear all interrupts */
-	ip3106_iclr(UART_BASE, tty_no) = IP3106_UART_INT_ALLRX |
-		IP3106_UART_INT_ALLTX;
-
-	/*
-	 * Now, initialize the UART
-	 */
-	ip3106_lcr(UART_BASE, tty_no) = IP3106_UART_LCR_8BIT;
-	ip3106_baud(UART_BASE, tty_no) = 5; // 38400 Baud
-}
-
-int putDebugChar(char c)
-{
-	/* Wait until FIFO not full */
-	while (((ip3106_fifo(UART_BASE, kdb_port_info.port) &
IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
-		;
-	/* Send one char */
-	ip3106_fifo(UART_BASE, kdb_port_info.port) = c;
-
-	return 1;
-}
-
-char getDebugChar(void)
-{
-	char ch;
-
-	/* Wait until there is a char in the FIFO */
-	while (!((ip3106_fifo(UART_BASE, kdb_port_info.port) &
-					IP3106_UART_FIFO_RXFIFO) >> 8))
-		;
-	/* Read one char */
-	ch = ip3106_fifo(UART_BASE, kdb_port_info.port) &
-		IP3106_UART_FIFO_RBRTHR;
-	/* Advance the RX FIFO read pointer */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_NEXT;
-	return (ch);
-}
-
-void rs_disable_debug_interrupts(void)
-{
-	ip3106_ien(UART_BASE, kdb_port_info.port) = 0; /* Disable all interrupts */
-}
-
-void rs_enable_debug_interrupts(void)
-{
-	/* Clear all the transmitter FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_TX_RST;
-	/* Clear all the receiver FIFO counters (pointer and status) */
-	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_RST;
-	/* Clear all interrupts */
-	ip3106_iclr(UART_BASE, kdb_port_info.port) = IP3106_UART_INT_ALLRX |
-		IP3106_UART_INT_ALLTX;
-	ip3106_ien(UART_BASE, kdb_port_info.port)  = IP3106_UART_INT_ALLRX;
/* Enable RX interrupts */
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/int.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/int.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/int.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/int.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,238 +0,0 @@
-/*
- *
- * Copyright (C) 2005 Embedded Alley Solutions, Inc
- * Ported to 2.6.
- *
- * Per Hallsmark, per.hallsmark@mvista.com
- * Copyright (C) 2000, 2001 MIPS Technologies, Inc.
- * Copyright (C) 2001 Ralf Baechle
- *
- * Cleaned up and bug fixing: Pete Popov, ppopov@embeddedalley.com
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-#include <linux/compiler.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
-#include <linux/random.h>
-#include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/gdb-stub.h>
-#include <int.h>
-#include <uart.h>
-
-/* default prio for interrupts */
-/* first one is a no-no so therefore always prio 0 (disabled) */
-static char gic_prio[PNX8550_INT_GIC_TOTINT] = {
-	0, 1, 1, 1, 1, 15, 1, 1, 1, 1,	//   0 -  9
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  10 - 19
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  20 - 29
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  30 - 39
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  40 - 49
-	1, 1, 1, 1, 1, 1, 1, 1, 2, 1,	//  50 - 59
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,	//  60 - 69
-	1			//  70
-};
-
-static void hw0_irqdispatch(int irq)
-{
-	/* find out which interrupt */
-	irq = PNX8550_GIC_VECTOR_0 >> 3;
-
-	if (irq == 0) {
-		printk("hw0_irqdispatch: irq 0, spurious interrupt?\n");
-		return;
-	}
-	do_IRQ(PNX8550_INT_GIC_MIN + irq);
-}
-
-
-static void timer_irqdispatch(int irq)
-{
-	irq = (0x01c0 & read_c0_config7()) >> 6;
-
-	if (unlikely(irq == 0)) {
-		printk("timer_irqdispatch: irq 0, spurious interrupt?\n");
-		return;
-	}
-
-	if (irq & 0x1)
-		do_IRQ(PNX8550_INT_TIMER1);
-	if (irq & 0x2)
-		do_IRQ(PNX8550_INT_TIMER2);
-	if (irq & 0x4)
-		do_IRQ(PNX8550_INT_TIMER3);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP2)
-		hw0_irqdispatch(2);
-	else if (pending & STATUSF_IP7) {
-		if (read_c0_config7() & 0x01c0)
-			timer_irqdispatch(7);
-	} else
-		spurious_interrupt();
-}
-
-static inline void modify_cp0_intmask(unsigned clr_mask, unsigned set_mask)
-{
-	unsigned long status = read_c0_status();
-
-	status &= ~((clr_mask & 0xFF) << 8);
-	status |= (set_mask & 0xFF) << 8;
-
-	write_c0_status(status);
-}
-
-static inline void mask_gic_int(unsigned int irq_nr)
-{
-	/* interrupt disabled, bit 26(WE_ENABLE)=1 and bit 16(enable)=0 */
-	PNX8550_GIC_REQ(irq_nr) = 1<<28; /* set priority to 0 */
-}
-
-static inline void unmask_gic_int(unsigned int irq_nr)
-{
-	/* set prio mask to lower four bits and enable interrupt */
-	PNX8550_GIC_REQ(irq_nr) = (1<<26 | 1<<16) | (1<<28) | gic_prio[irq_nr];
-}
-
-static inline void mask_irq(unsigned int irq_nr)
-{
-	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
-		modify_cp0_intmask(1 << irq_nr, 0);
-	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
-		(irq_nr <= PNX8550_INT_GIC_MAX)) {
-		mask_gic_int(irq_nr - PNX8550_INT_GIC_MIN);
-	} else if ((PNX8550_INT_TIMER_MIN <= irq_nr) &&
-		(irq_nr <= PNX8550_INT_TIMER_MAX)) {
-		modify_cp0_intmask(1 << 7, 0);
-	} else {
-		printk("mask_irq: irq %d doesn't exist!\n", irq_nr);
-	}
-}
-
-static inline void unmask_irq(unsigned int irq_nr)
-{
-	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
-		modify_cp0_intmask(0, 1 << irq_nr);
-	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
-		(irq_nr <= PNX8550_INT_GIC_MAX)) {
-		unmask_gic_int(irq_nr - PNX8550_INT_GIC_MIN);
-	} else if ((PNX8550_INT_TIMER_MIN <= irq_nr) &&
-		(irq_nr <= PNX8550_INT_TIMER_MAX)) {
-		modify_cp0_intmask(0, 1 << 7);
-	} else {
-		printk("mask_irq: irq %d doesn't exist!\n", irq_nr);
-	}
-}
-
-int pnx8550_set_gic_priority(int irq, int priority)
-{
-	int gic_irq = irq-PNX8550_INT_GIC_MIN;
-	int prev_priority = PNX8550_GIC_REQ(gic_irq) & 0xf;
-
-        gic_prio[gic_irq] = priority;
-	PNX8550_GIC_REQ(gic_irq) |= (0x10000000 | gic_prio[gic_irq]);
-
-	return prev_priority;
-}
-
-static struct irq_chip level_irq_type = {
-	.name =		"PNX Level IRQ",
-	.ack =		mask_irq,
-	.mask =		mask_irq,
-	.mask_ack =	mask_irq,
-	.unmask =	unmask_irq,
-};
-
-static struct irqaction gic_action = {
-	.handler =	no_action,
-	.flags =	IRQF_DISABLED,
-	.name =		"GIC",
-};
-
-static struct irqaction timer_action = {
-	.handler =	no_action,
-	.flags =	IRQF_DISABLED,
-	.name =		"Timer",
-};
-
-void __init arch_init_irq(void)
-{
-	int i;
-	int configPR;
-
-	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
-		mask_irq(i);	/* mask the irq just in case  */
-	}
-
-	/* init of GIC/IPC interrupts */
-	/* should be done before cp0 since cp0 init enables the GIC int */
-	for (i = PNX8550_INT_GIC_MIN; i <= PNX8550_INT_GIC_MAX; i++) {
-		int gic_int_line = i - PNX8550_INT_GIC_MIN;
-		if (gic_int_line == 0 )
-			continue;	// don't fiddle with int 0
-		/*
-		 * enable change of TARGET, ENABLE and ACTIVE_LOW bits
-		 * set TARGET        0 to route through hw0 interrupt
-		 * set ACTIVE_LOW    0 active high  (correct?)
-		 *
-		 * We really should setup an interrupt description table
-		 * to do this nicely.
-		 * Note, PCI INTA is active low on the bus, but inverted
-		 * in the GIC, so to us it's active high.
-		 */
-		PNX8550_GIC_REQ(i - PNX8550_INT_GIC_MIN) = 0x1E000000;
-
-		/* mask/priority is still 0 so we will not get any
-		 * interrupts until it is unmasked */
-
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
-	}
-
-	/* Priority level 0 */
-	PNX8550_GIC_PRIMASK_0 = PNX8550_GIC_PRIMASK_1 = 0;
-
-	/* Set int vector table address */
-	PNX8550_GIC_VECTOR_0 = PNX8550_GIC_VECTOR_1 = 0;
-
-	set_irq_chip_and_handler(MIPS_CPU_GIC_IRQ, &level_irq_type,
-				 handle_level_irq);
-	setup_irq(MIPS_CPU_GIC_IRQ, &gic_action);
-
-	/* init of Timer interrupts */
-	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++)
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
-
-	/* Stop Timer 1-3 */
-	configPR = read_c0_config7();
-	configPR |= 0x00000038;
-	write_c0_config7(configPR);
-
-	set_irq_chip_and_handler(MIPS_CPU_TIMER_IRQ, &level_irq_type,
-				 handle_level_irq);
-	setup_irq(MIPS_CPU_TIMER_IRQ, &timer_action);
-}
-
-EXPORT_SYMBOL(pnx8550_set_gic_priority);
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/Makefile
linux-2.6.24.2/arch/mips/philips/pnx8550/common/Makefile
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/Makefile	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/Makefile	1970-01-01
01:00:00.000000000 +0100
@@ -1,29 +0,0 @@
-#
-# Per Hallsmark, per.hallsmark@mvista.com
-#
-# ########################################################################
-#
-# This program is free software; you can distribute it and/or modify it
-# under the terms of the GNU General Public License (Version 2) as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
-#
-# #######################################################################
-#
-# Makefile for the PNX8550 specific kernel interface routines
-# under Linux.
-#
-
-obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
-obj-$(CONFIG_PCI) += pci.o
-obj-$(CONFIG_KGDB) += gdb_hook.o
-
-EXTRA_CFLAGS += -Werror
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/pci.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/pci.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/pci.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/pci.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,133 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *
- * Author: source@mvista.com
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <pci.h>
-#include <glb.h>
-#include <nand.h>
-
-static struct resource pci_io_resource = {
-	.start	= PNX8550_PCIIO + 0x1000,	/* reserve regacy I/O space */
-	.end	= PNX8550_PCIIO + PNX8550_PCIIO_SIZE,
-	.name	= "pci IO space",
-	.flags	= IORESOURCE_IO
-};
-
-static struct resource pci_mem_resource = {
-	.start	= PNX8550_PCIMEM,
-	.end	= PNX8550_PCIMEM + PNX8550_PCIMEM_SIZE - 1,
-	.name	= "pci memory space",
-	.flags	= IORESOURCE_MEM
-};
-
-extern struct pci_ops pnx8550_pci_ops;
-
-static struct pci_controller pnx8550_controller = {
-	.pci_ops	= &pnx8550_pci_ops,
-	.io_resource	= &pci_io_resource,
-	.mem_resource	= &pci_mem_resource,
-};
-
-/* Return the total size of DRAM-memory, (RANK0 + RANK1) */
-static inline unsigned long get_system_mem_size(void)
-{
-	/* Read IP2031_RANK0_ADDR_LO */
-	unsigned long dram_r0_lo = inl(PCI_BASE | 0x65010);
-	/* Read IP2031_RANK1_ADDR_HI */
-	unsigned long dram_r1_hi = inl(PCI_BASE | 0x65018);
-
-	return dram_r1_hi - dram_r0_lo + 1;
-}
-
-static int __init pnx8550_pci_setup(void)
-{
-	int pci_mem_code;
-	int mem_size = get_system_mem_size() >> 20;
-
-	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
-	   Bit 1:Enable DAC Powerdown
-	  -> 0:DACs are enabled and are working normally
-	     1:DACs are powerdown
-	   Bit 0:Enable of PCI inta output
-	  -> 0 = Disable PCI inta output
-	     1 = Enable PCI inta output
-	*/
-	PNX8550_GLB2_ENAB_INTA_O = 0;
-
-	/* Calc the PCI mem size code */
-	if (mem_size >= 128)
-		pci_mem_code = SIZE_128M;
-	else if (mem_size >= 64)
-		pci_mem_code = SIZE_64M;
-	else if (mem_size >= 32)
-		pci_mem_code = SIZE_32M;
-	else
-		pci_mem_code = SIZE_16M;
-
-	/* Set PCI_XIO registers */
-	outl(pci_mem_resource.start, PCI_BASE | PCI_BASE1_LO);
-	outl(pci_mem_resource.end + 1, PCI_BASE | PCI_BASE1_HI);
-	outl(pci_io_resource.start, PCI_BASE | PCI_BASE2_LO);
-	outl(pci_io_resource.end, PCI_BASE | PCI_BASE2_HI);
-
-	/* Send memory transaction via PCI_BASE2 */
-	outl(0x00000001, PCI_BASE | PCI_IO);
-
-	/* Unlock the setup register */
-	outl(0xca, PCI_BASE | PCI_UNLOCKREG);
-
-	/*
-	 * BAR0 of PNX8550 (pci base 10) must be zero in order for ide
-	 * to work, and in order for bus_to_baddr to work without any
-	 * hacks.
-	 */
-	outl(0x00000000, PCI_BASE | PCI_BASE10);
-
-	/*
-	 *These two bars are set by default or the boot code.
-	 * However, it's safer to set them here so we're not boot
-	 * code dependent.
-	 */
-	outl(0x1be00000, PCI_BASE | PCI_BASE14);  /* PNX MMIO */
-	outl(PNX8550_NAND_BASE_ADDR, PCI_BASE | PCI_BASE18);  /* XIO      */
-
-	outl(PCI_EN_TA |
-	     PCI_EN_PCI2MMI |
-	     PCI_EN_XIO |
-	     PCI_SETUP_BASE18_SIZE(SIZE_32M) |
-	     PCI_SETUP_BASE18_EN |
-	     PCI_SETUP_BASE14_EN |
-	     PCI_SETUP_BASE10_PREF |
-	     PCI_SETUP_BASE10_SIZE(pci_mem_code) |
-	     PCI_SETUP_CFGMANAGE_EN |
-	     PCI_SETUP_PCIARB_EN,
-	     PCI_BASE |
-	     PCI_SETUP);	/* PCI_SETUP */
-	outl(0x00000000, PCI_BASE | PCI_CTRL);	/* PCI_CONTROL */
-
-	register_pci_controller(&pnx8550_controller);
-
-	return 0;
-}
-
-arch_initcall(pnx8550_pci_setup);
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/platform.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/platform.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/platform.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/platform.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,132 +0,0 @@
-/*
- * Platform device support for Philips PNX8550 SoCs
- *
- * Copyright 2005, Embedded Alley Solutions, Inc
- *
- * Based on arch/mips/au1000/common/platform.c
- * Platform device support for Au1x00 SoCs.
- *
- * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/resource.h>
-#include <linux/serial.h>
-#include <linux/serial_pnx8xxx.h>
-#include <linux/platform_device.h>
-
-#include <int.h>
-#include <usb.h>
-#include <uart.h>
-
-static struct resource pnx8550_usb_ohci_resources[] = {
-	[0] = {
-		.start		= PNX8550_USB_OHCI_OP_BASE,
-		.end		= PNX8550_USB_OHCI_OP_BASE +
-				  PNX8550_USB_OHCI_OP_LEN,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= PNX8550_INT_USB,
-		.end		= PNX8550_INT_USB,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource pnx8550_uart_resources[] = {
-	[0] = {
-		.start		= PNX8550_UART_PORT0,
-		.end		= PNX8550_UART_PORT0 + 0xfff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= PNX8550_UART_INT(0),
-		.end		= PNX8550_UART_INT(0),
-		.flags		= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start		= PNX8550_UART_PORT1,
-		.end		= PNX8550_UART_PORT1 + 0xfff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[3] = {
-		.start		= PNX8550_UART_INT(1),
-		.end		= PNX8550_UART_INT(1),
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-struct pnx8xxx_port pnx8xxx_ports[] = {
-	[0] = {
-		.port   = {
-			.type		= PORT_PNX8XXX,
-			.iotype		= UPIO_MEM,
-			.membase	= (void __iomem *)PNX8550_UART_PORT0,
-			.mapbase	= PNX8550_UART_PORT0,
-			.irq		= PNX8550_UART_INT(0),
-			.uartclk	= 3692300,
-			.fifosize	= 16,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 0,
-		},
-	},
-	[1] = {
-		.port   = {
-			.type		= PORT_PNX8XXX,
-			.iotype		= UPIO_MEM,
-			.membase	= (void __iomem *)PNX8550_UART_PORT1,
-			.mapbase	= PNX8550_UART_PORT1,
-			.irq		= PNX8550_UART_INT(1),
-			.uartclk	= 3692300,
-			.fifosize	= 16,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 1,
-		},
-	},
-};
-
-/* The dmamask must be set for OHCI to work */
-static u64 ohci_dmamask = ~(u32)0;
-
-static u64 uart_dmamask = ~(u32)0;
-
-static struct platform_device pnx8550_usb_ohci_device = {
-	.name		= "pnx8550-ohci",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &ohci_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pnx8550_usb_ohci_resources),
-	.resource	= pnx8550_usb_ohci_resources,
-};
-
-static struct platform_device pnx8550_uart_device = {
-	.name		= "pnx8xxx-uart",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &uart_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data = pnx8xxx_ports,
-	},
-	.num_resources	= ARRAY_SIZE(pnx8550_uart_resources),
-	.resource	= pnx8550_uart_resources,
-};
-
-static struct platform_device *pnx8550_platform_devices[] __initdata = {
-	&pnx8550_usb_ohci_device,
-	&pnx8550_uart_device,
-};
-
-static int __init pnx8550_platform_init(void)
-{
-	return platform_add_devices(pnx8550_platform_devices,
-			            ARRAY_SIZE(pnx8550_platform_devices));
-}
-
-arch_initcall(pnx8550_platform_init);
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/proc.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/proc.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/proc.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/proc.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,112 +0,0 @@
-/*
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
-#include <linux/random.h>
-
-#include <asm/io.h>
-#include <asm/gdb-stub.h>
-#include <int.h>
-#include <uart.h>
-
-
-static int pnx8550_timers_read(char* page, char** start, off_t
offset, int count, int* eof, void* data)
-{
-        int len = 0;
-	int configPR = read_c0_config7();
-
-        if (offset==0) {
-		len += sprintf(&page[len], "Timer:       count,  compare, tc, status\n");
-                len += sprintf(&page[len], "    1: %11i, %8i,  %1i, %s\n",
-			       read_c0_count(), read_c0_compare(),
-			      (configPR>>6)&0x1, ((configPR>>3)&0x1)? "off":"on");
-                len += sprintf(&page[len], "    2: %11i, %8i,  %1i, %s\n",
-			       read_c0_count2(), read_c0_compare2(),
-			      (configPR>>7)&0x1, ((configPR>>4)&0x1)? "off":"on");
-                len += sprintf(&page[len], "    3: %11i, %8i,  %1i, %s\n",
-			       read_c0_count3(), read_c0_compare3(),
-			      (configPR>>8)&0x1, ((configPR>>5)&0x1)? "off":"on");
-        }
-
-        return len;
-}
-
-static int pnx8550_registers_read(char* page, char** start, off_t
offset, int count, int* eof, void* data)
-{
-        int len = 0;
-
-        if (offset==0) {
-                len += sprintf(&page[len], "config1:   %#10.8x\n",
read_c0_config1());
-                len += sprintf(&page[len], "config2:   %#10.8x\n",
read_c0_config2());
-                len += sprintf(&page[len], "config3:   %#10.8x\n",
read_c0_config3());
-                len += sprintf(&page[len], "configPR:  %#10.8x\n",
read_c0_config7());
-                len += sprintf(&page[len], "status:    %#10.8x\n",
read_c0_status());
-                len += sprintf(&page[len], "cause:     %#10.8x\n",
read_c0_cause());
-                len += sprintf(&page[len], "count:     %#10.8x\n",
read_c0_count());
-                len += sprintf(&page[len], "count_2:   %#10.8x\n",
read_c0_count2());
-                len += sprintf(&page[len], "count_3:   %#10.8x\n",
read_c0_count3());
-                len += sprintf(&page[len], "compare:   %#10.8x\n",
read_c0_compare());
-                len += sprintf(&page[len], "compare_2: %#10.8x\n",
read_c0_compare2());
-                len += sprintf(&page[len], "compare_3: %#10.8x\n",
read_c0_compare3());
-        }
-
-        return len;
-}
-
-static struct proc_dir_entry* pnx8550_dir        = NULL;
-static struct proc_dir_entry* pnx8550_timers     = NULL;
-static struct proc_dir_entry* pnx8550_registers  = NULL;
-
-static int pnx8550_proc_init( void )
-{
-
-	// Create /proc/pnx8550
-        pnx8550_dir = proc_mkdir("pnx8550", NULL);
-        if (!pnx8550_dir) {
-                printk(KERN_ERR "Can't create pnx8550 proc dir\n");
-                return -1;
-        }
-
-	// Create /proc/pnx8550/timers
-        pnx8550_timers = create_proc_read_entry(
-		"timers",
-		0,
-		pnx8550_dir,
-		pnx8550_timers_read,
-		NULL);
-
-        if (!pnx8550_timers)
-                printk(KERN_ERR "Can't create pnx8550 timers proc file\n");
-
-	// Create /proc/pnx8550/registers
-        pnx8550_registers = create_proc_read_entry(
-		"registers",
-		0,
-		pnx8550_dir,
-		pnx8550_registers_read,
-		NULL);
-
-        if (!pnx8550_registers)
-                printk(KERN_ERR "Can't create pnx8550 registers proc file\n");
-
-	return 0;
-}
-
-__initcall(pnx8550_proc_init);
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/prom.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/prom.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/prom.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/prom.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,129 +0,0 @@
-/*
- *
- * Per Hallsmark, per.hallsmark@mvista.com
- *
- * Based on jmr3927/common/prom.c
- *
- * 2004 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/serial_pnx8xxx.h>
-
-#include <asm/bootinfo.h>
-#include <uart.h>
-
-/* #define DEBUG_CMDLINE */
-
-extern int prom_argc;
-extern char **prom_argv, **prom_envp;
-
-typedef struct
-{
-    char *name;
-/*    char *val; */
-}t_env_var;
-
-
-char * prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-
-	arcs_cmdline[0] = '\0';
-	for (i = 0; i < prom_argc; i++) {
-		strcat(arcs_cmdline, prom_argv[i]);
-		strcat(arcs_cmdline, " ");
-	}
-}
-
-char *prom_getenv(char *envname)
-{
-	/*
-	 * Return a pointer to the given environment variable.
-	 * Environment variables are stored in the form of "memsize=64".
-	 */
-
-	t_env_var *env = (t_env_var *)prom_envp;
-	int i;
-
-	i = strlen(envname);
-
-	while(env->name) {
-		if(strncmp(envname, env->name, i) == 0) {
-			return(env->name + strlen(envname) + 1);
-		}
-		env++;
-	}
-	return(NULL);
-}
-
-inline unsigned char str2hexnum(unsigned char c)
-{
-	if(c >= '0' && c <= '9')
-		return c - '0';
-	if(c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if(c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return 0; /* foo */
-}
-
-inline void str2eaddr(unsigned char *ea, unsigned char *str)
-{
-	int i;
-
-	for(i = 0; i < 6; i++) {
-		unsigned char num;
-
-		if((*str == '.') || (*str == ':'))
-			str++;
-		num = str2hexnum(*str++) << 4;
-		num |= (str2hexnum(*str++));
-		ea[i] = num;
-	}
-}
-
-int get_ethernet_addr(char *ethernet_addr)
-{
-        char *ethaddr_str;
-
-        ethaddr_str = prom_getenv("ethaddr");
-	if (!ethaddr_str) {
-	        printk("ethaddr not set in boot prom\n");
-		return -1;
-	}
-	str2eaddr(ethernet_addr, ethaddr_str);
-	return 0;
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-extern int pnx8550_console_port;
-
-/* used by early printk */
-void prom_putchar(char c)
-{
-	if (pnx8550_console_port != -1) {
-		/* Wait until FIFO not full */
-		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) &
PNX8XXX_UART_FIFO_TXFIFO) >> 16) >= 16)
-			;
-		/* Send one char */
-		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
-	}
-}
-
-EXPORT_SYMBOL(prom_getcmdline);
-EXPORT_SYMBOL(get_ethernet_addr);
-EXPORT_SYMBOL(str2eaddr);
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/reset.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/reset.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/reset.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/reset.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,49 +0,0 @@
-/*.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Reset the PNX8550 board.
- *
- */
-#include <linux/slab.h>
-#include <asm/reboot.h>
-#include <glb.h>
-
-void pnx8550_machine_restart(char *command)
-{
-	char head[] = "************* Machine restart *************";
-	char foot[] = "*******************************************";
-
-	printk("\n\n");
-	printk("%s\n", head);
-	if (command != NULL)
-		printk("* %s\n", command);
-	printk("%s\n", foot);
-
-	PNX8550_RST_CTL = PNX8550_RST_DO_SW_RST;
-}
-
-void pnx8550_machine_halt(void)
-{
-	printk("*** Machine halt. (Not implemented) ***\n");
-}
-
-void pnx8550_machine_power_off(void)
-{
-	printk("*** Machine power off.  (Not implemented) ***\n");
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/setup.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/setup.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/setup.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/setup.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,157 +0,0 @@
-/*
- *
- * 2.6 port, Embedded Alley Solutions, Inc
- *
- *  Based on Per Hallsmark, per.hallsmark@mvista.com
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/serial_pnx8xxx.h>
-#include <linux/pm.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
-#include <asm/time.h>
-
-#include <glb.h>
-#include <int.h>
-#include <pci.h>
-#include <uart.h>
-#include <nand.h>
-
-extern void __init board_setup(void);
-extern void pnx8550_machine_restart(char *);
-extern void pnx8550_machine_halt(void);
-extern void pnx8550_machine_power_off(void);
-extern struct resource ioport_resource;
-extern struct resource iomem_resource;
-extern void rs_kgdb_hook(int tty_no);
-extern char *prom_getcmdline(void);
-
-struct resource standard_io_resources[] = {
-	{
-		.start	= 0x00,
-		.end	= 0x1f,
-		.name	= "dma1",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x40,
-		.end	= 0x5f,
-		.name	= "timer",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x80,
-		.end	= 0x8f,
-		.name	= "dma page reg",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0xc0,
-		.end	= 0xdf,
-		.name	= "dma2",
-		.flags	= IORESOURCE_BUSY
-	},
-};
-
-#define STANDARD_IO_RESOURCES
(sizeof(standard_io_resources)/sizeof(struct resource))
-
-extern struct resource pci_io_resource;
-extern struct resource pci_mem_resource;
-
-/* Return the total size of DRAM-memory, (RANK0 + RANK1) */
-unsigned long get_system_mem_size(void)
-{
-	/* Read IP2031_RANK0_ADDR_LO */
-	unsigned long dram_r0_lo = inl(PCI_BASE | 0x65010);
-	/* Read IP2031_RANK1_ADDR_HI */
-	unsigned long dram_r1_hi = inl(PCI_BASE | 0x65018);
-
-	return dram_r1_hi - dram_r0_lo + 1;
-}
-
-int pnx8550_console_port = -1;
-
-void __init plat_mem_setup(void)
-{
-	int i;
-	char* argptr;
-
-	board_setup();  /* board specific setup */
-
-        _machine_restart = pnx8550_machine_restart;
-        _machine_halt = pnx8550_machine_halt;
-        pm_power_off = pnx8550_machine_power_off;
-
-	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
-	   Bit 1:Enable DAC Powerdown
-	  -> 0:DACs are enabled and are working normally
-	     1:DACs are powerdown
-	   Bit 0:Enable of PCI inta output
-	  -> 0 = Disable PCI inta output
-	     1 = Enable PCI inta output
-	*/
-	PNX8550_GLB2_ENAB_INTA_O = 0;
-
-	/* IO/MEM resources. */
-	set_io_port_base(KSEG1);
-	ioport_resource.start = 0;
-	ioport_resource.end = ~0;
-	iomem_resource.start = 0;
-	iomem_resource.end = ~0;
-
-	/* Request I/O space for devices on this board */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources + i);
-
-	/* Place the Mode Control bit for GPIO pin 16 in primary function */
-	/* Pin 16 is used by UART1, UA1_TX                                */
-	outl((PNX8550_GPIO_MODE_PRIMOP << PNX8550_GPIO_MC_16_BIT) |
-			(PNX8550_GPIO_MODE_PRIMOP << PNX8550_GPIO_MC_17_BIT),
-			PNX8550_GPIO_MC1);
-
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "console=ttyS")) != NULL) {
-		argptr += strlen("console=ttyS");
-		pnx8550_console_port = *argptr == '0' ? 0 : 1;
-
-		/* We must initialize the UART (console) before early printk */
-		/* Set LCR to 8-bit and BAUD to 38400 (no 5)                */
-		ip3106_lcr(UART_BASE, pnx8550_console_port) =
-			PNX8XXX_UART_LCR_8BIT;
-		ip3106_baud(UART_BASE, pnx8550_console_port) = 5;
-	}
-
-#ifdef CONFIG_KGDB
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
-		int line;
-		argptr += strlen("kgdb=ttyS");
-		line = *argptr == '0' ? 0 : 1;
-		rs_kgdb_hook(line);
-		pr_info("KGDB: Using ttyS%i for session, "
-		        "please connect your debugger\n", line ? 1 : 0);
-	}
-#endif
-	return;
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/time.c
linux-2.6.24.2/arch/mips/philips/pnx8550/common/time.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/common/time.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/common/time.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,163 +0,0 @@
-/*
- * Copyright 2001, 2002, 2003 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- *
- * Common time service routines for MIPS machines. See
- * Documents/MIPS/README.txt.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/param.h>
-#include <linux/time.h>
-#include <linux/timer.h>
-#include <linux/smp.h>
-#include <linux/kernel_stat.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/time.h>
-#include <asm/hardirq.h>
-#include <asm/div64.h>
-#include <asm/debug.h>
-
-#include <int.h>
-#include <cm.h>
-
-static unsigned long cpj;
-
-static cycle_t hpt_read(void)
-{
-	return read_c0_count2();
-}
-
-static struct clocksource pnx_clocksource = {
-	.name		= "pnx8xxx",
-	.rating		= 200,
-	.read		= hpt_read,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static void timer_ack(void)
-{
-	write_c0_compare(cpj);
-}
-
-static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *c = dev_id;
-
-	/* clear MATCH, signal the event */
-	c->event_handler(c);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction pnx8xxx_timer_irq = {
-	.handler	= pnx8xxx_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_PERCPU,
-	.name		= "pnx8xxx_timer",
-};
-
-static irqreturn_t monotonic_interrupt(int irq, void *dev_id)
-{
-	/* Timer 2 clear interrupt */
-	write_c0_compare2(-1);
-	return IRQ_HANDLED;
-}
-
-static struct irqaction monotonic_irqaction = {
-	.handler = monotonic_interrupt,
-	.flags = IRQF_DISABLED,
-	.name = "Monotonic timer",
-};
-
-static int pnx8xxx_set_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	write_c0_compare(delta);
-	return 0;
-}
-
-static struct clock_event_device pnx8xxx_clockevent = {
-	.name		= "pnx8xxx_clockevent",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event = pnx8xxx_set_next_event,
-};
-
-/*
- * plat_time_init() - it does the following things:
- *
- * 1) plat_time_init() -
- * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use cpu counter as timer interrupt
- *	     source)
- */
-
-__init void plat_time_init(void)
-{
-	unsigned int             configPR;
-	unsigned int             n;
-	unsigned int             m;
-	unsigned int             p;
-	unsigned int             pow2p;
-
-	clockevents_register_device(&pnx8xxx_clockevent);
-	clocksource_register(&pnx_clocksource);
-
-	setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
-	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
-
-	/* Timer 1 start */
-	configPR = read_c0_config7();
-	configPR &= ~0x00000008;
-	write_c0_config7(configPR);
-
-	/* Timer 2 start */
-	configPR = read_c0_config7();
-	configPR &= ~0x00000010;
-	write_c0_config7(configPR);
-
-	/* Timer 3 stop */
-	configPR = read_c0_config7();
-	configPR |= 0x00000020;
-	write_c0_config7(configPR);
-
-
-        /* PLL0 sets MIPS clock (PLL1 <=> TM1, PLL6 <=> TM2, PLL5 <=> mem) */
-        /* (but only if CLK_MIPS_CTL select value [bits 3:1] is 1:  FIXME) */
-
-        n = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_N_MASK) >> 16;
-        m = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_M_MASK) >> 8;
-        p = (PNX8550_CM_PLL0_CTL & PNX8550_CM_PLL_P_MASK) >> 2;
-	pow2p = (1 << p);
-
-	db_assert(m != 0 && pow2p != 0);
-
-        /*
-	 * Compute the frequency as in the PNX8550 User Manual 1.0, p.186
-	 * (a.k.a. 8-10).  Divide by HZ for a timer offset that results in
-	 * HZ timer interrupts per second.
-	 */
-	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
-	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
-	write_c0_count(0);
-	timer_ack();
-
-	/* Setup Timer 2 */
-	write_c0_count2(0);
-	write_c0_compare2(0xffffffff);
-
-}
-
-
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/board_setup.c
linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/board_setup.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/board_setup.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/board_setup.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,65 +0,0 @@
-/*
- *  JBS Specific board startup routines.
- *
- *  Copyright 2005, Embedded Alley Solutions, Inc
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/mc146818rtc.h>
-#include <linux/delay.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
-
-#include <glb.h>
-
-/* CP0 hazard avoidance. */
-#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
-				     "nop; nop; nop; nop; nop; nop;\n\t" \
-				     ".set reorder\n\t")
-
-void __init board_setup(void)
-{
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
-
-	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
-	write_c0_config(config0);
-	BARRIER;
-
-	configpr = read_c0_config7();
-	configpr |= (1<<19); /* enable tlb */
-	write_c0_config7(configpr);
-	BARRIER;
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/init.c
linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/init.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/init.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/init.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,56 +0,0 @@
-/*
- *
- *  Copyright 2005 Embedded Alley Solutions, Inc
- *  source@embeddedalley.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-
-const char *get_system_type(void)
-{
-	return "Philips PNX8550/JBS";
-}
-
-void __init prom_init(void)
-{
-
-	unsigned long memsize;
-
-	mips_machtype = MACH_PHILIPS_JBS;
-
-	//memsize = 0x02800000; /* Trimedia uses memory above */
-	memsize = 0x08000000; /* Trimedia uses memory above */
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/irqmap.c
linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/irqmap.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/irqmap.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/irqmap.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,36 +0,0 @@
-/*
- *  Philips JBS board irqmap.
- *
- *  Copyright 2005 Embedded Alley Solutions, Inc
- *  source@embeddealley.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <int.h>
-
-char pnx8550_irq_tab[][5] __initdata = {
-	[8]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-	[9]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-	[17]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-};
-
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/Makefile
linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/Makefile
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/jbs/Makefile	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/jbs/Makefile	1970-01-01
01:00:00.000000000 +0100
@@ -1,4 +0,0 @@
-
-# Makefile for the Philips JBS Board.
-
-lib-y := init.o board_setup.o irqmap.o
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/board_setup.c
linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/board_setup.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/board_setup.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/board_setup.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,49 +0,0 @@
-/*
- *  STB810 specific board startup routines.
- *
- *  Based on the arch/mips/philips/pnx8550/jbs/board_setup.c
- *
- *  Author: MontaVista Software, Inc.
- *          source@mvista.com
- *
- *  Copyright 2005 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/mc146818rtc.h>
-#include <linux/delay.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
-
-#include <glb.h>
-
-void __init board_setup(void)
-{
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
-
-	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
-	write_c0_config(config0);
-
-	configpr = read_c0_config7();
-	configpr |= (1<<19); /* enable tlb */
-	write_c0_config7(configpr);
-}
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/irqmap.c
linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/irqmap.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/irqmap.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/irqmap.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,23 +0,0 @@
-/*
- *  Philips STB810 board irqmap.
- *
- *  Author: MontaVista Software, Inc.
- *          source@mvista.com
- *
- *  Copyright 2005 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-
-#include <linux/init.h>
-#include <int.h>
-
-char pnx8550_irq_tab[][5] __initdata = {
-	[8]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-	[9]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-	[10]	= { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-};
-
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/Makefile
linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/Makefile
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/Makefile	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/Makefile	1970-01-01
01:00:00.000000000 +0100
@@ -1,4 +0,0 @@
-
-# Makefile for the Philips STB810 Board.
-
-lib-y := prom_init.o board_setup.o irqmap.o
diff -urN linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/prom_init.c
linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/prom_init.c
--- linux-2.6.24.2.orig/arch/mips/philips/pnx8550/stb810/prom_init.c	2008-02-26
08:23:00.000000000 +0000
+++ linux-2.6.24.2/arch/mips/philips/pnx8550/stb810/prom_init.c	1970-01-01
01:00:00.000000000 +0100
@@ -1,48 +0,0 @@
-/*
- *  STB810 specific prom routines
- *
- *  Author: MontaVista Software, Inc.
- *          source@mvista.com
- *
- *  Copyright 2005 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-
-const char *get_system_type(void)
-{
-	return "Philips PNX8550/STB810";
-}
-
-void __init prom_init(void)
-{
-	unsigned long memsize;
-
-	prom_argc = (int) fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
-
-	prom_init_cmdline();
-
-	mips_machtype = MACH_PHILIPS_STB810;
-
-	memsize = 0x08000000; /* Trimedia uses memory above */
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff -urN linux-2.6.24.2.orig/drivers/serial/Kconfig
linux-2.6.24.2/drivers/serial/Kconfig
--- linux-2.6.24.2.orig/drivers/serial/Kconfig	2008-02-26
08:23:28.000000000 +0000
+++ linux-2.6.24.2/drivers/serial/Kconfig	2008-02-26 08:39:53.000000000 +0000
@@ -925,7 +925,7 @@
 	depends on MIPS && SOC_PNX8550
 	select SERIAL_CORE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as any PNX8XXX device
 	  and you want to use serial ports, say Y.  Otherwise, say N.

 config SERIAL_PNX8XXX_CONSOLE
@@ -933,7 +933,7 @@
 	depends on SERIAL_PNX8XXX
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as any PNX8XXX device
 	  and you want to use serial console, say Y. Otherwise, say N.

 config SERIAL_CORE
diff -urN linux-2.6.24.2.orig/include/asm-mips/bootinfo.h
linux-2.6.24.2/include/asm-mips/bootinfo.h
--- linux-2.6.24.2.orig/include/asm-mips/bootinfo.h	2008-02-26
08:23:45.000000000 +0000
+++ linux-2.6.24.2/include/asm-mips/bootinfo.h	2008-02-26
08:43:04.000000000 +0000
@@ -102,8 +102,12 @@
  */
 #define  MACH_PHILIPS_NINO	0	/* Nino */
 #define  MACH_PHILIPS_VELO	1	/* Velo */
-#define  MACH_PHILIPS_JBS	2	/* JBS */
-#define  MACH_PHILIPS_STB810	3	/* STB810 */
+
+/*
+ * Valid machtype for group NXP
+ */
+#define  MACH_NXP_JBS	    0	/* JBS */
+#define  MACH_NXP_STB810	1	/* STB810 */

 /*
  * Valid machtype for group SIBYTE
diff -urN linux-2.6.24.2.orig/include/asm-mips/cpu.h
linux-2.6.24.2/include/asm-mips/cpu.h
--- linux-2.6.24.2.orig/include/asm-mips/cpu.h	2008-02-26
08:23:45.000000000 +0000
+++ linux-2.6.24.2/include/asm-mips/cpu.h	2008-02-26 08:34:57.000000000 +0000
@@ -29,7 +29,7 @@
 #define PRID_COMP_ALCHEMY	0x030000
 #define PRID_COMP_SIBYTE	0x040000
 #define PRID_COMP_SANDCRAFT	0x050000
-#define PRID_COMP_PHILIPS	0x060000
+#define PRID_COMP_NXP   	0x060000
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
