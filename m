Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 02:53:47 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17909 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDYBxq>;
	Fri, 25 Apr 2003 02:53:46 +0100
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA11702;
	Thu, 24 Apr 2003 18:53:42 -0700
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: baitisj@evolution.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030424184817.B29809@mvista.com>
References: <20030424114832.O10148@luca.pas.lab>
	 <20030424121140.G28275@mvista.com> <20030424130459.P10148@luca.pas.lab>
	 <1051215131.511.659.camel@zeus.mvista.com>
	 <20030424184817.B29809@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051235666.29988.20.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Apr 2003 18:54:26 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-04-24 at 18:48, Jun Sun wrote:
> On Thu, Apr 24, 2003 at 01:12:11PM -0700, Pete Popov wrote:
> > 
> > > Here's another question:
> > 
> > > What are the goals of the AU1500 PCI auto config? Is it supposed to be a full
> > > implementation, or just enough to work with a PCI card? The reason I ask is
> > > that the DBAu1500 has only one PCI slot, so a simple implementation would
> > > normally suffice.
> > > 
> > > Restated: I don't know if the PCI auto config code was designed to work with
> > > all sorts of wacky PCI devices. I don't know if the intention of the code is to
> > > support the single PCI slot present on the DbAu1500 development board, or if it
> > > is supposed to be more flexible (and complicated). 
> > 
> > The MIPS pci auto should work fine with a single PCI bus and it _should_
> > be a full implementation. The code was ported from PPC some time ago,
> > but sub busses were not tested.  
> 
> That is not true.  pciauto has been working P2P bridges pretty much since day one.
> 
> Usually sub-bus not working is due to type 1 configuration not supported
> in pci ops, which is board-dependent code.
> 
> I took a brief look of au1x00 pci_ops and it appears it does not support type
> 1 configuration access.  See arch/mips/ddb5xxx/ddb5477/pci_ops.c for one
> example on how type 1 configuration being supported.

There is support for type 1 accesses in
arch/mips/au1000/common/pci_ops.c.  Maybe you were looking at the pb1000
pci routine which had limited pci bus support in an fpga. The Au1500 pci
routine does support type 1 accesses.

Pete
