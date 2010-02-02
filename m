Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 11:04:58 +0100 (CET)
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:42759 "HELO
        mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491920Ab0BBKEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 11:04:54 +0100
Received: (qmail 25227 invoked from network); 2 Feb 2010 10:04:53 -0000
Received: from unknown (HELO ?127.0.0.1?) (192.168.1.70)
  by 0 with SMTP; 2 Feb 2010 10:04:53 -0000
Message-ID: <4B67F8A8.6000706@ru.mvista.com>
Date:   Tue, 02 Feb 2010 13:04:24 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v4] Virtual memory size detection for 64 bit MIPS CPUs
References: <1265068979-12052-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1265068979-12052-1-git-send-email-guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Guenter Roeck wrote:

> Linux kernel 2.6.32 and later allocates memory from the top of virtual memory
> space.
>
> This patch implements virtual memory size detection for 64 bit MIPS CPUs
> to avoid resulting crashes.
>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
>   

[...]

> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 9cd5089..259ec58 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -110,7 +110,9 @@
>  #define VMALLOC_START		MAP_BASE
>  #define VMALLOC_END	\
>  	(VMALLOC_START + \
> -	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
> +	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
> +	     (1UL<<cpu_vmbits)) - (1UL << 32))
>   

   Why you've added spaces around the second << but not around the 
first? Should be more consistent.

> +
>  #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
>  	VMALLOC_START != CKSSEG
>  /* Load modules into 32bit-compatible segment. */
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 7a51866..ac9aca1 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -282,6 +282,16 @@ static inline int __cpu_has_fpu(void)
>  	return ((cpu_get_fpu_id() & 0xff00) != FPIR_IMP_NONE);
>  }
>  
> +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> +{
> +	if (cpu_has_64bits) {
> +		write_c0_entryhi(0xfffffffffffff000ULL);
> +		back_to_back_c0_hazard();
> +		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
>   

   I don't quite understand why set bits 62-63 only to mask them off 
later...

WBR, Sergei
