Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 18:20:20 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52472 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225837AbUDURUT>;
	Wed, 21 Apr 2004 18:20:19 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3LHKDx6032428;
	Wed, 21 Apr 2004 10:20:13 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3LHKDCM032426;
	Wed, 21 Apr 2004 10:20:13 -0700
Date: Wed, 21 Apr 2004 10:20:13 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040421102013.F32072@mvista.com>
References: <20040420163230Z8225288-1530+99@linux-mips.org> <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org> <20040420153108.F22846@mvista.com> <Pine.LNX.4.55.0404211608570.28167@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0404211608570.28167@jurand.ds.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Apr 21, 2004 at 04:11:29PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 21, 2004 at 04:11:29PM +0200, Maciej W. Rozycki wrote:
> On Tue, 20 Apr 2004, Jun Sun wrote:
> 
> > > drivers/pci can do that, you just need to supply a few board specific
> > > functions, see for example arch/alpha/kernel/pci.c.  So pci_auto.c isn't
> > > only b0rked, it also duplicates code.
> > 
> > Has anybody succssfully used pci_assign_unassigned_resources() in latest 2.4?
> > It was badly broken in early 2.4 kernels while pci_auto was the only 
> > option.
> 
>  In that case, fixing pci_assign_unassigned_resources() was the right way
> to go, instead of implementing a system-specific workaround.  

Using pci_auto() represented a different approach, which to many seems more
correct.  It does assignment first and then scanning.  It is supplied
as a replacement for broken firmware.

At one time a couple of pci_auto()'s existed in more than one arch.  And
there was a chance to make this approach the official one and completely 
eliminate pci_assign_unassigned_resources().

Having competing approaches co-existing in Linux is a norm.

> There are no
> excuses -- the source is available.
> 

Please don't always assume other people are more ignorant ....

Jun
