Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G79q915574
	for linux-mips-outgoing; Thu, 16 Aug 2001 00:09:52 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G79oj15570
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:09:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28653;
	Thu, 16 Aug 2001 00:09:08 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA13758;
	Thu, 16 Aug 2001 00:09:09 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7G77ma05129;
	Thu, 16 Aug 2001 09:07:49 +0200 (MEST)
Message-ID: <3B7B7143.AFAF1ABF@mips.com>
Date: Thu, 16 Aug 2001 09:07:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-mips@oss.sgi.com
Subject: Re: FP emulator patch
References: <3B7A70B8.ED92FE4@mips.com> <20010815110634.A19305@nevyn.them.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:

> On Wed, Aug 15, 2001 at 02:53:12PM +0200, Carsten Langgaard wrote:
> > There has been some reports regarding FP emulator failures, which the
> > attached patch should solve.
> > The patch include a fix for emulation of instructions in a COP1
> > delay-slot, a fix for FP context switching and some additional stuff ,
> > which was needed to pass our torture test.
> >
> > Ralf could you please apply this patch.
>
> Two comments, especially since parts of this seem to be the patch I
> posted here over a month ago.

You are absolutely right, it's your old patch.

>
> > Index: linux/arch/mips/kernel/signal.c
>
> > @@ -353,12 +355,11 @@
> >       owned_fp = (current == last_task_used_math);
> >       err |= __put_user(owned_fp, &sc->sc_ownedfp);
> >
> > -     if (current->used_math) {       /* fp is active.  */
> > +     if (owned_fp) { /* fp is active.  */
> >               set_cp0_status(ST0_CU1);
> >               err |= save_fp_context(sc);
> >               last_task_used_math = NULL;
> >               regs->cp0_status &= ~ST0_CU1;
> > -             current->used_math = 0;
> >       }
> >
> >       return err;
>
> This is absolutely not right.  It's righter than the status quo.  If we
> don't own the FP, you don't save the FP.  Then we can use FP in the
> signal handler, corrupting the process's original floating point
> context.

You are probably right, this is not a proper fix, but at least it solves the problems people
has been seeing.
So until we come up with a better fix, this is still better than the current sources.

>
> > Index: linux/include/asm-mips/processor.h
>
> > @@ -235,8 +215,8 @@
> >   * Do necessary setup to start up a newly executed thread.
> >   */
> >  #define start_thread(regs, new_pc, new_sp) do {                              \
> > -     /* New thread looses kernel privileges. */                      \
> > -     regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
> > +     /* New thread loses kernel and FPU privileges. */               \
> > +        regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
> >       regs->cp0_epc = new_pc;                                         \
> >       regs->regs[29] = new_sp;                                        \
> >       current->thread.current_ds = USER_DS;                           \
>
> I could be misremembering, but I believe that Ralf said this should be
> unnecessary and the problem was somewhere else.  On the other hand, I
> still think it's a good idea.
>
> --
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
