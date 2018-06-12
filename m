Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 20:41:11 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:48265 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992684AbeFLSlEEuACv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 20:41:04 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 12 Jun 2018 18:40:54 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 12
 Jun 2018 11:41:04 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 12 Jun
 2018 11:41:04 -0700
Date:   Tue, 12 Jun 2018 11:40:53 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH Resend 2/2] MIPS: mcs lock: implement
 arch_mcs_spin_lock_contended() for Loongson-3
Message-ID: <20180612184053.odi5gvvwbqovgvc6@pburton-laptop>
References: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
 <1528797283-16577-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1528797283-16577-2-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528828854-853316-1015-36534-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194004
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,ralf@linux-mips.org,linux-mips@linux-mips.org,zhangfx@lemote.com,wuzhangjin@gmail.com,chenhuacai@gmail.com
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64247
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

On Tue, Jun 12, 2018 at 05:54:43PM +0800, Huacai Chen wrote:
> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> has SFB (Store Fill Buffer) and need a mb() after every READ_ONCE().

Why do you need that mb()?

Could you describe what is actually happening with the current code, in
order to explain what requires the mb() you mention here? What's being
held in the SFB & why is that problematic?

Most importantly if smp_cond_load_acquire() isn't working as expected on
Loongson CPUs then fixing that would be a much better path forwards than
trying to avoid using it.

Could it be that Loongson requires an implementation of
(smp_)read_barrier_depends()?

Additionally you have "Resend" in the subject of this email, but I don't
see any previous submissions of this patch - given that commit
7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire() in MCS spin
loop") is very recent I doubt there were any. Please try to be factual,
and if you have 2 patches that are unrelated please send them separately
rather than as a series.

Thanks,
    Paul

> This patch introduce a MIPS-specific mcs_spinlock.h and revert to the
> old implementation of arch_mcs_spin_lock_contended() for Loongson-3.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/Kbuild         |  1 -
>  arch/mips/include/asm/mcs_spinlock.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/include/asm/mcs_spinlock.h
> 
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index 45d541b..7076627 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -6,7 +6,6 @@ generic-y += emergency-restart.h
>  generic-y += export.h
>  generic-y += irq_work.h
>  generic-y += local64.h
> -generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += parport.h
>  generic-y += percpu.h
> diff --git a/arch/mips/include/asm/mcs_spinlock.h b/arch/mips/include/asm/mcs_spinlock.h
> new file mode 100644
> index 0000000..063df4e
> --- /dev/null
> +++ b/arch/mips/include/asm/mcs_spinlock.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MCS_LOCK_H
> +#define __ASM_MCS_LOCK_H
> +
> +/* Loongson-3 need a mb() after every READ_ONCE() */
> +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_SMP)
> +#define arch_mcs_spin_lock_contended(l)					\
> +do {									\
> +	while (!(smp_load_acquire(l)))					\
> +		cpu_relax();						\
> +} while (0)
> +#endif	/* CONFIG_CPU_LOONGSON3 && CONFIG_SMP */
> +
> +#endif	/* __ASM_MCS_LOCK_H */
> -- 
> 2.7.0
> 
