Received:  by oss.sgi.com id <S553841AbQLSSjz>;
	Tue, 19 Dec 2000 10:39:55 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:40692 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553829AbQLSSjl>;
	Tue, 19 Dec 2000 10:39:41 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBJIZGx06141;
	Tue, 19 Dec 2000 10:35:16 -0800
Message-ID: <3A3FAB2B.35F0148E@mvista.com>
Date:   Tue, 19 Dec 2000 10:38:35 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET in sys_sysmips()
References: <Pine.GSO.3.96.1001219140739.10024F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:
> 
> On Mon, 18 Dec 2000, Jun Sun wrote:
> 
> > It looks like sometime after test5 the MIPS_ATOMIC_SET case in sys_sysmips()
> > function in the CVS tree is changed.  The new code now uses ll/sc instructions
> > and handles syscall trace, etc..
> >
> > This change does not make sense to me.  The userland typically uses
> > MIPS_ATOMIC_SET when ll/sc instructions are not available.  But the new code
> > itself uses ll/sc, which pretty much forfeit the purpose.  Or do I miss
> > something else?
> 
>  There is no problem with using ll/sc in sysmips() itself for machines
> that support them.
> 

Sure - but with ll/sc available the user programs don't need to issue
sysmip(MIPS_ATOMIC_SET,...) at the first place ...

> > What do we offer to machines without ll/sc?
> 
>  I asked Ralf for a clarification of the sysmips(MIPS_ATOMIC_SET, ...)
> call before I write better code.  No response so far.  I'm now really
> cosidering implementing the Ultrix atomic_op() syscall -- at least it has
> a well-known defined behaviour.
>

Where can I find the definitino of atomic_op()?  Or can you tell us a little
more about it? 

> > BTW, what is the wrong with previous code?  I understand it may be broken in
> > SMP case, but I think that is fixable.  Comments?
> 
>  The previous code was definitely broken -- depending on the path taken it
> would return either the value fetched from memory or an error code.  No
> way to distinguish between them.
>

I notice that.  I notice glibc is the only "customer" of the MIPS_SET_ATOMIC
call, the bug does not appear to be a big deal because error should not
happen.  Of course, it will be nice to fix it.

Jun
