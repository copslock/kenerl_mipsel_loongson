Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 07:54:11 +0100 (BST)
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:57941 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20099204AbYIPGyJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Sep 2008 07:54:09 +0100
Received: (qmail 56776 invoked from network); 16 Sep 2008 06:54:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=qx7y1Qo3JcR32mY4gXo/qlD8uikfon3Yk0UgbPrhXrmp5+NEor5dwwoUAWG50nuLU0qwrXX0pKBOBeGsu7D25AMn2Hg8V4cWWvUuuVE1UxgeWdC4XcvTeupu8nTxKlF8+8tFdN9BFuQkMrYsInqjjfeLXMQoOcwA6FnvGrOolhk=  ;
Received: from unknown (HELO host-245-109.pubnet.pdx.edu) (david-b@pacbell.net@131.252.245.109 with plain)
  by smtp108.sbc.mail.mud.yahoo.com with SMTP; 16 Sep 2008 06:54:00 -0000
X-YMail-OSG: qG4Teg4VM1mZpZ74neW6FrU44O9I.T.9x4sTEEOhvyL8rRWr1NhxW.OVQEp9cViziZuMzyYYhJpDSg0FJYL.pBXfT3OR2fFchrWFrEWWxWLcTdNGPaD03ZF7AyaDNbh7RU0-
X-Yahoo-Newman-Property: ymail-3
From:	David Brownell <david-b@pacbell.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH] Au1200 USB Device Controller and device-only OTG
Date:	Mon, 15 Sep 2008 23:53:59 -0700
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-usb@vger.kernel.org, mano@roarinelk.homelinux.net
References: <> <200809151216.02148.david-b@pacbell.net> <1221506788.6680.11.camel@kh-d820-ubuntu.razamicroelectronics.com>
In-Reply-To: <1221506788.6680.11.camel@kh-d820-ubuntu.razamicroelectronics.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200809152353.59530.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Monday 15 September 2008, Kevin Hickey wrote:
> On Mon, 2008-09-15 at 12:16 -0700, David Brownell wrote:
> > On Thursday 11 September 2008, Kevin Hickey wrote:
> > > basic device-only OTG (On-The-Go) support
> > 
> > That does't look like it's done right.  For starters, it abuses
> > Kconfig to handle a board-specific config option.  Put that data
> > in platform_data instead ...
>
> I don't understand what you mean by this.  Can you be more specific?

The need for CONFIG_USB_AU1200OTG is board-specific,
and doesn't belong in Kconfig.

Also, the au1200_otg code should live with platform code ...
plan for it to become "real OTG support" (at least for cable
based role switching), and then it becomes clear that it does
not belong in the drivers/usb host or gadget directories (since
it affects both).  At this point I have a preference for such
stuff to live in arch/... directories


> > Second, it breaks some previously-working code.
>
> Can you be more specific?

Breaks the orignal OMAP OTG support:

> > -config USB_OTG
> > -       boolean "OTG Support"
> > -       depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD

... by removing that stuff.

 
> > Third, it misbehaves even on an x86 config.  Needs something like
> > the appended patch.
>
> Does it only misbehave on an x86 config or also on a MIPS config?  I
> have no problems when building for DB1200.

Read the patch and you'll see what's going on.  Any non-MIPS config
gets broken.

- Dave


 
> > 
> > - Dave
> > 
> > 
> > --- g26.orig/drivers/usb/gadget/Kconfig	2008-09-15 12:10:22.000000000 -0700
> > +++ g26/drivers/usb/gadget/Kconfig	2008-09-15 12:10:06.000000000 -0700
> > @@ -490,7 +490,7 @@ config USB_GADGET_DUALSPEED
> >  
> >  config USB_PORT_AU1200OTG
> >  	boolean "AU1200 USB portmux control (On-The-Go support)"
> > -	depends on USB_GADGET_AU1200 || USB_EHCI_HCD || USB_OHCI_HCD
> > +	depends on USB_GADGET_AU1200 && (USB_EHCI_HCD || USB_OHCI_HCD)
> >  	default n
> >  	help
> >  	   The AU1200 and Au1200 USB device port can be used as either a host
> > 
> 
