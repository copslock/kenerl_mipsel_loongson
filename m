Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 11:38:43 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:34005
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993867AbdFMJigESB0v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 11:38:36 +0200
Received: by mail-io0-x242.google.com with SMTP id a96so12419993ioj.1;
        Tue, 13 Jun 2017 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n71h5b1w8iH4FIUAIO9qfu375NlBndlzlxCiYUfQ2xY=;
        b=fhqIbZf2kptu5v3k6CoDgzLSP82Qk/aTibHS9iF5oF3pp02t9O6xFHrrXcIOHRKxqo
         91KmLlMrzPerfCD6arksteSTCzoLNonJYUHzLQFFJgr33CPlc0b2KjGKNQUQHf9kPEpA
         sjfQSticF+q32Ak7dC9a3XRwoy03ofEmpwmN10BPOg/vqIbAUP2dvVK1d6PcM9TfVyQJ
         gCdcWjvlJDERbpL/osah5BhloZViloqHpa0dSo/H/jrdhPeYxswCutZWpJpOYhZLYcbs
         hzFKp3SmLmav8spY4o2BJ48VUeEtMEyGNCJCBHrfv+c1NEOFL6+hABCgGggmyjs116k9
         G/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n71h5b1w8iH4FIUAIO9qfu375NlBndlzlxCiYUfQ2xY=;
        b=O2Oxeb/+4q2kVvbmwvpB/Hd7qXj/BrnBmBgviezDtV6GDI62RoCn8i39q93qSGc0hL
         Hrb9q12+7dcB6Pv5R+sLF+YBsfRNhtpUDPm6Sc0tETRryupcai3XFYxi+G9z7sJXFG+6
         osG+HpoCgVYcWeJhwl+6E+LXlsK9ZMU1Hsw3mp4ncV4z36PdHSNzszR6AKheJ6rbOCmY
         E8uJdipEZCr/EvoD+70vVzO+UOzdPpCXGBTYI/yW5F3kZ+PFMWdnKCemrEmqMrGe08vJ
         wQQqKJuW/suxhYJkDMbN0Fr7HPfRfVDjBi8NtfkM9BrgnZFhY1F9eb9iHHsPx6JasA5s
         5cQQ==
X-Gm-Message-State: AODbwcDW1C/g+pZah8z1Lnho+MNcRYCIKSJCNJ6VdH/vqETNUhqsZljE
        +87/PBKAOtL/TvskvPoohcWDyVb8LxKl
X-Received: by 10.107.6.211 with SMTP id f80mr48587580ioi.188.1497346709962;
 Tue, 13 Jun 2017 02:38:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Tue, 13 Jun 2017 02:38:29 -0700 (PDT)
In-Reply-To: <20170613084057.GA31492@linux-mips.org>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
 <1496718888-18324-2-git-send-email-chenhc@lemote.com> <20170613084057.GA31492@linux-mips.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 13 Jun 2017 17:38:29 +0800
X-Google-Sender-Auth: 3PilwvYTTw6m_W8d_w-zpQRt7hM
Message-ID: <CAAhV-H4HKao+_eaMUm-7rXpwCtsfinca_iAa1qmuPCq4nPQaLw@mail.gmail.com>
Subject: Re: [PATCH V4 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Tue, Jun 13, 2017 at 4:40 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jun 06, 2017 at 11:14:41AM +0800, Huacai Chen wrote:
>
>> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
>> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
>> (CAC_BASE | (node_id << 44)) instead of CKSEG0 as the start address.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/r4kcache.h | 26 ++++++++++++++++++++++++++
>>  arch/mips/mm/c-r4k.c             | 33 ++++++++++++++++++++++++++++++++-
>>  2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
>> index 7f12d7e..aa615e3 100644
>> --- a/arch/mips/include/asm/r4kcache.h
>> +++ b/arch/mips/include/asm/r4kcache.h
>> @@ -747,4 +747,30 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
>>  __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
>>  __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)   \
>> +static inline void blast_##pfx##cache##lsize##_node(long node)               \
>> +{                                                                    \
>> +     unsigned long start = CAC_BASE | (node << 44);                  \
>> +     unsigned long end = start + current_cpu_data.desc.waysize;      \
>> +     unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;     \
>> +     unsigned long ws_end = current_cpu_data.desc.ways <<            \
>> +                            current_cpu_data.desc.waybit;            \
>> +     unsigned long ws, addr;                                         \
>> +                                                                     \
>> +     __##pfx##flush_prologue                                         \
>> +                                                                     \
>> +     for (ws = 0; ws < ws_end; ws += ws_inc)                         \
>> +             for (addr = start; addr < end; addr += lsize * 32)      \
>> +                     cache##lsize##_unroll32(addr|ws, indexop);      \
>> +                                                                     \
>> +     __##pfx##flush_epilogue                                         \
>> +}
>> +
>> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
>> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
>> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
>> +__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
>> +#endif
>
> This all expand to just inline functions which generate no code if they're
> unused, so you can drop the #ifdef.
>
> However a comment explaining why this function is only required for
> Loongson 3 would be great!
Address space is very specific to cpu-type. I don't know whether other
cpus need r4k_blast_scache_node(), and I don't know how to implement
r4k_blast_scache_node() for other cpus either (if they really need
this). So, I use #ifdefs.

>
>> +
>>  #endif /* _ASM_R4KCACHE_H */
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 3fe99cb..0a49af0 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -459,11 +459,29 @@ static void r4k_blast_scache_setup(void)
>>               r4k_blast_scache = blast_scache128;
>>  }
>>
>> +static void (* r4k_blast_scache_node)(long node);
>> +
>> +static void r4k_blast_scache_node_setup(void)
>> +{
>> +     unsigned long sc_lsize = cpu_scache_line_size();
>> +
>> +     r4k_blast_scache_node = (void *)cache_noop;
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     if (sc_lsize == 16)
>> +             r4k_blast_scache_node = blast_scache16_node;
>> +     else if (sc_lsize == 32)
>> +             r4k_blast_scache_node = blast_scache32_node;
>> +     else if (sc_lsize == 64)
>> +             r4k_blast_scache_node = blast_scache64_node;
>> +     else if (sc_lsize == 128)
>> +             r4k_blast_scache_node = blast_scache128_node;
>> +#endif
>
> No #idefs please.  Instead you can check the CPU type with something like
>
>         if (current_cpu_type() = CPU_LOONGSON3) {
>                 ...
>         }
>
> __get_cpu_type() in include/asm/cpu-type.h will then ensure that GCC
> knows it can optimize things for the CPU type(s) in use.
>
>> +
>>  static inline void local_r4k___flush_cache_all(void * args)
>>  {
>>       switch (current_cpu_type()) {
>>       case CPU_LOONGSON2:
>> -     case CPU_LOONGSON3:
>>       case CPU_R4000SC:
>>       case CPU_R4000MC:
>>       case CPU_R4400SC:
>> @@ -480,6 +498,10 @@ static inline void local_r4k___flush_cache_all(void * args)
>>               r4k_blast_scache();
>>               break;
>>
>> +     case CPU_LOONGSON3:
>> +             r4k_blast_scache_node(get_ebase_cpunum() >> 2);
>> +             break;
>> +
>>       case CPU_BMIPS5000:
>>               r4k_blast_scache();
>>               __sync();
>> @@ -840,7 +862,11 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>>       preempt_disable();
>>       if (cpu_has_inclusive_pcaches) {
>>               if (size >= scache_size)
>> +#ifndef CONFIG_CPU_LOONGSON3
>>                       r4k_blast_scache();
>> +#else
>> +                     r4k_blast_scache_node((addr >> 44) & 0xF);
>> +#endif
>
> Ditto.
>
>>               else
>>                       blast_scache_range(addr, addr + size);
>>               preempt_enable();
>> @@ -873,7 +899,11 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>>       preempt_disable();
>>       if (cpu_has_inclusive_pcaches) {
>>               if (size >= scache_size)
>> +#ifndef CONFIG_CPU_LOONGSON3
>>                       r4k_blast_scache();
>> +#else
>> +                     r4k_blast_scache_node((addr >> 44) & 0xF);
>> +#endif
>
> Ditto.
>
>>               else {
>>                       /*
>>                        * There is no clearly documented alignment requirement
>> @@ -1903,6 +1933,7 @@ void r4k_cache_init(void)
>>       r4k_blast_scache_page_setup();
>>       r4k_blast_scache_page_indexed_setup();
>>       r4k_blast_scache_setup();
>> +     r4k_blast_scache_node_setup();
>>  #ifdef CONFIG_EVA
>>       r4k_blast_dcache_user_page_setup();
>>       r4k_blast_icache_user_page_setup();
>
>   Ralf
>
