Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 19:05:00 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:60303 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225837AbUDUSE6>; Wed, 21 Apr 2004 19:04:58 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 16B694AEA0; Wed, 21 Apr 2004 20:04:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id E4B1447A40; Wed, 21 Apr 2004 20:04:50 +0200 (CEST)
Date: Wed, 21 Apr 2004 20:04:50 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20040421102013.F32072@mvista.com>
Message-ID: <Pine.LNX.4.55.0404211925270.28167@jurand.ds.pg.gda.pl>
References: <20040420163230Z8225288-1530+99@linux-mips.org>
 <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org>
 <20040420153108.F22846@mvista.com> <Pine.LNX.4.55.0404211608570.28167@jurand.ds.pg.gda.pl>
 <20040421102013.F32072@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 21 Apr 2004, Jun Sun wrote:

> >  In that case, fixing pci_assign_unassigned_resources() was the right way
> > to go, instead of implementing a system-specific workaround.  
> 
> Using pci_auto() represented a different approach, which to many seems more
> correct.  It does assignment first and then scanning.  It is supplied
> as a replacement for broken firmware.

 Well the Alpha port did resource management since its early days, due to
the complexity of Alpha setups (I'm pretty sure DEC was first to put
PCI-PCI bridges into their systems on a regular basis) and firmware
oddities (not necessarily due to brokenness but rather competing
assumptions, although there was an option to run MILO from the system
flash ROM and then the system wouldn't execute a lot of initialization
steps before passing control to Linux), like setting up I/O port
allocations above 0xffff, which would surprise some drivers.  That means
around 1995 or 1996.  So the code has been out there for a long time --
long enough to make any remaining problems resolved.

> At one time a couple of pci_auto()'s existed in more than one arch.  And
> there was a chance to make this approach the official one and completely 
> eliminate pci_assign_unassigned_resources().

 But if it didn't happen, then it means it was not the right approach.

> Having competing approaches co-existing in Linux is a norm.

 Well, it's normal for development series.  For stable series there's an
established way of doing stuff and port maintainers should migrate.  
Actually, there's a "feature freeze" point in the development series
(which you probably know) to let maintainers finish before a stable
release.  In reality it does not always happen as depending on various 
factors maintainers may have more or less resources available, but better 
or worse they work on eliminating obsolete cruft.

 I'm writing of in-tree development here -- people can do research on
alternatives off-tree, of course, including working and testing in stable
series.  If proved to be good, the results are typically merged in the
early days of development series.

> > There are no
> > excuses -- the source is available.
> 
> Please don't always assume other people are more ignorant ....

 This is insulting -- I never assume that.  One has to prove that to me
first.

 In cases like this, I've noticed the trend is to think: "Well, Linus[1]
is too tough to be convinced to accept arbitrary changes, so let's just
code our stuff independently and keep it with system-specific bits."  But 
as I wrote, code is available and you have two proper choices:

1. Fix what's wrong in the existing code.

2. Propose a superior alternative.

#1 may be easier and #2 may provide better results.  But it doesn't happen
-- I hardly ever hear any voice in discussions on the LKML from people
involved in developing for the MIPS platform.

[1] Substitute a subsystem maintainer as needed.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
