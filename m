Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 22:15:06 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:985 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225239AbTEHVPD>;
	Thu, 8 May 2003 22:15:03 +0100
Received: (qmail 13177 invoked by uid 6180); 8 May 2003 21:14:58 -0000
Date: Thu, 8 May 2003 14:14:58 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Yasushi SHOJI <yashi@atmark-techno.com>
Cc: linux-mips@linux-mips.org, stevel@mvista.com
Subject: Re: USB OHCI device port on Alchemy
Message-ID: <20030508141457.V30468@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030507203127.U30468@luca.pas.lab> <20030508065335.294643E4CC@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030508065335.294643E4CC@dns1.atmark-techno.com>; from yashi@atmark-techno.com on Thu, May 08, 2003 at 03:53:34PM +0900
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Ah, thanks Yashi, I didn't notice this since I was looking in the USB driver
directories ;)

Steve:

The option seems to be inactive in the kernel config; maybe this patch should
be applied? Or is there a reason why this option is inaccessible?

Thanks,

Jeff

Index: Config.in
===================================================================
RCS file: /home/cvs/linux/drivers/char/Attic/Config.in,v
retrieving revision 1.72.2.28
diff -u -r1.72.2.28 Config.in
--- Config.in   23 Apr 2003 00:23:24 -0000     1.72.2.28
+++ Config.in   8 May 2003 21:13:05 -0000
@@ -91,10 +91,11 @@
         if [ "$CONFIG_AU1X00_UART" = "y" ]; then
            bool '        Enable Au1x00 serial console' CONFIG_AU1X00_SERIAL_CONSOLE
          fi
+     bool '  Enable Au1x00 USB Device Support' CONFIG_AU1X00_USB_DEVICE
         if [ "$CONFIG_AU1X00_USB_DEVICE" = "y" ]; then
-           dep_tristate '  Au1x00 USB TTY Device support' CONFIG_AU1X00_USB_TTY $CONFIG_AU1X00_USB_DEVICE
+           dep_tristate '        Au1x00 USB TTY Device support' CONFIG_AU1X00_USB_TTY $CONFIG_AU1X00_USB_DEVICE
            if [ "$CONFIG_AU1000_USB_TTY" != "y" ]; then
-              dep_tristate '  Au1x00 USB Raw Device support' CONFIG_AU1X00_USB_RAW $CONFIG_AU1X00_USB_DEVICE
+              dep_tristate '        Au1x00 USB Raw Device support' CONFIG_AU1X00_USB_RAW $CONFIG_AU1X00_USB_DEVICE
            fi
          fi
       fi





On Thu, May 08, 2003 at 03:53:34PM +0900, Yasushi SHOJI wrote:
> At Wed, 7 May 2003 20:31:27 -0700,
> Jeff Baitis wrote:
> > 
> > Has anyone played with the AU1X00 USB device port yet? If not, what would you
> > guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
> > dummy device that will perform bulk transfers?
> 
> there are au1000_usbraw.c and au1000_usbtty.c in linux-mips.org's CVS
> under drivers/char.
> 
> I'd be excited to see usb storage driver for usb device.
> 
> as a related topic, does anyone know how usb gadget api is coming? I'm
> assuming that once usb gadget stabilized and people start using it,
> we'll be converting au1's usb dev driver to gadget api, no?
> 
> or people already working on it?
> --
>       yashi
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
