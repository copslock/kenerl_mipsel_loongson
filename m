Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 20:52:34 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:53181 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeFRSw0iRI0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 20:52:26 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1414.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 18 Jun 2018 18:51:49 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 18
 Jun 2018 11:51:54 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Mon, 18 Jun
 2018 11:51:54 -0700
Date:   Mon, 18 Jun 2018 11:51:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529347894-531716-5145-161145-2
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194166
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,paulmck@linux.vnet.ibm.com,luc.maranget@inria.fr,j.alglave@ucl.ac.uk,dhowells@redhat.com,npiggin@gmail.com,boqun.feng@gmail.com,peterz@infradead.org,will.deacon@arm.com,andrea.parri@amarulasolutions.com,stern@rowland.harvard.edu,stable@vger.kernel.org,chenhuacai@gmail.com,wuzhangjin@gmail.com,zhangfx@lemote.com,linux-mips@linux-mips.org,ralf@linux-mips.org,akiyks@gmail.com,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Huacai,

On Fri, Jun 15, 2018 at 02:07:38PM +0800, Huacai Chen wrote:
> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> has SFB (Store Fill Buffer) and READ_ONCE() may get an old value in a
> tight loop. So in smp_cond_load_acquire() we need a __smp_mb() after
> every READ_ONCE().

Thanks - modifying smp_cond_load_acquire() is a step better than
modifying arch_mcs_spin_lock_contended() to avoid it, but I'm still not
sure we've reached the root of the problem. If tight loops using
READ_ONCE() are at fault then what's special about
smp_cond_load_acquire()? Could other such loops not hit the same
problem?

Is the scenario you encounter the same as that outlined in the "DATA
DEPENDENCY BARRIERS (HISTORICAL)" section of
Documentation/memory-barriers.txt by any chance? If so then perhaps it
would be better to implement smp_read_barrier_depends(), or just raw
read_barrier_depends() depending upon how your SFB functions.

Is there any public documentation describing the behaviour of the store
fill buffer in Loongson-3?

Part of the problem is that I'm still not sure what's actually happening
in your system - it would be helpful to have further information in the
commit message about what actually happens. For example if you could
walk us through an example of the problem step by step in the style of
the diagrams you'll see in Documentation/memory-barriers.txt then I
think that would help us to see what the best solution here is.

I've copied the LKMM maintainers in case they have further input.

Thanks,
    Paul

> This patch introduce a Loongson-specific smp_cond_load_acquire(). And
> it should be backported to as early as linux-4.5, in which release the
> smp_cond_acquire() is introduced.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/barrier.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index a5eb1bb..4ea384d 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -222,6 +222,23 @@
>  #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
>  #define __smp_mb__after_atomic()	smp_llsc_mb()
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +/* Loongson-3 need a __smp_mb() after READ_ONCE() here */
> +#define smp_cond_load_acquire(ptr, cond_expr)			\
> +({								\
> +	typeof(ptr) __PTR = (ptr);				\
> +	typeof(*ptr) VAL;					\
> +	for (;;) {						\
> +		VAL = READ_ONCE(*__PTR);			\
> +		__smp_mb();					\
> +		if (cond_expr)					\
> +			break;					\
> +		cpu_relax();					\
> +	}							\
> +	VAL;							\
> +})
> +#endif	/* CONFIG_CPU_LOONGSON3 */
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* __ASM_BARRIER_H */
> -- 
> 2.7.0
> 
