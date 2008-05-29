Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:50:17 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:62128 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20044771AbYE2HbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 08:31:08 +0100
Received: from kirk.serum.com.pl ([213.77.9.205]:49652 "EHLO serum.com.pl")
	by lappi.linux-mips.net with ESMTP id S530701AbYE2CCR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2008 04:02:17 +0200
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4T21oev005696;
	Thu, 29 May 2008 04:01:50 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4T21nb3005692;
	Thu, 29 May 2008 03:01:49 +0100
Date:	Thu, 29 May 2008 03:01:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rdsandiford@googlemail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: Changing the treatment of the MIPS HI and LO registers
In-Reply-To: <87r6bm1ebd.fsf@firetop.home>
Message-ID: <Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl>
References: <87tzgj4nh6.fsf@firetop.home> <Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl>
 <87abib4d9t.fsf@firetop.home> <Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl>
 <87r6bm1ebd.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Richard,

 I do not feel like speaking for the whole MIPS/Linux community and
certainly not the maintainer.  I have thus added a couple of recipients to
the cc list as I fear gcc-patches does not reach exactly the right people
here.  Others may disagree with my thoughts expressed.

On Wed, 28 May 2008, Richard Sandiford wrote:

> >> I'm afraid they'll just have to use "x".  Although looking at it:
> >> 
> >>   - delay.h is just doing common-or-garden multiplication, albeit
> >>     with optional R4000 workaounds.  Why not just do them in C?
> >>     Can't you rely on GCC to work around the R4000 errata, now that we
> >>     have -mfix-r4000?
> >
> >  Which C type is correct to access the high 64 bits of the 128-bit result
> > of the multiplication on a 64-bit platform then?  Please note the piece of
> > code in question does not care about what the low 64 bits are -- a C
> > construct that ultimately expands to a multiplication followed by an
> > "mfhi" would be perfectly fine here.
> >
> >  The workaround only came in quite recently here and could be avoided if C
> > code was used of course -- don't get bothered with it.
> 
> After the patch, you can use:
> 
> ----------------------------------------------------------------------
> typedef unsigned int uint128_t __attribute__((mode(TI)));
> 
> uint64_t foo (uint64_t x, uint64_t y)
> {
>   return ((uint128_t) x * y) >> 64;
> }
> ----------------------------------------------------------------------
> 
> This doesn't work before the patch due to the lack of a movti instruction.
> We have *diti3_highpart patterns, but it looks like they haven't been
> used since combine started checking rtx_costs.
> 
> If the patch goes in, I'll add tests to make sure that this code
> continues to work without recourse to a libgcc function.  As a follow-on,
> I'll add proper TImode costs to rtx_costs, so that we take full advantage
> of the highpart instructions.  (This ought to avoid unnecessary moves.)

 OK, it is good to have a way to make use of some TImode functionality 
64-bit hardware provides, but it still does not provide a clean solution 
to the compatibility problem seen here.  While a construct like:

#if (__GNUC__ > 4) || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4)
[new wonderful TImode stuff]
#else
[old compatibility asm crap]
#endif

will certainly work, it is as ugly as you can get.  I am not sure I would 
be happy to see it in Linux, though obviously Ralf and the others may 
disagree.

> >  Is there absolutely no way to preserve the current asm semantics without
> > complicating the internals horribly?  I could imagine GCC could use some
> > other constraints internally that would refer to the HI and LO registers
> > explicitly and "h" and "l" could only be defined for asms -- I am not
> > enough of a GCC expert here, so I don't know if it makes sense, but it
> > would seem a reasonable idea to me.
> 
> I just don't think there is, sorry.  If you have:
> 
>    asm (... : "=h" (word1), "=l" (word2) : ...);
> 
> then there needs to be at least two separately-allocatable registers,
> each of which can hold word-sized values.  And if we have two such
> registers, the allocators will think they can use them for other things,
> including spill space.  Which brings us back to where we are now.

 I have just been wondering whether these can be defined as aliases to
halves of the "x" register or something like that.  Not as real registers
seen by the allocator.

  Maciej
