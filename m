Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 19:28:59 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:56215
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225472AbTISS25>; Fri, 19 Sep 2003 19:28:57 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA06782
	for <linux-mips@linux-mips.org>; Fri, 19 Sep 2003 14:28:50 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA00927
	for <linux-mips@linux-mips.org>; Fri, 19 Sep 2003 14:28:50 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 19 Sep 2003 14:28:49 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <20030919174039.GK13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.44.0309191423200.773-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I've been trying to follow this discussion but I don't see the consensus.
Probably from my inexperience. Can someone summarize what works now, as
opposed to what should be done? Is
the solution the same for the 2.4kernel/gcc2.95 and the 2.6kernel/gcc3+?
Also are all of these comments appicable to little and big endian systems?
Thanks,
David Kesselring

On Fri, 19 Sep 2003, Thiemo Seufer wrote:

> Maciej W. Rozycki wrote:
> > On Fri, 19 Sep 2003, Thiemo Seufer wrote:
> >
> > > > > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > > > > Together with -mabi=64 this would produce optimized ELF64 output.
> > > >
> > > >  Hmm, what do you exactly mean -- is that what I am worrying about?
> > >
> > > The idea is to use the assembler's 32bit macro expansions for addresses.
> >
> >  So it is...
> >
> > > This reduces the .text size of a n64 kernel and improves the performance,
> > > without tricks like -Wa,32.
> >
> >  What if the final link leads to segments being mapped outside the 32-bit
> > address range?  We won't know about it when assembling.
>
> Then the resulting code is broken. It's the programmers responsibility
> to care about it. IMHO that's not a problem, this feature is only
> useful for kernels, and the tricks currently done there are worse.
>
> >  If the idea were to be implemented, there should be a flag added to the
> > header of object files that would forbid the linker to map addresses
> > outside the 32-bit range.
>
> Please don't add any header flag. An additional (.note?) section would
> be nice, but is not a priority for me.
>
>
> Thiemo
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
