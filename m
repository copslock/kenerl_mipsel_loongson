Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 13:08:08 +0000 (GMT)
Received: from moutvdom.kundenserver.de ([IPv6:::ffff:212.227.126.250]:56811
	"EHLO moutvdom.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225223AbTCMNIH>; Thu, 13 Mar 2003 13:08:07 +0000
Received: from [212.227.126.220] (helo=mrvdomng.kundenserver.de)
	by moutvdom.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18tSRL-0006OF-00
	for linux-mips@linux-mips.org; Thu, 13 Mar 2003 14:08:07 +0100
Received: from [62.109.119.183] (helo=192.168.202.41)
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18tSRK-0003cC-00
	for linux-mips@linux-mips.org; Thu, 13 Mar 2003 14:08:06 +0100
From: Bruno Randolf <br1@4g-systems.de>
Organization: 4G Mobile Systeme
To: linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
Date: Thu, 13 Mar 2003 14:08:05 +0100
User-Agent: KMail/1.5
References: <3E689267.3070509@prosyst.bg> <3E6E588A.1090702@amd.com> <3E6E5BE0.4000203@embeddededge.com>
In-Reply-To: <3E6E5BE0.4000203@embeddededge.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1KIc+DdgiliP8jV"
Message-Id: <200303131408.05612.br1@4g-systems.de>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips


--Boundary-00=_1KIc+DdgiliP8jV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 March 2003 22:57, Dan Malek wrote:
> I would like to hear the
> results of the message posted earlier today about the proper power up
> of the USB interface on this board :-)

hello!

i got USB to work with the proper power up :)
the builtin usb devices still dont accept a new address (maybe thats ok?), but 
i can see the attached usb devices and they are powered. i tested a serial 
driver which also loads and detects the device fine. looks good, but i havent 
tested any functionality yet.

i attach a patch with the usb power up for the mycable XXS board, which also 
defines a new config option for this board. i'm not sure if this is the 
correct way to do it, so please correct me...

bruno
--Boundary-00=_1KIc+DdgiliP8jV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mycable_XXS_config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mycable_XXS_config.diff"

--- cvs-linux-mips-2_4/arch/mips/config-shared.in	Fri Mar  7 18:29:18 2003
+++ mips-2_4/arch/mips/config-shared.in	Thu Mar 13 13:52:47 2003
@@ -29,6 +29,9 @@
 fi
 dep_bool 'Support for Alchemy PB1100 board' CONFIG_MIPS_PB1100 $CONFIG_MIPS32
 dep_bool 'Support for Alchemy PB1500 board' CONFIG_MIPS_PB1500 $CONFIG_MIPS32
+if [ "$CONFIG_MIPS_PB1500" = "y" ]; then
+   bool '  Support for mycable XXS board' CONFIG_MYCABLE_XXS_1500
+fi
 dep_bool 'Support for BAGET MIPS series (EXPERIMENTAL)' CONFIG_BAGET_MIPS $CONFIG_MIPS32 $CONFIG_EXPERIMENTAL
 bool 'Support for CASIO CASSIOPEIA E-10/15/55/65' CONFIG_CASIO_E55
 dep_bool 'Support for Cobalt Server (EXPERIMENTAL)' CONFIG_MIPS_COBALT $CONFIG_EXPERIMENTAL

--Boundary-00=_1KIc+DdgiliP8jV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mycable_XXS_usb_power.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mycable_XXS_usb_power.diff"

--- cvs-linux-mips-2_4/arch/mips/au1000/pb1500/setup.c	Thu Mar 13 14:00:00 2003
+++ mips-2_4/arch/mips/au1000/pb1500/setup.c	Thu Mar 13 14:04:53 2003
@@ -197,8 +197,24 @@
 	pin_func |= 0x8000;
 #endif
 	au_writel(pin_func, SYS_PINFUNC);
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
 
+#ifdef CONFIG_MYCABLE_XXS_1500
+	// set multiple use pins (UART3/GPIO) to UART (it's used as UART too)
+	pin_func = au_readl(SYS_PINFUNC) & (u32)(~SYS_PF_UR3);
+	pin_func |= SYS_PF_UR3;
+	au_writel(pin_func, SYS_PINFUNC);
+
+	// enable UART
+	au_writel(0x01, UART3_ADDR+UART_MOD_CNTRL); // clock enable (CE)
+	mdelay(10);
+	au_writel(0x03, UART3_ADDR+UART_MOD_CNTRL); // CE and "enable"
+	mdelay(10);
+
+	// enable DTR = USB power up
+	au_writel(0x01, UART3_ADDR+UART_MCR); //? UART_MCR_DTR is 0x01???
+#endif
+
+#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 #ifdef CONFIG_USB_OHCI
 	// enable host controller and wait for reset done

--Boundary-00=_1KIc+DdgiliP8jV--
