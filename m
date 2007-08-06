Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 20:17:20 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:60907 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021589AbXHFTRS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 20:17:18 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II84m-0000aN-1Y; Mon, 06 Aug 2007 21:17:12 +0200
Date:	Mon, 6 Aug 2007 21:17:12 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: [PATCH -mm 2/4] MIPS: BCM947xx support (v2)
Message-ID: <20070806191712.GA2019@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net> <200708062037.05995.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200708062037.05995.mb@bu3sch.de>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
It originally comes from the OpenWrt patches.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Waldemar Brodkorb <wbx@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/bcm947xx/irq.c
+++ b/arch/mips/bcm947xx/irq.c
@@ -0,0 +1,63 @@
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
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/cpu.h>
+#include <asm/io.h>
+#include <asm/irq.h>
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
--- a/arch/mips/bcm947xx/Makefile
+++ b/arch/mips/bcm947xx/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the BCM947xx specific kernel interface routines
+# under Linux.
+#
+
+obj-y := irq.o prom.o setup.o time.o
--- a/arch/mips/bcm947xx/prom.c
+++ b/arch/mips/bcm947xx/prom.c
@@ -0,0 +1,58 @@
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
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/pmon.h>
+
+const char *get_system_type(void)
+{
+	return "Broadcom BCM947xx";
+}
+
+void __init prom_init(void)
+{
+	unsigned long mem;
+
+	mips_machgroup = MACH_GROUP_BRCM;
+	mips_machtype = MACH_BCM947XX;
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
--- a/arch/mips/bcm947xx/setup.c
+++ b/arch/mips/bcm947xx/setup.c
@@ -0,0 +1,108 @@
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
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <asm/reboot.h>
+#include <linux/pm.h>
+#include <linux/ssb/ssb.h>
+
+extern void bcm947xx_pci_init(void);
+extern void bcm947xx_time_init(void);
+
+struct ssb_bus ssb;
+
+static void bcm947xx_machine_restart(char *command)
+{
+	printk(KERN_ALERT "Please stand by while rebooting the system...\n");
+	local_irq_disable();
+	/* Set the watchdog timer to reset immediately */
+	ssb_chipco_watchdog_timer_set(&ssb.chipco, 1);
+	while (1)
+		cpu_relax();
+}
+
+static void bcm947xx_machine_halt(void)
+{
+	/* Disable interrupts and watchdog and spin forever */
+	local_irq_disable();
+	ssb_chipco_watchdog_timer_set(&ssb.chipco, 0);
+	while (1)
+		cpu_relax();
+}
+
+static int bcm947xx_get_invariants(struct ssb_bus *bus, struct ssb_init_invariants *iv)
+{
+	/* TODO: fill ssb_init_invariants using boardtype/boardrev 
+	 * CFE environment variables.
+	 */
+
+	return 0;
+}
+
+void __init plat_mem_setup(void)
+{
+	int i, err;
+	struct ssb_mipscore *mcore;
+
+	err = ssb_bus_ssbbus_register(&ssb, SSB_ENUM_BASE, bcm947xx_get_invariants);
+	if (err)
+		panic("Failed to initialize SSB bus (err %d)\n", err);
+	mcore = &ssb.mipscore;
+
+#ifdef CONFIG_SERIAL_8250
+	for (i = 0; i < mcore->nr_serial_ports; i++) {
+		struct ssb_serial_port *port = &(mcore->serial_ports[i]);
+		struct uart_port s;
+	
+		memset(&s, 0, sizeof(s));
+		s.line = i;
+		s.membase = port->regs;
+		s.irq = port->irq + 2;
+		s.uartclk = port->baud_base;
+		s.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+		s.iotype = SERIAL_IO_MEM;
+		s.regshift = port->reg_shift;
+
+		early_serial_setup(&s);
+	}
+#endif
+
+	_machine_restart = bcm947xx_machine_restart;
+	_machine_halt = bcm947xx_machine_halt;
+	pm_power_off = bcm947xx_machine_halt;
+	board_time_init = bcm947xx_time_init;
+}
+
+EXPORT_SYMBOL(ssb);
--- a/arch/mips/bcm947xx/time.c
+++ b/arch/mips/bcm947xx/time.c
@@ -0,0 +1,62 @@
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
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/serial_reg.h>
+#include <linux/interrupt.h>
+#include <linux/ssb/ssb.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/time.h>
+
+extern struct ssb_bus ssb;
+
+void __init
+bcm947xx_time_init(void)
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
+	hz = ssb_cpu_clock(&ssb.mipscore) / 2;
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

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
