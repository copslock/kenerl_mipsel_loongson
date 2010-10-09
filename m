Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2010 07:39:08 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490963Ab0JIFjF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 9 Oct 2010 07:39:05 +0200
Date:   Sat, 9 Oct 2010 06:39:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Subject: Re: [PATCH resend] Perf-tool/MIPS: support cross compiling of
 tools/perf for MIPS
Message-ID: <20101009053903.GA19625@linux-mips.org>
References: <4CA4920C.30401@gmail.com>
 <4CA6566D.2050003@caviumnetworks.com>
 <20101002015947.GB9360@linux-mips.org>
 <4CA69ECC.1070409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CA69ECC.1070409@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 02, 2010 at 10:54:04AM +0800, Deng-Cheng Zhu wrote:

> Thanks guys. So let's turn the patch into the following?
> 
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>  tools/perf/perf.h |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 6fb379b..cd05284 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -73,6 +73,20 @@
>  #define cpu_relax()	asm volatile("":::"memory")
>  #endif
> 
> +#ifdef __mips__
> +#include "../../arch/mips/include/asm/unistd.h"
> +#define rmb()		asm volatile(					\
> +				".set	push\n\t"			\
> +				".set	noreorder\n\t"			\
> +				".set	mips2\n\t"			\
> +				"sync\n\t"				\
> +				".set	pop"				\
> +				: /* no output */			\
> +				: /* no input */			\
> +				: "memory")
> +#define cpu_relax()	asm volatile("" ::: "memory")
> +#endif

Yes, aside of cosmetic issues this is looking good.  The cosmetic issue
is that there are lots of useless dot-ops in the inline assembler.  That
could be reduced to just .set mips2 before the SYNC and .set mips0 after.

There are some considerations wrt. to the MT ASE so I've bounced a few
emails around in the meantime but that's nothing that should stop merging
this patch with the rest of the perf patches.

  Ralf
