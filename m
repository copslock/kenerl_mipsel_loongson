Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 23:45:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10503 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492020Ab0JAVpZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 23:45:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca656930000>; Fri, 01 Oct 2010 14:45:55 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 14:45:25 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 14:45:25 -0700
Message-ID: <4CA6566D.2050003@caviumnetworks.com>
Date:   Fri, 01 Oct 2010 14:45:17 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Subject: Re: [PATCH resend] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
References: <4CA4920C.30401@gmail.com>
In-Reply-To: <4CA4920C.30401@gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2010 21:45:25.0602 (UTC) FILETIME=[F4E62420:01CB61B1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 09/30/2010 06:35 AM, Deng-Cheng Zhu wrote:
> 
> 
> (Directing this patch to Perf-events maintainers for review.)
> 
> With the kernel facility of Linux performance counters, we want the user
> level tool tools/perf to be cross compiled for MIPS platform. To do this,
> we need to include unistd.h, add rmb() and cpu_relax() in perf.h.
> 
> Your review comments are especially required for the definition of rmb():
> In perf.h, we need to have a proper rmb() for _all_ MIPS platforms. And
> we don't have CONFIG_* things for use in here. Looking at barrier.h,
> rmb() goes into barrier() and __sync() for CAVIUM OCTEON and other CPUs,
> respectively. What's more, __sync() has different versions as well.
> Referring to BARRIER() in dump_tlb.c, I propose the "common" definition
> for perf tool rmb() in this patch. Do you have any comments?
> 


In fact I do.

In user space the rmb() must expand to a SYNC instruction.  I am not
sure what your version in the patch is doing with all those NOPs.  That
is not guaranteed to do anything.

The instruction set specifications say that SYNC orders all loads and
stores.  This is a heaver operation than rmb() demands, but is the only
universally available instruction that imposes ordering.

For processors that do not support SYNC, the kernel will emulate it, so
it is safe to use in userspace.  I wouldn't worry about emulation
overhead though, because processors that lack SYNC probably also lack
performance counters, so are not as interesting from a perf-tool point
of view.

David Daney


> In addition, for testing the kernel part code I sent several days
> ago, I was using the "particular" rmb() version for 24K/34K/74K cores:
> 
> #define rmb()           asm volatile(                           \
>                                  ".set   push\n\t"               \
>                                  ".set   noreorder\n\t"          \
>                                  ".set   mips2\n\t"              \
>                                  "sync\n\t"                      \
>                                  ".set   pop"                    \
>                                  : /* no output */               \
>                                  : /* no input */                \
>                                  : "memory")
> 
> This is the definition of __sync() for CONFIG_CPU_HAS_SYNC.
> 
> 
> Thanks,
> 
> Deng-Cheng
> 
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   tools/perf/perf.h |   12 ++++++++++++
>   1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 6fb379b..cd05284 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -73,6 +73,18 @@
>   #define cpu_relax()	asm volatile("":::"memory")
>   #endif
> 
> +#ifdef __mips__
> +#include "../../arch/mips/include/asm/unistd.h"
> +#define rmb()		asm volatile(					\
> +				".set	noreorder\n\t"			\
> +				"nop;nop;nop;nop;nop;nop;nop\n\t"	\
> +				".set	reorder"			\
> +				: /* no output */			\
> +				: /* no input */			\
> +				: "memory")
> +#define cpu_relax()	asm volatile("" ::: "memory")
> +#endif
> +
>   #include<time.h>
>   #include<unistd.h>
>   #include<sys/types.h>
> 
> 
