Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2005 19:13:03 +0100 (BST)
Received: from pop.gmx.de ([IPv6:::ffff:213.165.64.20]:49092 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225899AbVFOSMp>;
	Wed, 15 Jun 2005 19:12:45 +0100
Received: (qmail invoked by alias); 15 Jun 2005 18:12:36 -0000
Received: from p54B09D19.dip0.t-ipconnect.de (EHLO nancy.sattler.local) [84.176.157.25]
  by mail.gmx.net (mp011) with SMTP; 15 Jun 2005 20:12:36 +0200
X-Authenticated: #1474915
Received: from localhost (localhost [127.0.0.1])
	by nancy.sattler.local (Postfix) with ESMTP
	id 565C327527; Wed, 15 Jun 2005 20:12:36 +0200 (CEST)
Received: from nancy.sattler.local ([127.0.0.1])
	by localhost (nancy [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13440-02; Wed, 15 Jun 2005 20:12:23 +0200 (CEST)
Received: by nancy.sattler.local (Postfix, from userid 9682)
	id 7FECF27540; Wed, 15 Jun 2005 20:12:22 +0200 (CEST)
Date:	Wed, 15 Jun 2005 20:12:22 +0200
From:	Thomas Sattler <tsattler@gmx.de>
To:	Bruno Randolf <bruno.randolf@4g-systems.biz>
Cc:	linux-mips@linux-mips.org
Subject: Re: no power on USB on linux 2.6?
Message-ID: <20050615181221.GA26155@nancy.sattler.local>
References: <20050615134607.GA19510@nancy.sattler.local> <200506151557.17731.bruno.randolf@4g-systems.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <200506151557.17731.bruno.randolf@4g-systems.biz>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at sattler.local
X-Y-GMX-Trusted: 0
Return-Path: <tsattler@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsattler@gmx.de
Precedence: bulk
X-list: linux-mips


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there ...

If Bruno is right and CONFIG_USB_OHCI simply was renamed to
CONFIG_USB_OHCI_HCD than there are currently six files in
the CVS that sould be patched (patch attached):

arch/mips/au1000/csb250/board_setup.c
arch/mips/au1000/mtx-1/board_setup.c
arch/mips/au1000/pb1000/board_setup.c
arch/mips/au1000/pb1100/board_setup.c
arch/mips/au1000/pb1500/board_setup.c
drivers/char/au1000_gpio.c

BTW: My cube is playing ABBA 'Dancing Queen' right now! :-)

Thomas


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usbohci2usbohcihcd.patch"

diff -Nur linux-latest/arch/mips/au1000/csb250/board_setup.c linux-patched/arch/mips/au1000/csb250/board_setup.c
--- linux-latest/arch/mips/au1000/csb250/board_setup.c	2005-01-15 00:59:07.000000000 +0100
+++ linux-patched/arch/mips/au1000/csb250/board_setup.c	2005-06-15 19:53:17.000000000 +0200
@@ -59,7 +59,7 @@
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
 
-#if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#if defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 	/* GPIO201 is input for PCMCIA card detect */
 	/* GPIO203 is input for PCMCIA interrupt request */
@@ -88,7 +88,7 @@
 	/*
 	 * Route 48MHz FREQ2 into USB Host and/or Device
 	 */
-#ifdef CONFIG_USB_OHCI
+#ifdef CONFIG_USB_OHCI_HCD
 	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
 #endif
 #ifdef CONFIG_AU1X00_USB_DEVICE
@@ -103,7 +103,7 @@
 	pin_func |= 0x8000;
 #endif
 	au_writel(pin_func, SYS_PINFUNC);
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 	/* Configure GPIO2....it's used by PCI among other things.
 	*/
diff -Nur linux-latest/arch/mips/au1000/mtx-1/board_setup.c linux-patched/arch/mips/au1000/mtx-1/board_setup.c
--- linux-latest/arch/mips/au1000/mtx-1/board_setup.c	2005-06-15 17:35:59.000000000 +0200
+++ linux-patched/arch/mips/au1000/mtx-1/board_setup.c	2005-06-15 19:53:17.000000000 +0200
@@ -52,7 +52,7 @@
 
 void __init board_setup(void)
 {
-#if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#if defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 #ifdef CONFIG_AU1X00_USB_DEVICE
 	// 2nd USB port is USB device
 	au_writel(au_readl(SYS_PINFUNC) & (u32)(~0x8000), SYS_PINFUNC);
@@ -60,7 +60,7 @@
 	// enable USB power switch
 	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
 	au_writel( 0x100000, GPIO2_OUTPUT );
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
diff -Nur linux-latest/arch/mips/au1000/pb1000/board_setup.c linux-patched/arch/mips/au1000/pb1000/board_setup.c
--- linux-latest/arch/mips/au1000/pb1000/board_setup.c	2005-01-19 03:18:44.000000000 +0100
+++ linux-patched/arch/mips/au1000/pb1000/board_setup.c	2005-06-15 19:53:17.000000000 +0200
@@ -55,7 +55,7 @@
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
 
-#if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#if defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 	/* zero and disable FREQ2 */
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
 	sys_freqctrl &= ~0xFFF00000;
@@ -103,7 +103,7 @@
 	/*
 	 * Route 48MHz FREQ2 into USB Host and/or Device
 	 */
-#ifdef CONFIG_USB_OHCI
+#ifdef CONFIG_USB_OHCI_HCD
 	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
 #endif
 #ifdef CONFIG_AU1X00_USB_DEVICE
@@ -121,7 +121,7 @@
 	au_writel(pin_func, SYS_PINFUNC);
 	au_writel(0x2800, SYS_TRIOUTCLR);
 	au_writel(0x0030, SYS_OUTPUTCLR);
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 	// make gpio 15 an input (for interrupt line)
 	pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x100);
diff -Nur linux-latest/arch/mips/au1000/pb1100/board_setup.c linux-patched/arch/mips/au1000/pb1100/board_setup.c
--- linux-latest/arch/mips/au1000/pb1100/board_setup.c	2005-01-15 00:56:38.000000000 +0100
+++ linux-patched/arch/mips/au1000/pb1100/board_setup.c	2005-06-15 19:53:17.000000000 +0200
@@ -56,7 +56,7 @@
 	au_writel(0, SYS_PININPUTEN);
 	udelay(100);
 
-#if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#if defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 	// configure pins GPIO[14:9] as GPIO
 	pin_func = au_readl(SYS_PINFUNC) & (u32)(~0x80);
 
@@ -98,7 +98,7 @@
 	pin_func |= 0x8000;
 #endif
 	au_writel(pin_func, SYS_PINFUNC);
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 	/* Enable sys bus clock divider when IDLE state or no bus activity. */
 	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
diff -Nur linux-latest/arch/mips/au1000/pb1500/board_setup.c linux-patched/arch/mips/au1000/pb1500/board_setup.c
--- linux-latest/arch/mips/au1000/pb1500/board_setup.c	2005-01-15 00:56:38.000000000 +0100
+++ linux-patched/arch/mips/au1000/pb1500/board_setup.c	2005-06-15 19:53:17.000000000 +0200
@@ -57,7 +57,7 @@
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
 
-#if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#if defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 	/* GPIO201 is input for PCMCIA card detect */
 	/* GPIO203 is input for PCMCIA interrupt request */
@@ -86,7 +86,7 @@
 	/*
 	 * Route 48MHz FREQ2 into USB Host and/or Device
 	 */
-#ifdef CONFIG_USB_OHCI
+#ifdef CONFIG_USB_OHCI_HCD
 	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
 #endif
 #ifdef CONFIG_AU1X00_USB_DEVICE
@@ -101,7 +101,7 @@
 	pin_func |= 0x8000;
 #endif
 	au_writel(pin_func, SYS_PINFUNC);
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI_HCD) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 
 
diff -Nur linux-latest/drivers/char/au1000_gpio.c linux-patched/drivers/char/au1000_gpio.c
--- linux-latest/drivers/char/au1000_gpio.c	2005-02-28 14:35:57.000000000 +0100
+++ linux-patched/drivers/char/au1000_gpio.c	2005-06-15 19:53:17.000000000 +0200
@@ -84,7 +84,7 @@
 	avail_mask &= ~(inl(IC1_MASKRD) &
 			(inl(IC1_CFG0RD) | inl(IC1_CFG1RD)));
 
-#ifdef CONFIG_USB_OHCI
+#ifdef CONFIG_USB_OHCI_HCD
 	avail_mask &= ~((1<<4) | (1<<11));
 #ifndef CONFIG_AU1X00_USB_DEVICE
 	avail_mask &= ~((1<<5) | (1<<13));

--a8Wt8u1KmwUX3Y2C--
