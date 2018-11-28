Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2018 03:44:59 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992492AbeK1CmF0SQmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Nov 2018 03:42:05 +0100
Date:   Wed, 28 Nov 2018 02:42:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: Remove GCC_IMM_ASM & GCC_REG_ACCUM macros
In-Reply-To: <20181107230454.3232-1-paul.burton@mips.com>
Message-ID: <alpine.LFD.2.21.1811280236170.32615@eddie.linux-mips.org>
References: <20181107230454.3232-1-paul.burton@mips.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 7 Nov 2018, Paul Burton wrote:

> diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
> index c9e8622b5a16..bada74af7641 100644
> --- a/arch/mips/kernel/cpu-bugs64.c
> +++ b/arch/mips/kernel/cpu-bugs64.c
> @@ -92,7 +92,7 @@ static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
>  		".set	pop"
>  		: "=&r" (lv1), "=r" (lw)
>  		: "r" (m1), "r" (m2), "r" (s), "I" (0)
> -		: "hi", "lo", GCC_REG_ACCUM);
> +		: "hi", "lo", "$0");

 You can remove GCC_REG_ACCUM altogether rather than replacing it with 
"$0" as $0 cannot be clobbered. ;)

 I chose this construct for sane syntax, so that we don't have to invent 
things to have "accum" optionally there (e.g. having GCC_REG_ACCUM defined 
to `, "accum"' would be crazy, IMHO).

  Maciej
