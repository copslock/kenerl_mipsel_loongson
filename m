Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Mar 2004 16:55:43 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:52984 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224954AbUCGQzl>;
	Sun, 7 Mar 2004 16:55:41 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA00290;
	Mon, 8 Mar 2004 01:55:36 +0900 (JST)
Received: 4UMDO00 id i27GtaO03370; Mon, 8 Mar 2004 01:55:36 +0900 (JST)
Received: 4UMRO01 id i27GtZb29810; Mon, 8 Mar 2004 01:55:36 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 8 Mar 2004 01:55:26 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Update fixup-eagle.c
Message-Id: <20040308015526.19d7484b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch updates a vrc4173 pre-fixup function.
Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	Sat Jan 31 01:46:15 2004
+++ linux/arch/mips/pci/Makefile	Mon Mar  8 01:19:08 2004
@@ -35,7 +35,7 @@
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
+++ linux/arch/mips/pci/fixup-eagle.c	Mon Mar  8 01:46:15 2004
@@ -1,15 +1,26 @@
 /*
- * arch/mips/vr41xx/nec-eagle/pci_fixup.c
+ *  fixup-eagle.c, The NEC Eagle/Hawk Board specific PCI fixups.
  *
- * The NEC Eagle/Hawk Board specific PCI fixups.
  *
- * Author: Yoichi Yuasa <you@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2001-2002,2004  MontaVista Software, Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * 2001-2002,2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
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
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 
@@ -58,3 +69,98 @@
 struct pci_fixup pcibios_fixups[] __initdata = {
 	{	.pass = 0,	},
 };
+
+#ifdef CONFIG_VRC4173
+/*
+ * PCI configuration registers
+ */
+#define PCI_CONFIG_ADDR	KSEG1ADDR(0x0f000c18)
+#define PCI_CONFIG_DATA	KSEG1ADDR(0x0f000c14)
+
+static inline void config_writeb(u8 reg, u8 val)
+{
+	u32 data;
+	int shift;
+
+	writel((1UL << 0x1e) | (reg & 0xfc), PCI_CONFIG_ADDR);
+	data = readl(PCI_CONFIG_DATA);
+
+	shift = (reg & 3) << 3;
+	data &= ~(0xff << shift);
+	data |= (((u32) val) << shift);
+
+	writel(data, PCI_CONFIG_DATA);
+}
+
+static inline u16 config_readw(u8 reg)
+{
+	u32 data;
+
+	writel(((1UL << 30) | (reg & 0xfc)), PCI_CONFIG_ADDR);
+	data = readl(PCI_CONFIG_DATA);
+
+	return (u16) (data >> ((reg & 2) << 3));
+}
+
+static inline u32 config_readl(u8 reg)
+{
+	writel(((1UL << 30) | (reg & 0xfc)), PCI_CONFIG_ADDR);
+
+	return readl(PCI_CONFIG_DATA);
+}
+
+static inline void config_writel(u8 reg, u32 val)
+{
+	writel((1UL << 0x1e) | (reg & 0xfc), PCI_CONFIG_ADDR);
+	writel(val, PCI_CONFIG_DATA);
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
+	if ((config_readw(PCI_VENDOR_ID) == PCI_VENDOR_ID_NEC) &&
+	    (config_readw(PCI_DEVICE_ID) == PCI_DEVICE_ID_NEC_VRC4173)) {
+		/*
+		 * Initialized NEC VRC4173 Bus Control Unit
+		 */
+		cmdsts = config_readl(PCI_COMMAND);
+		config_writel(PCI_COMMAND,
+			      cmdsts |
+			      PCI_COMMAND_IO |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+		config_writeb(PCI_LATENCY_TIMER, 0x80);
+
+		config_writel(PCI_BASE_ADDRESS_0, VR41XX_PCI_IO_START);
+		base = config_readl(PCI_BASE_ADDRESS_0);
+		base &= PCI_BASE_ADDRESS_IO_MASK;
+		config_writeb(0x40, 0x01);
+
+		/* CARDU1 IDSEL = AD12, CARDU2 IDSEL = AD13 */
+		config_writeb(0x41, 0);
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
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Mon Mar  8 01:10:18 2004
@@ -86,8 +86,6 @@
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
-
-	vrc4173_preinit();
 #endif
 
 	return 0;
