Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 19:20:24 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:41919 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdKMSUPeUWtR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 19:20:15 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 18:19:58 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 10:19:48 -0800
Date:   Mon, 13 Nov 2017 18:19:46 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: Re: [RFC PATCH] MIPS: cmpxchg64() and HAVE_VIRT_CPU_ACCOUNTING_GEN
 don't work for 32-bit SMP
Message-ID: <20171113181945.GC31917@jhogan-linux.mipstec.com>
References: <20171004024614.GC2971@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171004024614.GC2971@decadent.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510597183-321459-22239-1783-14
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186883
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Wed, Oct 04, 2017 at 03:46:14AM +0100, Ben Hutchings wrote:
> __cmpxchg64_local_generic() is atomic only w.r.t tasks and interrupts
> on the same CPU (that's what the 'local' means).  We can't use it to
> implement cmpxchg64() in SMP configurations.
> 
> So, for 32-bit SMP configurations:
> 
> - Don't define cmpxchg64()
> - Don't enable HAVE_VIRT_CPU_ACCOUNTING_GEN, which requires it
> 
> Fixes: e2093c7b03c1 ("MIPS: Fall back to generic implementation of ...")
> Fixes: bb877e96bea1 ("MIPS: Add support for full dynticks CPU time accounting")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks, looks reasonable to me

Applied

Cheers
James

> ---
>  arch/mips/Kconfig               | 2 +-
>  arch/mips/include/asm/cmpxchg.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cb7fcc4216fd..1e23f8455b7d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -64,7 +64,7 @@ config MIPS
>  	select HAVE_PERF_EVENTS
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_SYSCALL_TRACEPOINTS
> -	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> +	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
>  	select IRQ_FORCED_THREADING
>  	select MODULES_USE_ELF_RELA if MODULES && 64BIT
>  	select MODULES_USE_ELF_REL if MODULES
> diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
> index 903f3bf48419..ae2b4583b486 100644
> --- a/arch/mips/include/asm/cmpxchg.h
> +++ b/arch/mips/include/asm/cmpxchg.h
> @@ -202,8 +202,10 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  #else
>  #include <asm-generic/cmpxchg-local.h>
>  #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
> +#ifndef CONFIG_SMP
>  #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
>  #endif
> +#endif
>  
>  #undef __scbeqz
>  
