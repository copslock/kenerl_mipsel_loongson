Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 10:23:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007433AbbIXIXztHHiE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2015 10:23:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EDE0EF6B7A4FB;
        Thu, 24 Sep 2015 09:23:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Sep 2015 09:23:49 +0100
Received: from [192.168.154.88] (192.168.154.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 24 Sep
 2015 09:23:49 +0100
Subject: Re: [PATCH 2/2] MIPS: initialise MAARs on secondary CPUs
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
References: <1442948929-15862-1-git-send-email-paul.burton@imgtec.com>
 <1442948929-15862-3-git-send-email-paul.burton@imgtec.com>
CC:     Rusty Russell <rusty@rustcorp.com.au>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "James Hogan" <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <5603B315.4050008@imgtec.com>
Date:   Thu, 24 Sep 2015 09:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1442948929-15862-3-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/22/2015 08:08 PM, Paul Burton wrote:
> MAARs should be initialised on each CPU (or rather, core) in the system
> in order to achieve consistent behaviour & performance. Previously they
> have only been initialised on the boot CPU which leads to performance
> problems if tasks are later scheduled on a secondary CPU, particularly
> if those tasks make use of unaligned vector accesses where some CPUs
> don't handle any cases in hardware for non-speculative memory regions.
> Fix this by recording the MAAR configuration from the boot CPU and
> applying it to secondary CPUs as part of their bringup.
> 
> Reported-by: Doug Gilmore <doug.gilmore@imgtec.com>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  arch/mips/include/asm/maar.h |  9 +++++++++
>  arch/mips/kernel/smp.c       |  2 ++
>  arch/mips/mm/init.c          | 28 +++++++++++++++++++++++++---
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
> index b02891f..21d9607 100644
> --- a/arch/mips/include/asm/maar.h
> +++ b/arch/mips/include/asm/maar.h
> @@ -66,6 +66,15 @@ static inline void write_maar_pair(unsigned idx, phys_addr_t lower,
>  }
>  
>  /**
> + * maar_init() - initialise MAARs
> + *
> + * Performs initialisation of MAARs for the current CPU, making use of the
> + * platforms implementation of platform_maar_init where necessary and
> + * duplicating the setup it provides on secondary CPUs.
> + */
> +extern void maar_init(void);
> +
> +/**
>   * struct maar_config - MAAR configuration data
>   * @lower:	The lowest address that the MAAR pair will affect. Must be
>   *		aligned to a 2^16 byte boundary.
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index a31896c..bd4385a 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -42,6 +42,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/time.h>
>  #include <asm/setup.h>
> +#include <asm/maar.h>
>  
>  cpumask_t cpu_callin_map;		/* Bitmask of started secondaries */
>  
> @@ -157,6 +158,7 @@ asmlinkage void start_secondary(void)
>  	mips_clockevent_init();
>  	mp_ops->init_secondary();
>  	cpu_report();
> +	maar_init();
>  

Hi,

This breaks the ip27_defconfig in both upstream-sfr and linux-next

arch/mips/built-in.o: In function `start_secondary':
(.text+0x123e4): undefined reference to `maar_init'
Makefile:944: recipe for target 'vmlinux' failed


-- 
markos
