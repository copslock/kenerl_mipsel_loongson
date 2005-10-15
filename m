Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Oct 2005 10:20:23 +0100 (BST)
Received: from optima.cs.arizona.edu ([192.12.69.5]:16652 "EHLO
	optima.cs.arizona.edu") by ftp.linux-mips.org with ESMTP
	id S8133522AbVJOJUH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Oct 2005 10:20:07 +0100
Received: from lectura.CS.Arizona.EDU (lectura.cs.arizona.edu [192.12.69.186])
	by optima.cs.arizona.edu (8.13.4/8.13.4) with ESMTP id j9F9JwTP075865
	for <linux-mips@linux-mips.org>; Sat, 15 Oct 2005 02:19:58 -0700 (MST)
	(envelope-from bprasad@CS.Arizona.EDU)
Date:	Sat, 15 Oct 2005 02:19:58 -0700 (MST)
From:	Prasad Venkata Boddupalli <bprasad@CS.Arizona.EDU>
To:	linux-mips@linux-mips.org
Subject: Reg Hardware context and Signal Handlers 
Message-ID: <Pine.GSO.4.58.0510150154450.19178@lectura.CS.Arizona.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bprasad@CS.Arizona.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bprasad@CS.Arizona.EDU
Precedence: bulk
X-list: linux-mips

I am reading the program counter value from the hardware context passed as
the third argument to the signal handler. It doesn't seem to the same
value being set in setup_sigcontext() function in
arch/mips/kernel/signal.c.

I am using kernel version 2.6.6-rc3 and,

I printed out the PC twice, once in the kernel (signal.c)

#include <asm/ucontext.h>
setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs, ...) {
    ...

    regs->regs[ 5] = (unsigned long) &frame->rs_info;
    regs->regs[ 6] = (unsigned long) &frame->rs_uc;

    printk("SIG deliver pc=0x%llx\n",
          ((((struct ucontext *)regs->regs[6])->uc_mcontext).sc_pc));

    regs->regs[29] = (unsigned long) frame;
    ...

    force_sig(SIGSEGV, current)
}

Then I get the value 0x414830 repeatedly.

I print the same in my signal handler as


#include <asm/ucontext.h>
void dispatch_timer(int signal, siginfo_t * si, void *context) {
    ...

    printf ("pc value: 0x%llx\n",
        ((struct ucontext *)context)->uc_mcontext).sc_pc);

    ...
}

and I see a different value '0x7ff8000000000000'.

The values (addresses) of the third argument 'context' in my signal
handler is the same (as it must be) as 'regs->regs[6]' assigned just above
the print statement in setup_rt_frame().

I saw a few comments in the file sys/ucontext.h that read

/* Don't rely on this, the interface is currently messed up and may need
to be broken to be fixed.  */

So, I am not sure if those comments still hold good. I am anyway including
the header asm/ucontext.h and 'struct ucontext' seems to be different in
the two header files.

Does this problem sound familiar or am I screwing up something ?

regards,
Prasad.
