Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5AJZdnC026652
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 10 Jun 2002 12:35:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5AJZdXr026651
	for linux-mips-outgoing; Mon, 10 Jun 2002 12:35:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5AJZTnC026647
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 12:35:29 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id MAA09058;
	Mon, 10 Jun 2002 12:37:40 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA10598;
	Mon, 10 Jun 2002 12:37:41 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5AJbfb04195;
	Mon, 10 Jun 2002 21:37:41 +0200 (MEST)
Message-ID: <3D0500F6.333B7CA1@mips.com>
Date: Mon, 10 Jun 2002 21:41:42 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Bug in the _save_fp_context.
References: <3C46D2ED.9BCA458A@mips.com> <20020610114323.A25705@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Thu, Jan 17, 2002 at 02:34:37PM +0100, Carsten Langgaard wrote:
> > I posted the following problem on the list almost a year ago, but it
> > still hasn't made into the SGI CVS.
> > I think there is a bug in the _save_fp_context function in
> > arch/mips/kernel/r4k_fpu.S
> >
> > The problem is the following piece of code:
> >
> >  jr ra
> >  .set nomacro
> >  EX(sw t0,SC_FPC_EIR(a0))
> >  .set macro
> >
> > We do not handle entries in the __ex_table which is located in a branch
> > delay.
> > So we need to handle the situation where we take a page fault on an
> > instruction which is located in a brach delay slot, or we don't put the
> > "potential" faulting instruction in a delay slot.
> >
> > This situation probably doesn't generally hit people since it hasn't
> > been fix yet, but if you try run something nasty like Crashme, you will
> > get hit by this problem.
> > I suggest the following patch.
> >
> > /Carsten
> >
> >
> > --
> > _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark             http://www.mips.com
> >
> >
>
> > Index: arch/mips/kernel/r4k_fpu.S
> > ===================================================================
> > RCS file: /cvs/linux/arch/mips/kernel/r4k_fpu.S,v
> > retrieving revision 1.12
> > diff -u -r1.12 r4k_fpu.S
> > --- arch/mips/kernel/r4k_fpu.S        2001/04/11 05:19:46     1.12
> > +++ arch/mips/kernel/r4k_fpu.S        2002/01/17 14:21:09
> > @@ -50,11 +50,10 @@
> >       EX(sdc1 $f30,(SC_FPREGS+240)(a0))
> >       EX(sw   t1,SC_FPC_CSR(a0))
> >       cfc1    t0,$0                           # implementation/version
> > +     EX(sw   t0,SC_FPC_EIR(a0))
> >
> >       jr      ra
> > -     .set    nomacro
> > -      EX(sw  t0,SC_FPC_EIR(a0))
> > -     .set    macro
> > +      nop
> >       END(_save_fp_context)
> >
> >  /*
>
> Do we still need this patch for 2.4 on OSS?
>
> H.J.

No, this fix is not needed any more, as we now handle entries in the
__ex_table which is located in a branch delay.
