Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 18:26:07 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:32957 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLKRZ6OuRZa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 18:25:58 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 11 Dec 2017 17:25:45 +0000
Received: from [10.20.78.70] (10.20.78.70) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 11 Dec 2017 09:25:26 -0800
Date:   Mon, 11 Dec 2017 17:25:14 +0000
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
In-Reply-To: <alpine.DEB.2.00.1712061859120.4584@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1712111531270.4584@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk> <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk> <20171130172839.GQ22781@e103592.cambridge.arm.com> <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk> <20171201122356.GR22781@e103592.cambridge.arm.com>
 <alpine.DEB.2.00.1712061859120.4584@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1513013101-298555-4584-233235-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187865
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
X-archive-position: 61421
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

On Wed, 6 Dec 2017, Maciej W. Rozycki wrote:

> > > 2. Actually assert what we rely on having been enforced by generic code, 
> > >    i.e.:
> > > 
> > > 	BUG_ON(*count % sizeof(elf_fpreg_t));
> > > 	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> > > 		err = user_regset_copyin(pos, count, kbuf, ubuf,
> > > 					 &fpr_val, i * sizeof(elf_fpreg_t),
> > > 					 (i + 1) * sizeof(elf_fpreg_t));
> > > 		if (err)
> > > 			return err;
> > > 		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> > > 	}
> > > 
> > >    so that a discrepancy between generic code and the arch handler is 
> > >    caught should it happen.
> > 
> > The important property is that *count is at least sufficient to fill
> > fpr_val, so that a zero return user_regset_copyin() means fpr_val has
> > been fully initialised with user data.
> > 
> > So while your check is not wrong
> > 
> > (since *count > 0 && *count % sizeof(elf_fpreg_t) == 0 implies
> > *count >= sizeof(elf_fpreg_t))
> > 
> > I don't see how this is an improvement on the original check.
> > 
> > 
> > Either way, maybe adding a comment to explain the purpose of the check
> > would be a good idea.
> 
>  I agree a comment is worth having here given the complex dependency.  
> 
>  Therefore, taking what has been observed in the course of this discussion 
> into account and unless either you or someone else has further input I am 
> going to withdraw this patch from the series as recorded in patchwork and 
> submit another one separately that only adds a comment quoting the 
> observations made.  Obviously it won't be a backport candidate, but 5/5 
> does not depend on this change, so I believe there is no need to 
> regenerate and repost the remaining changes from this series.

 I take it back.  After thinking about it some more in the course of 
adding the commentary, I realised that with the addition of 2/5 we'll have 
a logical inconsistency with the treatment of `count' in that for someone 
reading this code without also looking at `ptrace_regset' it will appear 
that in the case of a partial register write we call `user_regset_copyin' 
to store FCSR having not completely exhausted `count' with FGR accesses.  

 Which means that for initial `count' being say 12 we'd put the first 8 
bytes into $f0 and the following 4 bytes into FCSR rather than into $f1, 
which I would find confusing if reading this code the first time.  This of 
course doesn't matter with our code as it is now, because it does not 
access FCSR at all, however this gets changed with 2/5.

 So I think that while such a change will have no effect at run time, 
because we guarantee that `count % sizeof(elf_fpreg_t) == 0' elsewhere, I 
think that using `count > 0' rather than `count >= sizeof(elf_fpreg_t)' 
will make code more consistent.  If you or anyone else feels uneasy about 
`fpr_val' appearing potentially partially uninitialised (even though it 
cannot trigger), then I can offer a minimal change for that, which will 
preset the variable to 0.

 Also to keep things consistent, this patch will have to be reordered 
ahead the 2/5 FCSR fix.  I will therefore submit v2 of the whole series, 
with patches shuffled appropriately, BUG_ON added as previously discussed 
as well as an explanatory comment.

  Maciej
