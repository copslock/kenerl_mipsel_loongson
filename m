Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:29:38 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:5603 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1123397AbSJDN3h>;
	Fri, 4 Oct 2002 15:29:37 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g94DTTr09207;
	Fri, 4 Oct 2002 14:29:29 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id OAA12180;
	Fri, 4 Oct 2002 14:29:24 +0100 (BST)
Date: Fri, 4 Oct 2002 14:29:24 +0100 (BST)
Message-Id: <200210041329.OAA12180@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Carsten Langgaard <carstenl@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <3D9D855B.12128FA2@mips.com>
References: <3D9D484B.4C149BD8@mips.com>
	<200210041153.MAA12052@mudchute.algor.co.uk>
	<3D9D855B.12128FA2@mips.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Carsten Langgaard (carstenl@mips.com) writes:

> >  "PREF does not cause addressing-related exceptions. If it does happen
> >   to raise an exception condition, the exception condition is
> >   ignored. If an addressing-related exception condition is raised and
> >   ignored, no data movement occurs."
> 
> Is a bus error exception an address related exception ?

Yes.

I agree some MIPS documentation has been ambiguous on the
subject, probably because from the chip designer's point of view the
address is generated early and internally, and the data turns up
later.  It's ambiguous whether the BadVaddr register will be correctly
set on a bus error (it is on most Big MIPS CPUs, I believe).

But that's beside the point.  PREF should plainly never cause an
exception because of a bus error.

> I'm afraid some implementation think it's not.

That would be a bug.

So let's suppose you've got that bug.  And you've got a program
running in cacheable memory, and PREF wanders off the edge of the
region.

If you were running mapped, you surely wouldn't have a spurious
cacheable mapping to single-cycle memory...

In kseg0, you might step into a different physical address region.
It's good practice to reserve a 'guard' area of address space between
general memory and I/O registers, of course.  If the hardware doesn't
do it, maybe the software could, by simply refusing to allocate the
highest addressable 4Kbytes of memory for general purposes.

Some systems idly decode a cache refill in a non-memory region as one
or a sequence of reads, causing a bus error.

I count that as one CPU bug and two system misfeatures.  The solution,
I guess, is a "bogus bus error" handler.

> What about an UART RX register, we might loose a character ?

Yes, without a guard region and with cache refills cheerfully decoded
to bogus single-cycle reads, you can get bogus reads.  With a
careless-enough memory map, you might read something with a side
effect.  

> You can also configure you system, so you get a external interrupt
> from you system controller in case of a bus error, there is no way
> the CPU can relate this interrupt to the prefetching.

Yes, that's true; interrupts on bus errors are vaguely useful for
post-mortem diagnosis, but useless for recovery.

-- 
Dominic Sweetman, 
MIPS Technologies (UK) - formerly Algorithmics
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
