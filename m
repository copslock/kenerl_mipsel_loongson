Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 00:43:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49395 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTEHXnl>;
	Fri, 9 May 2003 00:43:41 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA21570;
	Thu, 8 May 2003 16:43:35 -0700
Subject: Re: USB OHCI device port on Alchemy
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Steve Longerbeam <stevel@mvista.com>,
	Yasushi SHOJI <yashi@atmark-techno.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030508164134.C30468@luca.pas.lab>
References: <20030507203127.U30468@luca.pas.lab>
	 <20030508065335.294643E4CC@dns1.atmark-techno.com>
	 <20030508141457.V30468@luca.pas.lab> <3EBACCA4.8030803@mvista.com>
	 <20030508164134.C30468@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1052437426.558.119.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 May 2003 16:43:46 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


I'll check it in later.

Pete

On Thu, 2003-05-08 at 16:41, Jeff Baitis wrote:
> All:
> 
> Steve's patch includes some configuration options that I missed. Make sure you
> use his, not mine.
> 
> Sorry to cause confusion. I put his down below.
> 
> Thanks!
> 
> -Jeff
> 
> > Index: arch/mips/config.in
> > ===================================================================
> > RCS file: /cvsdev/mvl-kernel/linux/arch/mips/config.in,v
> > retrieving revision 1.20.2.15
> > diff -u -r1.20.2.15 config.in
> > --- arch/mips/config.in	19 Feb 2003 11:34:46 -0000	1.20.2.15
> > +++ arch/mips/config.in	29 Apr 2003 21:56:12 -0000
> > @@ -391,7 +391,6 @@
> >     define_bool CONFIG_NONCOHERENT_IO y
> >     define_bool CONFIG_PC_KEYB y
> >     define_bool CONFIG_SWAP_IO_SPACE y
> > -   define_bool CONFIG_AU1000_USB_DEVICE y
> >  fi
> >  if [ "$CONFIG_MIPS_PB1500" = "y" ]; then
> >     define_bool CONFIG_MIPS_AU1000 y
> > Index: drivers/char/Config.in
> > ===================================================================
> > RCS file: /cvsdev/mvl-kernel/linux/drivers/char/Config.in,v
> > retrieving revision 1.14.4.11
> > diff -u -r1.14.4.11 Config.in
> > --- drivers/char/Config.in	26 Mar 2003 03:51:58 -0000	1.14.4.11
> > +++ drivers/char/Config.in	29 Apr 2003 21:56:23 -0000
> > @@ -71,9 +71,13 @@
> >       if [ "$CONFIG_AU1000_UART" = "y" ]; then
> >           bool '        Enable Au1000 serial console' CONFIG_AU1000_SERIAL_CONSOLE
> >       fi
> > -     dep_tristate '  Au1000 USB TTY Device support' CONFIG_AU1000_USB_TTY $CONFIG_AU1000_USB_DEVICE
> > +     dep_tristate '  Au1000 USB TTY Device support' CONFIG_AU1000_USB_TTY $CONFIG_MIPS_AU1000
> >       if [ "$CONFIG_AU1000_USB_TTY" != "y" ]; then
> > -        dep_tristate '  Au1000 USB Raw Device support' CONFIG_AU1000_USB_RAW $CONFIG_AU1000_USB_DEVICE
> > +        dep_tristate '  Au1000 USB Raw Device support' CONFIG_AU1000_USB_RAW $CONFIG_MIPS_AU1000
> > +     fi
> > +     if [ "$CONFIG_AU1000_USB_TTY" != "n" -o \
> > +          "$CONFIG_AU1000_USB_RAW" != "n" ]; then
> > +	define_bool CONFIG_AU1000_USB_DEVICE y
> >       fi
> >       bool 'TXx927 SIO support' CONFIG_TXX927_SERIAL 
> >       if [ "$CONFIG_TXX927_SERIAL" = "y" ]; then
> On Thu, May 08, 2003 at 02:31:16PM -0700, Steve Longerbeam wrote:
> > 
> > 
> > Jeff Baitis wrote:
> > 
> > >Ah, thanks Yashi, I didn't notice this since I was looking in the USB driver
> > >directories ;)
> > >
> > >Steve:
> > >
> > >The option seems to be inactive in the kernel config; maybe this patch should
> > >be applied? Or is there a reason why this option is inaccessible?
> > >
> > 
> > Jeff, Yashi:
> > 
> > I wrote a similar patch to Yashi's. I've attached it.
> > 
> > Pete: have you applied this to linux-mips yet?
> > 
> > 
> > >
> > >On Thu, May 08, 2003 at 03:53:34PM +0900, Yasushi SHOJI wrote:
> > >  
> > >
> > >>At Wed, 7 May 2003 20:31:27 -0700,
> > >>Jeff Baitis wrote:
> > >>    
> > >>
> > >>>Has anyone played with the AU1X00 USB device port yet? If not, what would you
> > >>>guys suggest that the AU1X00 appear as? USB over Ethernet? Or maybe a simple
> > >>>dummy device that will perform bulk transfers?
> > >>>      
> > >>>
> > >>there are au1000_usbraw.c and au1000_usbtty.c in linux-mips.org's CVS
> > >>under drivers/char.
> > >>
> > >>I'd be excited to see usb storage driver for usb device.
> > >>
> > >>as a related topic, does anyone know how usb gadget api is coming? I'm
> > >>assuming that once usb gadget stabilized and people start using it,
> > >>we'll be converting au1's usb dev driver to gadget api, no?
> > >>
> > 
> > This is the first time I've heard of the gadget api, but I'd love to 
> > port the
> > au1x00 usb dev driver to a full-featured device-side protocol stack, as soon
> > as the community agrees on one.
> > 
> > When I wrote this driver, I implemented my own, very limited, device and
> > function api, as there still wasn't an accepted device-side api. But 
> > sounds like
> > maybe that will finally happen.
> > 
> > Steve
> > 
> 
> 
