Received:  by oss.sgi.com id <S553850AbRBITIS>;
	Fri, 9 Feb 2001 11:08:18 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:64497 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553847AbRBITII>;
	Fri, 9 Feb 2001 11:08:08 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f19J4S812503;
	Fri, 9 Feb 2001 11:04:28 -0800
Message-ID: <3A84400E.82CEA4B@mvista.com>
Date:   Fri, 09 Feb 2001 11:07:58 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: irq.c
References: <3A843C2D.525643E7@mvista.com> <0102091101190P.01909@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
> On Fri, 09 Feb 2001, Pete Popov wrote:
> > There's a dozen copies of "irq.c", and a few more files that do the same
> > thing but are named differently. The irq.c in arch/mips/kernel doesn't
> > seem to be used by any system.  The PowerPC also has lots of variants
> > also, but I believe they have a single irq.c file that all systems use.
> > So I guess my question is, is anyone using arch/mips/kernel/irq.c, and
> > does everyone plan on moving to that file (which seems like the right
> > thing to do).
> >
> 
> I've noticed that arch/i386/kernel/irq.c has this note on it:
> 
> /*
>  * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
>  *
>  * IRQs are in fact implemented a bit like signal handlers for the kernel.
>  * Naturally it's not a 1:1 relation, but there are similarities.
>  */
> 
> My internal code uses this as a template, in anticipation of this move;
> assuming this will happen in 2.5, does it make sense to do an intermediate move
> to a common mips/kernel/irq.c?
> 
> If it does, I'd like to see mips/kernel/irq.c updated to more closely match the
> i386 version, but I'm curious what other people think.

Thanks for pointing that out.  If all architectures will move to
kernel/irq.c, then it probably makes sense to wait.  At first glance,
mips/kernel/irq.c seems pretty close to i386/kernel/irq.c -- certainly a
lot closer than many of the other copies.  

Pete
