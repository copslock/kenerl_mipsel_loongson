Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 16:29:55 +0000 (GMT)
Received: from mail.scs.ch ([IPv6:::ffff:212.254.229.5]:41874 "EHLO
	mail.scs.ch") by linux-mips.org with ESMTP id <S8225235AbVATQ3t>;
	Thu, 20 Jan 2005 16:29:49 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KGThNa030986
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 17:29:43 +0100
Received: from mail.scs.ch ([127.0.0.1])
 by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 30823-03 for <linux-mips@linux-mips.org>;
 Thu, 20 Jan 2005 17:29:39 +0100 (CET)
Received: from kronenbourg.scs.ch (190.scs.ch [212.254.229.190])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KGTZUi030979
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 17:29:35 +0100
Subject: Au1000 Big Endian USB OHCI
From:	Thomas Sailer <sailer@scs.ch>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: SCS
Date:	Thu, 20 Jan 2005 17:29:35 +0100
Message-Id: <1106238575.8838.9.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at scs.ch
Return-Path: <sailer@scs.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sailer@scs.ch
Precedence: bulk
X-list: linux-mips

Hi,

does the Au1000 OHCI controller work for anybody with the current 2.6
cvs tree in big endian mode? When I try to insmod ohci-hcd, the machine
just hangs. Also, I used the attached patch to be able to select usb
ohci even without PCI.

Furthermore, is there any news about the porting of the usb device
driver to the usb gadget stack?

Tom



--- drivers/usb/host/Kconfig.jnx	2005-01-19 22:48:43.049114480 +0100
+++ drivers/usb/host/Kconfig	2005-01-19 22:49:08.777555520 +0100
@@ -14,6 +14,7 @@
 	default y if ARCH_OMAP
 	default y if ARCH_LH7A404
 	default y if PXA27x
+	default y if SOC_AU1X00
 	default PCI
 
 #
--- arch/mips/Kconfig.jnx	2005-01-19 23:05:07.801263123 +0100
+++ arch/mips/Kconfig	2005-01-19 23:11:31.977151245 +0100
@@ -1055,9 +1055,12 @@
 	bool
 
 config AU1X00_USB_DEVICE
-	bool
+	bool "Au1X00 USB Device Driver"
 	depends on MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
 	default n
+	help
+	  Say Y here if you want to use the USB device connector on your
+	  AU1X00 Board
 
 config MIPS_GT96100
 	bool
--- arch/mips/au1000/common/usbdev.c.jnx	2005-01-19 23:16:40.028506546 +0100
+++ arch/mips/au1000/common/usbdev.c	2005-01-19 23:24:53.161629362 +0100
@@ -46,9 +46,9 @@
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
-#include <asm/au1000.h>
-#include <asm/au1000_dma.h>
-#include <asm/au1000_usbdev.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
+#include <asm/mach-au1x00/au1000_usbdev.h>
 
 #ifdef DEBUG
 #undef VDEBUG
@@ -348,7 +348,7 @@
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("endpoint_stall");
 
 	cs = au_readl(ep->reg->ctrl_stat) | USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
@@ -360,7 +360,7 @@
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("endpoint_unstall");
 
 	cs = au_readl(ep->reg->ctrl_stat) & ~USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
@@ -1031,7 +1031,7 @@
 
 
 /* This ISR handles the receive complete and suspend events */
-static void
+static irqreturn_t
 req_sus_intr (int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct usb_dev *dev = (struct usb_dev *) dev_id;
@@ -1046,11 +1046,12 @@
 		process_ep_receive(dev, &dev->ep[4]);
 	if (status & (1<<5))
 		process_ep_receive(dev, &dev->ep[5]);
+	return (status & ((1<<0) | (1<<4) | (1<<5))) ? IRQ_HANDLED : IRQ_NONE;
 }
 
 
 /* This ISR handles the DMA done events on EP0 */
-static void
+static irqreturn_t
 dma_done_ep0_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct usb_dev *dev = (struct usb_dev *) dev_id;
@@ -1092,10 +1093,11 @@
 	}
 
 	spin_unlock(&ep0->lock);
+	return IRQ_HANDLED;
 }
 
 /* This ISR handles the DMA done events on endpoints 2,3,4,5 */
-static void
+static irqreturn_t
 dma_done_ep_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct usb_dev *dev = (struct usb_dev *) dev_id;
@@ -1149,6 +1151,7 @@
 
 		spin_unlock(&ep->lock);
 	}
+	return IRQ_HANDLED;
 }
 
 
--- drivers/char/Kconfig.jnx	2005-01-20 01:50:45.401014480 +0100
+++ drivers/char/Kconfig	2005-01-20 01:51:19.595499298 +0100
@@ -358,11 +358,11 @@
 
 config AU1X00_USB_TTY
 	tristate "Au1000 USB TTY Device support"
-	depends on MIPS && MIPS_AU1000 && AU1000_USB_DEVICE=y && AU1000_USB_DEVICE
+	depends on MIPS && AU1X00_USB_DEVICE=y && AU1X00_USB_DEVICE
 
 config AU1X00_USB_RAW
 	tristate "Au1000 USB Raw Device support"
-	depends on MIPS && MIPS_AU1000 && AU1000_USB_DEVICE=y && AU1000_USB_TTY!=y && AU1X00_USB_DEVICE
+	depends on MIPS && AU1X00_USB_DEVICE=y && AU1X00_USB_TTY!=y && AU1X00_USB_DEVICE
 
 config SERIAL_TX3912
 	bool "TX3912/PR31700 serial port support"
