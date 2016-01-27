Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 05:58:50 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcA0E6sbTJoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 05:58:48 +0100
Received: by mail-wm0-f66.google.com with SMTP id p63so1133654wmp.1;
        Tue, 26 Jan 2016 20:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TqgN5Aa5NUJat24EGfLQuqbK4yQxb9M7JYmXDBS5pDA=;
        b=DxHC3cA+Q0qGe9fp4WO7D+5Q03/MEIPm5XQqktszIxc14jICFt+hGnIktyDH+62I2z
         w5YjuviIHrFiDQ8D36NdEA69URitWMbKqjsORr079b9vM2KR68/rz0wcj1PbvPWpojhX
         mPfNIciKCp1zz8k5n1tx7YIpwbAOYPZPgdIjgVa9n+jYN2HkUPD1jim9msd4gm4zx5sT
         NKMHBQ6+BVr3qqICqom2dTVTVYtHeAZD4S5z+B5VD9Ai3lOg6u45Xbx3dGE8B+2riK+c
         OaYsF2vekc5iJOCRLK0elTiImPbkciQ+/Ry67IwrCwTSuyAgTzhREM3x4ensZnVjRwj0
         YiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TqgN5Aa5NUJat24EGfLQuqbK4yQxb9M7JYmXDBS5pDA=;
        b=LrpMlRRU3u/f3plV8rSgP6d4JNt/9fh2//KR3zDQPh+STgEkKdoQOO0NVZo6ywNgv/
         b59BCM9IhiFJKVlous+Kt6iSJhoFJDsr8KUyYU9C6p6k9lM4qDDQx+nNqWf5b9dUBu9D
         y0JNiip/jmygFqQSHUfpR75pFeNAcZaojtAyoc6Kqd9akifVJIxex7GPCO/2tVN758tp
         kQYap/nnKxpGa0A81p0f0GZWiLLSbQXube5eXLdrucfyHC6AqwlYV9yGijdzjO+ky7up
         aYvU8nn9ZDj2MCzWEjUxTtorK1OlRaV6TCKeEsb8RGg6GIPSYHSnVHxhn+C3QvQlMwTj
         LYjQ==
X-Gm-Message-State: AG10YORpDXCvx3SPsTtxAmb50/W0bTZakZMdEZxe5/Svu3djswzHe3G+CRqY/QWlZL4vKhLeCuva40qptKU4fQ==
MIME-Version: 1.0
X-Received: by 10.28.101.131 with SMTP id z125mr26771788wmb.60.1453870722559;
 Tue, 26 Jan 2016 20:58:42 -0800 (PST)
Received: by 10.27.13.15 with HTTP; Tue, 26 Jan 2016 20:58:42 -0800 (PST)
In-Reply-To: <20160126134229.GA12365@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
        <1453814784-14230-6-git-send-email-chenhc@lemote.com>
        <20160126134229.GA12365@jhogan-linux.le.imgtec.org>
Date:   Wed, 27 Jan 2016 12:58:42 +0800
X-Google-Sender-Auth: x33Y_szqwdIwVI3kWFa0hXYZlew
Message-ID: <CAAhV-H5zFb=rnESwHvgykNVe1FyAC1WX5zAHUXswYwu7a=VPKw@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: Loongson: Introduce and use cpu_has_coherent_cache
 feature
From:   Huacai Chen <chenhc@lemote.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51452
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

"cache coherency" here means the coherency across cores, not ic/dc
coherency, could you please suggest a suitable name?

Huacai

On Tue, Jan 26, 2016 at 9:42 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On Tue, Jan 26, 2016 at 09:26:23PM +0800, Huacai Chen wrote:
>> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
>> feature named cpu_has_coherent_cache and use it to modify MIPS's cache
>> flushing functions.
>
> This is rather ambiguous (the phrase "cache coherency" can be associated
> with dcache coherency between cores). Are you saying that the icache is
> coherent with the dcache, such that writes to dcache are immediately
> visible to instruction fetches on all CPUs in the system without any
> icache flushing?
>
> If so, I think that needs clarifying, e.g. cpu_has_coherent_icache.
>
> Perhaps it should be a flag of icache along with MIPS_CACHE_IC_F_DC too
> which is already intended to avoid the dcache flushes, but not necessary
> the icache flushes.
>
> Cheers
> James
>
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/cpu-features.h                |  3 +++
>>  arch/mips/include/asm/cpu.h                         |  1 +
>>  .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
>>  arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++++++++
>>  4 files changed, 26 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
>> index e0ba50a..1ec3dea 100644
>> --- a/arch/mips/include/asm/cpu-features.h
>> +++ b/arch/mips/include/asm/cpu-features.h
>> @@ -148,6 +148,9 @@
>>  #ifndef cpu_has_xpa
>>  #define cpu_has_xpa          (cpu_data[0].options & MIPS_CPU_XPA)
>>  #endif
>> +#ifndef cpu_has_coherent_cache
>> +#define cpu_has_coherent_cache       (cpu_data[0].options & MIPS_CPU_CACHE_COHERENT)
>> +#endif
>>  #ifndef cpu_has_vtag_icache
>>  #define cpu_has_vtag_icache  (cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
>>  #endif
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index 5f50551..28471f0 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -391,6 +391,7 @@ enum cpu_type_enum {
>>  #define MIPS_CPU_NAN_LEGACY  0x40000000000ull /* Legacy NaN implemented */
>>  #define MIPS_CPU_NAN_2008    0x80000000000ull /* 2008 NaN implemented */
>>  #define MIPS_CPU_LDPTE               0x100000000000ull /* CPU has ldpte/lddir instructions */
>> +#define MIPS_CPU_CACHE_COHERENT      0x200000000000ull /* CPU maintains cache coherency by hardware */
>>
>>  /*
>>   * CPU ASE encodings
>> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>> index c3406db..647d952 100644
>> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>> @@ -46,6 +46,7 @@
>>  #define cpu_has_local_ebase  0
>>
>>  #define cpu_has_wsbh         IS_ENABLED(CONFIG_CPU_LOONGSON3)
>> +#define cpu_has_coherent_cache       IS_ENABLED(CONFIG_CPU_LOONGSON3)
>>  #define cpu_hwrena_impl_bits 0xc0000000
>>
>>  #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 2abc73d..65fb28c 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -429,6 +429,9 @@ static void r4k_blast_scache_setup(void)
>>
>>  static inline void local_r4k___flush_cache_all(void * args)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       switch (current_cpu_type()) {
>>       case CPU_LOONGSON2:
>>       case CPU_LOONGSON3:
>> @@ -457,6 +460,9 @@ static inline void local_r4k___flush_cache_all(void * args)
>>
>>  static void r4k___flush_cache_all(void)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
>>  }
>>
>> @@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
>>  {
>>       int exec = vma->vm_flags & VM_EXEC;
>>
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>>               r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>>  }
>> @@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>>  {
>>       struct flush_cache_page_args args;
>>
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       args.vma = vma;
>>       args.addr = addr;
>>       args.pfn = pfn;
>> @@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>>
>>  static inline void local_r4k_flush_data_cache_page(void * addr)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       r4k_blast_dcache_page((unsigned long) addr);
>>  }
>>
>>  static void r4k_flush_data_cache_page(unsigned long addr)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       if (in_atomic())
>>               local_r4k_flush_data_cache_page((void *)addr);
>>       else
>> @@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>>
>>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
>>       r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>>  }
>>
>> --
>> 2.4.6
>>
>>
>>
>>
>>
