Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 20:25:35 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:60762 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLFTZ1WAY76 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 20:25:27 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 19:25:14 +0000
Received: from [10.20.78.27] (10.20.78.27) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 6 Dec 2017 11:24:49 -0800
Date:   Wed, 6 Dec 2017 19:24:36 +0000
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
In-Reply-To: <20171201122356.GR22781@e103592.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1712061859120.4584@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk> <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk> <20171130172839.GQ22781@e103592.cambridge.arm.com> <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
 <20171201122356.GR22781@e103592.cambridge.arm.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1512588313-298552-12296-16495-5
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187690
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
X-archive-position: 61326
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

On Fri, 1 Dec 2017, Dave Martin wrote:

> >  You are of course right about the (partially) uninitialised variable, and 
> > I think there are two ways to address it:
> > 
> > 1. By preinitialising it, i.e.:
> > 
> > 	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> > 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
> > 		err = user_regset_copyin(pos, count, kbuf, ubuf,
> > 					 &fpr_val, i * sizeof(elf_fpreg_t),
> > 					 (i + 1) * sizeof(elf_fpreg_t));
> > 		if (err)
> > 			return err;
> > 		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> > 	}
> > 
> >    but that would be an overkill given that we assert that `count' is a 
> >    multiple of `sizeof(elf_fpreg_t)'.
> 
> Agreed.
> 
> Was a partial write to fscr ever supported by this regset?  Your commit
> message suggested that my patch may have broken that, but I can't see
> how it was ever possible in the first place... unless .size has been
> changed for this regset at some point.
> 
> If my patch does cause an ABI regression, then it certainly should be
> fixed though.

 I have looked into it some more, and I can see the upstream check:

	if (!regset || (kiov->iov_len % regset->size) != 0)
		return -EIO;

has always been there since the introduction of the regset feature, which 
was with commit 2225a122ae26 ("ptrace: Add support for generic 
PTRACE_GETREGSET/PTRACE_SETREGSET").  And the core file writer, i.e. 
`fill_thread_core_info', always operates on whole regsets by taking the 
size from the regset definition in question itself.

 Which means that my patch does not change the situation, but as far as 
security is concerned neither did yours, as you addressed an impossible 
case.  You did improve performance a bit though for the corner case 
situation of a partial regset access, by avoiding iterating over further 
FPRs with a call to `user_regset_copyin' once the requested transfer size 
has been exhausted.

> > 2. Actually assert what we rely on having been enforced by generic code, 
> >    i.e.:
> > 
> > 	BUG_ON(*count % sizeof(elf_fpreg_t));
> > 	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> > 		err = user_regset_copyin(pos, count, kbuf, ubuf,
> > 					 &fpr_val, i * sizeof(elf_fpreg_t),
> > 					 (i + 1) * sizeof(elf_fpreg_t));
> > 		if (err)
> > 			return err;
> > 		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> > 	}
> > 
> >    so that a discrepancy between generic code and the arch handler is 
> >    caught should it happen.
> 
> The important property is that *count is at least sufficient to fill
> fpr_val, so that a zero return user_regset_copyin() means fpr_val has
> been fully initialised with user data.
> 
> So while your check is not wrong
> 
> (since *count > 0 && *count % sizeof(elf_fpreg_t) == 0 implies
> *count >= sizeof(elf_fpreg_t))
> 
> I don't see how this is an improvement on the original check.
> 
> 
> Either way, maybe adding a comment to explain the purpose of the check
> would be a good idea.

 I agree a comment is worth having here given the complex dependency.  

 Therefore, taking what has been observed in the course of this discussion 
into account and unless either you or someone else has further input I am 
going to withdraw this patch from the series as recorded in patchwork and 
submit another one separately that only adds a comment quoting the 
observations made.  Obviously it won't be a backport candidate, but 5/5 
does not depend on this change, so I believe there is no need to 
regenerate and repost the remaining changes from this series.

 Thank you for your input.

  Maciej
