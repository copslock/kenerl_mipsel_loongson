Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 22:21:36 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:56705
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225230AbTGVVV1>; Tue, 22 Jul 2003 22:21:27 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MLLJDB009291;
	Tue, 22 Jul 2003 23:21:19 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MLLHZf009284;
	Tue, 22 Jul 2003 23:21:17 +0200
Date: Tue, 22 Jul 2003 23:21:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030722212117.GB1660@linux-mips.org>
References: <20030721182002.GA28587@foobazco.org> <Pine.GSO.3.96.1030722212122.607D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030722212122.607D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 09:39:40PM +0200, Maciej W. Rozycki wrote:

> > sparc32 and sparc64 processors and systems are significantly
> > different.  For example, the SRMMU present in v8 CPUs is 100% replaced
> > with a totally different MMU (indeed, totally different instructions,
> > access methods, etc) in v9.  Accordingly there is very little code in
> > common between the two ports, and most of that is in device handling;
> > code that is in drivers/sbus and thus shared anyway.
> 
>  Well, the MMU of (original) 32-bit MIPS processors (i.e. R2k/R3k) is
> completely different from the one in later ones, too.  I suspect this is
> true for the R6k as well.  The exception handlers differ a bit as well,
> especially considering the XTLB refill one.  That probably counts as
> nitpicking, though... 

It's also a question of taste - and that one can be discussed forever.
How far do you want to factor our common code, as little as possible
which was our previous approach or extremly aggressive, glibc-like.

And yes, the R6000 is different.  With that in mind R2000 and R4000 look
like enzygotic twins ...

> > Something that made sense for sparc might not make sense for mips.
> 
>  Certainly it needs to be analysed on a case by case basis, avoiding
> blanket assumptions.  Anyway, I still see two reasons for having at least
> a separate top-level directory:
> 
> 1. A better separation of the more straightforward 32-bit Makefile and the
> more complicated 64-bit one.
> 
> 2. A better visual existence of the 64-bit port; not really a technical
> advantage, but more a psychological one.  It stops any newcomer wondering
> whether we support 64-bit systems natively or not. 

I was thinking about that also.  arch/mips64 and include/asm-mips64 will
go away but on the other side there will be an option to configure a
64-bit kernel in the menus - which will hopefully be more visible than
just two subdirectories.

>  There is also no point in having headers in asm-mips consisting of a
> single #ifdef CONFIG_MIPS32/#else/#endif conditional, where two distinct
> versions should be present in asm-mips and asm-mips64, respectively.  It's
> easier to make a diff between such separate implementations to verify
> everything's OK. 

Like 80% of the headers could be identical between both files without
lots of trickery.  The current approach is have two physical copies of
these identical files.

Btw, an old experience repeats - some of the code was identical except
inline assembler using addu etc. for 32-bit and daddu etc. for 64-bit.
I rewrote that stuff to use C for this arithmetic.  The result - less
inline assembler, more readable code and a file that's identical for
both 32-bit and 64-bit.

  Ralf
