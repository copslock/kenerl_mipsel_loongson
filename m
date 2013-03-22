Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 01:56:34 +0100 (CET)
Received: from mail-bk0-f41.google.com ([209.85.214.41]:37613 "EHLO
        mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834938Ab3CVA4dDs4VT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Mar 2013 01:56:33 +0100
Received: by mail-bk0-f41.google.com with SMTP id q16so1655366bkw.14
        for <multiple recipients>; Thu, 21 Mar 2013 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=m76enff9or/+Prhs4jLj3yMc9xGY2nwffb5lz3ifav8=;
        b=cux/Ux3N5L1LM7FESsH5X22Uhe9iRN19G6JZ74/A/oKtD+HOyWzr0KRXjX3YqPTd/A
         p2grfoe3C+BGIws3/3mhqRbOoO53P8Gi889/VIixSXPlth7vtNwn8KIQpUXst4GFQaSe
         RotNDIwzPovLEBqUiInw2CI458sSb0KHLABXdKBTvYbLWPjrrpQhYKmiERM0t8N/UZsh
         ZmEHqv9f/vtfY0LmztBG/BUzAthhViXfYHiZc+hzR04pYfbjT0+7/OlGiGYbVOlTHr+W
         95tMEOO3xgFKgEncHrgAkSH7Hz7JKiJVpx0bB3GA1+8WvknYhftD/bw7xVnSYQ4xN0JZ
         9u4w==
MIME-Version: 1.0
X-Received: by 10.204.244.196 with SMTP id lr4mr14282865bkb.80.1363913787429;
 Thu, 21 Mar 2013 17:56:27 -0700 (PDT)
Received: by 10.204.24.207 with HTTP; Thu, 21 Mar 2013 17:56:27 -0700 (PDT)
In-Reply-To: <514B2D0E.808@gmail.com>
References: <1363524578-3765-1-git-send-email-chenhc@lemote.com>
        <514A42F2.4080501@gmail.com>
        <514B2D0E.808@gmail.com>
Date:   Fri, 22 Mar 2013 08:56:27 +0800
X-Google-Sender-Auth: nWpSjPnZbHjZ-HUm4C56n_F91d0
Message-ID: <CAAhV-H79SGN-R5paROAzJQ+yuFsF7znOSpzEe+=bKJ9UMtajRw@mail.gmail.com>
Subject: Re: [PATCH V2 01/02] MIPS: Build uasm-generated code only once to
 avoid CPU Hotplug problem
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongbing Hu <huhb@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35938
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Mar 21, 2013 at 11:53 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 03/20/2013 04:14 PM, David Daney wrote:
>>
>> On 03/17/2013 05:49 AM, Huacai Chen wrote:
>>>
>>> This and the next patch resolve memory corruption problems while CPU
>>> hotplug. Without these patches, memory corruption can triggered easily
>>> as below:
>>>
> [...]
>
>>
>> We were seeing the same crashes, this patch set seems to fix the problem.
>>
>> Acked-by: David Daney <david.daney@cavium.com>
>
>
> On second thought...
>
>
>
>>
>>> ---
>>>   arch/mips/include/asm/cpu-features.h               |    3 +++
>>>   .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
>>>   arch/mips/mm/page.c                                |   10 ++++++++++
>>>   arch/mips/mm/tlbex.c                               |   10 ++++++++--
>>>   4 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/cpu-features.h
>>> b/arch/mips/include/asm/cpu-features.h
>>> index 1a57e8b..e5ec8fc 100644
>>> --- a/arch/mips/include/asm/cpu-features.h
>>> +++ b/arch/mips/include/asm/cpu-features.h
>>> @@ -113,6 +113,9 @@
>>>   #ifndef cpu_has_pindexed_dcache
>>>   #define cpu_has_pindexed_dcache (cpu_data[0].dcache.flags &
>>> MIPS_CACHE_PINDEX)
>>>   #endif
>>> +#ifndef cpu_has_local_ebase
>>> +#define cpu_has_local_ebase    1
>
>
>
> This really should default to 0 and only be set for (??who knows what??).
The original code before this patch assume all MIPS has a local ebase.
To minimize the modification, we default it to 1 (but I don't know
which CPU has local ebase).

>
> David Daney
>
>
>
>>> +#endif
>>>
>>>   /*
>>>    * I-Cache snoops remote store.     This only matters on SMP.  Some
>>> multiprocessors
>>> diff --git
>>> a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>>> b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>>> index 75fd8c0..c0f3ef4 100644
>>> --- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>>> +++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>>> @@ -57,5 +57,6 @@
>>>   #define cpu_has_vint        0
>>>   #define cpu_has_vtag_icache    0
>>>   #define cpu_has_watch        1
>>> +#define cpu_has_local_ebase    0
>>>
>>>   #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
>>> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
>>> index a29fba5..4eb8dcf 100644
>>> --- a/arch/mips/mm/page.c
>>> +++ b/arch/mips/mm/page.c
>>> @@ -247,6 +247,11 @@ void __cpuinit build_clear_page(void)
>>>       struct uasm_label *l = labels;
>>>       struct uasm_reloc *r = relocs;
>>>       int i;
>>> +    static atomic_t run_once = ATOMIC_INIT(0);
>>> +
>>> +    if (atomic_xchg(&run_once, 1)) {
>>> +        return;
>>> +    }
>>>
>>>       memset(labels, 0, sizeof(labels));
>>>       memset(relocs, 0, sizeof(relocs));
>>> @@ -389,6 +394,11 @@ void __cpuinit build_copy_page(void)
>>>       struct uasm_label *l = labels;
>>>       struct uasm_reloc *r = relocs;
>>>       int i;
>>> +    static atomic_t run_once = ATOMIC_INIT(0);
>>> +
>>> +    if (atomic_xchg(&run_once, 1)) {
>>> +        return;
>>> +    }
>>>
>>>       memset(labels, 0, sizeof(labels));
>>>       memset(relocs, 0, sizeof(relocs));
>>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>>> index 820e661..6bc28b4 100644
>>> --- a/arch/mips/mm/tlbex.c
>>> +++ b/arch/mips/mm/tlbex.c
>>> @@ -2162,8 +2162,11 @@ void __cpuinit build_tlb_refill_handler(void)
>>>       case CPU_TX3922:
>>>       case CPU_TX3927:
>>>   #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>>> -        build_r3000_tlb_refill_handler();
>>> +        if (cpu_has_local_ebase)
>>> +            build_r3000_tlb_refill_handler();
>>>           if (!run_once) {
>>> +            if (!cpu_has_local_ebase)
>>> +                build_r3000_tlb_refill_handler();
>>>               build_r3000_tlb_load_handler();
>>>               build_r3000_tlb_store_handler();
>>>               build_r3000_tlb_modify_handler();
>>> @@ -2192,9 +2195,12 @@ void __cpuinit build_tlb_refill_handler(void)
>>>               build_r4000_tlb_load_handler();
>>>               build_r4000_tlb_store_handler();
>>>               build_r4000_tlb_modify_handler();
>>> +            if (!cpu_has_local_ebase)
>>> +                build_r4000_tlb_refill_handler();
>>>               run_once++;
>>>           }
>>> -        build_r4000_tlb_refill_handler();
>>> +        if (cpu_has_local_ebase)
>>> +            build_r4000_tlb_refill_handler();
>>>       }
>>>   }
>>>
>>>
>>
>
>
