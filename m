Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6R1W0i30295
	for linux-mips-outgoing; Thu, 26 Jul 2001 18:32:00 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6R1VxV30291
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 18:31:59 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA25151
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 18:31:43 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15PwG5-00026O-00; Thu, 26 Jul 2001 18:17:41 -0700
Date: Thu, 26 Jul 2001 18:17:41 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com, linux-alpha@sources.redhat.com
Subject: Re: [patch] fix profiling in glibc for Linux/MIPS
Message-ID: <20010726181740.A8070@nevyn.them.org>
References: <20010726103922.A6643@nevyn.them.org> <20010727024820.B27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010727024820.B27008@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Jul 27, 2001 at 02:48:20AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 27, 2001 at 02:48:20AM +0200, Thiemo Seufer wrote:
> Daniel Jacobowitz wrote:
> > _mcount was doing awful things to its caller's stack frame.
> 
> Maybe I'm missing something, but both the old and the new code
> add 8 byte more to sp than they subtracted before. How is this
> supposed to work?

It's supposed to do that, according to GCC.  Build something with -S
-pg and look at it.

> [snip]
> > I think this is close enough; it only adds
> > one instruction.  Is this OK?
> 
> Why do you save and restore $6, $7, seemingly without using them?

Because they were already there; I was trying to keep this patch
minimal.  My MIPS assembly knowledge, as I said, is a little scanty.

> > Do I need a "nop" after the subu?
> 
> It works here since it is expanded in an
> 
> 	addiu $29,$29,-40
> 
> which is executed in one cycle. The usual suspects for hazards
> to be NOPed are load/store insns and branches.

Ahh, OK.  I see.

> [snip]
> > +        "sw $31,20($29);" \
> >          "move $5,$31;" \
> >          "jal __mcount;" \
> >          "move $4,$1;" \
>             ^
> Some stylistic issue: In ".set noreorder" assembly it helps to
> indent the insns in a branch delay slot by one blank to avoid
> confusion about their non-sequential nature.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
