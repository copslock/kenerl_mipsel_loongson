Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 04:12:07 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34026 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbcBWDMC0uRwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 04:12:02 +0100
Received: by mail-wm0-f68.google.com with SMTP id b205so20074291wmb.1;
        Mon, 22 Feb 2016 19:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TgClZxBK3W3VT62znxB/McVGUuH55v1b8yJckbfZKA4=;
        b=jDmyZaujhoUmj4JfulPuQs5y7ZZk1xDJNvt0FiAC1KqsSIRoVhy0e8FNNs90ZZrXFZ
         5NSfCRqtlsqr5NxANgVtfKOqm41QRiC7LGjvAFHml9+JZlgsd2P6IpknaY8eTYDRtpM2
         Z0AEYBqIXbY/CSHfVOJGF70G+2cXS5ynAEfGOF/CMID9JA2dAE59cuUv3/3VS/w4N1Ir
         DFbgiJO6fpPyE/MRB7oJemkQxjg27dW/4XUTXXv4IBkcsG06ugfry0/u21Chxbkmruju
         qRuq4TwU/dgzKTXRe9XEIRkIXxCiT4ye+fdBWd+F2nvylvTMNROJZzTyxQ4C2y9Puvg5
         clhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TgClZxBK3W3VT62znxB/McVGUuH55v1b8yJckbfZKA4=;
        b=K1dQnMC2g07IT55mh0dNt5/Yj+fRMb7DjlZaSGi6QSKvXo+lugQWDj3+4lcBaSEukt
         DtgYllYvDbwfRq1hwk++6HVZBGeRaWT3U+THtXymO98bCJsi3849zvnhPSdI1xTcfk2L
         1ruBtNzN8o+Pwm0CjzfGotRm3dEsVGcvXbItUc/jnZVFkEKahFCA7Ydp28K6WQbZZX1e
         XXgvu7dQGGJEQN1j+aIP0LRIoFPbl5eJ/BaA3rgbHxBiEw9BMqDfuOX/bRKdMmId5Hbd
         7tOWq3LK1F4b9u3hci0HaOycAcNN+QzcaMpniuCMJiYH5J1nd3tqNm/Dn5ZisXF5FiCq
         6hoA==
X-Gm-Message-State: AG10YORz9tD+Hj8+yLQ4PzPN9nT4SchfD8Gj3qHHxhKzCrP5xdo1ua+484FFj8pzCBxIJD/fzz8LUYTSJCf8MQ==
MIME-Version: 1.0
X-Received: by 10.194.60.100 with SMTP id g4mr30711470wjr.30.1456197117150;
 Mon, 22 Feb 2016 19:11:57 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Mon, 22 Feb 2016 19:11:57 -0800 (PST)
In-Reply-To: <56CB9D42.5070608@gentoo.org>
References: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
        <1454395724-28442-6-git-send-email-chenhc@lemote.com>
        <56CB9D42.5070608@gentoo.org>
Date:   Tue, 23 Feb 2016 11:11:57 +0800
X-Google-Sender-Auth: fT4gpG-FPzlhSaLv9yyW8gWsmdY
Message-ID: <CAAhV-H6tYcOR9gz1_W7vM3ACWzZnQoCnpFTiuMpoa5WHEN==ew@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52177
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

Hi, Joshua

Splitting this patch means the first patch modifies
arch/mips/include/asm/cpu-features.h, arch/mips/include/asm/cpu.h and
arch/mips/mm/c-r4k.c, the second one only modifies
.../asm/mach-loongson64/cpu-feature-overrides.h?

Huacai

On Tue, Feb 23, 2016 at 7:44 AM, Joshua Kinard <kumba@gentoo.org> wrote:
> On 02/02/2016 01:48, Huacai Chen wrote:
>> Loongson-3 maintains cache coherency by hardware, this means:
>>  1) Loongson-3's icache is coherent with dcache.
>>  2) Loongson-3's dcaches don't alias (if PAGE_SIZE>=16K).
>>  3) Loongson-3 maintains cache coherency across cores (and for DMA).
>>
>> So we introduce a cpu feature named cpu_has_coherent_cache and use it
>> to modify MIPS's cache flushing functions.
>
> Could you look at breaking this support out into two separate patches:
>
> 1) First patch adds the generic bits for cpu_has_coherent_cache.
>
> 2) Second patch adds the Loongson-specific bits to utilize it (and remains part
> of the Loongson patch set).
>
> I was playing around with this on my Octane and didn't see any adverse effects
> yet, so maybe it has applications on that platform (or it's another feature of
> the R1x000 taking care of things on its own).  Only tested PAGE_SIZE_64KB,
> though.
>
> Thanks!,
>
> --J
>
>
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
>>
>
>
