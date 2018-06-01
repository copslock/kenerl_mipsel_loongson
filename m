Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2018 01:08:05 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:36390 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992567AbeFAXH5XPBIE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Jun 2018 01:07:57 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 01 Jun 2018 23:07:49 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 1 Jun
 2018 16:07:55 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 1 Jun
 2018 16:07:55 -0700
Date:   Fri, 1 Jun 2018 16:07:48 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <r@hev.cc>
CC:     <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Fix ejtag handler on SMP
Message-ID: <20180601230748.3jn73ao6pnyivric@pburton-laptop>
References: <20180403114102.10700-1-r@hev.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180403114102.10700-1-r@hev.cc>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527894468-321459-30660-31535-1
X-BESS-VER: 2018.6-r1805312037
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193623
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64147
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

Hi Heiher,

On Tue, Apr 03, 2018 at 07:41:02PM +0800, r@hev.cc wrote:
> From: Heiher <r@hev.cc>
> 
> On SMP systems, the shared ejtag debug buffer may be overwritten by
> other cores, because every cores can generate ejtag exception at
> same time.
> 
> Unfortunately, in that context, it's difficult to relax more registers
> to access per cpu buffers. so use ll/sc to serialize the access.
> 
> Signed-off-by: Heiher <r@hev.cc>
> ---
>  arch/mips/kernel/genex.S | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 37b9383eacd3..1af8c83835ef 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -354,6 +354,16 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	sll	k0, k0, 30	# Check for SDBBP.
>  	bgez	k0, ejtag_return
>  
> +#ifdef CONFIG_SMP
> +	PTR_LA	k0, ejtag_debug_buffer
> +1:	ll	k0, LONGSIZE(k0)
> +	bnez	k0, 1b
> +	PTR_LA	k0, ejtag_debug_buffer
> +	sc	k0, LONGSIZE(k0)
> +	beqz	k0, 1b

If this branch is taken then we're in trouble k0 is now 0x0 so the ll
will try to load from address 0+LONGSIZE. So we'll take a TLBL exception
& panic.

The easiest solution would be to move the 1 label a line earlier to the
PTR_LA, so that we repeat the PTR_LA. I like the clever trick that the
data returned from the ll should either be 0 or the address of
ejtag_debug_buffer, which meant the bnez a little earlier wouldn't have
this problem, and I see that trivially moving the 1 label would make
that case redundantly repeat the PTR_LA too but in practice this should
be rarely executed so the extra couple of instructions ought not to
matter.

I think if we're being really correct this should take into account
R10000_LLSC_WAR too, and use beqzl when that's set (see asm/cmpxchg.h).

> +	sync

This is being used as the equivalent of an smp_llsc_mb(), so it would be
good to comment to that effect & clarify that we need an ordering
barrier to ensure that writes to ejtag_debug_buffer can't overtake the
acquisition of this lock.

The sync could also be omitted if either of
CONFIG_WEAK_REORDERING_BEYOND_LLSC or CONFIG_SMP aren't enabled, but
that might just clutter up the rarely executed code for little gain so I
won't insist.

> +#endif
> +
>  	PTR_LA	k0, ejtag_debug_buffer
>  	LONG_S	k1, 0(k0)
>  	SAVE_ALL
> @@ -363,7 +373,12 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	PTR_LA	k0, ejtag_debug_buffer
>  	LONG_L	k1, 0(k0)
>  
> +#ifdef CONFIG_SMP
> +	sw	zero, LONGSIZE(k0)
> +#endif
> +
>  ejtag_return:
> +	back_to_back_c0_hazard
>  	MFC0	k0, CP0_DESAVE
>  	.set	mips32
>  	deret
> @@ -377,6 +392,9 @@ ejtag_return:
>  	.data
>  EXPORT(ejtag_debug_buffer)
>  	.fill	LONGSIZE
> +#ifdef CONFIG_SMP

I think it would make sense to EXPORT(ejtag_debug_buffer_spinlock) or
something to that effect here, and use that symbol when accessing the
lock above. That would make it easier to see at a glance that this is an
open-coded spinlock.

Having said all of that, I'm a little concerned about the approach in
general because it relies on CPUs always returning from
ejtag_exception_handler() to release the lock. If a CPU doesn't return
from ejtag_exception_handler() then any other CPUs that take an EJTAG
exception will hang silently. In practice ejtag_exception_handler() is
currently quite simple so we probably will always return, so I'd
consider this patch an improvement on what we have now once the comments
above are addressed.

One obvious alternative would be to make ejtag_debug_buffer per-CPU, or
probably more easily making it an array of NR_CPUS length. It would be
tricky to access though until MIPSr6, where AUI would help, or nanoMIPS
where an ADDIU[48] could encode the whole address of ejtag_debug_buffer
to add to the CPU offset.

Another option would be to use a KScratch register where they're
present, but pre-r6 we usually can't guarantee they exist so that would
complicate things again.

Thanks,
    Paul

> +	.fill	LONGSIZE
> +#endif
>  	.previous
>  
>  	__INIT
> -- 
> 2.16.3
> 
> 
