Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 20:43:30 +0000 (GMT)
Received: from mail.qarbon.com ([IPv6:::ffff:66.151.148.199]:14790 "EHLO
	eagle.qarbon.com") by linux-mips.org with ESMTP id <S8225428AbVAGUnY>;
	Fri, 7 Jan 2005 20:43:24 +0000
Received: (qmail 1812 invoked by uid 210); 7 Jan 2005 20:43:17 +0000
Received: from 216.217.36.130 by mail (envelope-from <ilya@total-knowledge.com>, uid 201) with qmail-scanner-1.23st 
 (perlscan: 1.23st.  
 Clear:RC:0(216.217.36.130):. 
 Processed in 0.030015 secs); 07 Jan 2005 20:43:17 -0000
Received: from unknown (HELO ?10.0.15.99?) (ilya@216.217.36.130)
  by 192.168.2.15 with AES256-SHA encrypted SMTP; 7 Jan 2005 20:43:16 +0000
Message-ID: <41DEF45B.8060800@total-knowledge.com>
Date: Fri, 07 Jan 2005 12:43:07 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: ths@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
References: <20050107191947Z8225432-1341+49@linux-mips.org>
In-Reply-To: <20050107191947Z8225432-1341+49@linux-mips.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

ths@linux-mips.org wrote:

>CVSROOT:	/home/cvs
>Module name:	linux
>Changes by:	ths@ftp.linux-mips.org	05/01/07 19:19:40
>
>Modified files:
>	arch/mips/kernel: signal.c signal_n32.c 
>Added files:
>	arch/mips/kernel: signal-common.h 
>
>Log message:
>	Save a bit of copy&paste by separating out common parts in the signal handling.
>
>  
>
Seems like following piece is missing from this patch:

Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.84
diff -u -r1.84 signal.c
--- arch/mips/kernel/signal.c   7 Jan 2005 19:19:40 -0000       1.84
+++ arch/mips/kernel/signal.c   7 Jan 2005 20:40:02 -0000
@@ -155,51 +155,6 @@
        return do_sigaltstack(uss, uoss, usp);
 }

-int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
-{
-       int err = 0;
-
-       /* Always make any pending restarted system calls return -EINTR */
-       current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
-       err |= __get_user(regs->cp0_epc, &sc->sc_pc);
-       err |= __get_user(regs->hi, &sc->sc_mdhi);
-       err |= __get_user(regs->lo, &sc->sc_mdlo);
-
-#define restore_gp_reg(i) do {                                         \
-       err |= __get_user(regs->regs[i], &sc->sc_regs[i]);              \
-} while(0)
-       restore_gp_reg( 1); restore_gp_reg( 2); restore_gp_reg( 3);
-       restore_gp_reg( 4); restore_gp_reg( 5); restore_gp_reg( 6);
-       restore_gp_reg( 7); restore_gp_reg( 8); restore_gp_reg( 9);
-       restore_gp_reg(10); restore_gp_reg(11); restore_gp_reg(12);
-       restore_gp_reg(13); restore_gp_reg(14); restore_gp_reg(15);
-       restore_gp_reg(16); restore_gp_reg(17); restore_gp_reg(18);
-       restore_gp_reg(19); restore_gp_reg(20); restore_gp_reg(21);
-       restore_gp_reg(22); restore_gp_reg(23); restore_gp_reg(24);
-       restore_gp_reg(25); restore_gp_reg(26); restore_gp_reg(27);
-       restore_gp_reg(28); restore_gp_reg(29); restore_gp_reg(30);
-       restore_gp_reg(31);
-#undef restore_gp_reg
-
-       err |= __get_user(current->used_math, &sc->sc_used_math);
-
-       preempt_disable();
-
-       if (current->used_math) {
-               /* restore fpu context if we have used it before */
-               own_fpu();
-               err |= restore_fp_context(sc);
-       } else {
-               /* signal handler may have used FPU.  Give it up. */
-               lose_fpu();
-       }
-
-       preempt_enable();
-
-       return err;
-}
-
 #if PLAT_TRAMPOLINE_STUFF_LINE
 #define __tramp __attribute__((aligned(PLAT_TRAMPOLINE_STUFF_LINE)))
 #else
