Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 14:01:16 +0100 (CET)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:42198 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013112AbcBXNBK2uU02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 14:01:10 +0100
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id ND0n1s0022VvR6D01D124K; Wed, 24 Feb 2016 13:01:02 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id ND101s0030w5D3801D10y3; Wed, 24 Feb 2016 13:01:02 +0000
Subject: Re: [PATCH V2 5/6] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
To:     Huacai Chen <chenhc@lemote.com>
References: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
 <1454395724-28442-6-git-send-email-chenhc@lemote.com>
 <56CB9D42.5070608@gentoo.org>
 <CAAhV-H6tYcOR9gz1_W7vM3ACWzZnQoCnpFTiuMpoa5WHEN==ew@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56CDA980.5090103@gentoo.org>
Date:   Wed, 24 Feb 2016 08:00:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6tYcOR9gz1_W7vM3ACWzZnQoCnpFTiuMpoa5WHEN==ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1456318862;
        bh=N8ZdGgPgEfy6hfCePlKqY2cV4Ne2vijzu/iq9vKU31s=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=u+9kMH6eREMQwNnZTsV4/wUmONLb7o7EuXmswgmq3BCmGHHYTIv+FdNsJxY7NMnBp
         N3mUOOsuOKEYXjOSJRXafOIt4DdCg/UeYf5k6syzDs02NLydfNPJlYeWZkGBbwdYcW
         ckN20MJ8pUAM6YSMWgAUnQkiXssPhUQRjQdfYr/cxmXFAhtwOgLBLcO32Dn66rD7PW
         GNJ7RuIHiU4Ajgks1B3q9vKKWxNw+6Z6V+7YKOMTIfSQmkTfZG74ICtgHwLWCwTdPL
         feg8K+wCruKJ69aJxwzsqSfCrvSHrg95J2J3tHdrAIDBm8pGastOWCUYDyMw4BaHtM
         oWuP3laAf4jKg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 02/22/2016 22:11, Huacai Chen wrote:
> Hi, Joshua
> 
> Splitting this patch means the first patch modifies
> arch/mips/include/asm/cpu-features.h, arch/mips/include/asm/cpu.h and
> arch/mips/mm/c-r4k.c, the second one only modifies
> .../asm/mach-loongson64/cpu-feature-overrides.h?

Yup.  I'd also break out that TLB bug fix patch into its own from the Loongson
patchset as well.  Seems to be a corner case bug, but if it addresses an actual
problem that isn't Loongson-specific, it might be a candidate to get backported
to the stable branches as well.

--J



> Huacai
> 
> On Tue, Feb 23, 2016 at 7:44 AM, Joshua Kinard <kumba@gentoo.org> wrote:
>> On 02/02/2016 01:48, Huacai Chen wrote:
>>> Loongson-3 maintains cache coherency by hardware, this means:
>>>  1) Loongson-3's icache is coherent with dcache.
>>>  2) Loongson-3's dcaches don't alias (if PAGE_SIZE>=16K).
>>>  3) Loongson-3 maintains cache coherency across cores (and for DMA).
>>>
>>> So we introduce a cpu feature named cpu_has_coherent_cache and use it
>>> to modify MIPS's cache flushing functions.
>>
>> Could you look at breaking this support out into two separate patches:
>>
>> 1) First patch adds the generic bits for cpu_has_coherent_cache.
>>
>> 2) Second patch adds the Loongson-specific bits to utilize it (and remains part
>> of the Loongson patch set).
>>
>> I was playing around with this on my Octane and didn't see any adverse effects
>> yet, so maybe it has applications on that platform (or it's another feature of
>> the R1x000 taking care of things on its own).  Only tested PAGE_SIZE_64KB,
>> though.
>>
>> Thanks!,
>>
>> --J
>>
>>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> ---
>>>  arch/mips/include/asm/cpu-features.h                |  3 +++
>>>  arch/mips/include/asm/cpu.h                         |  1 +
>>>  .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
>>>  arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++++++++
>>>  4 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
>>> index e0ba50a..1ec3dea 100644
>>> --- a/arch/mips/include/asm/cpu-features.h
>>> +++ b/arch/mips/include/asm/cpu-features.h
>>> @@ -148,6 +148,9 @@
>>>  #ifndef cpu_has_xpa
>>>  #define cpu_has_xpa          (cpu_data[0].options & MIPS_CPU_XPA)
>>>  #endif
>>> +#ifndef cpu_has_coherent_cache
>>> +#define cpu_has_coherent_cache       (cpu_data[0].options & MIPS_CPU_CACHE_COHERENT)
>>> +#endif
>>>  #ifndef cpu_has_vtag_icache
>>>  #define cpu_has_vtag_icache  (cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
>>>  #endif
>>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>>> index 5f50551..28471f0 100644
>>> --- a/arch/mips/include/asm/cpu.h
>>> +++ b/arch/mips/include/asm/cpu.h
>>> @@ -391,6 +391,7 @@ enum cpu_type_enum {
>>>  #define MIPS_CPU_NAN_LEGACY  0x40000000000ull /* Legacy NaN implemented */
>>>  #define MIPS_CPU_NAN_2008    0x80000000000ull /* 2008 NaN implemented */
>>>  #define MIPS_CPU_LDPTE               0x100000000000ull /* CPU has ldpte/lddir instructions */
>>> +#define MIPS_CPU_CACHE_COHERENT      0x200000000000ull /* CPU maintains cache coherency by hardware */
>>>
>>>  /*
>>>   * CPU ASE encodings
>>> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>>> index c3406db..647d952 100644
>>> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>>> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>>> @@ -46,6 +46,7 @@
>>>  #define cpu_has_local_ebase  0
>>>
>>>  #define cpu_has_wsbh         IS_ENABLED(CONFIG_CPU_LOONGSON3)
>>> +#define cpu_has_coherent_cache       IS_ENABLED(CONFIG_CPU_LOONGSON3)
>>>  #define cpu_hwrena_impl_bits 0xc0000000
>>>
>>>  #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
>>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>>> index 2abc73d..65fb28c 100644
>>> --- a/arch/mips/mm/c-r4k.c
>>> +++ b/arch/mips/mm/c-r4k.c
>>> @@ -429,6 +429,9 @@ static void r4k_blast_scache_setup(void)
>>>
>>>  static inline void local_r4k___flush_cache_all(void * args)
>>>  {
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       switch (current_cpu_type()) {
>>>       case CPU_LOONGSON2:
>>>       case CPU_LOONGSON3:
>>> @@ -457,6 +460,9 @@ static inline void local_r4k___flush_cache_all(void * args)
>>>
>>>  static void r4k___flush_cache_all(void)
>>>  {
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
>>>  }
>>>
>>> @@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
>>>  {
>>>       int exec = vma->vm_flags & VM_EXEC;
>>>
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>>>               r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>>>  }
>>> @@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>>>  {
>>>       struct flush_cache_page_args args;
>>>
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       args.vma = vma;
>>>       args.addr = addr;
>>>       args.pfn = pfn;
>>> @@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>>>
>>>  static inline void local_r4k_flush_data_cache_page(void * addr)
>>>  {
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       r4k_blast_dcache_page((unsigned long) addr);
>>>  }
>>>
>>>  static void r4k_flush_data_cache_page(unsigned long addr)
>>>  {
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       if (in_atomic())
>>>               local_r4k_flush_data_cache_page((void *)addr);
>>>       else
>>> @@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>>>
>>>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>>>  {
>>> +     if (cpu_has_coherent_cache)
>>> +             return;
>>> +
>>>       r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>>>  }
>>>
