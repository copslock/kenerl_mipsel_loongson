Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:53:59 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:41964 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226040AbUEZPvr>;
	Wed, 26 May 2004 16:51:47 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02404;
	Thu, 27 May 2004 00:51:42 +0900 (JST)
Received: 4UMDO01 id i4QFpgu09045; Thu, 27 May 2004 00:51:42 +0900 (JST)
Received: 4UMRO00 id i4QFpfV28781; Thu, 27 May 2004 00:51:41 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:51:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][8/14] vr41xx: update PCIU initialization function
Message-Id: <20040527005139.63740a65.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The PCIU initialization function was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2004-05-24 10:40:22.000000000 +0900
+++ linux/arch/mips/Kconfig	2004-05-24 18:37:36.000000000 +0900
@@ -127,6 +127,10 @@
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 
+config PCI_VR41XX
+	bool "add PCI control unit support of NEC VR4100 series"
+	depends on MACH_VR41XX && PCI
+
 config VRC4171
 	tristate "add NEC VRC4171 companion chip support"
 	depends on MACH_VR41XX && ISA
@@ -135,7 +139,7 @@
 
 config VRC4173
 	tristate "add NEC VRC4173 companion chip support"
-	depends on MACH_VR41XX && PCI
+	depends on MACH_VR41XX && PCI_VR41XX
 	---help---
 	  The NEC VRC4173 is a companion chip for NEC VR4122/VR4131.
 
diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	2004-05-24 18:43:12.000000000 +0900
+++ linux/arch/mips/pci/Makefile	2004-05-24 18:37:36.000000000 +0900
@@ -16,6 +16,7 @@
 obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
 obj-$(CONFIG_MIPS_TX3927)	+= ops-jmr3927.o
+obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
@@ -49,5 +50,4 @@
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
-obj-$(CONFIG_MACH_VR41XX)	+= pci-vr41xx.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
diff -urN -X dontdiff linux-orig/arch/mips/pci/ops-vr41xx.c linux/arch/mips/pci/ops-vr41xx.c
--- linux-orig/arch/mips/pci/ops-vr41xx.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/arch/mips/pci/ops-vr41xx.c	2004-05-24 18:37:36.000000000 +0900
@@ -0,0 +1,126 @@
+/*
+ *  ops-vr41xx.c, PCI configuration routines for the PCIU of NEC VR4100 series.
+ *
+ *  Copyright (C) 2001-2003 MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
+/*
+ * Changes:
+ *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
+ *  - New creation, NEC VR4122 and VR4131 are supported.
+ */
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+
+#define PCICONFDREG	KSEG1ADDR(0x0f000c14)
+#define PCICONFAREG	KSEG1ADDR(0x0f000c18)
+
+static inline int set_pci_configuration_address(unsigned char number,
+                                                unsigned int devfn, int where)
+{
+	if (number == 0) {
+		/*
+		 * Type 0 configuration
+		 */
+		if (PCI_SLOT(devfn) < 11 || where > 0xff)
+			return -EINVAL;
+
+		writel((1U << PCI_SLOT(devfn)) | (PCI_FUNC(devfn) << 8) |
+		       (where & 0xfc), PCICONFAREG);
+	} else {
+		/*
+		 * Type 1 configuration
+		 */
+		if (where > 0xff)
+			return -EINVAL;
+
+		writel(((uint32_t)number << 16) | ((devfn & 0xff) << 8) |
+		       (where & 0xfc) | 1U, PCICONFAREG);
+	}
+
+	return 0;
+}
+
+static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+                           int size, uint32_t *val)
+{
+	uint32_t data;
+
+	*val = 0xffffffffU;
+	if (set_pci_configuration_address(bus->number, devfn, where) < 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	data = readl(PCICONFDREG);
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xffU;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffffU;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+                            int size, uint32_t val)
+{
+	uint32_t data;
+	int shift;
+
+	if (set_pci_configuration_address(bus->number, devfn, where) < 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	data = readl(PCICONFDREG);
+
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xffU << shift);
+		data |= ((val & 0xffU) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffffU << shift);
+		data |= ((val & 0xffffU) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	writel(data, PCICONFDREG);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops vr41xx_pci_ops = {
+	.read	= pci_config_read,
+	.write	= pci_config_write,
+};
diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	2004-02-25 12:12:07.000000000 +0900
+++ linux/arch/mips/pci/pci-vr41xx.c	2004-05-24 18:37:36.000000000 +0900
@@ -1,48 +1,32 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/pciu.c
+ *  pci-vr41xx.c, PCI Control Unit routines for the NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	PCI Control Unit routines for the NEC VR4100 series.
+ *  Copyright (C) 2001-2003 MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- * Copyright 2001-2003 MontaVista Software Inc.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 /*
  * Changes:
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - Fix deadlock-causing PCIU access race for VR4131.
- *
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4122 and VR4131 are supported.
  */
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <linux/delay.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
@@ -51,183 +35,257 @@
 
 #include "pci-vr41xx.h"
 
-static inline int vr41xx_pci_config_access(unsigned char bus,
-					   unsigned int devfn, int where)
-{
-	if (bus == 0) {
-		/*
-		 * Type 0 configuration
-		 */
-		if (PCI_SLOT(devfn) < 11 || where > 255)
-			return -1;
-
-		writel((1UL << PCI_SLOT(devfn)) |
-		       (PCI_FUNC(devfn) << 8) |
-		       (where & 0xfc), PCICONFAREG);
-	} else {
-		/*
-		 * Type 1 configuration
-		 */
-		if (where > 255)
-			return -1;
-
-		writel((bus << 16) |
-		       (devfn << 8) | (where & 0xfc) | 1UL, PCICONFAREG);
-	}
-
-	return 0;
-}
-
-static int vr41xx_pci_config_read(struct pci_bus *bus, unsigned int devfn,
-				  int where, int size, u32 * val)
-{
-	u32 data;
+extern struct pci_ops vr41xx_pci_ops;
 
-	*val = 0xffffffffUL;
-	if (vr41xx_pci_config_access(bus->number, devfn, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+static struct pci_master_address_conversion pci_master_memory1 = {
+	.bus_base_address	= PCI_MASTER_MEM1_BUS_BASE_ADDRESS,
+	.address_mask		= PCI_MASTER_MEM1_ADDRESS_MASK,
+	.pci_base_address	= PCI_MASTER_MEM1_PCI_BASE_ADDRESS,
+};
 
-	data = readl(PCICONFDREG);
+static struct pci_target_address_conversion pci_target_memory1 = {
+	.address_mask		= PCI_TARGET_MEM1_ADDRESS_MASK,
+	.bus_base_address	= PCI_TARGET_MEM1_BUS_BASE_ADDRESS,
+};
 
-	switch (size) {
-	case 1:
-		*val = (data >> ((where & 3) << 3)) & 0xffUL;
-		break;
-	case 2:
-		*val = (data >> ((where & 2) << 3)) & 0xffffUL;
-		break;
-	case 4:
-		*val = data;
-		break;
-	default:
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-	}
+static struct pci_master_address_conversion pci_master_io = {
+	.bus_base_address	= PCI_MASTER_IO_BUS_BASE_ADDRESS,
+	.address_mask		= PCI_MASTER_IO_ADDRESS_MASK,
+	.pci_base_address	= PCI_MASTER_IO_PCI_BASE_ADDRESS,
+};
 
-	return PCIBIOS_SUCCESSFUL;
-}
+static struct pci_mailbox_address pci_mailbox = {
+	.base_address		= PCI_MAILBOX_BASE_ADDRESS,
+};
 
-static int vr41xx_pci_config_write(struct pci_bus *bus, unsigned int devfn,
-				   int where, int size, u32 val)
-{
-	u32 data;
-	int shift;
+static struct pci_target_address_window pci_target_window1 = {
+	.base_address		= PCI_TARGET_WINDOW1_BASE_ADDRESS,
+};
 
-	if (vr41xx_pci_config_access(bus->number, devfn, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+static struct resource pci_mem_resource = {
+	.name   = "PCI Memory resources",
+	.start  = PCI_MEM_RESOURCE_START,
+	.end    = PCI_MEM_RESOURCE_END,
+	.flags  = IORESOURCE_MEM,
+};
 
-	data = readl(PCICONFDREG);
+static struct resource pci_io_resource = {
+	.name   = "PCI I/O resources",
+	.start  = PCI_IO_RESOURCE_START,
+	.end    = PCI_IO_RESOURCE_END,
+	.flags  = IORESOURCE_IO,
+};
 
-	switch (size) {
-	case 1:
-		shift = (where & 3) << 3;
-		data &= ~(0xff << shift);
-		data |= ((val & 0xff) << shift);
-		break;
-	case 2:
-		shift = (where & 2) << 3;
-		data &= ~(0xffff << shift);
-		data |= ((val & 0xffff) << shift);
-		break;
-	case 4:
-		data = val;
-		break;
-	default:
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-	}
+static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
+	.master_memory1				= &pci_master_memory1,
+	.target_memory1				= &pci_target_memory1,
+	.master_io				= &pci_master_io,
+	.exclusive_access			= CANNOT_LOCK_FROM_DEVICE,
+	.wait_time_limit_from_irdy_to_trdy	= 0,
+	.mailbox				= &pci_mailbox,
+	.target_window1				= &pci_target_window1,
+	.master_latency_timer			= 0x80,
+	.retry_limit				= 0,
+	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
+	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
+};
 
-	writel(data, PCICONFDREG);
+static struct pci_controller vr41xx_pci_controller = {
+	.pci_ops        = &vr41xx_pci_ops,
+	.mem_resource	= &pci_mem_resource,
+	.io_resource	= &pci_io_resource,
+};
 
-	return PCIBIOS_SUCCESSFUL;
+void __init vr41xx_pciu_setup(struct pci_controller_unit_setup *setup)
+{
+	vr41xx_pci_controller_unit_setup = *setup;
 }
 
-struct pci_ops vr41xx_pci_ops = {
-	.read = vr41xx_pci_config_read,
-	.write = vr41xx_pci_config_write,
-};
-
-void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)
+static int __init vr41xx_pciu_init(void)
 {
-	struct vr41xx_pci_address_space *s;
-	unsigned long vtclock;
-	u32 config;
-	int n;
+	struct pci_controller_unit_setup *setup;
+	struct pci_master_address_conversion *master;
+	struct pci_target_address_conversion *target;
+	struct pci_mailbox_address *mailbox;
+	struct pci_target_address_window *window;
+	unsigned long vtclock, pci_clock_max;
+	uint32_t val;
 
-	if (!map)
-		return;
+	setup = &vr41xx_pci_controller_unit_setup;
 
 	/* Disable PCI interrupt */
-	writew(0, MPCIINTREG);
+	vr41xx_disable_pciint();
 
 	/* Supply VTClock to PCIU */
 	vr41xx_supply_clock(PCIU_CLOCK);
 
-	/*
-	 * Sleep for 1us after setting MSKPPCIU bit in CMUCLKMSK
-	 * before doing any PCIU access to avoid deadlock on VR4131.
-	 */
-	udelay(1);
+	/* Dummy write, waiting for supply of VTClock. */
+	vr41xx_disable_pciint();
 
 	/* Select PCI clock */
+	if (setup->pci_clock_max != 0)
+		pci_clock_max = setup->pci_clock_max;
+	else
+		pci_clock_max = PCI_CLOCK_MAX;
 	vtclock = vr41xx_get_vtclock_frequency();
-	if (vtclock < MAX_PCI_CLOCK)
+	if (vtclock < pci_clock_max)
 		writel(EQUAL_VTCLOCK, PCICLKSELREG);
-	else if ((vtclock / 2) < MAX_PCI_CLOCK)
+	else if ((vtclock / 2) < pci_clock_max)
 		writel(HALF_VTCLOCK, PCICLKSELREG);
-	else if ((vtclock / 4) < MAX_PCI_CLOCK)
+	else if (current_cpu_data.processor_id >= PRID_VR4131_REV2_1 &&
+	         (vtclock / 3) < pci_clock_max)
+		writel(ONE_THIRD_VTCLOCK, PCICLKSELREG);
+	else if ((vtclock / 4) < pci_clock_max)
 		writel(QUARTER_VTCLOCK, PCICLKSELREG);
-	else
-		printk(KERN_INFO "Warning: PCI Clock is over 33MHz.\n");
+	else {
+		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
+		return -EINVAL;
+	}
 
 	/* Supply PCI clock by PCI bus */
 	vr41xx_supply_clock(PCI_CLOCK);
 
-	/*
-	 * Set PCI memory & I/O space address conversion registers
-	 * for master transaction.
-	 */
-	if (map->mem1 != NULL) {
-		s = map->mem1;
-		config = (s->internal_base & 0xff000000) |
-		    ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		    ((s->pci_base & 0xff000000) >> 24);
-		writel(config, PCIMMAW1REG);
-	}
-	if (map->mem2 != NULL) {
-		s = map->mem2;
-		config = (s->internal_base & 0xff000000) |
-		    ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		    ((s->pci_base & 0xff000000) >> 24);
-		writel(config, PCIMMAW2REG);
-	}
-	if (map->io != NULL) {
-		s = map->io;
-		config = (s->internal_base & 0xff000000) |
-		    ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		    ((s->pci_base & 0xff000000) >> 24);
-		writel(config, PCIMIOAWREG);
-	}
-
-	/* Set target memory windows */
-	writel(0x00081000, PCITAW1REG);
-	writel(0UL, PCITAW2REG);
-	pciu_write_config_dword(PCI_BASE_ADDRESS_0, 0UL);
-	pciu_write_config_dword(PCI_BASE_ADDRESS_1, 0UL);
+	if (setup->master_memory1 != NULL) {
+		master = setup->master_memory1;
+		val = IBA(master->bus_base_address) |
+		      MASTER_MSK(master->address_mask) |
+		      WINEN |
+		      PCIA(master->pci_base_address);
+		writel(val, PCIMMAW1REG);
+	} else {
+		val = readl(PCIMMAW1REG);
+		val &= ~WINEN;
+		writel(val, PCIMMAW1REG);
+	}
+
+	if (setup->master_memory2 != NULL) {
+		master = setup->master_memory2;
+		val = IBA(master->bus_base_address) |
+		      MASTER_MSK(master->address_mask) |
+		      WINEN |
+		      PCIA(master->pci_base_address);
+		writel(val, PCIMMAW2REG);
+	} else {
+		val = readl(PCIMMAW2REG);
+		val &= ~WINEN;
+		writel(val, PCIMMAW2REG);
+	}
 
-	/* Clear bus error */
-	n = readl(BUSERRADREG);
+	if (setup->target_memory1 != NULL) {
+		target = setup->target_memory1;
+		val = TARGET_MSK(target->address_mask) |
+		      WINEN |
+		      ITA(target->bus_base_address);
+		writel(val, PCITAW1REG);
+	} else {
+		val = readl(PCITAW1REG);
+		val &= ~WINEN;
+		writel(val, PCITAW1REG);
+	}
+
+	if (setup->target_memory2 != NULL) {
+		target = setup->target_memory2;
+		val = TARGET_MSK(target->address_mask) |
+		      WINEN |
+		      ITA(target->bus_base_address);
+		writel(val, PCITAW2REG);
+	} else {
+		val = readl(PCITAW2REG);
+		val &= ~WINEN;
+		writel(val, PCITAW2REG);
+	}
 
-	if (current_cpu_data.cputype == CPU_VR4122) {
-		writel(0UL, PCITRDYVREG);
-		pciu_write_config_dword(PCI_CACHE_LINE_SIZE, 0x0000f804);
+	if (setup->master_io != NULL) {
+		master = setup->master_io;
+		val = IBA(master->bus_base_address) |
+		      MASTER_MSK(master->address_mask) |
+		      WINEN |
+		      PCIIA(master->pci_base_address);
+		writel(val, PCIMIOAWREG);
 	} else {
-		writel(100UL, PCITRDYVREG);
-		pciu_write_config_dword(PCI_CACHE_LINE_SIZE, 0x00008004);
+		val = readl(PCIMIOAWREG);
+		val &= ~WINEN;
+		writel(val, PCIMIOAWREG);
+	}
+
+	if (setup->exclusive_access == CANNOT_LOCK_FROM_DEVICE)
+		writel(UNLOCK, PCIEXACCREG);
+	else
+		writel(0, PCIEXACCREG);
+
+	if (current_cpu_data.cputype == CPU_VR4122)
+		writel(TRDYV(setup->wait_time_limit_from_irdy_to_trdy), PCITRDYVREG);
+
+	writel(MLTIM(setup->master_latency_timer), LATTIMEREG);
+
+	if (setup->mailbox != NULL) {
+		mailbox = setup->mailbox;
+		val = MBADD(mailbox->base_address) | TYPE_32BITSPACE |
+		      MSI_MEMORY | PREF_APPROVAL;
+		writel(val, MAILBAREG);
+	}
+
+	if (setup->target_window1) {
+		window = setup->target_window1;
+		val = PMBA(window->base_address) | TYPE_32BITSPACE |
+		      MSI_MEMORY | PREF_APPROVAL;
+		writel(val, PCIMBA1REG);
+	}
+
+	if (setup->target_window2) {
+		window = setup->target_window2;
+		val = PMBA(window->base_address) | TYPE_32BITSPACE |
+		      MSI_MEMORY | PREF_APPROVAL;
+		writel(val, PCIMBA2REG);
 	}
 
+	val = readl(RETVALREG);
+	val &= ~RTYVAL_MASK;
+	val |= RTYVAL(setup->retry_limit);
+	writel(val, RETVALREG);
+
+	val = readl(PCIAPCNTREG);
+	val &= ~(TKYGNT | PAPC);
+
+	switch (setup->arbiter_priority_control) {
+	case PCI_ARBITRATION_MODE_ALTERNATE_0:
+		val |= PAPC_ALTERNATE_0;
+		break;
+	case PCI_ARBITRATION_MODE_ALTERNATE_B:
+		val |= PAPC_ALTERNATE_B;
+		break;
+	default:
+		val |= PAPC_FAIR;
+		break;
+	}
+
+	if (setup->take_away_gnt_mode == PCI_TAKE_AWAY_GNT_ENABLE)
+		val |= TKYGNT_ENABLE;
+
+	writel(val, PCIAPCNTREG);
+
+	writel(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+	       PCI_COMMAND_PARITY | PCI_COMMAND_SERR, COMMANDREG);
+
+	/* Clear bus error */
+	readl(BUSERRADREG);
+
 	writel(CONFIG_DONE, PCIENREG);
-	pciu_write_config_dword(PCI_COMMAND,
-				PCI_COMMAND_IO |
-				PCI_COMMAND_MEMORY |
-				PCI_COMMAND_MASTER |
-				PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+
+	if (setup->mem_resource != NULL)
+		vr41xx_pci_controller.mem_resource = setup->mem_resource;
+
+	if (setup->io_resource != NULL) {
+		vr41xx_pci_controller.io_resource = setup->io_resource;
+	} else {
+		set_io_port_base(IO_PORT_BASE);
+		ioport_resource.start = IO_PORT_RESOURCE_START;
+		ioport_resource.end = IO_PORT_RESOURCE_END;
+	}
+
+	register_pci_controller(&vr41xx_pci_controller);
+
+	return 0;
 }
+
+early_initcall(vr41xx_pciu_init);
diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.h linux/arch/mips/pci/pci-vr41xx.h
--- linux-orig/arch/mips/pci/pci-vr41xx.h	2003-10-31 11:29:18.000000000 +0900
+++ linux/arch/mips/pci/pci-vr41xx.h	2004-05-24 18:37:36.000000000 +0900
@@ -1,164 +1,151 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/pciu.h
+ *  pci-vr41xx.h, Include file for PCI Control Unit of the NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for PCI Control Unit of the NEC VR4100 series.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
+ *  Copyright (C) 2002  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
  */
-#ifndef __VR41XX_PCIU_H
-#define __VR41XX_PCIU_H
-
-#include <linux/config.h>
-#include <asm/addrspace.h>
-
-#define BIT(x)	(1 << (x))
-
-#define PCIMMAW1REG			KSEG1ADDR(0x0f000c00)
-#define PCIMMAW2REG			KSEG1ADDR(0x0f000c04)
-#define PCITAW1REG			KSEG1ADDR(0x0f000c08)
-#define PCITAW2REG			KSEG1ADDR(0x0f000c0c)
-#define PCIMIOAWREG			KSEG1ADDR(0x0f000c10)
-#define INTERNAL_BUS_BASE_ADDRESS	0xff000000
-#define ADDRESS_MASK			0x000fe000
-#define PCI_ACCESS_ENABLE		BIT(12)
-#define PCI_ADDRESS_SETTING		0x000000ff
-
-#define PCICONFDREG			KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG			KSEG1ADDR(0x0f000c18)
-#define PCIMAILREG			KSEG1ADDR(0x0f000c1c)
-
-#define BUSERRADREG			KSEG1ADDR(0x0f000c24)
-#define ERROR_ADDRESS			0xfffffffc
-
-#define INTCNTSTAREG			KSEG1ADDR(0x0f000c28)
-#define MABTCLR				BIT(31)
-#define TRDYCLR				BIT(30)
-#define PARCLR				BIT(29)
-#define MBCLR				BIT(28)
-#define SERRCLR				BIT(27)
-
-#define PCIEXACCREG			KSEG1ADDR(0x0f000c2c)
-#define UNLOCK				BIT(1)
-#define EAREQ				BIT(0)
-
-#define PCIRECONTREG			KSEG1ADDR(0x0f000c30)
-#define RTRYCNT				0x000000ff
+#ifndef __PCI_VR41XX_H
+#define __PCI_VR41XX_H
 
-#define PCIENREG			KSEG1ADDR(0x0f000c34)
-#define CONFIG_DONE			BIT(2)
+#define PCIMMAW1REG		KSEG1ADDR(0x0f000c00)
+#define PCIMMAW2REG		KSEG1ADDR(0x0f000c04)
+#define PCITAW1REG		KSEG1ADDR(0x0f000c08)
+#define PCITAW2REG		KSEG1ADDR(0x0f000c0c)
+#define PCIMIOAWREG		KSEG1ADDR(0x0f000c10)
+ #define IBA(addr)		((addr) & 0xff000000U)
+ #define MASTER_MSK(mask)	(((mask) >> 11) & 0x000fe000U)
+ #define PCIA(addr)		(((addr) >> 24) & 0x000000ffU)
+ #define TARGET_MSK(mask)	(((mask) >> 8) & 0x000fe000U)
+ #define ITA(addr)		(((addr) >> 24) & 0x000000ffU)
+ #define PCIIA(addr)		(((addr) >> 24) & 0x000000ffU)
+ #define WINEN			0x1000U
+#define PCICONFDREG		KSEG1ADDR(0x0f000c14)
+#define PCICONFAREG		KSEG1ADDR(0x0f000c18)
+#define PCIMAILREG		KSEG1ADDR(0x0f000c1c)
+#define BUSERRADREG		KSEG1ADDR(0x0f000c24)
+ #define EA(reg)		((reg) &0xfffffffc)
+
+#define INTCNTSTAREG		KSEG1ADDR(0x0f000c28)
+ #define MABTCLR		0x80000000U
+ #define TRDYCLR		0x40000000U
+ #define PARCLR			0x20000000U
+ #define MBCLR			0x10000000U
+ #define SERRCLR		0x08000000U
+ #define RTYCLR			0x04000000U
+ #define MABCLR			0x02000000U
+ #define TABCLR			0x01000000U
+ /* RFU */
+ #define MABTMSK		0x00008000U
+ #define TRDYMSK		0x00004000U
+ #define PARMSK			0x00002000U
+ #define MBMSK			0x00001000U
+ #define SERRMSK		0x00000800U
+ #define RTYMSK			0x00000400U
+ #define MABMSK			0x00000200U
+ #define TABMSK			0x00000100U
+ #define IBAMABT		0x00000080U
+ #define TRDYRCH		0x00000040U
+ #define PAR			0x00000020U
+ #define MB			0x00000010U
+ #define PCISERR		0x00000008U
+ #define RTYRCH			0x00000004U
+ #define MABORT			0x00000002U
+ #define TABORT			0x00000001U
+
+#define PCIEXACCREG		KSEG1ADDR(0x0f000c2c)
+ #define UNLOCK			0x2U
+ #define EAREQ			0x1U
+#define PCIRECONTREG		KSEG1ADDR(0x0f000c30)
+ #define RTRYCNT(reg)		((reg) & 0x000000ffU)
+#define PCIENREG		KSEG1ADDR(0x0f000c34)
+ #define CONFIG_DONE		0x4U
+#define PCICLKSELREG		KSEG1ADDR(0x0f000c38)
+ #define EQUAL_VTCLOCK		0x2U
+ #define HALF_VTCLOCK		0x0U
+ #define ONE_THIRD_VTCLOCK	0x3U
+ #define QUARTER_VTCLOCK	0x1U
+#define PCITRDYVREG		KSEG1ADDR(0x0f000c3c)
+ #define TRDYV(val)		((uint32_t)(val) & 0xffU)
+#define PCICLKRUNREG		KSEG1ADDR(0x0f000c60)
+
+#define VENDORIDREG		KSEG1ADDR(0x0f000d00)
+#define DEVICEIDREG		KSEG1ADDR(0x0f000d00)
+#define COMMANDREG		KSEG1ADDR(0x0f000d04)
+#define STATUSREG		KSEG1ADDR(0x0f000d04)
+#define REVIDREG		KSEG1ADDR(0x0f000d08)
+#define CLASSREG		KSEG1ADDR(0x0f000d08)
+#define CACHELSREG		KSEG1ADDR(0x0f000d0c)
+#define LATTIMEREG		KSEG1ADDR(0x0f000d0c)
+ #define MLTIM(val)		(((uint32_t)(val) << 7) & 0xff00U)
+#define MAILBAREG		KSEG1ADDR(0x0f000d10)
+#define PCIMBA1REG		KSEG1ADDR(0x0f000d14)
+#define PCIMBA2REG		KSEG1ADDR(0x0f000d18)
+ #define MBADD(base)		((base) & 0xfffff800U)
+ #define PMBA(base)		((base) & 0xffe00000U)
+ #define PREF			0x8U
+ #define PREF_APPROVAL		0x8U
+ #define PREF_DISAPPROVAL	0x0U
+ #define TYPE			0x6U
+ #define TYPE_32BITSPACE	0x0U
+ #define MSI			0x1U
+ #define MSI_MEMORY		0x0U
+#define INTLINEREG		KSEG1ADDR(0x0f000d3c)
+#define INTPINREG		KSEG1ADDR(0x0f000d3c)
+#define RETVALREG		KSEG1ADDR(0x0f000d40)
+#define PCIAPCNTREG		KSEG1ADDR(0x0f000d40)
+ #define TKYGNT			0x04000000U
+ #define TKYGNT_ENABLE		0x04000000U
+ #define TKYGNT_DISABLE		0x00000000U
+ #define PAPC			0x03000000U
+ #define PAPC_ALTERNATE_B	0x02000000U
+ #define PAPC_ALTERNATE_0	0x01000000U
+ #define PAPC_FAIR		0x00000000U
+ #define RTYVAL(val)		(((uint32_t)(val) << 7) & 0xff00U)
+ #define RTYVAL_MASK		0xff00U
 
-#define PCICLKSELREG			KSEG1ADDR(0x0f000c38)
-#define EQUAL_VTCLOCK			0x00000002
-#define HALF_VTCLOCK			0x00000000
-#define QUARTER_VTCLOCK			0x00000001
+#define PCI_CLOCK_MAX		33333333U
 
-#define PCITRDYVREG			KSEG1ADDR(0x0f000c3c)
-
-#define PCICLKRUNREG			KSEG1ADDR(0x0f000c60)
-
-#define PCIU_CONFIGREGS_BASE		KSEG1ADDR(0x0f000d00)
-#define VENDORIDREG			KSEG1ADDR(0x0f000d00)
-#define DEVICEIDREG			KSEG1ADDR(0x0f000d00)
-#define COMMANDREG			KSEG1ADDR(0x0f000d04)
-#define STATUSREG			KSEG1ADDR(0x0f000d04)
-#define REVIDREG			KSEG1ADDR(0x0f000d08)
-#define CLASSREG			KSEG1ADDR(0x0f000d08)
-#define CACHELSREG			KSEG1ADDR(0x0f000d0c)
-#define LATTIMEREG			KSEG1ADDR(0x0f000d0c)
-#define MAILBAREG			KSEG1ADDR(0x0f000d10)
-#define PCIMBA1REG			KSEG1ADDR(0x0f000d14)
-#define PCIMBA2REG			KSEG1ADDR(0x0f000d18)
-#define INTLINEREG			KSEG1ADDR(0x0f000d3c)
-#define INTPINREG			KSEG1ADDR(0x0f000d3c)
-#define RETVALREG			KSEG1ADDR(0x0f000d40)
-#define PCIAPCNTREG			KSEG1ADDR(0x0f000d40)
-
-#define MPCIINTREG			KSEG1ADDR(0x0f0000b2)
-
-#define MAX_PCI_CLOCK			33333333
-
-static inline int pciu_read_config_byte(int where, u8 * val)
-{
-	u32 data;
-
-	data = readl(PCIU_CONFIGREGS_BASE + where);
-	*val = (u8) (data >> ((where & 3) << 3));
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int pciu_read_config_word(int where, u16 * val)
-{
-	u32 data;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	data = readl(PCIU_CONFIGREGS_BASE + where);
-	*val = (u16) (data >> ((where & 2) << 3));
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int pciu_read_config_dword(int where, u32 * val)
-{
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	*val = readl(PCIU_CONFIGREGS_BASE + where);
+/*
+ * Default setup
+ */
+#define PCI_MASTER_MEM1_BUS_BASE_ADDRESS	0x10000000U
+#define PCI_MASTER_MEM1_ADDRESS_MASK		0x7c000000U
+#define PCI_MASTER_MEM1_PCI_BASE_ADDRESS	0x10000000U
 
-	return PCIBIOS_SUCCESSFUL;
-}
+#define PCI_TARGET_MEM1_ADDRESS_MASK		0x08000000U
+#define PCI_TARGET_MEM1_BUS_BASE_ADDRESS	0x00000000U
 
-static inline int pciu_write_config_byte(int where, u8 val)
-{
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+#define PCI_MASTER_IO_BUS_BASE_ADDRESS		0x16000000U
+#define PCI_MASTER_IO_ADDRESS_MASK		0x7e000000U
+#define PCI_MASTER_IO_PCI_BASE_ADDRESS		0x00000000U
 
-	return 0;
-}
+#define PCI_MAILBOX_BASE_ADDRESS		0x00000000U
 
-static inline int pciu_write_config_word(int where, u16 val)
-{
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+#define PCI_TARGET_WINDOW1_BASE_ADDRESS		0x00000000U
 
-	return 0;
-}
+#define IO_PORT_BASE		KSEG1ADDR(PCI_MASTER_IO_BUS_BASE_ADDRESS)
+#define IO_PORT_RESOURCE_START	PCI_MASTER_IO_PCI_BASE_ADDRESS
+#define IO_PORT_RESOURCE_END	(~PCI_MASTER_IO_ADDRESS_MASK & PCI_MASTER_ADDRESS_MASK)
 
-static inline int pciu_write_config_dword(int where, u32 val)
-{
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+#define PCI_IO_RESOURCE_START	0x01000000UL
+#define PCI_IO_RESOURCE_END	0x01ffffffUL
 
-	return 0;
-}
+#define PCI_MEM_RESOURCE_START	0x11000000UL
+#define PCI_MEM_RESOURCE_END	0x13ffffffUL
 
-#endif				/* __VR41XX_PCIU_H */
+#endif /* __PCI_VR41XX_H */
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	2004-05-24 18:42:52.000000000 +0900
+++ linux/include/asm-mips/vr41xx/vr41xx.h	2004-05-24 18:37:36.000000000 +0900
@@ -277,18 +277,71 @@
 /*
  * PCI Control Unit
  */
-struct vr41xx_pci_address_space {
-	u32 internal_base;
-	u32 address_mask;
-	u32 pci_base;
+#define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
+
+struct pci_master_address_conversion {
+	uint32_t bus_base_address;
+	uint32_t address_mask;
+	uint32_t pci_base_address;
+};
+
+struct pci_target_address_conversion {
+	uint32_t address_mask;
+	uint32_t bus_base_address;
 };
 
-struct vr41xx_pci_address_map {
-	struct vr41xx_pci_address_space *mem1;
-	struct vr41xx_pci_address_space *mem2;
-	struct vr41xx_pci_address_space *io;
+typedef enum {
+	CANNOT_LOCK_FROM_DEVICE,
+	CAN_LOCK_FROM_DEVICE,
+} pci_exclusive_access_t;
+
+struct pci_mailbox_address {
+	uint32_t base_address;
+};
+
+struct pci_target_address_window {
+	uint32_t base_address;
+};
+
+typedef enum {
+	PCI_ARBITRATION_MODE_FAIR,
+	PCI_ARBITRATION_MODE_ALTERNATE_0,
+	PCI_ARBITRATION_MODE_ALTERNATE_B,
+} pci_arbiter_priority_control_t;
+
+typedef enum {
+	PCI_TAKE_AWAY_GNT_DISABLE,
+	PCI_TAKE_AWAY_GNT_ENABLE,
+} pci_take_away_gnt_mode_t;
+
+struct pci_controller_unit_setup {
+	struct pci_master_address_conversion *master_memory1;
+	struct pci_master_address_conversion *master_memory2;
+
+	struct pci_target_address_conversion *target_memory1;
+	struct pci_target_address_conversion *target_memory2;
+
+	struct pci_master_address_conversion *master_io;
+
+	pci_exclusive_access_t exclusive_access;
+
+	uint32_t pci_clock_max;
+	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
+
+	struct pci_mailbox_address *mailbox;
+	struct pci_target_address_window *target_window1;
+	struct pci_target_address_window *target_window2;
+
+	uint8_t master_latency_timer;
+	uint8_t retry_limit;
+
+	pci_arbiter_priority_control_t arbiter_priority_control;
+	pci_take_away_gnt_mode_t take_away_gnt_mode;
+
+	struct resource *mem_resource;
+	struct resource *io_resource;
 };
 
-extern void vr41xx_pciu_init(struct vr41xx_pci_address_map *map);
+extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
 
 #endif /* __NEC_VR41XX_H */
