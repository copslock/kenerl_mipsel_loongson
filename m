Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2003 10:48:54 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:32681 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEEJsq>;
	Mon, 5 May 2003 10:48:46 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id LAA19126;
	Mon, 5 May 2003 11:47:49 +0200 (MET DST)
Date: Mon, 5 May 2003 11:47:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petko Manolov <petkan@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Ralf Baechle <ralf@linux-mips.org>
cc: linux-usb-devel@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Dimitri Torfs <Dimitri.Torfs@sonycom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Big endian RTL8150
Message-ID: <Pine.GSO.4.21.0305051135140.9126-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi,

The RTL8150 USB Ethernet driver doesn't work on big endian machines. Here are
patches (for both 2.4.x and 2.5.x) to fix that. The fix was tested on the
2.4.20 and 2.4.21-rc1 version of the driver on big endian MIPS.

Changes:
  - Fix endianness of rx_creg (from Dimitri Torfs <Dimitri.Torfs@sonycom.com>)
  - Kill unused last parameter of async_set_registers()

--- linux-2.4.21-rc1/drivers/usb/rtl8150.c.orig	Wed Jan 29 10:14:22 2003
+++ linux-2.4.21-rc1/rtl8150.c	Mon May  5 11:27:37 2003
@@ -155,7 +155,7 @@
 	clear_bit(RX_REG_SET, &dev->flags);
 }
 
-static int async_set_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
+static int async_set_registers(rtl8150_t * dev, u16 indx, u16 size)
 {
 	int ret;
 
@@ -426,7 +426,8 @@
 	if (rtl8150_reset(dev)) {
 		warn("%s - device reset failed", __FUNCTION__);
 	}
-	dev->rx_creg = rcr = 0x9e;	/* bit7=1 attach Rx info at the end */
+	rcr = 0x9e;	/* bit7=1 attach Rx info at the end */
+	dev->rx_creg = cpu_to_le16(rcr);
 	tcr = 0xd8;
 	cr = 0x0c;
 	set_registers(dev, RCR, 1, &rcr);
@@ -471,18 +472,18 @@
 	dev = netdev->priv;
 	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
-		dev->rx_creg |= 0x0001;
+		dev->rx_creg |= cpu_to_le16(0x0001);
 		info("%s: promiscuous mode", netdev->name);
 	} else if ((netdev->mc_count > multicast_filter_limit) ||
 		   (netdev->flags & IFF_ALLMULTI)) {
-		dev->rx_creg &= 0xfffe;
-		dev->rx_creg |= 0x0002;
+		dev->rx_creg &= cpu_to_le16(0xfffe);
+		dev->rx_creg |= cpu_to_le16(0x0002);
 		info("%s: allmulti set", netdev->name);
 	} else {
 		/* ~RX_MULTICAST, ~RX_PROMISCUOUS */
-		dev->rx_creg &= 0x00fc;
+		dev->rx_creg &= cpu_to_le16(0x00fc);
 	}
-	async_set_registers(dev, RCR, 2, &dev->rx_creg);
+	async_set_registers(dev, RCR, 2);
 	netif_wake_queue(netdev);
 }
 
--- linux-2.5.69/drivers/usb/net/rtl8150.c.orig	Sun Apr 20 12:28:50 2003
+++ linux-2.5.69/drivers/usb/net/rtl8150.c	Mon May  5 11:32:05 2003
@@ -160,7 +160,7 @@
 	clear_bit(RX_REG_SET, &dev->flags);
 }
 
-static int async_set_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
+static int async_set_registers(rtl8150_t * dev, u16 indx, u16 size)
 {
 	int ret;
 
@@ -537,7 +537,8 @@
 		warn("%s - device reset failed", __FUNCTION__);
 	}
 	/* RCR bit7=1 attach Rx info at the end;  =0 HW CRC (which is broken) */
-	dev->rx_creg = rcr = 0x9e;
+	rcr = 0x9e;	/* bit7=1 attach Rx info at the end */
+	dev->rx_creg = cpu_to_le16(rcr);
 	tcr = 0xd8;
 	cr = 0x0c;
 	if (!(rcr & 0x80))
@@ -584,18 +585,18 @@
 	dev = netdev->priv;
 	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
-		dev->rx_creg |= 0x0001;
+		dev->rx_creg |= cpu_to_le16(0x0001);
 		info("%s: promiscuous mode", netdev->name);
 	} else if ((netdev->mc_count > multicast_filter_limit) ||
 		   (netdev->flags & IFF_ALLMULTI)) {
-		dev->rx_creg &= 0xfffe;
-		dev->rx_creg |= 0x0002;
+		dev->rx_creg &= cpu_to_le16(0xfffe);
+		dev->rx_creg |= cpu_to_le16(0x0002);
 		info("%s: allmulti set", netdev->name);
 	} else {
 		/* ~RX_MULTICAST, ~RX_PROMISCUOUS */
-		dev->rx_creg &= 0x00fc;
+		dev->rx_creg &= cpu_to_le16(0x00fc);
 	}
-	async_set_registers(dev, RCR, 2, &dev->rx_creg);
+	async_set_registers(dev, RCR, 2);
 	netif_wake_queue(netdev);
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
