Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 01:24:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50939 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTD3AYL>;
	Wed, 30 Apr 2003 01:24:11 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA06001;
	Tue, 29 Apr 2003 17:24:08 -0700
Message-ID: <3EAF17A8.8050805@mvista.com>
Date: Tue, 29 Apr 2003 17:24:08 -0700
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pete Popov <ppopov@mvista.com>, Jun Sun <jsun@mvista.com>
Subject: patch: change config options for au1x00 usb device
Content-Type: multipart/mixed;
 boundary="------------010100090308090708080807"
Return-Path: <stevel@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stevel@mvista.com
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.
--------------010100090308090708080807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch fixes CONFIG_AU1000_USB_DEVICE, which
had to be defined manually for each au1x00-based board in
arch/mips/config.in. The patch defines it automatically if one of
the au1x00 usb function drivers have been enabled.

-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-3875
http://www.mvista.com


--------------010100090308090708080807
Content-Type: text/plain;
 name="au1000-usbd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1000-usbd.patch"

Index: arch/mips/config.in
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/arch/mips/config.in,v
retrieving revision 1.20.2.15
diff -u -r1.20.2.15 config.in
--- arch/mips/config.in	19 Feb 2003 11:34:46 -0000	1.20.2.15
+++ arch/mips/config.in	29 Apr 2003 21:56:12 -0000
@@ -391,7 +391,6 @@
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_SWAP_IO_SPACE y
-   define_bool CONFIG_AU1000_USB_DEVICE y
 fi
 if [ "$CONFIG_MIPS_PB1500" = "y" ]; then
    define_bool CONFIG_MIPS_AU1000 y
Index: drivers/char/Config.in
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/drivers/char/Config.in,v
retrieving revision 1.14.4.11
diff -u -r1.14.4.11 Config.in
--- drivers/char/Config.in	26 Mar 2003 03:51:58 -0000	1.14.4.11
+++ drivers/char/Config.in	29 Apr 2003 21:56:23 -0000
@@ -71,9 +71,13 @@
      if [ "$CONFIG_AU1000_UART" = "y" ]; then
          bool '        Enable Au1000 serial console' CONFIG_AU1000_SERIAL_CONSOLE
      fi
-     dep_tristate '  Au1000 USB TTY Device support' CONFIG_AU1000_USB_TTY $CONFIG_AU1000_USB_DEVICE
+     dep_tristate '  Au1000 USB TTY Device support' CONFIG_AU1000_USB_TTY $CONFIG_MIPS_AU1000
      if [ "$CONFIG_AU1000_USB_TTY" != "y" ]; then
-        dep_tristate '  Au1000 USB Raw Device support' CONFIG_AU1000_USB_RAW $CONFIG_AU1000_USB_DEVICE
+        dep_tristate '  Au1000 USB Raw Device support' CONFIG_AU1000_USB_RAW $CONFIG_MIPS_AU1000
+     fi
+     if [ "$CONFIG_AU1000_USB_TTY" != "n" -o \
+          "$CONFIG_AU1000_USB_RAW" != "n" ]; then
+	define_bool CONFIG_AU1000_USB_DEVICE y
      fi
      bool 'TXx927 SIO support' CONFIG_TXX927_SERIAL 
      if [ "$CONFIG_TXX927_SERIAL" = "y" ]; then

--------------010100090308090708080807--
