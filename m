Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2002 08:48:11 +0100 (CET)
Received: from r-bu.iij4u.or.jp ([210.130.0.89]:46570 "EHLO r-bu.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122037AbSKLHsJ>;
	Tue, 12 Nov 2002 08:48:09 +0100
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id gAC7lwq06883;
	Tue, 12 Nov 2002 16:47:59 +0900 (JST)
Date: Tue, 12 Nov 2002 16:44:33 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Patch for vrc4173(companion chip for NEC VR41xx)
Message-Id: <20021112164433.32788ca8.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__12_Nov_2002_16:44:33_+0900_08211790"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Tue__12_Nov_2002_16:44:33_+0900_08211790
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I added support of NEC VRC4173.
VRC4173 is companion chip for NEC VR41xx series.

This patch is based on linux_2_4 tag cvs tree on ftp.linux-mips.org
Would you apply this patch to CVS on ftp.linux-mips.org?

Best Regards,

Yoichi
--Multipart_Tue__12_Nov_2002_16:44:33_+0900_08211790
Content-Type: text/plain;
 name="vrc4173.diff"
Content-Disposition: attachment;
 filename="vrc4173.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/Makefile linux/arch/mips/vr41xx/nec-eagle/Makefile
--- linux.orig/arch/mips/vr41xx/nec-eagle/Makefile	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/nec-eagle/Makefile	Wed Oct 30 20:10:37 2002
@@ -20,6 +20,6 @@
 obj-y	:= init.o irq.o setup.o
 
 obj-$(CONFIG_IDE)	+= ide-eagle.o
-obj-$(CONFIG_PCI)	+= pci_fixup.o
+obj-$(CONFIG_PCI)	+= pci_fixup.o vrc4173.o
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/irq.c linux/arch/mips/vr41xx/nec-eagle/irq.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/irq.c	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/nec-eagle/irq.c	Wed Oct 30 19:48:00 2002
@@ -164,9 +164,6 @@
 	writeb(0, NEC_EAGLE_SDBINTMSK);
 	writeb(0, NEC_EAGLE_PCIINTMSKREG);
 
-	vr41xx_set_irq_trigger(VRC4173_PIN, TRIGGER_LEVEL, SIGNAL_THROUGH);
-	vr41xx_set_irq_level(VRC4173_PIN, LEVEL_LOW);
-
 	vr41xx_set_irq_trigger(PCISLOT_PIN, TRIGGER_LEVEL, SIGNAL_THROUGH);
 	vr41xx_set_irq_level(PCISLOT_PIN, LEVEL_HIGH);
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/pci_fixup.c linux/arch/mips/vr41xx/nec-eagle/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/pci_fixup.c	Fri Oct  4 10:50:26 2002
+++ linux/arch/mips/vr41xx/nec-eagle/pci_fixup.c	Thu Oct 31 11:05:22 2002
@@ -47,9 +47,7 @@
 #include <linux/pci.h>
 
 #include <asm/vr41xx/eagle.h>
-#ifdef CONFIG_VRC4173
 #include <asm/vr41xx/vrc4173.h>
-#endif
 
 void __init pcibios_fixup_resources(struct pci_dev *dev)
 {
@@ -119,20 +117,12 @@
 				break;
 			}
 			break;
-#ifdef CONFIG_VRC4173
 		case 12:
-			dev->irq = VRC4173_CARDU1_IRQ;
+			dev->irq = VRC4173_PCMCIA1_IRQ;
 			break;
 		case 13:
-			dev->irq = VRC4173_CARDU2_IRQ;
+			dev->irq = VRC4173_PCMCIA2_IRQ;
 			break;
-		case 24:
-			dev->irq = VRC4173_CARDU1_IRQ;
-			break;
-		case 25:
-			dev->irq = VRC4173_CARDU2_IRQ;
-			break;
-#endif
 		case 28:
 			dev->irq = LANINTA_IRQ;
 			break;
@@ -152,21 +142,19 @@
 				break;
 			}
 			break;
-#ifdef CONFIG_VRC4173
 		case 30:
 			switch (func) {
 			case 0:
-				dev->irq = VRC4173_IRQ;
+				dev->irq = VRC4173_CASCADE_IRQ;
 				break;
 			case 1:
-				dev->irq = VRC4173_AC97U_IRQ;
+				dev->irq = VRC4173_AC97_IRQ;
 				break;
 			case 2:
-				dev->irq = VRC4173_USBU_IRQ;
+				dev->irq = VRC4173_USB_IRQ;
 				break;
 			}
 			break;
-#endif
 		}
 
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/setup.c	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Wed Oct 30 20:08:38 2002
@@ -150,7 +150,5 @@
 	vr41xx_pciu_init(&pci_address_map);
 #endif
 
-#ifdef CONFIG_VRC4173
-	vrc4173_init();
-#endif
+	vrc4173_pre_init();
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/vrc4173.c linux/arch/mips/vr41xx/nec-eagle/vrc4173.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/vrc4173.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/nec-eagle/vrc4173.c	Thu Oct 31 11:29:49 2002
@@ -0,0 +1,118 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/nec-eagle/vrc4173.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Pre-setup for NEC VRC4173.
+ *
+ * Author: Yoichi Yuasa
+ *         yyuasa@mvista.com or source@mvista.com
+ *
+ * Copyright 2001,2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+
+#ifdef CONFIG_PCI
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+
+#include <asm/pci_channel.h>
+#include <asm/vr41xx/eagle.h>
+#include <asm/vr41xx/vrc4173.h>
+
+extern int early_read_config_byte(struct pci_channel *hose, int top_bus, int bus,
+                                  int devfn, int offset, u8 *val);
+extern int early_read_config_word(struct pci_channel *hose, int top_bus, int bus,
+                                  int devfn, int offset, u16 *val);
+extern int early_read_config_dword(struct pci_channel *hose, int top_bus, int bus,
+                                   int devfn, int offset, u32 *val);
+extern int early_write_config_byte(struct pci_channel *hose, int top_bus, int bus,
+                                   int devfn, int offset, u8 val);
+extern int early_write_config_word(struct pci_channel *hose, int top_bus, int bus,
+                                   int devfn, int offset, u16 val);
+extern int early_write_config_dword(struct pci_channel *hose, int top_bus, int bus,
+                                    int devfn, int offset, u32 val);
+
+void __init vrc4173_pre_init(void)
+{
+	struct pci_channel *hose;
+	int top_bus;
+	int current_bus;
+	u32 pci_devfn, cmdstat, base;
+	u16 vid, did, cmu_mask;
+
+	hose = mips_pci_channels;
+	top_bus = 0;
+	current_bus = 0;
+	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
+
+		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
+		                       PCI_VENDOR_ID, &vid);
+		if (vid != PCI_VENDOR_ID_NEC)
+			continue;
+
+		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
+		                       PCI_DEVICE_ID, &did);
+		if (did != 0x00a5)
+			continue;
+
+		/*
+		 * Initialized NEC VRC4173 Bus Control Unit
+		 */
+		early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
+		                        PCI_COMMAND, &cmdstat);
+		early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+		                         PCI_COMMAND, cmdstat | PCI_COMMAND_IO |
+					 PCI_COMMAND_MEMORY |
+					 PCI_COMMAND_MASTER);
+		early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+		                        PCI_LATENCY_TIMER, 0x80);
+
+		early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+		                         PCI_BASE_ADDRESS_0, VR41XX_PCI_IO_START);
+
+		early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
+		                        PCI_BASE_ADDRESS_0, &base);
+		base &= PCI_BASE_ADDRESS_IO_MASK;
+
+		early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+		                        0x40, 0x01);
+
+		/* CARDU1 IDSEL = AD12, CARDU2 IDSEL = AD13 */
+		early_write_config_byte(hose, top_bus, current_bus, pci_devfn, 0x41, 0);
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
+	}
+}
+
+#endif
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/pci_fixup.c linux/arch/mips/vr41xx/victor-mpc30x/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/pci_fixup.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/victor-mpc30x/pci_fixup.c	Thu Oct 31 11:55:00 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
+#include <asm/vr41xx/vrc4173.h>
 #include <asm/vr41xx/mpc30x.h>
 
 void __init pcibios_fixup_resources(struct pci_dev *dev)
@@ -38,32 +39,28 @@
 		dev->irq = 0;
 
 		switch (slot) {
-#ifdef CONFIG_VRC4173
 		case 12:	/* NEC VRC4173 CARDU1 */
-			dev->irq = PCMCIA1_IRQ;
+			dev->irq = VRC4173_PCMCIA1_IRQ;
 			break;
 		case 13:	/* NEC VRC4173 CARDU2 */
-			dev->irq = PCMCIA2_IRQ;
+			dev->irq = VRC4173_PCMCIA2_IRQ;
 			break;
-#endif
 		case 29:	/* mediaQ MQ-200 */
 			dev->irq = MQ200_IRQ;
 			break;
-#ifdef CONFIG_VRC4173
 		case 30:
 			switch (func) {
 			case 0:	/* NEC VRC4173 */
 				dev->irq = VRC4173_CASCADE_IRQ;
 				break;
 			case 1:	/* NEC VRC4173 AC97U */
-				dev->irq = AC97_IRQ;
+				dev->irq = VRC4173_AC97_IRQ;
 				break;
 			case 2:	/* NEC VRC4173 USBU */
-				dev->irq = USB_IRQ;
+				dev->irq = VRC4173_USB_IRQ;
 				break;
 			}
 			break;
-#endif
 		}
 
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Tue Oct  8 12:40:10 2002
+++ linux/drivers/char/Config.in	Fri Nov  1 13:31:06 2002
@@ -302,4 +302,7 @@
 if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
   tristate ' ITE GPIO' CONFIG_ITE_GPIO
 fi
+if [ "$CONFIG_CPU_VR41XX" = "y" -a "$CONFIG_PCI" = "y" ]; then
+   tristate 'NEC VRC4173 Support' CONFIG_VRC4173
+fi
 endmenu
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/Makefile linux/drivers/char/Makefile
--- linux.orig/drivers/char/Makefile	Thu Sep 12 13:08:19 2002
+++ linux/drivers/char/Makefile	Fri Nov  1 13:35:39 2002
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o hp_psaux.o
+			au1000_gpio.o hp_psaux.o vrc4173.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 
@@ -158,6 +158,7 @@
 obj-$(CONFIG_SERIAL_SA1100) += serial_sa1100.o
 obj-$(CONFIG_SERIAL_AMBA) += serial_amba.o
 obj-$(CONFIG_TS_AU1000_ADS7846) += au1000_ts.o
+obj-$(CONFIG_VRC4173) += vrc4173.o
 
 ifndef CONFIG_SUN_KEYBOARD
   obj-$(CONFIG_VT) += keyboard.o $(KEYMAP) $(KEYBD)
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/vrc4173.c linux/drivers/char/vrc4173.c
--- linux.orig/drivers/char/vrc4173.c	Thu Jan  1 09:00:00 1970
+++ linux/drivers/char/vrc4173.c	Fri Nov  1 13:54:57 2002
@@ -0,0 +1,281 @@
+/*
+ * FILE NAME
+ *	drivers/char/vrc4173.c
+ * 
+ * BRIEF MODULE DESCRIPTION
+ *	NEC VRC4173 driver for NEC VR4122/VR4131.
+ *
+ * Author: Yoichi Yuasa
+ *         yyuasa@mvista.com or source@mvista.com
+ *
+ * Copyright 2001,2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/vrc4173.h>
+
+MODULE_DESCRIPTION("NEC VRC4173 driver for NEC VR4122/4131");
+MODULE_AUTHOR("Yoichi Yuasa <yyuasa@mvista.com>");
+MODULE_LICENSE("GPL");
+
+#define PCI_DEVICE_ID_NEC_VRC4173	0x00a5
+
+#define VRC4173_CMUCLKMSK	0x040
+#define VRC4173_CMUSRST		0x042
+
+#define VRC4173_SELECTREG	0x09e
+
+#define VRC4173_SYSINT1REG	0x060
+#define VRC4173_MSYSINT1REG	0x06c
+
+static struct pci_device_id vrc4173_table[] __devinitdata = {
+	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC4173, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0, }
+};
+
+unsigned long vrc4173_io_port_base = 0;
+
+EXPORT_SYMBOL_GPL(vrc4173_io_port_base);
+
+static u16 vrc4173_cmuclkmsk;
+static int vrc4173_initialized;
+
+void vrc4173_clock_supply(u16 mask)
+{
+	if (vrc4173_initialized) {
+		vrc4173_cmuclkmsk |= mask;
+		vrc4173_outw(vrc4173_cmuclkmsk, VRC4173_CMUCLKMSK);
+	}
+}
+
+void vrc4173_clock_mask(u16 mask)
+{
+	if (vrc4173_initialized) {
+		vrc4173_cmuclkmsk &= ~mask;
+		vrc4173_outw(vrc4173_cmuclkmsk, VRC4173_CMUCLKMSK);
+	}
+}
+
+static inline void vrc4173_cmu_init(void)
+{
+	vrc4173_cmuclkmsk = vrc4173_inw(VRC4173_CMUCLKMSK);
+}
+
+EXPORT_SYMBOL_GPL(vrc4173_clock_supply);
+EXPORT_SYMBOL_GPL(vrc4173_clock_mask);
+
+void vrc4173_select_function(int func)
+{
+	u16 val;
+
+	if (vrc4173_initialized) {
+		val = vrc4173_inw(VRC4173_SELECTREG);
+		switch(func) {
+		case PS2CH1_SELECT:
+			val |= 0x0004;
+			break;
+		case PS2CH2_SELECT:
+			val |= 0x0002;
+			break;
+		case TOUCHPANEL_SELECT:
+			val &= 0x0007;
+			break;
+		case KIU8_SELECT:
+			val &= 0x000e;
+			break;
+		case KIU10_SELECT:
+			val &= 0x000c;
+			break;
+		case KIU12_SELECT:
+			val &= 0x0008;
+			break;
+		case GPIO_SELECT:
+			val |= 0x0008;
+			break;
+		}
+		vrc4173_outw(val, VRC4173_SELECTREG);
+	}
+}
+
+EXPORT_SYMBOL_GPL(vrc4173_select_function);
+
+static void enable_vrc4173_irq(unsigned int irq)
+{
+	u16 val;
+
+	val = vrc4173_inw(VRC4173_MSYSINT1REG);
+	val |= (u16)1 << (irq - VRC4173_IRQ_BASE);
+	vrc4173_outw(val, VRC4173_MSYSINT1REG);
+}
+
+static void disable_vrc4173_irq(unsigned int irq)
+{
+	u16 val;
+
+	val = vrc4173_inw(VRC4173_MSYSINT1REG);
+	val &= ~((u16)1 << (irq - VRC4173_IRQ_BASE));
+	vrc4173_outw(val, VRC4173_MSYSINT1REG);
+}
+
+static unsigned int startup_vrc4173_irq(unsigned int irq)
+{
+	enable_vrc4173_irq(irq);
+	return 0; /* never anything pending */
+}
+
+#define shutdown_vrc4173_irq	disable_vrc4173_irq
+#define ack_vrc4173_irq		disable_vrc4173_irq
+
+static void end_vrc4173_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		enable_vrc4173_irq(irq);
+}
+
+static struct hw_interrupt_type vrc4173_irq_type = {
+	"VRC4173",
+	startup_vrc4173_irq,
+	shutdown_vrc4173_irq,
+	enable_vrc4173_irq,
+	disable_vrc4173_irq,
+	ack_vrc4173_irq,
+	end_vrc4173_irq,
+	NULL
+};
+
+static int vrc4173_get_irq_number(int irq)
+{
+	u16 status, mask;
+	int i;
+
+        status = vrc4173_inw(VRC4173_SYSINT1REG);
+        mask = vrc4173_inw(VRC4173_MSYSINT1REG);
+
+	status &= mask;
+	if (status) {
+		for (i = 0; i < 16; i++)
+			if (status & (0x0001 << i))
+				return VRC4173_IRQ_BASE + i;
+	}
+
+	return -EINVAL;
+}
+
+static inline void vrc4173_icu_init(int cascade_irq)
+{
+	int i;
+
+	if (cascade_irq < GIU_IRQ(0) || cascade_irq > GIU_IRQ(15))
+		return;
+	
+	vrc4173_outw(0, VRC4173_MSYSINT1REG);
+
+	vr41xx_set_irq_trigger(cascade_irq - GIU_IRQ(0), TRIGGER_LEVEL, SIGNAL_THROUGH);
+	vr41xx_set_irq_level(cascade_irq - GIU_IRQ(0), LEVEL_LOW);
+
+	for (i = VRC4173_IRQ_BASE; i <= VRC4173_IRQ_LAST; i++)
+                irq_desc[i].handler = &vrc4173_irq_type;
+}
+
+static int __devinit vrc4173_probe(struct pci_dev *pdev,
+                                   const struct pci_device_id *ent)
+{
+	unsigned long start, flags;
+	int err;
+
+	if ((err = pci_enable_device(pdev)) < 0) {
+		printk(KERN_ERR "vrc4173: failed to enable device -- err=%d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	start = pci_resource_start(pdev, 0);
+	if (!start) {
+		printk(KERN_ERR "vrc4173:No PCI I/O resources, aborting\n");
+		return -ENODEV;
+	}
+
+	if (!start || (((flags = pci_resource_flags(pdev, 0)) & IORESOURCE_IO) == 0)) {
+		printk(KERN_ERR "vrc4173: No PCI I/O resources, aborting\n");
+		return -ENODEV;
+	}
+
+	if ((err = pci_request_regions(pdev, "NEC VRC4173")) < 0) {
+		printk(KERN_ERR "vrc4173: PCI resources are busy, aborting\n");
+		return err;
+	}
+
+	set_vrc4173_io_port_base(start);
+
+	vrc4173_cmu_init();
+
+	vrc4173_icu_init(pdev->irq);
+
+	if ((err = vr41xx_cascade_irq(pdev->irq, vrc4173_get_irq_number)) < 0) {
+		printk(KERN_ERR
+		       "vrc4173: IRQ resource %d is busy, aborting\n", pdev->irq);
+		return err;
+	}
+
+	printk(KERN_INFO
+	       "NEC VRC4173 at 0x%#08lx, IRQ is cascaded to %d\n", start, pdev->irq);
+
+	return 0;
+}
+
+static struct pci_driver vrc4173_driver = {
+	name:		"NEC VRC4173",
+	probe:		vrc4173_probe,
+	remove:		NULL,
+	id_table:	vrc4173_table,
+};
+
+static int __devinit vrc4173_init(void)
+{
+	int err;
+
+	if ((err = pci_module_init(&vrc4173_driver)) < 0)
+		return err;
+
+	vrc4173_initialized = 1;
+
+	return 0;
+}
+
+static void __devexit vrc4173_exit(void)
+{
+	vrc4173_initialized = 0;
+
+	pci_unregister_driver(&vrc4173_driver);
+}
+
+module_init(vrc4173_init);
+module_exit(vrc4173_exit);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux.orig/include/asm-mips/vr41xx/vrc4173.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/vrc4173.h	Fri Nov  1 12:28:48 2002
@@ -0,0 +1,210 @@
+/*
+ * FILE NAME
+ *	include/asm-mips/vr41xx/vrc4173.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for NEC VRC4173.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000 by Michael R. McDonald
+ *
+ * Copyright 2001,2002 Montavista Software Inc.
+ * Author: Yoichi Yuasa
+ *         yyuasa@mvista.com or source@mvista.com
+ */
+#ifndef __NEC_VRC4173_H 
+#define __NEC_VRC4173_H 
+
+#include <asm/io.h>
+
+/*
+ * Interrupt Number
+ */
+#define VRC4173_IRQ_BASE	72
+#define VRC4173_USB_IRQ		(VRC4173_IRQ_BASE + 0)
+#define VRC4173_PCMCIA2_IRQ	(VRC4173_IRQ_BASE + 1)
+#define VRC4173_PCMCIA1_IRQ	(VRC4173_IRQ_BASE + 2)
+#define VRC4173_PS2CH2_IRQ	(VRC4173_IRQ_BASE + 3)
+#define VRC4173_PS2CH1_IRQ	(VRC4173_IRQ_BASE + 4)
+#define VRC4173_PIU_IRQ		(VRC4173_IRQ_BASE + 5)
+#define VRC4173_AIU_IRQ		(VRC4173_IRQ_BASE + 6)
+#define VRC4173_KIU_IRQ		(VRC4173_IRQ_BASE + 7)
+#define VRC4173_GIU_IRQ		(VRC4173_IRQ_BASE + 8)
+#define VRC4173_AC97_IRQ	(VRC4173_IRQ_BASE + 9)
+#define VRC4173_AC97INT1_IRQ	(VRC4173_IRQ_BASE + 10)
+#define VRC4173_DOZEPIU_IRQ	(VRC4173_IRQ_BASE + 13)
+#define VRC4173_IRQ_LAST	VRC4173_DOZEPIU_IRQ
+
+/*
+ * PCI I/O accesses
+ */
+extern unsigned long vrc4173_io_port_base;
+
+#define set_vrc4173_io_port_base(base)	\
+	do { vrc4173_io_port_base = mips_io_port_base + (base); } while (0)
+
+#define vrc4173_outb(val,port)							\
+do {										\
+	*(volatile u8 *)(vrc4173_io_port_base + (port)) = __ioswab8(val);	\
+} while(0)
+
+#define vrc4173_outw(val,port)							\
+do {										\
+	*(volatile u16 *)(vrc4173_io_port_base + (port)) = __ioswab16(val);	\
+} while(0)
+
+#define vrc4173_outl(val,port)							\
+do {										\
+	*(volatile u32 *)(vrc4173_io_port_base + (port)) = __ioswab32(val);	\
+} while(0)
+
+#define vrc4173_outb_p(val,port)						\
+do {										\
+	*(volatile u8 *)(vrc4173_io_port_base + (port)) = __ioswab8(val);	\
+	SLOW_DOWN_IO;								\
+} while(0)
+
+#define vrc4173_outw_p(val,port)						\
+do {										\
+	*(volatile u16 *)(vrc4173_io_port_base + (port)) = __ioswab16(val);	\
+	SLOW_DOWN_IO;								\
+} while(0)
+
+#define vrc4173_outl_p(val,port)						\
+do {										\
+	*(volatile u32 *)(vrc4173_io_port_base + (port)) = __ioswab32(val);	\
+	SLOW_DOWN_IO;								\
+} while(0)
+
+#define vrc4173_inb(port) __vrc4173_inb(port)
+#define vrc4173_inw(port) __vrc4173_inw(port)
+#define vrc4173_inl(port) __vrc4173_inl(port)
+#define vrc4173_inb_p(port) __vrc4173_inb_p(port)
+#define vrc4173_inw_p(port) __vrc4173_inw_p(port)
+#define vrc4173_inl_p(port) __vrc4173_inl_p(port)
+
+static inline unsigned char __vrc4173_inb(unsigned long port)
+{
+	return __ioswab8(*(volatile u8 *)(vrc4173_io_port_base + port));
+}
+
+static inline unsigned short __vrc4173_inw(unsigned long port)
+{
+	return __ioswab16(*(volatile u16 *)(vrc4173_io_port_base + port));
+}
+
+static inline unsigned int __vrc4173_inl(unsigned long port)
+{
+	return __ioswab32(*(volatile u32 *)(vrc4173_io_port_base + port));
+}
+
+static inline unsigned char __vrc4173_inb_p(unsigned long port)
+{
+ 	u8 __val;
+
+	__val = *(volatile u8 *)(vrc4173_io_port_base + (port));
+	SLOW_DOWN_IO;
+
+	return __ioswab8(__val);
+}
+
+static inline unsigned short __vrc4173_inw_p(unsigned long port)
+{
+ 	u16 __val;
+
+	__val = *(volatile u16 *)(vrc4173_io_port_base + (port));
+	SLOW_DOWN_IO;
+
+	return __ioswab16(__val);
+}
+
+static inline unsigned int __vrc4173_inl_p(unsigned long port)
+{
+ 	u32 __val;
+
+	__val = *(volatile u32 *)(vrc4173_io_port_base + (port));
+	SLOW_DOWN_IO;
+
+	return __ioswab32(__val);
+}
+
+#define vrc4173_outsb(port, addr, count) __vrc4173_outsb(port, addr, count)
+#define vrc4173_insb(port, addr, count) __vrc4173_insb(port, addr, count)
+#define vrc4173_outsw(port, addr, count) __vrc4173_outsw(port, addr, count)
+#define vrc4173_insw(port, addr, count) __vrc4173_insw(port, addr, count)
+#define vrc4173_outsl(port, addr, count) __vrc4173_outsl(port, addr, count)
+#define vrc4173_insl(port, addr, count) __vrc4173_insl(port, addr, count)
+
+static inline void __vrc4173_outsb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		vrc4173_outb(*(u8 *)addr, port);
+		addr++;
+	}
+}
+
+static inline void __vrc4173_insb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u8 *)addr = vrc4173_inb(port);
+		addr++;
+	}
+}
+
+static inline void __vrc4173_outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		vrc4173_outw(*(u16 *)addr, port);
+		addr += 2;
+	}
+}
+
+static inline void __vrc4173_insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = vrc4173_inw(port);
+		addr += 2;
+	}
+}
+
+static inline void __vrc4173_outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		vrc4173_outl(*(u32 *)addr, port);
+		addr += 4;
+	}
+}
+
+static inline void __vrc4173_insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = vrc4173_inl(port);
+		addr += 4;
+	}
+}
+
+/*
+ * Clock Mask Unit
+ */
+extern void vrc4173_clock_supply(u16 mask);
+extern void vrc4173_clock_mask(u16 mask);
+
+/*
+ * Clock Mask Unit
+ */
+enum {
+	PS2CH1_SELECT,
+	PS2CH2_SELECT,
+	TOUCHPANEL_SELECT,
+	KIU8_SELECT,
+	KIU10_SELECT,
+	KIU12_SELECT,
+	GPIO_SELECT
+};
+
+extern void vrc4173_select_function(int func);
+
+#endif /* __NEC_VRC4173_H */


--Multipart_Tue__12_Nov_2002_16:44:33_+0900_08211790--
