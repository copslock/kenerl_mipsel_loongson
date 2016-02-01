Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 13:50:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45342 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011480AbcBAMuXCoDil (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 13:50:23 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 27B97F7364CD5;
        Mon,  1 Feb 2016 12:50:15 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 1 Feb 2016
 12:50:16 +0000
Date:   Mon, 1 Feb 2016 12:50:16 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Milko Leporis <milko.leporis@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix buffer overflow in syscall_get_arguments()
In-Reply-To: <20160201115036.GB32210@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1602011236500.15885@tp.orcam.me.uk>
References: <1453753923-26620-1-git-send-email-james.hogan@imgtec.com> <alpine.DEB.2.00.1601312327590.5958@tp.orcam.me.uk> <20160201115036.GB32210@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 1 Feb 2016, James Hogan wrote:

> > > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> > > index 6499d93ae68d..47bc45a67e9b 100644
> > > --- a/arch/mips/include/asm/syscall.h
> > > +++ b/arch/mips/include/asm/syscall.h
> > > @@ -101,10 +101,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
> > >  	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
> > >  	if ((config_enabled(CONFIG_32BIT) ||
> > >  	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
> > > -	    (regs->regs[2] == __NR_syscall)) {
> > > +	    (regs->regs[2] == __NR_syscall))
> > >  		i++;
> > > -		n++;
> > > -	}
> > >  
> > >  	while (n--)
> > >  		ret |= mips_get_syscall_arg(args++, task, regs, i++);
> > 
> >  What I think it really needs to do is to *decrease* the number of 
> > arguments, as we're throwing the syscall number away as not an argument to 
> > itself.  So this looks like a typo to me, the expression was meant to be 
> > `n--' rather than `n++'.  With the number of arguments unchanged, as in 
> > your proposed change, we're still reaching one word too far.
> 
> No, the caller asked for n args, thats what it should get. It doesn't
> care whether the syscall was indirected or not.
> 
> The syscall doesn't have 1 less arg as a result of indirection. E.g.
> What about system calls with 6 arguments, and hence 7 arguments
> including syscall number argument when redirected? We'd get an
> uninitialised 6th arg back when passing n=6.

 Do you mean the caller ignores the extra argument holding the number of 
the wrapped syscall in counting syscall arguments?  Where does it take `n' 
from?

> Note scall32-o32.S sys_syscall shifts 7 arguments starting at a1 (I've
> reordered code slightly):
> 	move	a0, a1				# shift argument registers
> 	move	a1, a2
> 	move	a2, a3
> 	lw	a3, 16(sp)
> 	lw	t4, 20(sp)
> 	lw	t5, 24(sp)
> 	lw	t6, 28(sp)
> 
> 	sw	a0, PT_R4(sp)			# .. and push back a0 - a3, some
> 	sw	a1, PT_R5(sp)			# syscalls expect them there
> 	sw	a2, PT_R6(sp)
> 	sw	a3, PT_R7(sp)
> 	sw	t4, 16(sp)
> 	sw	t5, 20(sp)
> 	sw	t6, 24(sp)
> 
> So it takes args 0..2 from a1..a3, and 3..6 from stack.

 Sure, no need to explain it as far as I'm concerned, I didn't question 
it.

  Maciej
