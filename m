Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 01:44:44 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:28578 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021518AbXHIAof (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 01:44:35 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IIw8c-0001TV-7y; Thu, 09 Aug 2007 02:44:30 +0200
Date:	Thu, 9 Aug 2007 02:44:30 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Andrew Morton <akpm@linux-foundation.org>, mb@bu3sch.de,
	nbd@openwrt.org, jolt@tuxbox.org
Subject: [PATCH 2/4][RFC] MIPS: BCM947xx support
Message-ID: <20070809004430.GC4682@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net> <200708062037.05995.mb@bu3sch.de> <20070806191712.GA2019@hall.aurel32.net> <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp> <20070807121638.GA9953@hall.aurel32.net> <20070807183302.1e38a4df.akpm@linux-foundation.org> <20070809004156.GA4682@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070809004156.GA4682@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
It originally comes from the OpenWrt patches.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/bcm947xx/irq.c
+++ b/arch/mips/bcm947xx/irq.c
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
--- a/arch/mips/bcm947xx/Makefile
+++ b/arch/mips/bcm947xx/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the BCM947xx specific kernel interface routines
+# under Linux.
+#
+
+obj-y := irq.o prom.o serial.o setup.o time.o
--- a/arch/mips/bcm947xx/prom.c
+++ b/arch/mips/bcm947xx/prom.c
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
+	return "Broadcom BCM947xx";
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
--- a/arch/mips/bcm947xx/serial.c	
+++ b/arch/mips/bcm947xx/serial.c	
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
+#include <bcm947xx.h>
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
+	struct ssb_mipscore *mcore = &(ssb_bcm947xx.mipscore);
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
+MODULE_DESCRIPTION("8250 UART probe driver for the BCM947xx platforms");
--- a/arch/mips/bcm947xx/setup.c
+++ b/arch/mips/bcm947xx/setup.c
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
+#include <bcm947xx.h>
+
+struct ssb_bus ssb_bcm947xx;
+EXPORT_SYMBOL(ssb_bcm947xx);
+
+static void bcm947xx_machine_restart(char *command)
+{
+	printk(KERN_ALERT "Please stand by while rebooting the system...\n");
+	local_irq_disable();
+	/* Set the watchdog timer to reset immediately */
+	ssb_chipco_watchdog_timer_set(&ssb_bcm947xx.chipco, 1);
+	while (1)
+		cpu_relax();
+}
+
+static void bcm947xx_machine_halt(void)
+{
+	/* Disable interrupts and watchdog and spin forever */
+	local_irq_disable();
+	ssb_chipco_watchdog_timer_set(&ssb_bcm947xx.chipco, 0);
+	while (1)
+		cpu_relax();
+}
+
+static int bcm947xx_get_invariants(struct ssb_bus *bus,
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
+	err = ssb_bus_ssbbus_register(&ssb_bcm947xx, SSB_ENUM_BASE,
+				      bcm947xx_get_invariants);
+	if (err)
+		panic("Failed to initialize SSB bus (err %d)\n", err);
+
+	_machine_restart = bcm947xx_machine_restart;
+	_machine_halt = bcm947xx_machine_halt;
+	pm_power_off = bcm947xx_machine_halt;
+	board_time_init = bcm947xx_time_init;
+}
+
--- a/arch/mips/bcm947xx/time.c
+++ b/arch/mips/bcm947xx/time.c
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
+#include <bcm947xx.h>
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
+	hz = ssb_cpu_clock(&ssb_bcm947xx.mipscore) / 2;
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
--- a/include/asm-mips/mach-bcm947xx/bcm947xx.h
+++ b/include/asm-mips/mach-bcm947xx/bcm947xx.h
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
+#ifndef __ASM_BCM947XX_H
+#define __ASM_BCM947XX_H
+
+/* SSB bus */
+extern struct ssb_bus ssb_bcm947xx;
+
+extern void bcm947xx_time_init(void);
+
+#endif /* __ASM_BCM947XX_H */

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
