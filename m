Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HK7xA28852
	for linux-mips-outgoing; Thu, 17 Jan 2002 12:07:59 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HK7pP28849
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 12:07:51 -0800
Received: from hermes.mvista.com ([12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA28675
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 11:03:22 -0800 (PST)
	mail_from (ppopov@pacbell.net)
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0HIxvB07463;
	Thu, 17 Jan 2002 10:59:57 -0800
Subject: Re: usb-problems with Au1000
From: Pete Popov <ppopov@pacbell.net>
To: Kunihiko IMAI <kimai@laser5.co.jp>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <m3bsft6z87.wl@l5ac152.l5.laser5.co.jp>
References: <3B7DA3A3.8010000@pacbell.net> <3C3DD208.45B5BC29@esk.fhg.de> 
	<m3bsft6z87.wl@l5ac152.l5.laser5.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Jan 2002 11:02:03 -0800
Message-Id: <1011294123.4550.58.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-17 at 02:36, Kunihiko IMAI wrote:
> Hi,
> 
> I'm trying SGI version of kernel-2.2.17.
> And I get same message,
> 
> At Thu, 10 Jan 2002 18:40:24 +0100,
> Wolfgang Heidrich wrote:
> 
> > hub.c: USB new device connect on bus1/1, assigned device number 3
> > usb.c: USB device not accepting new address=3 (error=-145)

I'm surprised the sgi kernel works with usb at all.  We did a patch for
non-pci usb devices which was not accepted by the usb project at that
time because they were working on a different solution.
 
> when connect some device.
> 
> 
> I checked in some cases:
> 
> - Some devices are recognized, some are not.
> 	A joystick device (sanwa supply) works fine.
> 	A mouse device (century corp.) works too.
> 	But another mouse (Logitech Mini Wheel Mouse) doesn't work and
> 		I got message like above.
> 
> - When connected via USB hub device, Logitech mouse works fine.
> 
> I think USB root HUB doesn't work properly. 
 
> By the way:
> 
> today, I got a errata document from the chip dealer.  This document
> reports some USB errata.
> I read the report and source code, then  I found a bug in
> arch/mips/au1000/pb1000/setup.c.
> 
> 
> The errata report says workaround method:
> - set the CPU clock is 384MHz
> - set the source of USB host controller is CPU clcck.
> 
> And the code:
> 
>         /*
>          * Setup 48MHz FREQ2 from CPUPLL for USB Host
>          */
>         /* FRDIV2=3 -> div by 8 of 384MHz -> 48MHz */
>         sys_freqctrl |= ((3<<22) | (1<<21) | (0<<20));
>         outl(sys_freqctrl, FQ_CNTRL_1);
> 
> Comment says "Setup FREQ2" but the code set FREQ5.

It's the comment that's wrong, not the code. The code works and has been
tested.  Alchemy makes available the Linux Support Package (LSP) which
we did. That kernel has been tested with all peripherals so I would
recommend that you get that from them.  Also,make sure your jumpers are
setup correctly (S4).

I do have a better USB workaround which checks the CPU silicon rev, but
I haven't had time to send Ralf an updated patch. The current setup.c
should work though.  Get the latest LSP from Alchemy, check the S4
jumpers (1-4 off, 5-6 on, 7-8 off), and let me know if it still doesn't
work for you.

Pete
