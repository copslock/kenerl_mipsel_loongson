Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 02:07:38 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:30338 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225272AbUDMBHh>;
	Tue, 13 Apr 2004 02:07:37 +0100
Received: from drow by nevyn.them.org with local (Exim 4.31 #1 (Debian))
	id 1BDCOi-0001yX-Va; Mon, 12 Apr 2004 21:07:33 -0400
Date: Mon, 12 Apr 2004 21:07:32 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: linux-mips@linux-mips.org, Eric Christopher <echristo@redhat.com>
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" intime.c
Message-ID: <20040413010732.GA7560@nevyn.them.org>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl> <20040412231309.GA702@linux-mips.org> <03f301c420e7$d8de2d70$8d01010a@prefect> <048e01c420f1$ad4ae3b0$8d01010a@prefect> <1081818125.19719.14.camel@dzur.sfbay.redhat.com> <04d501c420f3$6c836a30$8d01010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d501c420f3$6c836a30$8d01010a@prefect>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 12, 2004 at 09:05:34PM -0400, Bradley D. LaRonde wrote:
> ----- Original Message ----- 
> From: "Eric Christopher" <echristo@redhat.com>
> To: "Bradley D. LaRonde" <brad@laronde.org>
> Cc: <linux-mips@linux-mips.org>
> Sent: Monday, April 12, 2004 9:02 PM
> Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi"
> intime.c
> 
> 
> > On Mon, 2004-04-12 at 17:53, Bradley D. LaRonde wrote:
> > > Uh oh, with this patch:
> > >
> > > ...
> > > time.c: In function `fixed_rate_gettimeoffset':
> > > time.c:242: error: can't find a register in class `HI_REG' while
> reloading
> > > `asm'
> > > ...
> >
> > > >
> > > >         /*
> > > >          * Due to possible jiffies inconsistencies, we need to check
> > > > @@ -339,7 +339,7 @@
> > > >                                 : "r" (timerhi), "m" (timerlo),
> > > >                                   "r" (tmp), "r" (USECS_PER_JIFFY),
> > > >                                   "r" (USECS_PER_JIFFY_FRAC)
> > > > -                               : "hi", "lo", "accum");
> > > > +                               : "hi", "lo", "hi");
> > > >                         cached_quotient = quotient;
> >
> >
> > Maybe this hunk where you use "hi" twice for the same asm statement?
> 
> Yeah, that's messed up, but it fails here too:
> 
> @@ -242,7 +242,7 @@
>         __asm__("multu  %1,%2"
>                 : "=h" (res)
>                 : "r" (count), "r" (sll32_usecs_per_cycle)
> -               : "lo", "accum");
> +               : "lo", "hi");

Because the asm is outputting something in HI - see the =h?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
