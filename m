Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 02:48:23 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7156 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDYBsW>;
	Fri, 25 Apr 2003 02:48:22 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3P1mH029914;
	Thu, 24 Apr 2003 18:48:17 -0700
Date: Thu, 24 Apr 2003 18:48:17 -0700
From: Jun Sun <jsun@mvista.com>
To: Pete Popov <ppopov@mvista.com>
Cc: baitisj@evolution.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
Message-ID: <20030424184817.B29809@mvista.com>
References: <20030424114832.O10148@luca.pas.lab> <20030424121140.G28275@mvista.com> <20030424130459.P10148@luca.pas.lab> <1051215131.511.659.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051215131.511.659.camel@zeus.mvista.com>; from ppopov@mvista.com on Thu, Apr 24, 2003 at 01:12:11PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 24, 2003 at 01:12:11PM -0700, Pete Popov wrote:
> 
> > Here's another question:
> 
> > What are the goals of the AU1500 PCI auto config? Is it supposed to be a full
> > implementation, or just enough to work with a PCI card? The reason I ask is
> > that the DBAu1500 has only one PCI slot, so a simple implementation would
> > normally suffice.
> > 
> > Restated: I don't know if the PCI auto config code was designed to work with
> > all sorts of wacky PCI devices. I don't know if the intention of the code is to
> > support the single PCI slot present on the DbAu1500 development board, or if it
> > is supposed to be more flexible (and complicated). 
> 
> The MIPS pci auto should work fine with a single PCI bus and it _should_
> be a full implementation. The code was ported from PPC some time ago,
> but sub busses were not tested.  

That is not true.  pciauto has been working P2P bridges pretty much since day one.

Usually sub-bus not working is due to type 1 configuration not supported
in pci ops, which is board-dependent code.

I took a brief look of au1x00 pci_ops and it appears it does not support type
1 configuration access.  See arch/mips/ddb5xxx/ddb5477/pci_ops.c for one
example on how type 1 configuration being supported.

Jun
