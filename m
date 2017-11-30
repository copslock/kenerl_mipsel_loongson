Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 19:21:21 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:35704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994628AbdK3SVLXFOas (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 19:21:11 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572CA1435;
        Thu, 30 Nov 2017 09:28:44 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D08143F318;
        Thu, 30 Nov 2017 09:28:42 -0800 (PST)
Date:   Thu, 30 Nov 2017 17:28:40 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
Message-ID: <20171130172839.GQ22781@e103592.cambridge.arm.com>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
 <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Dave.Martin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Dave.Martin@arm.com
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

On Wed, Nov 29, 2017 at 03:21:14PM +0000, Maciej W. Rozycki wrote:
> Fix a commit d614fd58a283 ("mips/ptrace: Preserve previous registers for 
> short regset write") bug and allow the last register requested with a 
> ptrace(2) PTRACE_SETREGSET call to be partially written if supplied this 
> way by the caller, like with other register sets.
> 
> Cc: stable@vger.kernel.org # v4.11+
> Fixes: d614fd58a283 ("mips/ptrace: Preserve previous registers for short regset write")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
>  arch/mips/kernel/ptrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> linux-mips-nt-prfpreg-count.diff
> Index: linux-sfr-test/arch/mips/kernel/ptrace.c
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-21 22:12:00.000000000 +0000
> +++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-21 22:13:13.471970000 +0000
> @@ -484,7 +484,7 @@ static int fpr_set_msa(struct task_struc
>  	int err;
>  
>  	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
> -	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
> +	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> 
>  		err = user_regset_copyin(pos, count, kbuf, ubuf,
>  					 &fpr_val, i * sizeof(elf_fpreg_t),
>  					 (i + 1) * sizeof(elf_fpreg_t));

But mips*_regsets[REGSET_FPR].size == sizeof(elf_fpreg_t),
linux/kernel/regset.c:ptrace_regset() polices
iov_len % regset->size == 0, and each user_regset_copyout() call here
transfers sizeof(elf_fpreg_t) bytes, decrementing *count by that
amount unless something goest wrong in which case we return.

So how do we end up with *count > 0 && *count < sizeof(elf_fpreg_t)
here?

If we can't end up with that, then this patch doesn't change ABI-
observable behaviour, unless I've missed something.

If we can end up with that somehow, then this patch reintroduces the
issue d614fd58a283 aims to fix, whereby fpr_val can contain
uninitialised kernel stack which userspace can then obtain via
PTRACE_GETREGSET.

Cheers
---Dave
