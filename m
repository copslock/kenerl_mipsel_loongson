Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 23:05:30 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:48277 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991127AbeFRVFXDFQE8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 23:05:23 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1404.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 18 Jun 2018 21:05:08 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 18
 Jun 2018 14:05:21 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Mon, 18 Jun
 2018 14:05:21 -0700
Date:   Mon, 18 Jun 2018 14:05:07 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V3 03/10] MIPS: Loongson-3: Enable Store Fill Buffer at
 runtime
Message-ID: <20180618210507.akcvvigzj7qis3re@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-4-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524885694-18132-4-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529355907-382908-20156-164175-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194169
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
X-archive-position: 64358
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

On Sat, Apr 28, 2018 at 11:21:27AM +0800, Huacai Chen wrote:
> New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
> (Store Fill Buffer) which can improve the performance of memory access.
> Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
> the generic kernel has no benefit from SFB (even it is running on a new
> Loongson-3 machine). With this patch, we can enable SFB at runtime by
> detecting the CPU type (the expense is war_io_reorder_wmb() will always
> be a 'sync', which will hurt the performance of old Loongson-3).

Neat - I like the move towards the kernel detecting this at runtime,
rather than requiring the user to select it at configuration/build time.

> diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> index 3127391..cbac603 100644
> --- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> @@ -11,6 +11,8 @@
>  #ifndef __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
>  #define __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
>  
> +#include <asm/cpu.h>
> +
>  /*
>   * Override macros used in arch/mips/kernel/head.S.
>   */
> @@ -26,12 +28,15 @@
>  	mfc0	t0, CP0_PAGEGRAIN
>  	or	t0, (0x1 << 29)
>  	mtc0	t0, CP0_PAGEGRAIN
> -#ifdef CONFIG_LOONGSON3_ENHANCEMENT
>  	/* Enable STFill Buffer */
> +	mfc0	t0, CP0_PRID
> +	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
> +	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
> +	bnez	t0, 1f
>  	mfc0	t0, CP0_CONFIG6
>  	or	t0, 0x100
>  	mtc0	t0, CP0_CONFIG6
> -#endif
> +1:
>  	_ehb
>  	.set	pop
>  #endif

I think it'd be neater if we did this from C in cpu_probe_loongson()
though. If we add __BUILD_SET_C0(config6) to asm/mipsregs.h and define a
macro naming the SFB enable bit then both boot CPU & secondary cases
could be handled by a single line in cpu_probe_loongson(). Something
like this:

    set_c0_config6(LOONGSON_CONFIG6_SFB_ENABLE);

Unless there's a technical reason this doesn't work I'd prefer it to the
assembly version (and maybe we could move the LPA & ELPA configuration
into cpu-probe.c too then remove asm/mach-loongson64/kernel-entry-init.h
entirely).

Thanks,
    Paul
