Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 22:37:12 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:11248 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224914AbUASWhM>;
	Mon, 19 Jan 2004 22:37:12 +0000
Received: from [10.2.2.30] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA09317;
	Mon, 19 Jan 2004 14:36:20 -0800
Subject: Re: au1100 usb support
From: Pete Popov <ppopov@mvista.com>
To: Bob Lees <bob@diamond.demon.co.uk>
Cc: linux-mips@linux-mips.org
In-Reply-To: <200401192239.02283.bob@diamond.demon.co.uk>
References: <200401191806.27381.bob@diamond.demon.co.uk>
	 <400BB003.8000605@mvista.com>  <200401192239.02283.bob@diamond.demon.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1074551771.3054.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Jan 2004 14:36:12 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2004-01-19 at 14:39, Bob Lees wrote:
> Correct assumption.  Thank you for the pointer, unfortunately both the usb 
> non-pci and zboot patches for 2.4.24 are only rw by the owner, there is no 
> world read access.  Can this be changed, pretty please:)

Done, thanks for pointing this out.

Pete

> 
> Thanks
> 
> Bob
> On Monday 19 January 2004 10:22, Pete Popov wrote:
> > Bob Lees wrote:
> > >OK I'm missing something somewhere
> > >
> > >I am trying to get the usb host controller to work on an AU1100 board (the
> > >Aurora board from DSP Design) and it isn't initialising the host
> > > controller.
> >
> > From looking at the usb host code it appears that the only interface
> > supported
> >
> > >is via pci, but this processor/board doesn't have pci.
> > >
> > >A previous kernel based on 2.4.17 had the concept of
> > > CONFIG_USB_NON_PCI_OHCI which appears to have disappeared.  This
> > > generated a pseudo pci interface.
> > >
> > >Help, any idea where I should be looking.
> >
> > I assume you're working with the linux-mips.org kernel?  Take a look at
> > the readme at ftp.linux-mips.org:/pub/linux/mips/people/ppopov.  You're
> > missing the usb non-pci patch.
> >
> > Pete
