Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2003 17:43:24 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5622 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225397AbTLRRnX>;
	Thu, 18 Dec 2003 17:43:23 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id hBIHhMY04282;
	Thu, 18 Dec 2003 09:43:22 -0800
Date: Thu, 18 Dec 2003 09:43:21 -0800
From: Jun Sun <jsun@mvista.com>
To: samavarthy c <samavarthy@hotmail.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: USB on MIPS
Message-ID: <20031218094321.A4146@mvista.com>
References: <BAY7-F37p6I65awhyxk00043bd8@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <BAY7-F37p6I65awhyxk00043bd8@hotmail.com>; from samavarthy@hotmail.com on Thu, Dec 18, 2003 at 07:58:36PM +0530
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Dec 18, 2003 at 07:58:36PM +0530, samavarthy c wrote:
> Hi,
> 
> I am working on a PDA based board which has a NEC MIPS VR4131
> processor.
> The board has a companion chip MediaQ 1132 which has OHCI support
> builtin.
> The kernel used is MontaVista HardHat 2.4.18. I am trying to configure
> MQ1132 for USB Host support. It looks like the Host controller
> (MQ1132) is initialized properly but not sure. When I plug in a USB
> stick on to the USB port, I get the following messages.
> -----------------------------------------------------------------
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb-ohci.c: unlink URB timeout
> usb.c: USB device not accepting new address=2 (error=-145)
> 
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb_control/bulk_msg: timeout
> usb-ohci.c: unlink URB timeout
> usb.c: USB device not accepting new address=3 (error=-145)
> -------------------------------------------------------------------
> Has anyone experienced the same out there. Could any one suggest how
> to debug this error. What could be the problem?.
> 

Another possiblity (which is probably more likely) is the IRQ
number is not seupt correctly.  

Are you using Rokchopper II baseboard?  If so, single-function
PCI card should work properly w.r.t. IRQ.  If you are using other
backplan or using multi-function pci card, you need to some IRQ
fixup.

Jun
