Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U8KbG04752
	for linux-mips-outgoing; Tue, 30 Oct 2001 00:20:37 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U8KP004746;
	Tue, 30 Oct 2001 00:20:25 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA19420;
	Tue, 30 Oct 2001 00:20:09 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02581;
	Tue, 30 Oct 2001 00:20:08 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f9U8K4a27880;
	Tue, 30 Oct 2001 09:20:06 +0100 (MET)
Message-ID: <3BDE62B4.BE7A1885@mips.com>
Date: Tue, 30 Oct 2001 09:20:04 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Alice Hennessy <ahennessy@mvista.com>
CC: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ralf@oss.sgi.com,
   ajob4me@21cn.com, linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp>
				<20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alice Hennessy wrote:

> Carsten Langgaard wrote:
>
> > This doesn't look right, you still need to enable the CU1 bit in the status register to let the FP
> > emulator kick-in.
> > FPU-less CPUs should take a coprocessor unusable exception on any floating-point instructions.
> > I have been running this on several FPU-less CPUs, and it works fine for me.
>
> Maybe the FPU-less CPUs you have been using define the CU1 bit as reserved
> or is unused (ignore on write, zero on read)? The TX3927 actually allows the setting of the CU1 bit.
> Have you seen
> a case where you need to set the CU1 bit for the emulation to kick-in?   I would think that the CU1
> bit should
> never be set to one for FPU-less CPUs.

You are right, you don't need to set the CU1 bit for the emulator to kick-in (you just need a
coprocessor unusable exception), sorry my mistake.
So generally I think we should use the check against a FPU present (mips_cpu.options & MIPS_CPU_FPU),
instead of the TX39XX specific fix.

>
> Alice
>
> >
> >
> > Actually there is a problem with this code on CPUs, which have a FPU. The problem is that a lot of
> > CPUs have a CP0 hazard of 4 nops, between setting the CU1 bit in the status register and executing
> > the first floating point instruction thereafter. It probably only a performance issue, because if
> > the setting of CU1 hasn't taken effect yet, then we get a coprocessor unusable exception and the
> > the exception handler will also set the CU1 bit.
> >
> > /Carsten
> >
> > Atsushi Nemoto wrote:
> >
> > > >>>>> On Fri, 26 Oct 2001 22:58:06 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
> > > nemoto> I have seen TX39 dead on "cfc1" insturuction if STATUS.CU1 bit
> > > nemoto> enabled.  Such codes were in arch/mips/kernel/process.c.
> > >
> > > So, please apply this patch to CVS for TX39XX support.
> > >
> > > I use CONFIG_CPU_TX39XX in this patch, but I suppose other FPU-less
> > > CPUs may need this also.
> > >
> > > Does anybody know how about on other CPUs?
> > >
> > > diff -u linux-sgi-cvs/arch/mips/kernel/process.c linux.new/arch/mips/kernel/
> > > --- linux-sgi-cvs/arch/mips/kernel/process.c    Mon Oct 22 10:29:56 2001
> > > +++ linux.new/arch/mips/kernel/process.c        Mon Oct 29 15:49:37 2001
> > > @@ -57,6 +57,12 @@
> > >  {
> > >         /* Forget lazy fpu state */
> > >         if (last_task_used_math == current) {
> > > +#ifdef CONFIG_CPU_TX39XX
> > > +               if (!(mips_cpu.options & MIPS_CPU_FPU)) {
> > > +                       last_task_used_math = NULL;
> > > +                       return;
> > > +               }
> > > +#endif
> > >                 set_cp0_status(ST0_CU1);
> > >                 __asm__ __volatile__("cfc1\t$0,$31");
> > >                 last_task_used_math = NULL;
> > > @@ -67,6 +73,12 @@
> > >  {
> > >         /* Forget lazy fpu state */
> > >         if (last_task_used_math == current) {
> > > +#ifdef CONFIG_CPU_TX39XX
> > > +               if (!(mips_cpu.options & MIPS_CPU_FPU)) {
> > > +                       last_task_used_math = NULL;
> > > +                       return;
> > > +               }
> > > +#endif
> > >                 set_cp0_status(ST0_CU1);
> > >                 __asm__ __volatile__("cfc1\t$0,$31");
> > >                 last_task_used_math = NULL;
> > > ---
> > > Atsushi Nemoto
> >
> > --
> > _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
