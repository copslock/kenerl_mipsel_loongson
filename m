Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J6rNnC008947
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 23:53:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J6rNqN008946
	for linux-mips-outgoing; Tue, 18 Jun 2002 23:53:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J6qonC008933
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 23:52:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id XAA19374;
	Tue, 18 Jun 2002 23:55:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA20785;
	Tue, 18 Jun 2002 23:55:26 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5J6tQb25482;
	Wed, 19 Jun 2002 08:55:27 +0200 (MEST)
Message-ID: <3D102ADD.71178636@mips.com>
Date: Wed, 19 Jun 2002 08:55:26 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Louis Hamilton <hamilton@redhat.com>, linux-mips@oss.sgi.com,
   sandcraft-elinux-project@redhat.com
Subject: Re: Bug in Linux?  fcr31 not being saved-restored
References: <3D0BD42E.20602@redhat.com> <3D0D7F98.566B3176@mips.com> <3D0E38E8.10804@mvista.com> <3D0EEA5A.1B5DAA23@mips.com> <3D0F7213.6000002@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

> Your first chunk is not clear as to where it applies.  Maybe you are using a
> different code base.

Here is my do_cpu handler:

asmlinkage void do_cpu(struct pt_regs *regs)
{
        unsigned int cpid;
        extern void lazy_fpu_switch(void *);
        extern void save_fp(struct task_struct *);
        extern void init_fpu(void);
        void fpu_emulator_init_fpu(void);
        int sig;

        cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
        if (cpid != 1)
                goto bad_cid;

        if (!(mips_cpu.options & MIPS_CPU_FPU))
                goto fp_emul;

        regs->cp0_status |= ST0_CU1;
        if (last_task_used_math == current)
                return;

        if (current->used_math) {               /* Using the FPU again.  */
                lazy_fpu_switch(last_task_used_math);
        } else {                                /* First time FPU user.  */
                if (last_task_used_math != NULL)
                {
                        __enable_fpu();
                        save_fp(last_task_used_math);
                        /* last_task_used_math loose fpu */
                        ((struct pt_regs *)(__KSTK_TOS(last_task_used_math) -
                                            sizeof(struct pt_regs)))->
                                cp0_status &= ~ST0_CU1;
                }
                init_fpu();
                current->used_math = 1;
        }
        last_task_used_math = current;

        return;

fp_emul:
        if (last_task_used_math != current) {
                if (!current->used_math) {
                        fpu_emulator_init_fpu();
                        current->used_math = 1;
                }
        }
        sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
        last_task_used_math = current;
        if (sig)
        {
                /*
                 * Return EPC is not calculated in the FPU emulator, if
                 * a signal is being send. So we calculate it here.
                 */
                compute_return_epc(regs);
                force_sig(sig, current);
        }
        return;

bad_cid:
#ifndef CONFIG_CPU_HAS_LLSC
        switch (mips_cpu.cputype) {
        case CPU_TX3927:
        case CPU_TX39XX:
                do_ri(regs);
                return;
        }
#endif
        compute_return_epc(regs);
        force_sig(SIGILL, current);
}


>
> The second chunck is not necessary.  Although the FPU values in thread struct
> for the new thread are stale, the new program cannot assume the fpu register
> values and cannot use them without initialization anyway.

At least with the do_cpu handler above, you need this.
I'm not sure which tests failed without this, but I think it was some of the gcc selftests
and I think the problem was, that a thread inherited the previous thread's fsr (floating
point status register).

>
> I don't see such a code in x86's code.  Current call to start_thread() is ok
> with or without this change.  I am afraid future use of start_thread() may
> give undesired effect after we make this change.

Why ?

>
> As for the new fpu context switch code, I wrote a experiemental patch after
> much discussion with Ralf and Kevin.  It is at
>
> http://linux.junsun.net/patches/oss.sgi.com/experimental/020304-half-fpu-context-switch
>
> I also did some performance study of this patch.  Did not get much feedbacks
> when I asked last time. :-(
>
> Jun
>
> Carsten Langgaard wrote:
>
> > I believe this is the patch that solve the problem.
> > The lazy fpu stuff has cause so many problems, that we have decided (together
> > with Ralf) to get rid of it, and do the FPU context save and restore a little bit
> > differently.
> > We now have a solution here locally and we are testing it at the moment.
> >
> > /Carsten
> >
> >
> > Index: arch/mips/kernel/traps.c
> > ===================================================================
> > RCS file: /cvs/linux/arch/mips/kernel/traps.c,v
> > retrieving revision 1.99.2.14
> > diff -u -r1.99.2.14 traps.c
> > --- arch/mips/kernel/traps.c    2002/05/28 06:33:13     1.99.2.14
> > +++ arch/mips/kernel/traps.c    2002/06/18 07:53:47
> > +               {
> > +                       __enable_fpu();
> >                         save_fp(last_task_used_math);
> > +                       /* last_task_used_math loose fpu */
> > +                       ((struct pt_regs *)(__KSTK_TOS(last_task_used_math) -
> > +                                           sizeof(struct pt_regs)))->
> > +                               cp0_status &= ~ST0_CU1;
> > +               }
> >
> > Index: include/asm-mips/processor.h
> > ===================================================================
> > RCS file: /cvs/linux/include/asm-mips/processor.h,v
> > retrieving revision 1.43.2.2
> > diff -u -r1.43.2.2 processor.h
> > --- include/asm-mips/processor.h        2002/05/28 06:11:56     1.43.2.2
> > +++ include/asm-mips/processor.h        2002/06/18 07:56:58
> > @@ -215,6 +215,7 @@
> >         regs->cp0_epc = new_pc;                                         \
> >         regs->regs[29] = new_sp;                                        \
> >         current->thread.current_ds = USER_DS;                           \
> > +       current->used_math = 0;                                         \
> >  } while (0)
> >
> >  unsigned long get_wchan(struct task_struct *p);
> >
> >
> >
> > Jun Sun wrote:
> >
> >
> >>Carsten Langgaard wrote:
> >>
> >>
> >>>This is one of the bugs, among others, we have fixed.
> >>>I'm not sure, if Ralf have integrated the patches we send him yet.
> >>>
> >>>
> >>Carsten,
> >>
> >>Do you remember the cause and the fix?  It appears to me the first ctc1
> >>instruction should trap into kernel and mark current process as fpu owner, and
> >>should not cause fcr31 corruption.
> >>
> >>Or somehow the ctc1 does not trap into kernel?
> >>
> >>Jun
> >>
> >>
> >>>/Carsten
> >>>
> >>>Louis Hamilton wrote:
> >>>
> >>>
> >>>
> >>>>We have a customer here testing a 2.4.16 mips kernel on an embedded
> >>>>Linux RM7000/SR71000 based system who has written a test that they
> >>>>believe has uncovered a bug in Linux.  The FPU control register appears
> >>>>to not get saved and restored.  I've reproduced the problem described
> >>>>below and find the results consistent with their description.  The
> >>>>problem occurs on both the RM7000 and SR71000 cpus.
> >>>>
> >>>>It looks like save_fp_context and restore_fp_context are not being
> >>>>called since the kernel save-restore logic thinks the process is not
> >>>>using floating point math.  If you do some fp math before calling the
> >>>>test routine below, it seems to works fine.
> >>>>
> >>>>Is this a known caveat?  A true bug?  Or a contorted corner case
> >>>>unlikely to be seen under typical end-user usage (see customer's
> >>>>last paragraph :-) ?   If true bug, recommended remedy?
> >>>>
> >>>>TIA,
> >>>>Louis
> >>>>
> >>>>Louis Hamilton
> >>>>hamilton@redhat.com
> >>>>
> >>>>------ customer reports the following: ---------
> >>>>We found a bug in Linux.  A ^C (control-C) typed into a shell (or a
> >>>>running program, it doesn't matter), causes the FCR (floating-point
> >>>>control register) to be corrupted in another, unrelated process.  This
> >>>>is repeatable behavior.
> >>>>
> >>>>This can be reproduced with the following short assembly language
> >>>>program that loops forever, waiting for the FCR to change.
> >>>>
> >>>>       .align 2
> >>>>       .globl mips_float_debug_loop
> >>>>mips_float_debug_loop:
> >>>>       li      $9, 0xF000F02F
> >>>>       ctc1    $9, $31         # set FCR to some non-zero value
> >>>>       nop
> >>>>1:      cfc1    $8, $31         # get FCR
> >>>>       beq     $8, $9, 1b      # spin, waiting for FCR to change
> >>>>       nop
> >>>>       or      $2, $0, $8
> >>>>       jr    $31
> >>>>       nop
> >>>>
> >>>>You can call this function from a short C program and the return value
> >>>>is the (corrupted) FCR, which turns out to alwyas be: 0x00000002.
> >>>>
> >>>>Run the above loop in one window (connected to the board using telnet)
> >>>>and then in another window (connected to the same board) type ^C.
> >>>>
> >>>>I'm surprised this bug hasn't been encountered by other MIPS vendors.
> >>>>
> >>>><end>
> >>>>
> >>>--
> >>>_    _ ____  ___   Carsten Langgaard Mailto:carstenl@mips.com
> >>>|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> >>>| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >>>  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >>>                   Denmark           http://www.mips.com
> >>>
> >>>
> >>>
> >>>
> >>>
> >
> > --
> > _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark            http://www.mips.com
> >
> >
> >
> >

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
