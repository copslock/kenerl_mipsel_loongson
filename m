Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 20:40:54 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:48897 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdK3Tkqqpogr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Nov 2017 20:40:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 30 Nov 2017 19:40:39 +0000
Received: from [10.20.78.207] (10.20.78.207) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Thu, 30 Nov 2017
 11:38:37 -0800
Date:   Thu, 30 Nov 2017 19:38:25 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Dave Martin <Dave.Martin@arm.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
In-Reply-To: <20171130172839.GQ22781@e103592.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk> <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk> <20171130172839.GQ22781@e103592.cambridge.arm.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1512070838-298554-29173-151835-5
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187472
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Dave,

> > linux-mips-nt-prfpreg-count.diff
> > Index: linux-sfr-test/arch/mips/kernel/ptrace.c
> > ===================================================================
> > --- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-21 22:12:00.000000000 +0000
> > +++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-21 22:13:13.471970000 +0000
> > @@ -484,7 +484,7 @@ static int fpr_set_msa(struct task_struc
> >  	int err;
> >  
> >  	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
> > -	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
> > +	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> > 
> >  		err = user_regset_copyin(pos, count, kbuf, ubuf,
> >  					 &fpr_val, i * sizeof(elf_fpreg_t),
> >  					 (i + 1) * sizeof(elf_fpreg_t));
> 
> But mips*_regsets[REGSET_FPR].size == sizeof(elf_fpreg_t),
> linux/kernel/regset.c:ptrace_regset() polices
> iov_len % regset->size == 0, and each user_regset_copyout() call here
> transfers sizeof(elf_fpreg_t) bytes, decrementing *count by that
> amount unless something goest wrong in which case we return.

 Good point, I missed that check.

 I don't think however that re-enforcing in arch code, especially in such 
a subtle way, a constraint that has already been enforced upstream in 
generic code is a good idea, because if we ever decide to relax the 
constraint, then all the arch code will have to be carefully reviewed.

> If we can't end up with that, then this patch doesn't change ABI-
> observable behaviour, unless I've missed something.

 Right, in which case there is no need to backport this change if it is 
given a go-ahead.

> If we can end up with that somehow, then this patch reintroduces the
> issue d614fd58a283 aims to fix, whereby fpr_val can contain
> uninitialised kernel stack which userspace can then obtain via
> PTRACE_GETREGSET.

 That wasn't actually clarified in the referred commit's description, 
which it should in the first place, and I wasn't able to track down any 
review of your change as submitted, which would be the potential second 
source of such support information.  The description isn't even correct, 
as it states that if a short buffer is supplied, then the old values held 
in thread's registers are preserved, which clearly isn't correct as 
individual registers do get written from the beginning of the regset up to 
the point no more data is available to fill a whole register.

 You are of course right about the (partially) uninitialised variable, and 
I think there are two ways to address it:

1. By preinitialising it, i.e.:

	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
		err = user_regset_copyin(pos, count, kbuf, ubuf,
					 &fpr_val, i * sizeof(elf_fpreg_t),
					 (i + 1) * sizeof(elf_fpreg_t));
		if (err)
			return err;
		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
	}

   but that would be an overkill given that we assert that `count' is a 
   multiple of `sizeof(elf_fpreg_t)'.

2. Actually assert what we rely on having been enforced by generic code, 
   i.e.:

	BUG_ON(*count % sizeof(elf_fpreg_t));
	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
		err = user_regset_copyin(pos, count, kbuf, ubuf,
					 &fpr_val, i * sizeof(elf_fpreg_t),
					 (i + 1) * sizeof(elf_fpreg_t));
		if (err)
			return err;
		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
	}

   so that a discrepancy between generic code and the arch handler is 
   caught should it happen.

 Thoughts?

  Maciej
