Received:  by oss.sgi.com id <S305160AbQDTQsJ>;
	Thu, 20 Apr 2000 09:48:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36654 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305157AbQDTQr6>; Thu, 20 Apr 2000 09:47:58 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA09674; Thu, 20 Apr 2000 09:52:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA37496
	for linux-list;
	Thu, 20 Apr 2000 09:40:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA30152
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 09:40:41 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02116
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 09:40:41 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA10773;
	Thu, 20 Apr 2000 09:40:42 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA17008;
	Thu, 20 Apr 2000 09:40:39 -0700 (PDT)
Message-ID: <011e01bfaae7$66747a20$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: Should send SIGFPE to .*
Date:   Thu, 20 Apr 2000 18:42:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>arch/mips/kernel/traps.c
>
>    354                 printk(KERN_DEBUG "Unimplemented exception for insn
%08x at 0x%08lx in %s.\n",
>    355                        insn, regs->cp0_epc, current->comm);
>    356                 simfp(insn);
>    357         }
>    358
>    359         if (compute_return_epc(regs))
>    360                 goto out;
>    361         //force_sig(SIGFPE, current);
>    362         printk(KERN_DEBUG "Should send SIGFPE to %s\n", current->comm);
>    363
>    364 out:
>    365         unlock_kernel();
>
>
>Might it be that compute_return_epc in branch.c does not support
>the mentioned instructions (FP instructions ?) and though can not
>calculate the correct epc ?


My previous response was a bit confused, because I was
looking at our already-modified code and reconstructing
the old logic.  Looking at the more-or-less-current 2.3
tree, I see the further bug to which you are referring.
There *should* be another goto following the simfp()
call.  The code that does the compute_return_epc()
followed by the force_sig(SIGFP) should be executed
in all cases where the emulator was not invoked,
which is to say in the cases of real FP exceptions,
but not if the mini-emulator has handled the situation.
Presumably, the absence of that bypass path was causing
bogus SIGFPE's, prompting someone to comment
out the force_sig() in all cases and add the printk(),
but that's not the correct behaviour.

The overall handler (MIPS version) looks like this:
(and yes, it still can be improved, as I mentioned earlier...)

/*
 * XXX Delayed fp exceptions when doing a lazy ctx switch XXX
 */
void do_fpe(struct pt_regs *regs, unsigned long fcr31)
{

#ifdef CONFIG_MIPS_FPU_EMULATOR
        if(!(mips_cpu.options & MIPS_CPU_FPU))
                panic("Floating Point Exception with No FPU");
#endif

#ifdef CONFIG_MIPS_FPE_MODULE
        if (fpe_handler != NULL) {
                fpe_handler(regs, fcr31);
                return;
        }
#endif

        lock_kernel();
        if (fcr31 & FPU_CSR_UNI_X) {
#ifdef CONFIG_MIPS_FPU_EMULATOR
                extern void r4xx0_save_fp(struct task_struct *);
                extern void r4xx0_restore_fp(struct task_struct *);
                int sig;
                /*
                 * Unimplemented operation exception.  If we've got the
                 * Full software emulator on-board, let's use it...
                 *
                 * Force FPU to dump state into task/thread context.
                 * We're moving a lot of data here for what is probably
                 * a single instruction, but the alternative is to
                 * pre-decode the FP register operands before invoking
                 * the emulator, which seems a bit extreme for what
                 * should be an infrequent event.
                 */
                r4xx0_save_fp(current);

                /* Run the emulator */
                sig = fpu_emulator_cop1Handler(0, regs);

                /* Restore the hardware register state */
                r4xx0_restore_fp(current);

                /* If something went wrong, signal */
                if(sig) {
                        force_sig(sig, current);
                }
#else
                /* Else use mini-emulator */

                extern void simfp(int);
                unsigned long pc;
                unsigned int insn;

                /* Retry instruction with flush to zero ...  */
                if (!(fcr31 & (1<<24))) {
                        printk("Setting flush to zero for %s.\n",
                               current->comm);
                        fcr31 &= ~FPU_CSR_UNI_X;
                        fcr31 |= (1<<24);
                        __asm__ __volatile__(
                                "ctc1\t%0,$31"
                                : /* No outputs */
                                : "r" (fcr31));
                        goto out;
                }
                pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);
                if(pc & 0x80000000) insn = *(unsigned int *)pc;
                else if (get_user(insn, (unsigned int *)pc)) {
                        /* XXX Can this happen?  */
                        force_sig(SIGSEGV, current);
                    }

                printk(KERN_DEBUG "Unimplemented exception for insn %08x at
0x%8lx in %s.\n",
                       insn, regs->cp0_epc, current->comm);
                simfp(MIPSInst(insn));
                compute_return_epc(regs);
#endif /* CONFIG_MIPS_FPU_EMULATOR */

                goto out;
        }

        if (compute_return_epc(regs)) {
                goto out;
        }
        force_sig(SIGFPE, current);
        printk(KERN_DEBUG "Sent SIGFPE to %s\n", current->comm);

out:
        unlock_kernel();
}
