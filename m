Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 08:48:05 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:42969 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225278AbUBJIsD>;
	Tue, 10 Feb 2004 08:48:03 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id RAA27280;
	Tue, 10 Feb 2004 17:47:59 +0900 (JST)
Received: 4UMDO01 id i1A8lx912841; Tue, 10 Feb 2004 17:47:59 +0900 (JST)
Received: 4UMRO00 id i1A8lwv19564; Tue, 10 Feb 2004 17:47:58 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 10 Feb 2004 17:47:59 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Fixed PCI config founctions for vr41xx
Message-Id: <20040210174759.0772912e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for PCI config functions for vr41xx.

I found my mistake about PCI config functions of vr41xx,
and also include some fixes.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pciu.c linux/arch/mips/vr41xx/common/pciu.c
--- linux-orig/arch/mips/vr41xx/common/pciu.c	2003-12-02 04:31:49.000000000 +0900
+++ linux/arch/mips/vr41xx/common/pciu.c	2004-02-10 15:52:00.000000000 +0900
@@ -1,40 +1,17 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/pciu.c
+ * arch/mips/vr41xx/common/pciu.c
  *
- * BRIEF MODULE DESCRIPTION
- *	PCI Control Unit routines for the NEC VR4100 series.
+ * PCI Control Unit routines for the NEC VR4100 series.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
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
+ * 2001-2003 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 /*
  * Changes:
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - Fix deadlock-causing PCIU access race for VR4131.
- *
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4122 and VR4131 are supported.
  */
@@ -42,7 +19,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <linux/delay.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
@@ -60,49 +36,48 @@
 		/*
 		 * Type 0 configuration
 		 */
-		if (PCI_SLOT(dev_fn) < 11 || PCI_SLOT(dev_fn) > 31 || where > 255)
-			return -1;
+		if (PCI_SLOT(dev_fn) < 11 || PCI_SLOT(dev_fn) > 31 || where > 0xff)
+			return -EINVAL;
 
-		writel((1UL << PCI_SLOT(dev_fn))|
+		writel((1U << PCI_SLOT(dev_fn))	|
 		       (PCI_FUNC(dev_fn) << 8)	|
 		       (where & 0xfc),
 		       PCICONFAREG);
-	}
-	else {
+	} else {
 		/*
 		 * Type 1 configuration
 		 */
-		if (PCI_SLOT(dev_fn) > 31 || where > 255)
-			return -1;
+		if (PCI_SLOT(dev_fn) > 31 || where > 0xff)
+			return -EINVAL;
 
 		writel((bus << 16)	|
 		       (dev_fn << 8)	|
 		       (where & 0xfc)	|
-		       1UL,
+		       1U,
 		       PCICONFAREG);
 	}
 
 	return 0;
 }
 
-static int vr41xx_pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
+static int vr41xx_pci_config_read_byte(struct pci_dev *dev, int where, uint8_t *val)
 {
-	u32 data;
+	uint32_t data;
 
 	*val = 0xff;
 	if (vr41xx_pci_config_access(dev, where) < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	data = readl(PCICONFDREG);
-	*val = (u8)(data >> ((where & 3) << 3));
+	*val = (uint8_t)(data >> ((where & 3) << 3));
 
 	return PCIBIOS_SUCCESSFUL;
 
 }
 
-static int vr41xx_pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
+static int vr41xx_pci_config_read_word(struct pci_dev *dev, int where, uint16_t *val)
 {
-	u32 data;
+	uint32_t data;
 
 	*val = 0xffff;
 	if (where & 1)
@@ -112,12 +87,12 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	data = readl(PCICONFDREG);
-	*val = (u16)(data >> ((where & 2) << 3));
+	*val = (uint16_t)(data >> ((where & 2) << 3));
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_read_config_dword(struct pci_dev *dev, int where, u32 *val)
+static int vr41xx_pci_config_read_dword(struct pci_dev *dev, int where, uint32_t *val)
 {
 	*val = 0xffffffff;
 	if (where & 3)
@@ -131,9 +106,9 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_write_config_byte(struct pci_dev *dev, int where, u8 val)
+static int vr41xx_pci_config_write_byte(struct pci_dev *dev, int where, uint8_t val)
 {
-	u32 data;
+	uint32_t data;
 	int shift;
 
 	if (vr41xx_pci_config_access(dev, where) < 0)
@@ -141,17 +116,16 @@
 
 	data = readl(PCICONFDREG);
 	shift = (where & 3) << 3;
-	data &= ~(0xff << shift);
-	data |= (((u32)val) << shift);
-
+	data &= ~(0xffU << shift);
+	data |= (uint32_t)val << shift;
 	writel(data, PCICONFDREG);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_write_config_word(struct pci_dev *dev, int where, u16 val)
+static int vr41xx_pci_config_write_word(struct pci_dev *dev, int where, uint16_t val)
 {
-	u32 data;
+	uint32_t data;
 	int shift;
 
 	if (where & 1)
@@ -162,14 +136,14 @@
 
 	data = readl(PCICONFDREG);
 	shift = (where & 2) << 3;
-	data &= ~(0xffff << shift);
-	data |= (((u32)val) << shift);
+	data &= ~(0xffffU << shift);
+	data |= (uint32_t)val << shift;
 	writel(data, PCICONFDREG);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_write_config_dword(struct pci_dev *dev, int where, u32 val)
+static int vr41xx_pci_config_write_dword(struct pci_dev *dev, int where, uint32_t val)
 {
 	if (where & 3)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -183,22 +157,21 @@
 }
 
 struct pci_ops vr41xx_pci_ops = {
-	vr41xx_pci_read_config_byte,
-	vr41xx_pci_read_config_word,
-	vr41xx_pci_read_config_dword,
-	vr41xx_pci_write_config_byte,
-	vr41xx_pci_write_config_word,
-	vr41xx_pci_write_config_dword
+	.read_byte	= vr41xx_pci_config_read_byte,
+	.read_word	= vr41xx_pci_config_read_word,
+	.read_dword	= vr41xx_pci_config_read_dword,
+	.write_byte	= vr41xx_pci_config_write_byte,
+	.write_word	= vr41xx_pci_config_write_word,
+	.write_dword	= vr41xx_pci_config_write_dword,
 };
 
 void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)
 {
 	struct vr41xx_pci_address_space *s;
 	unsigned long vtclock;
-	u32 config;
-	int n;
+	uint32_t config;
 
-	if (!map)
+	if (map == NULL)
 		return;
 
 	/* Disable PCI interrupt */
@@ -207,11 +180,9 @@
 	/* Supply VTClock to PCIU */
 	vr41xx_clock_supply(PCIU_CLOCK);
 
-	/*
-	 * Sleep for 1us after setting MSKPPCIU bit in CMUCLKMSK
-	 * before doing any PCIU access to avoid deadlock on VR4131.
-	 */
-	udelay(1);
+	/* Dummy read/write, waiting for supply of VTClock. */
+	readw(MPCIINTREG);
+	writew(0, MPCIINTREG);
 
 	/* Select PCI clock */
 	vtclock = vr41xx_get_vtclock_frequency();
@@ -233,48 +204,52 @@
 	 */
 	if (map->mem1 != NULL) {
 		s = map->mem1;
-		config = (s->internal_base & 0xff000000) |
-		         ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		         ((s->pci_base & 0xff000000) >> 24);
+		config = (s->internal_base & INTERNAL_BUS_BASE_ADDRESS)	|
+		         ((s->address_mask >> 11) & ADDRESS_MASK)	|
+		         PCI_ACCESS_ENABLE				|
+		         ((s->pci_base >> 24) & PCI_ADDRESS_SETTING);
 		writel(config, PCIMMAW1REG);
 	}
 	if (map->mem2 != NULL) {
 		s = map->mem2;
-		config = (s->internal_base & 0xff000000) |
-		         ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		         ((s->pci_base & 0xff000000) >> 24);
+		config = (s->internal_base & INTERNAL_BUS_BASE_ADDRESS)	|
+		         ((s->address_mask >> 11) & ADDRESS_MASK)	|
+		         PCI_ACCESS_ENABLE				|
+		         ((s->pci_base >> 24) & PCI_ADDRESS_SETTING);
 		writel(config, PCIMMAW2REG);
 	}
 	if (map->io != NULL) {
 		s = map->io;
-		config = (s->internal_base & 0xff000000) |
-		         ((s->address_mask & 0x7f000000) >> 11) | (1UL << 12) |
-		         ((s->pci_base & 0xff000000) >> 24);
+		config = (s->internal_base & INTERNAL_BUS_BASE_ADDRESS) |
+		         ((s->address_mask >> 11) & ADDRESS_MASK) |
+		         PCI_ACCESS_ENABLE |
+		         ((s->pci_base >> 24) & PCI_ADDRESS_SETTING);
 		writel(config, PCIMIOAWREG);
 	}
 
 	/* Set target memory windows */
-	writel(0x00081000, PCITAW1REG);
-	writel(0UL, PCITAW2REG);
-	pciu_write_config_dword(PCI_BASE_ADDRESS_0, 0UL);
-	pciu_write_config_dword(PCI_BASE_ADDRESS_1, 0UL);
+	writel(0x00081000U, PCITAW1REG);
+	writel(0U, PCITAW2REG);
+
+	pciu_write_config_dword(PCI_BASE_ADDRESS_0, 0U);
+	pciu_write_config_dword(PCI_BASE_ADDRESS_1, 0U);
 
 	/* Clear bus error */
-	n = readl(BUSERRADREG);
+	readl(BUSERRADREG);
 
 	if (current_cpu_data.cputype == CPU_VR4122) {
-		writel(0UL, PCITRDYVREG);
-		pciu_write_config_dword(PCI_CACHE_LINE_SIZE, 0x0000f804);
+		writel(0U, PCITRDYVREG);
+		pciu_write_config_byte(PCI_LATENCY_TIMER, 0xf8);
 	} else {
-		writel(100UL, PCITRDYVREG);
-		pciu_write_config_dword(PCI_CACHE_LINE_SIZE, 0x00008004);
+		writel(100U, PCITRDYVREG);
+		pciu_write_config_byte(PCI_LATENCY_TIMER, 0x80);
 	}
 
 	writel(CONFIG_DONE, PCIENREG);
-	pciu_write_config_dword(PCI_COMMAND,
-	                        PCI_COMMAND_IO |
-	                        PCI_COMMAND_MEMORY |
-	                        PCI_COMMAND_MASTER |
-	                        PCI_COMMAND_PARITY |
-	                        PCI_COMMAND_SERR);
+	pciu_write_config_word(PCI_COMMAND,
+	                       PCI_COMMAND_IO |
+	                       PCI_COMMAND_MEMORY |
+	                       PCI_COMMAND_MASTER |
+	                       PCI_COMMAND_PARITY |
+	                       PCI_COMMAND_SERR);
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pciu.h linux/arch/mips/vr41xx/common/pciu.h
--- linux-orig/arch/mips/vr41xx/common/pciu.h	2003-10-31 10:43:08.000000000 +0900
+++ linux/arch/mips/vr41xx/common/pciu.h	2004-02-10 15:53:07.000000000 +0900
@@ -1,34 +1,14 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/pciu.h
+ * arch/mips/vr41xx/common/pciu.h
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for PCI Control Unit of the NEC VR4100 series.
+ * Include file for PCI Control Unit of the NEC VR4100 series.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
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
+ * 2002-2003 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 /*
  * Changes:
@@ -41,24 +21,24 @@
 #include <linux/config.h>
 #include <asm/addrspace.h>
 
-#define BIT(x)	(1 << (x))
+#define BIT(x)	(1U << (x))
 
 #define PCIMMAW1REG			KSEG1ADDR(0x0f000c00)
 #define PCIMMAW2REG			KSEG1ADDR(0x0f000c04)
 #define PCITAW1REG			KSEG1ADDR(0x0f000c08)
 #define PCITAW2REG			KSEG1ADDR(0x0f000c0c)
 #define PCIMIOAWREG			KSEG1ADDR(0x0f000c10)
-#define INTERNAL_BUS_BASE_ADDRESS	0xff000000
-#define ADDRESS_MASK			0x000fe000
+#define INTERNAL_BUS_BASE_ADDRESS	0xff000000U
+#define ADDRESS_MASK			0x000fe000U
 #define PCI_ACCESS_ENABLE		BIT(12)
-#define PCI_ADDRESS_SETTING		0x000000ff
+#define PCI_ADDRESS_SETTING		0x000000ffU
 
 #define PCICONFDREG			KSEG1ADDR(0x0f000c14)
 #define PCICONFAREG			KSEG1ADDR(0x0f000c18)
 #define PCIMAILREG			KSEG1ADDR(0x0f000c1c)
 
 #define BUSERRADREG			KSEG1ADDR(0x0f000c24)
-#define ERROR_ADDRESS			0xfffffffc
+#define ERROR_ADDRESS			0xfffffffcU
 
 #define INTCNTSTAREG			KSEG1ADDR(0x0f000c28)
 #define MABTCLR				BIT(31)
@@ -72,91 +52,102 @@
 #define EAREQ				BIT(0)
 
 #define PCIRECONTREG			KSEG1ADDR(0x0f000c30)
-#define RTRYCNT				0x000000ff
+#define RTRYCNT				0xffU
 
 #define PCIENREG			KSEG1ADDR(0x0f000c34)
 #define CONFIG_DONE			BIT(2)
 
 #define PCICLKSELREG			KSEG1ADDR(0x0f000c38)
-#define EQUAL_VTCLOCK			0x00000002
-#define HALF_VTCLOCK			0x00000000
-#define QUARTER_VTCLOCK			0x00000001
+#define EQUAL_VTCLOCK			0x2U
+#define HALF_VTCLOCK			0x0U
+#define QUARTER_VTCLOCK			0x1U
 
 #define PCITRDYVREG			KSEG1ADDR(0x0f000c3c)
 
 #define PCICLKRUNREG			KSEG1ADDR(0x0f000c60)
 
-#define PCIU_CONFIGREGS_BASE		KSEG1ADDR(0x0f000d00)
 #define VENDORIDREG			KSEG1ADDR(0x0f000d00)
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
 
 #define MPCIINTREG			KSEG1ADDR(0x0f0000b2)
 
 #define MAX_PCI_CLOCK			33333333
 
-static inline int pciu_read_config_byte(int where, u8 *val)
+static inline int pciu_read_config_byte(int where, uint8_t *val)
 {
-	u32 data;
+	uint32_t data;
 
-	data = readl(PCIU_CONFIGREGS_BASE + where);
-	*val = (u8)(data >> ((where & 3) << 3));
+	if (where > 0xff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = readl(VENDORIDREG + (where & 0xfc));
+	*val = (uint8_t)(data >> ((where & 3) << 3));
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline int pciu_read_config_word(int where, u16 *val)
+static inline int pciu_read_config_word(int where, uint16_t *val)
 {
-	u32 data;
+	uint32_t data;
 
-	if (where & 1)
+	if (where > 0xff || (where & 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	data = readl(PCIU_CONFIGREGS_BASE + where);
-	*val = (u16)(data >> ((where & 2) << 3));
+	data = readl(VENDORIDREG + (where & 0xfc));
+	*val = (uint16_t)(data >> ((where & 2) << 3));
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline int pciu_read_config_dword(int where, u32 *val)
+static inline int pciu_read_config_dword(int where, uint32_t *val)
 {
-	if (where & 3)
+	if (where > 0xff || (where & 3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	*val = readl(PCIU_CONFIGREGS_BASE + where);
+	*val = readl(VENDORIDREG + where);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline int pciu_write_config_byte(int where, u8 val)
+static inline int pciu_write_config_byte(int where, uint8_t val)
 {
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+	uint32_t data;
+	int shift;
+
+	if (where > 0xff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = readl(VENDORIDREG + (where & 0xfc));
+	shift = (where & 3) << 3;
+	data &= ~(0xffU << shift);
+	data |= (uint32_t)val << shift;
+	writel(data, VENDORIDREG + (where & 0xfc));
 
 	return 0;
 }
 
-static inline int pciu_write_config_word(int where, u16 val)
+static inline int pciu_write_config_word(int where, uint16_t val)
 {
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+	uint32_t data;
+	int shift;
+
+	if (where > 0xff || (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = readl(VENDORIDREG + (where & 0xfc));
+	shift = (where & 2) << 3;
+	data &= ~(0xffffU << shift);
+	data |= (uint32_t)val << shift;
+	writel(data, VENDORIDREG + (where & 0xfc));
 
 	return 0;
 }
 
-static inline int pciu_write_config_dword(int where, u32 val)
+static inline int pciu_write_config_dword(int where, uint32_t val)
 {
-	writel(val, PCIU_CONFIGREGS_BASE + where);
+	if (where > 0xff || (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	writel(val, VENDORIDREG + where);
 
 	return 0;
 }
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	2004-02-09 10:43:52.000000000 +0900
+++ linux/include/asm-mips/vr41xx/vr41xx.h	2004-02-10 15:58:45.000000000 +0900
@@ -208,9 +208,9 @@
  * PCI Control Unit
  */
 struct vr41xx_pci_address_space {
-	u32 internal_base;
-	u32 address_mask;
-	u32 pci_base;
+	uint32_t internal_base;
+	uint32_t address_mask;
+	uint32_t pci_base;
 };
 
 struct vr41xx_pci_address_map {
