Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G01aT04629
	for linux-mips-outgoing; Wed, 15 Aug 2001 17:01:36 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G01Xj04612
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 17:01:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id RAA26098;
	Wed, 15 Aug 2001 17:01:20 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id RAA08229;
	Wed, 15 Aug 2001 17:01:18 -0700 (PDT)
Message-ID: <010001c125e7$35ca2d80$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>,
   "Carsten Langgaard" <carstenl@mips.com>
Cc: <linux-mips@oss.sgi.com>
References: <3B7A70B8.ED92FE4@mips.com> <20010815110634.A19305@nevyn.them.org>
Subject: Re: FP emulator patch
Date: Thu, 16 Aug 2001 02:05:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Two comments, especially since parts of this seem to be the patch I
> posted here over a month ago.
> 
> > Index: linux/arch/mips/kernel/signal.c
> 
> > @@ -353,12 +355,11 @@
> >  owned_fp = (current == last_task_used_math);
> >  err |= __put_user(owned_fp, &sc->sc_ownedfp);
> >  
> > - if (current->used_math) { /* fp is active.  */
> > + if (owned_fp) { /* fp is active.  */
> >  set_cp0_status(ST0_CU1);
> >  err |= save_fp_context(sc);
> >  last_task_used_math = NULL;
> >  regs->cp0_status &= ~ST0_CU1;
> > - current->used_math = 0;
> >  }
> >  
> >  return err;
> 
> This is absolutely not right.  It's righter than the status quo.  If we
> don't own the FP, you don't save the FP.  Then we can use FP in the
> signal handler, corrupting the process's original floating point
> context.

I only worked on the FP branch emulation fix, and hadn't looked
at the stack signal context problem until now.   If the current thread
has any FPU state, it needs to be saved ahead of signal delivery
for the reasons you suggest above.  I assume that's the reason
for the previous "if (current->used_math)" condition.  If there's
been a problem with FP register corruption in the face of signals
and context switches, it's presumably because, while we're
saving the state in the sigcontext so that it will be restored
on the signal return, we're also clearing last_task_used_math
and curren->used_math.  The former means that if
we invoke the signal handler, it returns, and we will restore the
FP context to the register file.  But if the signal handler 
*doesn't* do any FP, we've got a "dirty" FPU and no owner
for the state, and Bad Things happen.  And the way the current
code is written, if the signal handler does happen to acquire
the FPU, the thread inherits the enable, the register contents,
and an obligation to save the FPU state uselessly on the next
context switch.

I don't understand why there is any manipulation of the
FPU ownership status going on in setup_sigcontext(), nor 
any persistent modification of the Cp0.Status state.  
Shouldn't the code in setup_sigcontext() look more like:

    if(owned_fp) {
        /* Not clear to me how we could have owned_fp 
           true with CU1 off.  Double check this... */
        someaccursednewtemp = regs->cp0_status;
        set_cp0_status(ST0_CU1);
        err |= save_fp_context(sc);
        regs->cp0_status = someaccursednewtemp;
    }

Then, in the symmetric code fragment in restore_sigcontext()

    if(owned_fp) {
        err |= restore_fp_context(sc);
    } else {
        if (current == last_task_used_math) {
        /* signal handler acquired FPU - give it back */
            last_task_used_math = NULL;
            current->used_math = 0;
            clear_cp0_status(ST0_CU1);
        }
    }

Disclaimer:  The above was typed into Outlook Express
and may contain typos, but I think it expresses the idea
well enough for someone to tell me if I'm completely off
base.

            Regards,

            Kevin K.


 
