Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 23:31:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16881 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225525AbUDTWbK>;
	Tue, 20 Apr 2004 23:31:10 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3KMV8x6009780;
	Tue, 20 Apr 2004 15:31:08 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3KMV8ZX009778;
	Tue, 20 Apr 2004 15:31:08 -0700
Date: Tue, 20 Apr 2004 15:31:08 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040420153108.F22846@mvista.com>
References: <20040420163230Z8225288-1530+99@linux-mips.org> <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040420201128.GC24025@linux-mips.org>; from ralf@linux-mips.org on Tue, Apr 20, 2004 at 10:11:28PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 20, 2004 at 10:11:28PM +0200, Ralf Baechle wrote:
> On Tue, Apr 20, 2004 at 10:51:16AM -0700, Jun Sun wrote:
> 
> > CONFIG_PCI_AUTO was meant to a board attribute.  It should not be changed
> > to be a choice at the first place.
> > 
> > And, the code is not bOrked.  In 2.4 it is a life saver for most MIPS boards
> > whose firmware do not do a proper or full PCI resource assignment.
> 
> drivers/pci can do that, you just need to supply a few board specific
> functions, see for example arch/alpha/kernel/pci.c.  So pci_auto.c isn't
> only b0rked, it also duplicates code.
> 

Has anybody succssfully used pci_assign_unassigned_resources() in latest 2.4?
It was badly broken in early 2.4 kernels while pci_auto was the only 
option.

So at most you can only say "pci_assign_unassigned_resources() can
finally does what pci_auto does". :)

Jun
