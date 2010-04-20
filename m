Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 18:26:27 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15451 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492407Ab0DTQ0X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 18:26:23 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bcdd5b90000>; Tue, 20 Apr 2010 09:26:33 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 20 Apr 2010 09:25:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 20 Apr 2010 09:25:56 -0700
Message-ID: <4BCDD58F.7020201@caviumnetworks.com>
Date:   Tue, 20 Apr 2010 09:25:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH 1/3] MIPS: use the generic atomic64 operations for perf
 counter support
References: <1271349525.7467.420.camel@fun-lab>
In-Reply-To: <1271349525.7467.420.camel@fun-lab>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2010 16:25:56.0828 (UTC) FILETIME=[27AC59C0:01CAE0A6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/15/2010 09:38 AM, Deng-Cheng Zhu wrote:
> Currently we take the generic spinlock'ed atomic64 implementation from the
> lib. The atomic64 types and related functions are needed for the Linux
> performance counter subsystem.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

NAK.

> ---
>   arch/mips/Kconfig              |    1 +
>   arch/mips/include/asm/atomic.h |    4 ++++
>   2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 29e8692..7161751 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -4,6 +4,7 @@ config MIPS
>   	select HAVE_GENERIC_DMA_COHERENT
>   	select HAVE_IDE
>   	select HAVE_OPROFILE
> +	select GENERIC_ATOMIC64
>   	select HAVE_ARCH_KGDB
>   	select HAVE_FUNCTION_TRACER
>   	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> index 519197e..b0a932e 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -21,6 +21,10 @@
>   #include<asm/war.h>
>   #include<asm/system.h>
>
> +#ifdef CONFIG_GENERIC_ATOMIC64
> +#include<asm-generic/atomic64.h>
> +#endif
> +
>   #define ATOMIC_INIT(i)    { (i) }
>
>   /*

This is incorrect.  For 64-bit kernels, we already have all the 64-bit 
atomics implemented.  This will break 64-bit kernels.

David Daney
