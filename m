Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:56:44 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:58604 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226045AbUEZPwi>;
	Wed, 26 May 2004 16:52:38 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02630;
	Thu, 27 May 2004 00:52:34 +0900 (JST)
Received: 4UMDO00 id i4QFqXQ00117; Thu, 27 May 2004 00:52:33 +0900 (JST)
Received: 4UMRO00 id i4QFqXV28859; Thu, 27 May 2004 00:52:33 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:52:31 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][14/14] vr41xx: vrc4173.c synchronizes with latest
Message-Id: <20040527005231.0d0c03b1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

vrc4173.c synchronizes with latest.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/vrc4173.c linux/arch/mips/vr41xx/common/vrc4173.c
--- linux-orig/arch/mips/vr41xx/common/vrc4173.c	Thu Dec 18 01:02:24 2003
+++ linux/arch/mips/vr41xx/common/vrc4173.c	Fri May 14 00:32:07 2004
@@ -1,143 +1,336 @@
 /*
- * FILE NAME
- *	drivers/char/vrc4173.c
- * 
- * BRIEF MODULE DESCRIPTION
- *	NEC VRC4173 driver for NEC VR4122/VR4131.
+ *  vrc4173.c, NEC VRC4173 base driver for NEC VR4122/VR4131.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ *  Copyright (C) 2001-2003  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2001,2002 MontaVista Software Inc.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
  *
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
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/vr41xx/vr41xx.h>
 #include <asm/vr41xx/vrc4173.h>
 
-MODULE_DESCRIPTION("NEC VRC4173 driver for NEC VR4122/4131");
+MODULE_DESCRIPTION("NEC VRC4173 base driver for NEC VR4122/4131");
 MODULE_AUTHOR("Yoichi Yuasa <yyuasa@mvista.com>");
 MODULE_LICENSE("GPL");
 
 #define VRC4173_CMUCLKMSK	0x040
+ #define MSKPIU			0x0001
+ #define MSKKIU			0x0002
+ #define MSKAIU			0x0004
+ #define MSKPS2CH1		0x0008
+ #define MSKPS2CH2		0x0010
+ #define MSKUSB			0x0020
+ #define MSKCARD1		0x0040
+ #define MSKCARD2		0x0080
+ #define MSKAC97		0x0100
+ #define MSK48MUSB		0x0400
+ #define MSK48MPIN		0x0800
+ #define MSK48MOSC		0x1000
 #define VRC4173_CMUSRST		0x042
-
-#define VRC4173_SELECTREG	0x09e
+ #define USBRST			0x0001
+ #define CARD1RST		0x0002
+ #define CARD2RST		0x0004
+ #define AC97RST		0x0008
 
 #define VRC4173_SYSINT1REG	0x060
 #define VRC4173_MSYSINT1REG	0x06c
 
-static struct pci_device_id vrc4173_table[] = {
-	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC4173, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{0, }
+#define VRC4173_SELECTREG	0x09e
+ #define SEL3			0x0008
+ #define SEL2			0x0004
+ #define SEL1			0x0002
+ #define SEL0			0x0001
+
+static struct pci_device_id vrc4173_id_table[] __devinitdata = {
+	{	.vendor		= PCI_VENDOR_ID_NEC,
+		.device		= PCI_DEVICE_ID_NEC_VRC4173,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,			},
+	{	.vendor		= 0,				},
 };
 
 unsigned long vrc4173_io_offset = 0;
 
 EXPORT_SYMBOL(vrc4173_io_offset);
 
-static u16 vrc4173_cmuclkmsk;
 static int vrc4173_initialized;
+static uint16_t vrc4173_cmuclkmsk;
+static uint16_t vrc4173_selectreg;
+static spinlock_t vrc4173_cmu_lock;
+static spinlock_t vrc4173_giu_lock;
 
-void vrc4173_clock_supply(u16 mask)
+static inline void set_cmusrst(uint16_t val)
+{
+	uint16_t cmusrst;
+
+	cmusrst = vrc4173_inw(VRC4173_CMUSRST);
+	cmusrst |= val;
+	vrc4173_outw(cmusrst, VRC4173_CMUSRST);
+}
+
+static inline void clear_cmusrst(uint16_t val)
+{
+	uint16_t cmusrst;
+
+	cmusrst = vrc4173_inw(VRC4173_CMUSRST);
+	cmusrst &= ~val;
+	vrc4173_outw(cmusrst, VRC4173_CMUSRST);
+}
+
+void vrc4173_supply_clock(vrc4173_clock_t clock)
 {
 	if (vrc4173_initialized) {
-		vrc4173_cmuclkmsk |= mask;
+		spin_lock_irq(&vrc4173_cmu_lock);
+
+		switch (clock) {
+		case VRC4173_PIU_CLOCK:
+			vrc4173_cmuclkmsk |= MSKPIU;
+			break;
+		case VRC4173_KIU_CLOCK:
+			vrc4173_cmuclkmsk |= MSKKIU;
+			break;
+		case VRC4173_AIU_CLOCK:
+			vrc4173_cmuclkmsk |= MSKAIU;
+			break;
+		case VRC4173_PS2_CH1_CLOCK:
+			vrc4173_cmuclkmsk |= MSKPS2CH1;
+			break;
+		case VRC4173_PS2_CH2_CLOCK:
+			vrc4173_cmuclkmsk |= MSKPS2CH2;
+			break;
+		case VRC4173_USBU_PCI_CLOCK:
+			set_cmusrst(USBRST);
+			vrc4173_cmuclkmsk |= MSKUSB;
+			break;
+		case VRC4173_CARDU1_PCI_CLOCK:
+			set_cmusrst(CARD1RST);
+			vrc4173_cmuclkmsk |= MSKCARD1;
+			break;
+		case VRC4173_CARDU2_PCI_CLOCK:
+			set_cmusrst(CARD2RST);
+			vrc4173_cmuclkmsk |= MSKCARD2;
+			break;
+		case VRC4173_AC97U_PCI_CLOCK:
+			set_cmusrst(AC97RST);
+			vrc4173_cmuclkmsk |= MSKAC97;
+			break;
+		case VRC4173_USBU_48MHz_CLOCK:
+			set_cmusrst(USBRST);
+			vrc4173_cmuclkmsk |= MSK48MUSB;
+			break;
+		case VRC4173_EXT_48MHz_CLOCK:
+			if (vrc4173_cmuclkmsk & MSK48MOSC)
+				vrc4173_cmuclkmsk |= MSK48MPIN;
+			else
+				printk(KERN_WARNING
+				       "vrc4173_supply_clock: "
+				       "Please supply VRC4173_48MHz_CLOCK first "
+				       "rather than VRC4173_EXT_48MHz_CLOCK.\n");
+			break;
+		case VRC4173_48MHz_CLOCK:
+			vrc4173_cmuclkmsk |= MSK48MOSC;
+			break;
+		default:
+			printk(KERN_WARNING
+			       "vrc4173_supply_clock: Invalid CLOCK value %u\n", clock);
+			break;
+		}
+
 		vrc4173_outw(vrc4173_cmuclkmsk, VRC4173_CMUCLKMSK);
+
+		switch (clock) {
+		case VRC4173_USBU_PCI_CLOCK:
+		case VRC4173_USBU_48MHz_CLOCK:
+			clear_cmusrst(USBRST);
+			break;
+		case VRC4173_CARDU1_PCI_CLOCK:
+			clear_cmusrst(CARD1RST);
+			break;
+		case VRC4173_CARDU2_PCI_CLOCK:
+			clear_cmusrst(CARD2RST);
+			break;
+		case VRC4173_AC97U_PCI_CLOCK:
+			clear_cmusrst(AC97RST);
+			break;
+		default:
+			break;
+		}
+
+		spin_unlock_irq(&vrc4173_cmu_lock);
 	}
 }
 
-void vrc4173_clock_mask(u16 mask)
+EXPORT_SYMBOL(vrc4173_supply_clock);
+
+void vrc4173_mask_clock(vrc4173_clock_t clock)
 {
 	if (vrc4173_initialized) {
-		vrc4173_cmuclkmsk &= ~mask;
+		spin_lock_irq(&vrc4173_cmu_lock);
+
+		switch (clock) {
+		case VRC4173_PIU_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSKPIU;
+			break;
+		case VRC4173_KIU_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSKKIU;
+			break;
+		case VRC4173_AIU_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSKAIU;
+			break;
+		case VRC4173_PS2_CH1_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSKPS2CH1;
+			break;
+		case VRC4173_PS2_CH2_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSKPS2CH2;
+			break;
+		case VRC4173_USBU_PCI_CLOCK:
+			set_cmusrst(USBRST);
+			vrc4173_cmuclkmsk &= ~MSKUSB;
+			break;
+		case VRC4173_CARDU1_PCI_CLOCK:
+			set_cmusrst(CARD1RST);
+			vrc4173_cmuclkmsk &= ~MSKCARD1;
+			break;
+		case VRC4173_CARDU2_PCI_CLOCK:
+			set_cmusrst(CARD2RST);
+			vrc4173_cmuclkmsk &= ~MSKCARD2;
+			break;
+		case VRC4173_AC97U_PCI_CLOCK:
+			set_cmusrst(AC97RST);
+			vrc4173_cmuclkmsk &= ~MSKAC97;
+			break;
+		case VRC4173_USBU_48MHz_CLOCK:
+			set_cmusrst(USBRST);
+			vrc4173_cmuclkmsk &= ~MSK48MUSB;
+			break;
+		case VRC4173_EXT_48MHz_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSK48MPIN;
+			break;
+		case VRC4173_48MHz_CLOCK:
+			vrc4173_cmuclkmsk &= ~MSK48MOSC;
+			break;
+		default:
+			printk(KERN_WARNING "vrc4173_mask_clock: Invalid CLOCK value %u\n", clock);
+			break;
+		}
+
 		vrc4173_outw(vrc4173_cmuclkmsk, VRC4173_CMUCLKMSK);
+
+		switch (clock) {
+		case VRC4173_USBU_PCI_CLOCK:
+		case VRC4173_USBU_48MHz_CLOCK:
+			clear_cmusrst(USBRST);
+			break;
+		case VRC4173_CARDU1_PCI_CLOCK:
+			clear_cmusrst(CARD1RST);
+			break;
+		case VRC4173_CARDU2_PCI_CLOCK:
+			clear_cmusrst(CARD2RST);
+			break;
+		case VRC4173_AC97U_PCI_CLOCK:
+			clear_cmusrst(AC97RST);
+			break;
+		default:
+			break;
+		}
+
+		spin_unlock_irq(&vrc4173_cmu_lock);
 	}
 }
 
+EXPORT_SYMBOL(vrc4173_mask_clock);
+
 static inline void vrc4173_cmu_init(void)
 {
 	vrc4173_cmuclkmsk = vrc4173_inw(VRC4173_CMUCLKMSK);
-}
 
-EXPORT_SYMBOL(vrc4173_clock_supply);
-EXPORT_SYMBOL(vrc4173_clock_mask);
+	spin_lock_init(&vrc4173_cmu_lock);
+}
 
-void vrc4173_select_function(int func)
+void vrc4173_select_function(vrc4173_function_t function)
 {
-	u16 val;
-
 	if (vrc4173_initialized) {
-		val = vrc4173_inw(VRC4173_SELECTREG);
-		switch(func) {
-		case PS2CH1_SELECT:
-			val |= 0x0004;
+		spin_lock_irq(&vrc4173_giu_lock);
+
+		switch(function) {
+		case PS2_CHANNEL1:
+			vrc4173_selectreg |= SEL2;
 			break;
-		case PS2CH2_SELECT:
-			val |= 0x0002;
+		case PS2_CHANNEL2:
+			vrc4173_selectreg |= SEL1;
 			break;
-		case TOUCHPANEL_SELECT:
-			val &= 0x0007;
+		case TOUCHPANEL:
+			vrc4173_selectreg &= SEL2 | SEL1 | SEL0;
 			break;
-		case KIU8_SELECT:
-			val &= 0x000e;
+		case KEYBOARD_8SCANLINES:
+			vrc4173_selectreg &= SEL3 | SEL2 | SEL1;
 			break;
-		case KIU10_SELECT:
-			val &= 0x000c;
+		case KEYBOARD_10SCANLINES:
+			vrc4173_selectreg &= SEL3 | SEL2;
 			break;
-		case KIU12_SELECT:
-			val &= 0x0008;
+		case KEYBOARD_12SCANLINES:
+			vrc4173_selectreg &= SEL3;
 			break;
-		case GPIO_SELECT:
-			val |= 0x0008;
+		case GPIO_0_15PINS:
+			vrc4173_selectreg |= SEL0;
+			break;
+		case GPIO_16_20PINS:
+			vrc4173_selectreg |= SEL3;
 			break;
 		}
-		vrc4173_outw(val, VRC4173_SELECTREG);
+
+		vrc4173_outw(vrc4173_selectreg, VRC4173_SELECTREG);
+
+		spin_unlock_irq(&vrc4173_giu_lock);
 	}
 }
 
 EXPORT_SYMBOL(vrc4173_select_function);
 
+static inline void vrc4173_giu_init(void)
+{
+	vrc4173_selectreg = vrc4173_inw(VRC4173_SELECTREG);
+
+	spin_lock_init(&vrc4173_giu_lock);
+}
+
 static void enable_vrc4173_irq(unsigned int irq)
 {
-	u16 val;
+	uint16_t val;
 
 	val = vrc4173_inw(VRC4173_MSYSINT1REG);
-	val |= (u16)1 << (irq - VRC4173_IRQ_BASE);
+	val |= (uint16_t)1 << (irq - VRC4173_IRQ_BASE);
 	vrc4173_outw(val, VRC4173_MSYSINT1REG);
 }
 
 static void disable_vrc4173_irq(unsigned int irq)
 {
-	u16 val;
+	uint16_t val;
 
 	val = vrc4173_inw(VRC4173_MSYSINT1REG);
-	val &= ~((u16)1 << (irq - VRC4173_IRQ_BASE));
+	val &= ~((uint16_t)1 << (irq - VRC4173_IRQ_BASE));
 	vrc4173_outw(val, VRC4173_MSYSINT1REG);
 }
 
@@ -157,19 +350,18 @@
 }
 
 static struct hw_interrupt_type vrc4173_irq_type = {
-	"VRC4173",
-	startup_vrc4173_irq,
-	shutdown_vrc4173_irq,
-	enable_vrc4173_irq,
-	disable_vrc4173_irq,
-	ack_vrc4173_irq,
-	end_vrc4173_irq,
-	NULL
+	.typename	= "VRC4173",
+	.startup	= startup_vrc4173_irq,
+	.shutdown	= shutdown_vrc4173_irq,
+	.enable		= enable_vrc4173_irq,
+	.disable	= disable_vrc4173_irq,
+	.ack		= ack_vrc4173_irq,
+	.end		= end_vrc4173_irq,
 };
 
 static int vrc4173_get_irq_number(int irq)
 {
-	u16 status, mask;
+	uint16_t status, mask;
 	int i;
 
         status = vrc4173_inw(VRC4173_SYSINT1REG);
@@ -179,18 +371,18 @@
 	if (status) {
 		for (i = 0; i < 16; i++)
 			if (status & (0x0001 << i))
-				return VRC4173_IRQ_BASE + i;
+				return VRC4173_IRQ(i);
 	}
 
 	return -EINVAL;
 }
 
-static inline void vrc4173_icu_init(int cascade_irq)
+static inline int vrc4173_icu_init(int cascade_irq)
 {
 	int i;
 
 	if (cascade_irq < GIU_IRQ(0) || cascade_irq > GIU_IRQ(15))
-		return;
+		return -EINVAL;
 	
 	vrc4173_outw(0, VRC4173_MSYSINT1REG);
 
@@ -199,33 +391,38 @@
 
 	for (i = VRC4173_IRQ_BASE; i <= VRC4173_IRQ_LAST; i++)
                 irq_desc[i].handler = &vrc4173_irq_type;
+
+	return 0;
 }
 
-static int __devinit vrc4173_probe(struct pci_dev *pdev,
-                                   const struct pci_device_id *ent)
+static int __devinit vrc4173_probe(struct pci_dev *dev,
+                                   const struct pci_device_id *id)
 {
 	unsigned long start, flags;
 	int err;
 
-	if ((err = pci_enable_device(pdev)) < 0) {
-		printk(KERN_ERR "vrc4173: failed to enable device -- err=%d\n", err);
+	err = pci_enable_device(dev);
+	if (err < 0) {
+		printk(KERN_ERR "vrc4173: Failed to enable PCI device, aborting\n");
 		return err;
 	}
 
-	pci_set_master(pdev);
+	pci_set_master(dev);
 
-	start = pci_resource_start(pdev, 0);
-	if (!start) {
-		printk(KERN_ERR "vrc4173:No PCI I/O resources, aborting\n");
-		return -ENODEV;
+	start = pci_resource_start(dev, 0);
+	if (start == 0) {
+		printk(KERN_ERR "vrc4173:No such PCI I/O resource, aborting\n");
+		return -ENXIO;
 	}
 
-	if (!start || (((flags = pci_resource_flags(pdev, 0)) & IORESOURCE_IO) == 0)) {
-		printk(KERN_ERR "vrc4173: No PCI I/O resources, aborting\n");
-		return -ENODEV;
+	flags = pci_resource_flags(dev, 0);
+	if ((flags & IORESOURCE_IO) == 0) {
+		printk(KERN_ERR "vrc4173: No such PCI I/O resource, aborting\n");
+		return -ENXIO;
 	}
 
-	if ((err = pci_request_regions(pdev, "NEC VRC4173")) < 0) {
+	err = pci_request_regions(dev, "NEC VRC4173");
+	if (err < 0) {
 		printk(KERN_ERR "vrc4173: PCI resources are busy, aborting\n");
 		return err;
 	}
@@ -233,25 +430,37 @@
 	set_vrc4173_io_offset(start);
 
 	vrc4173_cmu_init();
+	vrc4173_giu_init();
 
-	vrc4173_icu_init(pdev->irq);
+	err = vrc4173_icu_init(dev->irq);
+	if (err < 0) {
+		printk(KERN_ERR "vrc4173: Invalid IRQ %d, aborting\n", dev->irq);
+		return err;
+	}
 
-	if ((err = vr41xx_cascade_irq(pdev->irq, vrc4173_get_irq_number)) < 0) {
-		printk(KERN_ERR
-		       "vrc4173: IRQ resource %d is busy, aborting\n", pdev->irq);
+	err = vr41xx_cascade_irq(dev->irq, vrc4173_get_irq_number);
+	if (err < 0) {
+		printk(KERN_ERR "vrc4173: IRQ resource %d is busy, aborting\n", dev->irq);
 		return err;
 	}
 
 	printk(KERN_INFO
-	       "NEC VRC4173 at 0x%#08lx, IRQ is cascaded to %d\n", start, pdev->irq);
+	       "NEC VRC4173 at 0x%#08lx, IRQ is cascaded to %d\n", start, dev->irq);
 
 	return 0;
 }
 
+static void vrc4173_remove(struct pci_dev *dev)
+{
+	free_irq(dev->irq, NULL);
+
+	pci_release_regions(dev);
+}
+
 static struct pci_driver vrc4173_driver = {
 	.name		= "NEC VRC4173",
 	.probe		= vrc4173_probe,
-	.remove		= NULL,
+	.remove		= vrc4173_remove,
 	.id_table	= vrc4173_table,
 };
 
@@ -259,7 +468,8 @@
 {
 	int err;
 
-	if ((err = pci_module_init(&vrc4173_driver)) < 0)
+	err = pci_module_init(&vrc4173_driver);
+	if (err < 0)
 		return err;
 
 	vrc4173_initialized = 1;
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux-orig/include/asm-mips/vr41xx/vrc4173.h	Sat Dec 20 01:49:05 2003
+++ linux/include/asm-mips/vr41xx/vrc4173.h	Fri May 14 00:32:07 2004
@@ -1,19 +1,24 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/vrc4173.h
+ *  vrc4173.h, Include file for NEC VRC4173.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for NEC VRC4173.
+ *  Copyright (C) 2000  Michael R. McDonald
+ *  Copyright (C) 2001-2003 Montavista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- * Copyright (C) 2000 by Michael R. McDonald
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
  *
- * Copyright 2001-2003 Montavista Software Inc.
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #ifndef __NEC_VRC4173_H 
 #define __NEC_VRC4173_H 
@@ -72,35 +77,38 @@
 /*
  * Clock Mask Unit
  */
-#define VRC4173_PIU_CLOCK		0x0001
-#define VRC4173_KIU_CLOCK		0x0002
-#define VRC4173_AIU_CLOCK		0x0004
-#define VRC4173_PS2CH1_CLOCK		0x0008
-#define VRC4173_PS2CH2_CLOCK		0x0010
-#define VRC4173_USBU_PCI_CLOCK		0x0020
-#define VRC4173_CARDU1_PCI_CLOCK	0x0040
-#define VRC4173_CARDU2_PCI_CLOCK	0x0080
-#define VRC4173_AC97U_PCI_CLOCK		0x0100
-#define VRC4173_USBU_48MHz_CLOCK	0x0400
-#define VRC4173_EXT_48MHz_CLOCK		0x0800
-#define VRC4173_48MHz_CLOCK		0x1000
+enum vrc4173_clock {
+	VRC4173_PIU_CLOCK,
+	VRC4173_KIU_CLOCK,
+	VRC4173_AIU_CLOCK,
+	VRC4173_PS2_CH1_CLOCK,
+	VRC4173_PS2_CH2_CLOCK,
+	VRC4173_USBU_PCI_CLOCK,
+	VRC4173_CARDU1_PCI_CLOCK,
+	VRC4173_CARDU2_PCI_CLOCK,
+	VRC4173_AC97U_PCI_CLOCK,
+	VRC4173_USBU_48MHz_CLOCK,
+	VRC4173_EXT_48MHz_CLOCK,
+	VRC4173_48MHz_CLOCK,
+} vrc4173_clock_t;
 
-extern void vrc4173_clock_supply(u16 mask);
-extern void vrc4173_clock_mask(u16 mask);
+extern void vrc4173_supply_clock(vrc4173_clock_t clock);
+extern void vrc4173_mask_clock(vrc4173_clock_t clock);
 
 /*
  * General-Purpose I/O Unit
  */
-enum {
-	PS2CH1_SELECT,
-	PS2CH2_SELECT,
-	TOUCHPANEL_SELECT,
-	KIU8_SELECT,
-	KIU10_SELECT,
-	KIU12_SELECT,
-	GPIO_SELECT
-};
+enum vrc4173_function {
+	PS2_CHANNEL1,
+	PS2_CHANNEL2,
+	TOUCHPANEL,
+	KEYBOARD_8SCANLINES,
+	KEYBOARD_10SCANLINES,
+	KEYBOARD_12SCANLINES,
+	GPIO_0_15PINS,
+	GPIO_16_20PINS,
+} vrc4173_function_t;
 
-extern void vrc4173_select_function(int func);
+extern void vrc4173_select_function(vrc4173_function_t function);
 
 #endif /* __NEC_VRC4173_H */
