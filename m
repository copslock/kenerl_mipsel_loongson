Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jun 2011 15:07:50 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37928 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490998Ab1FRNHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Jun 2011 15:07:45 +0200
Received: by wyf23 with SMTP id 23so1815737wyf.36
        for <multiple recipients>; Sat, 18 Jun 2011 06:07:38 -0700 (PDT)
Received: by 10.216.241.132 with SMTP id g4mr3454536wer.9.1308402458151;
        Sat, 18 Jun 2011 06:07:38 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.74.231])
        by mx.google.com with ESMTPS id g2sm1895198wes.10.2011.06.18.06.07.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 06:07:36 -0700 (PDT)
Message-ID: <4DFCA2DD.9060707@mvista.com>
Date:   Sat, 18 Jun 2011 17:06:37 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Christoph Hellwig <hch@lst.de>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API
 not exists for MIPS
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com> <20110325172709.GC8483@linux-mips.org> <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com> <20110616180250.GA13025@lst.de> <20110617152028.GA14107@linux-mips.org>
In-Reply-To: <20110617152028.GA14107@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15155

Hello.

On 17-06-2011 19:20, Ralf Baechle wrote:

>> Ralf,

>> I'll second that request.  We'll really need this, right now embedded XFS
>> users are hacking around it in horrible ways.

> Here's my shot at the problem.  I don't have the time to setup a XFS
> filesystem and tools for testing before the weekend so all I claim is this
> patch builds for R4000-class CPUs but it should be pretty close to the
> real thing.

> Naveen, can you give this patch a spin?  Thanks!

>    Ralf

> Signed-off-by: Ralf Baechle<ralf@linux-mips.org>

[...]

> diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
> index 40bb9fd..69468de 100644
> --- a/arch/mips/include/asm/cacheflush.h
> +++ b/arch/mips/include/asm/cacheflush.h
> @@ -114,4 +114,28 @@ unsigned long run_uncached(void *func);
>   extern void *kmap_coherent(struct page *page, unsigned long addr);
>   extern void kunmap_coherent(void);
>
> +#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +static inline void flush_kernel_dcache_page(struct page *page)
> +{
> +	BUG_ON(cpu_has_dc_aliases&&  PageHighMem(page));
> +}
> +
> +/*
> + * For now flush_kernel_vmap_range and invalidate_kernel_vmap_range both do a
> + * cache writeback and invalidate operation.
> + */
> +extern void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
> +
> +static inline void flush_kernel_vmap_range(void *vaddr, int size)
> +{
> +	if (cpu_has_dc_aliases)
> +		__flush_kernel_vmap_range((unsigned long) vaddr, size);
> +}
> +
> +static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> +{
> +	if (cpu_has_dc_aliases)
> +		__flush_kernel_vmap_range((unsigned long) vaddr, size);

    Not __invalidate_kernel_vmap_range()?

WBR, Sergei
