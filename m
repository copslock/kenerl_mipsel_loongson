Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 18:24:18 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:3522 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225837AbUDURYR>;
	Wed, 21 Apr 2004 18:24:17 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id CAA28061;
	Thu, 22 Apr 2004 02:24:13 +0900 (JST)
Received: 4UMDO00 id i3LHODq04662; Thu, 22 Apr 2004 02:24:13 +0900 (JST)
Received: 4UMRO00 id i3LHOCG12575; Thu, 22 Apr 2004 02:24:12 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 22 Apr 2004 02:24:09 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [patch][2.6] PCI fixup function for NEC Eagle
Message-Id: <20040422022409.56428e62.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

This patch fixes the PCI fixup function for NEC Eagle.

Please apply to CVS.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	Thu Apr 15 00:06:22 2004
+++ linux/arch/mips/pci/Makefile	Thu Apr 22 00:34:12 2004
@@ -38,7 +38,7 @@
 obj-$(CONFIG_MOMENCO_OCELOT)	+= fixup-ocelot.o pci-ocelot.o
 obj-$(CONFIG_MOMENCO_OCELOT_C)	+= pci-ocelot-c.o
 obj-$(CONFIG_MOMENCO_OCELOT_G)	+= pci-ocelot-g.o
-obj-$(CONFIG_NEC_EAGLE)		+= fixup-eagle.o ops-vrc4173.o
+obj-$(CONFIG_NEC_EAGLE)		+= fixup-eagle.o
 obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yosemite.o ops-titan.o
 obj-$(CONFIG_SGI_IP27)		+= pci-ip27.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-eagle.c linux/arch/mips/pci/fixup-eagle.c
--- linux-orig/arch/mips/pci/fixup-eagle.c	Fri Feb 20 00:49:46 2004
+++ linux/arch/mips/pci/fixup-eagle.c	Thu Apr 22 00:34:12 2004
@@ -1,15 +1,25 @@
 /*
- * arch/mips/vr41xx/nec-eagle/pci_fixup.c
+ *  fixup-eagle.c, The NEC Eagle/Hawk Board specific PCI fixups.
  *
- * The NEC Eagle/Hawk Board specific PCI fixups.
+ *  Copyright (C) 2001-2002,2004  MontaVista Software, Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Author: Yoichi Yuasa <you@mvista.com, or source@mvista.com>
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- * 2001-2002,2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 
@@ -29,13 +39,13 @@
 #define SLOT	PCISLOT_IRQ
 
 static char irq_tab_eagle[][5] __initdata = {
- [ 8] = { 0,    INTA, INTB, INTC, INTD },
- [ 9] = { 0,    INTD, INTA, INTB, INTC },
- [10] = { 0,    INTC, INTD, INTA, INTB },
- [12] = { 0, PCMCIA1,    0,    0,    0 },
- [13] = { 0, PCMCIA2,    0,    0,    0 },
- [28] = { 0,     LAN,    0,    0,    0 },
- [29] = { 0,    SLOT, INTB, INTC, INTD },
+ [ 8] = { -1,    INTA, INTB, INTC, INTD },
+ [ 9] = { -1,    INTD, INTA, INTB, INTC },
+ [10] = { -1,    INTC, INTD, INTA, INTB },
+ [12] = { -1, PCMCIA1,   -1,   -1,   -1 },
+ [13] = { -1, PCMCIA2,   -1,   -1,   -1 },
+ [28] = { -1,     LAN,  LAN,  LAN,  LAN },
+ [29] = { -1,    SLOT, INTB, INTC, INTD },
 };
 
 /*
@@ -58,3 +68,97 @@
 struct pci_fixup pcibios_fixups[] __initdata = {
 	{	.pass = 0,	},
 };
+
+#ifdef CONFIG_VRC4173
+/*
+ * PCI configuration registers
+ */
+#define PCICONFAREG	KSEG1ADDR(0x0f000c18)
+#define PCICONFDREG	KSEG1ADDR(0x0f000c14)
+
+static inline void pci_config_write_byte(u8 reg, u8 val)
+{
+	u32 data;
+	int shift;
+
+	writel((1UL << 0x1e) | (reg & 0xfc), PCICONFAREG);
+	data = readl(PCICONFDREG);
+
+	shift = (reg & 3) << 3;
+	data &= ~(0xff << shift);
+	data |= (((u32) val) << shift);
+
+	writel(data, PCICONFDREG);
+}
+
+static inline u16 pci_config_read_halfword(u8 reg)
+{
+	u32 data;
+
+	writel(((1UL << 30) | (reg & 0xfc)), PCICONFAREG);
+	data = readl(PCICONFDREG);
+
+	return (u16) (data >> ((reg & 2) << 3));
+}
+
+static inline u32 pci_config_read_word(u8 reg)
+{
+	writel(((1UL << 30) | (reg & 0xfc)), PCICONFAREG);
+
+	return readl(PCICONFDREG);
+}
+
+static inline void pci_config_write_word(u8 reg, u32 val)
+{
+	writel((1UL << 0x1e) | (reg & 0xfc), PCICONFAREG);
+	writel(val, PCICONFDREG);
+}
+
+/*
+ * Pre-fixup for AC97U/CARDU/USBU of VRC4173
+ */
+static int __init vrc4173_prefixup(void)
+{
+	u32 cmdsts, base;
+	u16 cmu_mask;
+
+
+	if ((pci_config_read_halfword(PCI_VENDOR_ID) == PCI_VENDOR_ID_NEC) &&
+	    (pci_config_read_halfword(PCI_DEVICE_ID) == PCI_DEVICE_ID_NEC_VRC4173)) {
+		/*
+		 * Initialized NEC VRC4173 Bus Control Unit
+		 */
+		cmdsts = pci_config_read_word(PCI_COMMAND);
+		pci_config_write_word(PCI_COMMAND,
+		                      cmdsts | PCI_COMMAND_IO |
+		                      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+		pci_config_write_byte(PCI_LATENCY_TIMER, 0x80);
+
+		pci_config_write_word(PCI_BASE_ADDRESS_0, VR41XX_PCI_IO_START);
+		base = pci_config_read_word(PCI_BASE_ADDRESS_0);
+		base &= PCI_BASE_ADDRESS_IO_MASK;
+		pci_config_write_byte(0x40, 0x01);
+
+		/* CARDU1 IDSEL = AD12, CARDU2 IDSEL = AD13 */
+		pci_config_write_byte(0x41, 0);
+
+		cmu_mask = 0x1000;
+		outw(cmu_mask, base + 0x040);
+		cmu_mask |= 0x0800;
+		outw(cmu_mask, base + 0x040);
+
+		outw(0x000f, base + 0x042);	/* Soft reset of CMU */
+		cmu_mask |= 0x05e0;
+		outw(cmu_mask, base + 0x040);
+		cmu_mask = inw(base + 0x040);	/* dummy read */
+		outw(0x0000, base + 0x042);
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+early_initcall(vrc4173_prefixup);
+#endif
diff -urN -X dontdiff linux-orig/arch/mips/pci/ops-vrc4173.c linux/arch/mips/pci/ops-vrc4173.c
--- linux-orig/arch/mips/pci/ops-vrc4173.c	Fri Jun 13 23:19:56 2003
+++ linux/arch/mips/pci/ops-vrc4173.c	Thu Jan  1 09:00:00 1970
@@ -1,120 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/vrc4173.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Pre-setup for NEC VRC4173.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
- * Copyright 2001,2002 MontaVista Software Inc.
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
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/vr41xx/eagle.h>
-#include <asm/vr41xx/vrc4173.h>
-
-#define PCI_CONFIG_ADDR	KSEG1ADDR(0x0f000c18)
-#define PCI_CONFIG_DATA	KSEG1ADDR(0x0f000c14)
-
-static inline void config_writeb(u8 reg, u8 val)
-{
-	u32 data;
-	int shift;
-
-	writel((1UL << 0x1e) | (reg & 0xfc), PCI_CONFIG_ADDR);
-	data = readl(PCI_CONFIG_DATA);
-
-	shift = (reg & 3) << 3;
-	data &= ~(0xff << shift);
-	data |= (((u32) val) << shift);
-
-	writel(data, PCI_CONFIG_DATA);
-}
-
-static inline u16 config_readw(u8 reg)
-{
-	u32 data;
-
-	writel(((1UL << 30) | (reg & 0xfc)), PCI_CONFIG_ADDR);
-	data = readl(PCI_CONFIG_DATA);
-
-	return (u16) (data >> ((reg & 2) << 3));
-}
-
-static inline u32 config_readl(u8 reg)
-{
-	writel(((1UL << 30) | (reg & 0xfc)), PCI_CONFIG_ADDR);
-
-	return readl(PCI_CONFIG_DATA);
-}
-
-static inline void config_writel(u8 reg, u32 val)
-{
-	writel((1UL << 0x1e) | (reg & 0xfc), PCI_CONFIG_ADDR);
-	writel(val, PCI_CONFIG_DATA);
-}
-
-void __init vrc4173_preinit(void)
-{
-	u32 cmdsts, base;
-	u16 cmu_mask;
-
-
-	if ((config_readw(PCI_VENDOR_ID) == PCI_VENDOR_ID_NEC) &&
-	    (config_readw(PCI_DEVICE_ID) == PCI_DEVICE_ID_NEC_VRC4173)) {
-		/*
-		 * Initialized NEC VRC4173 Bus Control Unit
-		 */
-		cmdsts = config_readl(PCI_COMMAND);
-		config_writel(PCI_COMMAND,
-			      cmdsts |
-			      PCI_COMMAND_IO |
-			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-
-		config_writeb(PCI_LATENCY_TIMER, 0x80);
-
-		config_writel(PCI_BASE_ADDRESS_0, VR41XX_PCI_IO_START);
-		base = config_readl(PCI_BASE_ADDRESS_0);
-		base &= PCI_BASE_ADDRESS_IO_MASK;
-		config_writeb(0x40, 0x01);
-
-		/* CARDU1 IDSEL = AD12, CARDU2 IDSEL = AD13 */
-		config_writeb(0x41, 0);
-
-		cmu_mask = 0x1000;
-		outw(cmu_mask, base + 0x040);
-		cmu_mask |= 0x0800;
-		outw(cmu_mask, base + 0x040);
-
-		outw(0x000f, base + 0x042);	/* Soft reset of CMU */
-		cmu_mask |= 0x05e0;
-		outw(cmu_mask, base + 0x040);
-		cmu_mask = inw(base + 0x040);	/* dummy read */
-		outw(0x0000, base + 0x042);
-	}
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb 26 07:05:00 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Thu Apr 22 00:34:12 2004
@@ -86,8 +86,6 @@
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
-
-	vrc4173_preinit();
 #endif
 
 	return 0;
