Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 22:31:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35575 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTEHVbY>;
	Thu, 8 May 2003 22:31:24 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA02783;
	Thu, 8 May 2003 14:31:16 -0700
Message-ID: <3EBACCA4.8030803@mvista.com>
Date: Thu, 08 May 2003 14:31:16 -0700
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: baitisj@evolution.com
CC: Yasushi SHOJI <yashi@atmark-techno.com>, linux-mips@linux-mips.org,
	Pete Popov <ppopov@mvista.com>
Subject: Re: USB OHCI device port on Alchemy
References: <20030507203127.U30468@luca.pas.lab> <20030508065335.294643E4CC@dns1.atmark-techno.com> <20030508141457.V30468@luca.pas.lab>
Content-Type: multipart/mixed;
 boundary="------------010801020101030607050905"
Return-Path: <stevel@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stevel@mvista.com
Precedence: bulk
X-list: linux-mips


This is a multi-part message in MIME format.
--------------010801020101030607050905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jeff Baitis wrote:

>Ah, thanks Yashi, I didn't notice this since I was looking in the USB driver
>directories ;)
>
>Steve:
>
>The option seems to be inactive in the kernel config; maybe this patch should
>be applied? Or is there a reason why this option is inaccessible?
>

Jeff, Yashi:

I wrote a similar patch to Yashi's. I've attached it.

Pete: have you applied this to linux-mips yet?


>
>On Thu, May 08, 2003 at 03:53:34PM +0900, Yasushi SHOJI wrote:
>  
>
>>At Wed, 7 May 2003 20:31:27 -0700,
>>Jeff Baitis wrote:
>>    
>>
>>>Has anyone played with the AU1X00 USB device port yet? If not, what would you
>>>guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
>>>dummy device that will perform bulk transfers?
>>>      
>>>
>>there are au1000_usbraw.c and au1000_usbtty.c in linux-mips.org's CVS
>>under drivers/char.
>>
>>I'd be excited to see usb storage driver for usb device.
>>
>>as a related topic, does anyone know how usb gadget api is coming? I'm
>>assuming that once usb gadget stabilized and people start using it,
>>we'll be converting au1's usb dev driver to gadget api, no?
>>

This is the first time I've heard of the gadget api, but I'd love to 
port the
au1x00 usb dev driver to a full-featured device-side protocol stack, as soon
as the community agrees on one.

When I wrote this driver, I implemented my own, very limited, device and
function api, as there still wasn't an accepted device-side api. But 
sounds like
maybe that will finally happen.

Steve


--------------010801020101030607050905
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

--------------010801020101030607050905--
