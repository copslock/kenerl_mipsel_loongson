Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:43:40 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:2510 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023093AbXIYNn1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:43:27 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IaAe5-0003jw-04; Tue, 25 Sep 2007 15:40:13 +0200
Date:	Tue, 25 Sep 2007 15:40:12 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/4][MIPS] Add support for BCM47XX CPUs.
Message-ID: <20070925134012.GB14227@hall.aurel32.net>
References: <20070925133847.GA14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070925133847.GA14227@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch replaces commit ceb550f7d4b24ee5d5de1a8f7ac07f8a2fe3bf1d in
order to replace BCM947XX into BCM47XX.


    [MIPS] Add support for BCM47XX CPUs.
    
    Note that the BCM4710 does not support the wait instruction, this
    is not a mistake in the code.
    
    It originally comes from the OpenWrt patches.
    
    Cc: Michael Buesch <mb@bu3sch.de>
    Cc: Felix Fietkau <nbd@openwrt.org>
    Cc: Florian Schirmer <jolt@tuxbox.org>
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -44,6 +44,20 @@ config BASLER_EXCITE_PROTOTYPE
 	  note that a kernel built with this option selected will not be
 	  able to run on normal units.
 
+config BCM47XX
+	bool "BCM47XX based boards"
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SSB
+	select SSB_DRIVER_MIPS
+	select GENERIC_GPIO
+	help
+	 Support for BCM47XX based boards
+
 config MIPS_COBALT
 	bool "Cobalt Server"
 	select DMA_NONCOHERENT
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -535,6 +535,13 @@ libs-$(CONFIG_SIBYTE_BIGSUR)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
 
 #
+# Broadcom BCM47XX boards
+#
+core-$(CONFIG_BCM47XX)		+= arch/mips/bcm47xx/
+cflags-$(CONFIG_BCM47XX)	+= -Iinclude/asm-mips/mach-bcm47xx
+load-$(CONFIG_BCM47XX)		:= 0xffffffff80001000
+
+#
 # SNI RM
 #
 core-$(CONFIG_SNI_RM)		+= arch/mips/sni/
--- /dev/null
+++ b/arch/mips/bcm47xx/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the BCM47XX specific kernel interface routines
+# under Linux.
+#
+
+obj-y := irq.o prom.o serial.o setup.o time.o
--- /dev/null
+++ b/arch/mips/bcm47xx/irq.c
@@ -0,0 +1,55 @@
+/*
+ *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
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
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/irq_cpu.h>
+
+void plat_irq_dispatch(void)
+{
+	u32 cause;
+
+	cause = read_c0_cause() & read_c0_status() & CAUSEF_IP;
+
+	clear_c0_status(cause);
+
+	if (cause & CAUSEF_IP7)
+		do_IRQ(7);
+	if (cause & CAUSEF_IP2)
+		do_IRQ(2);
+	if (cause & CAUSEF_IP3)
+		do_IRQ(3);
+	if (cause & CAUSEF_IP4)
+		do_IRQ(4);
+	if (cause & CAUSEF_IP5)
+		do_IRQ(5);
+	if (cause & CAUSEF_IP6)
+		do_IRQ(6);
+}
+
+void __init arch_init_irq(void)
+{
+	mips_cpu_irq_init();
+}
--- /dev/null
+++ b/arch/mips/bcm47xx/prom.c
@@ -0,0 +1,49 @@
+/*
+ *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
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
+#include <asm/bootinfo.h>
+
+const char *get_system_type(void)
+{
+	return "Broadcom BCM47XX";
+}
+
+void __init prom_init(void)
+{
+	unsigned long mem;
+
+	/* Figure out memory size by finding aliases */
+	for (mem = (1 << 20); mem < (128 << 20); mem += (1 << 20)) {
+		if (*(unsigned long *)((unsigned long)(prom_init) + mem) ==
+		    *(unsigned long *)(prom_init))
+			break;
+	}
+
+	add_memory_region(0, mem, BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
--- /dev/null
+++ b/arch/mips/bcm47xx/serial.c
@@ -0,0 +1,52 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/ssb/ssb.h>
+#include <bcm47xx.h>
+
+static struct plat_serial8250_port uart8250_data[5];
+
+static struct platform_device uart8250_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev			= {
+		.platform_data	= uart8250_data,
+	},
+};
+
+static int __init uart8250_init(void)
+{
+	int i;
+	struct ssb_mipscore *mcore = &(ssb_bcm47xx.mipscore);
+
+	memset(&uart8250_data, 0,  sizeof(uart8250_data));
+
+	for (i = 0; i < mcore->nr_serial_ports; i++) {
+		struct plat_serial8250_port *p = &(uart8250_data[i]);
+		struct ssb_serial_port *ssb_port = &(mcore->serial_ports[i]);
+
+		p->mapbase = (unsigned int) ssb_port->regs;
+		p->membase = (void *) ssb_port->regs;
+		p->irq = ssb_port->irq + 2;
+		p->uartclk = ssb_port->baud_base;
+		p->regshift = ssb_port->reg_shift;
+		p->iotype = UPIO_MEM;
+		p->flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	}
+	return platform_device_register(&uart8250_device);
+}
+
+module_init(uart8250_init);
+
+MODULE_AUTHOR("Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("8250 UART probe driver for the BCM47XX platforms");
--- /dev/null
+++ b/arch/mips/bcm47xx/setup.c
@@ -0,0 +1,79 @@
+/*
+ *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
+ *  Copyright (C) 2005 Waldemar Brodkorb <wbx@openwrt.org>
+ *  Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ *  Copyright (C) 2006 Michael Buesch <mb@bu3sch.de>
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
+#include <linux/types.h>
+#include <linux/ssb/ssb.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <bcm47xx.h>
+
+struct ssb_bus ssb_bcm47xx;
+EXPORT_SYMBOL(ssb_bcm47xx);
+
+static void bcm47xx_machine_restart(char *command)
+{
+	printk(KERN_ALERT "Please stand by while rebooting the system...\n");
+	local_irq_disable();
+	/* Set the watchdog timer to reset immediately */
+	ssb_chipco_watchdog_timer_set(&ssb_bcm47xx.chipco, 1);
+	while (1)
+		cpu_relax();
+}
+
+static void bcm47xx_machine_halt(void)
+{
+	/* Disable interrupts and watchdog and spin forever */
+	local_irq_disable();
+	ssb_chipco_watchdog_timer_set(&ssb_bcm47xx.chipco, 0);
+	while (1)
+		cpu_relax();
+}
+
+static int bcm47xx_get_invariants(struct ssb_bus *bus,
+				   struct ssb_init_invariants *iv)
+{
+	/* TODO: fill ssb_init_invariants using boardtype/boardrev
+	 * CFE environment variables.
+	 */
+	return 0;
+}
+
+void __init plat_mem_setup(void)
+{
+	int err;
+
+	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
+				      bcm47xx_get_invariants);
+	if (err)
+		panic("Failed to initialize SSB bus (err %d)\n", err);
+
+	_machine_restart = bcm47xx_machine_restart;
+	_machine_halt = bcm47xx_machine_halt;
+	pm_power_off = bcm47xx_machine_halt;
+	board_time_init = bcm47xx_time_init;
+}
+
--- /dev/null
+++ b/arch/mips/bcm47xx/time.c
@@ -0,0 +1,56 @@
+/*
+ *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
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
+
+#include <linux/init.h>
+#include <linux/ssb/ssb.h>
+#include <asm/time.h>
+#include <bcm47xx.h>
+
+void __init
+bcm47xx_time_init(void)
+{
+	unsigned long hz;
+
+	/*
+	 * Use deterministic values for initial counter interrupt
+	 * so that calibrate delay avoids encountering a counter wrap.
+	 */
+	write_c0_count(0);
+	write_c0_compare(0xffff);
+
+	hz = ssb_cpu_clock(&ssb_bcm47xx.mipscore) / 2;
+	if (!hz)
+		hz = 100000000;
+
+	/* Set MIPS counter frequency for fixed_rate_gettimeoffset() */
+	mips_hpt_frequency = hz;
+}
+
+void __init
+plat_timer_setup(struct irqaction *irq)
+{
+	/* Enable the timer interrupt */
+	setup_irq(7, irq);
+}
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -159,6 +159,7 @@ static inline void check_wait(void)
 	case CPU_5KC:
 	case CPU_25KF:
 	case CPU_PR4450:
+	case CPU_BCM3302:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -793,6 +794,22 @@ static inline void cpu_probe_philips(struct cpuinfo_mips *c)
 }
 
 
+static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_BCM3302:
+		c->cputype = CPU_BCM3302;
+		break;
+	case PRID_IMP_BCM4710:
+		c->cputype = CPU_BCM4710;
+		break;
+	default:
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+}
+
 __init void cpu_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -815,6 +832,9 @@ __init void cpu_probe(void)
 	case PRID_COMP_SIBYTE:
 		cpu_probe_sibyte(c);
 		break;
+	case PRID_COMP_BROADCOM:
+		cpu_probe_broadcom(c);
+		break;
 	case PRID_COMP_SANDCRAFT:
 		cpu_probe_sandcraft(c);
 		break;
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -82,6 +82,8 @@ static const char *cpu_name[] = {
 	[CPU_VR4181]	= "NEC VR4181",
 	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
+	[CPU_BCM3302]	= "Broadcom BCM3302",
+	[CPU_BCM4710]	= "Broadcom BCM4710",
 	[CPU_PR4450]	= "Philips PR4450",
 	[CPU_LOONGSON2]	= "ICT Loongson-2",
 };
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -908,6 +908,8 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
+	case CPU_BCM3302:
+	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 		if (m4kc_tlbp_war())
 			i_nop(p);
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -215,6 +215,12 @@
 #define MACH_GROUP_WINDRIVER   28	/* Windriver boards */
 #define MACH_WRPPMC             1
 
+/*
+ * Valid machtype for group Broadcom
+ */
+#define MACH_GROUP_BRCM		23	/* Broadcom			*/
+#define  MACH_BCM47XX		1	/* Broadcom BCM47XX		*/
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -106,6 +106,13 @@
 #define PRID_IMP_SR71000        0x0400
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_BROADCOM
+ */
+
+#define PRID_IMP_BCM4710	0x4000
+#define PRID_IMP_BCM3302	0x9000
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -217,8 +224,9 @@
 #define CPU_R14000		64
 #define CPU_LOONGSON1           65
 #define CPU_LOONGSON2           66
-
-#define CPU_LAST		66
+#define CPU_BCM3302		67
+#define CPU_BCM4710		68
+#define CPU_LAST		68
 
 /*
  * ISA Level encodings
--- /dev/null
+++ b/include/asm-mips/mach-bcm47xx/bcm47xx.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#ifndef __ASM_BCM47XX_H
+#define __ASM_BCM47XX_H
+
+/* SSB bus */
+extern struct ssb_bus ssb_bcm47xx;
+
+extern void bcm47xx_time_init(void);
+
+#endif /* __ASM_BCM47XX_H */

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
