Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:54:03 +0100 (CET)
Received: from mail-da0-f42.google.com ([209.85.210.42]:60014 "EHLO
        mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825897Ab3CUPyCH3sXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Mar 2013 16:54:02 +0100
Received: by mail-da0-f42.google.com with SMTP id n15so1719947dad.29
        for <multiple recipients>; Thu, 21 Mar 2013 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hwDE9pla9eQDb73OKUyN81VKz7hCu/zAMS7JvHxN/8Y=;
        b=xo3wu9MychSmQiWGYf+yiL+q8O17zIHoCnQIdHGAtVwUzTFqFb8wa/DM4u0+NWvqP0
         l0Qk5tDU+kfIKwCJiKd3XIl0e2wYEL2+I6GhtbIvnBRFtgN8nrsJZqPP047IGuFHJIIU
         HJHW+H8O87/7F6FtUG4Fjvv84p0IlRCQPxJalfHAmRUQjMRTetFzSUp4+bXgp9QTDv0/
         KALmwcskcqNl7ITUywsu1/3vdNb4Xzoqf1lwnVACR0nlC+jTVsABs8G9pUUcKKYI2FnL
         emIVlduQbr/Vps9eULOLZpIbqvUNt4gC45fktHJE02azfUhrHnaG2VYTxin5qudgxz5L
         nn2w==
X-Received: by 10.68.224.169 with SMTP id rd9mr15265457pbc.199.1363881234260;
        Thu, 21 Mar 2013 08:53:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d7sm6523846pbh.45.2013.03.21.08.53.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 08:53:52 -0700 (PDT)
Message-ID: <514B2D0E.808@gmail.com>
Date:   Thu, 21 Mar 2013 08:53:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongbing Hu <huhb@lemote.com>
Subject: Re: [PATCH V2 01/02] MIPS: Build uasm-generated code only once to
 avoid CPU Hotplug problem
References: <1363524578-3765-1-git-send-email-chenhc@lemote.com> <514A42F2.4080501@gmail.com>
In-Reply-To: <514A42F2.4080501@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/20/2013 04:14 PM, David Daney wrote:
> On 03/17/2013 05:49 AM, Huacai Chen wrote:
>> This and the next patch resolve memory corruption problems while CPU
>> hotplug. Without these patches, memory corruption can triggered easily
>> as below:
>>
[...]
>
> We were seeing the same crashes, this patch set seems to fix the problem.
>
> Acked-by: David Daney <david.daney@cavium.com>

On second thought...


>
>> ---
>>   arch/mips/include/asm/cpu-features.h               |    3 +++
>>   .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
>>   arch/mips/mm/page.c                                |   10 ++++++++++
>>   arch/mips/mm/tlbex.c                               |   10 ++++++++--
>>   4 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/cpu-features.h
>> b/arch/mips/include/asm/cpu-features.h
>> index 1a57e8b..e5ec8fc 100644
>> --- a/arch/mips/include/asm/cpu-features.h
>> +++ b/arch/mips/include/asm/cpu-features.h
>> @@ -113,6 +113,9 @@
>>   #ifndef cpu_has_pindexed_dcache
>>   #define cpu_has_pindexed_dcache (cpu_data[0].dcache.flags &
>> MIPS_CACHE_PINDEX)
>>   #endif
>> +#ifndef cpu_has_local_ebase
>> +#define cpu_has_local_ebase    1


This really should default to 0 and only be set for (??who knows what??).

David Daney


>> +#endif
>>
>>   /*
>>    * I-Cache snoops remote store.     This only matters on SMP.  Some
>> multiprocessors
>> diff --git
>> a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>> b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>> index 75fd8c0..c0f3ef4 100644
>> --- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>> +++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>> @@ -57,5 +57,6 @@
>>   #define cpu_has_vint        0
>>   #define cpu_has_vtag_icache    0
>>   #define cpu_has_watch        1
>> +#define cpu_has_local_ebase    0
>>
>>   #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
>> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
>> index a29fba5..4eb8dcf 100644
>> --- a/arch/mips/mm/page.c
>> +++ b/arch/mips/mm/page.c
>> @@ -247,6 +247,11 @@ void __cpuinit build_clear_page(void)
>>       struct uasm_label *l = labels;
>>       struct uasm_reloc *r = relocs;
>>       int i;
>> +    static atomic_t run_once = ATOMIC_INIT(0);
>> +
>> +    if (atomic_xchg(&run_once, 1)) {
>> +        return;
>> +    }
>>
>>       memset(labels, 0, sizeof(labels));
>>       memset(relocs, 0, sizeof(relocs));
>> @@ -389,6 +394,11 @@ void __cpuinit build_copy_page(void)
>>       struct uasm_label *l = labels;
>>       struct uasm_reloc *r = relocs;
>>       int i;
>> +    static atomic_t run_once = ATOMIC_INIT(0);
>> +
>> +    if (atomic_xchg(&run_once, 1)) {
>> +        return;
>> +    }
>>
>>       memset(labels, 0, sizeof(labels));
>>       memset(relocs, 0, sizeof(relocs));
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index 820e661..6bc28b4 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -2162,8 +2162,11 @@ void __cpuinit build_tlb_refill_handler(void)
>>       case CPU_TX3922:
>>       case CPU_TX3927:
>>   #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>> -        build_r3000_tlb_refill_handler();
>> +        if (cpu_has_local_ebase)
>> +            build_r3000_tlb_refill_handler();
>>           if (!run_once) {
>> +            if (!cpu_has_local_ebase)
>> +                build_r3000_tlb_refill_handler();
>>               build_r3000_tlb_load_handler();
>>               build_r3000_tlb_store_handler();
>>               build_r3000_tlb_modify_handler();
>> @@ -2192,9 +2195,12 @@ void __cpuinit build_tlb_refill_handler(void)
>>               build_r4000_tlb_load_handler();
>>               build_r4000_tlb_store_handler();
>>               build_r4000_tlb_modify_handler();
>> +            if (!cpu_has_local_ebase)
>> +                build_r4000_tlb_refill_handler();
>>               run_once++;
>>           }
>> -        build_r4000_tlb_refill_handler();
>> +        if (cpu_has_local_ebase)
>> +            build_r4000_tlb_refill_handler();
>>       }
>>   }
>>
>>
>
