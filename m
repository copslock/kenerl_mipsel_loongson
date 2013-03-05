Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 04:39:35 +0100 (CET)
Received: from mail-wg0-f53.google.com ([74.125.82.53]:39868 "EHLO
        mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3CEDjdQQ0pv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Mar 2013 04:39:33 +0100
Received: by mail-wg0-f53.google.com with SMTP id fn15so5069132wgb.20
        for <multiple recipients>; Mon, 04 Mar 2013 19:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=KP1XLRT3tqB1ZtNBQvRS/Se1mRTyH71tGJhlxpCHOUU=;
        b=LNiEyuu6ZC12ujIJvVtGPyDqTmvCKc9Q8nAvi/4iZiiwii/l6Tx3/BEEuTos3/n08y
         YgtuHyVT/KNvdRRytwxKbPANuDzzl8Fru/wcgxFDXGMPrCWEhv2320orK8lucL99gpiQ
         ov9Z2FbW8BY/p9MB7WtzEi7G67i8x3OeWJTpX/XDi3eJhAdDMZbLEv4OdiP4D2+D4WDZ
         a+AQ8GLjnFlSEaj05KnsGs9VuMZj90sRDiL7kQ3srSeYAyvkFCTVZLHCIkSkevQSD6Ij
         MdCiLYDfiMsdvEWZy6cKnOv++o+JXJ3ZxZdZ74DtGDgJ0osy4eKQ4RdXhe8B0758NI1t
         gocQ==
MIME-Version: 1.0
X-Received: by 10.205.129.16 with SMTP id hg16mr8517450bkc.11.1362454767775;
 Mon, 04 Mar 2013 19:39:27 -0800 (PST)
Received: by 10.204.24.207 with HTTP; Mon, 4 Mar 2013 19:39:27 -0800 (PST)
In-Reply-To: <5134EA49.6020807@gmail.com>
References: <1362401764-31494-1-git-send-email-chenhc@lemote.com>
        <5134EA49.6020807@gmail.com>
Date:   Tue, 5 Mar 2013 11:39:27 +0800
X-Google-Sender-Auth: QDcKc1o-cpYPGMBiIiQRZzKl3qc
Message-ID: <CAAhV-H6eZ7wUYuE7Ot-zXaBbGiX3vzhvAvsp0g3sced_Yf3x2w@mail.gmail.com>
Subject: Re: [PATCH RFC] MIPS: Build uasm-generated code only once to avoid
 CPU Hotplug problem
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongbing Hu <huhb@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35845
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

OK, I'm reworking...

On Tue, Mar 5, 2013 at 2:39 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 03/04/2013 04:56 AM, Huacai Chen wrote:
>>
>> Currently, clear_page()/copy_page() are generated by Micro-assembler
>> dynamically. But they are unavailable until uasm_resolve_relocs() has
>> finished because jump labels are illegal before that. Since these
>> functions are shared by every CPU, we only call build_clear_page()/
>> build_copy_page() on CPU#0 at boot time. Without this patch, programs
>> will get random memory corruption (segmentation fault, bus error, etc.)
>> while CPU Hotplug (e.g. one CPU is using clear_page() while another is
>> generating it in cpu_cache_init()).
>>
>> For similar reasons we modify build_tlb_refill_handler()'s invocation.
>>
>
> I like the general idea behind the patch.  But would prefer to move the test
> to the functions that are generating the code.  That way if more call sites
> are added, we don't have to copy the boiler-plate testing code.
>
> Also can we change the test to something like:
>
>    static atomic_t execute_once;
>    .
>    .
>    .
>    if (!atomic_xchg(&execute_once, 1)) {
>       /* Generate the code */
>    }
>    .
>    .
>    .
>
> That way if we take CPU-0 on and off line, the code will not be regenerated.
>
> Thanks,
> David Daney
>
>
>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongbing Hu <huhb@lemote.com>
>> ---
>>   arch/mips/mm/c-octeon.c        |    6 ++++--
>>   arch/mips/mm/c-r3k.c           |    6 ++++--
>>   arch/mips/mm/c-r4k.c           |    6 ++++--
>>   arch/mips/mm/c-tx39.c          |    6 ++++--
>>   arch/mips/mm/tlb-r3k.c         |    3 ++-
>>   arch/mips/mm/tlb-r4k.c         |    3 ++-
>>   arch/mips/mm/tlb-r8k.c         |    3 ++-
>>   arch/mips/sgi-ip27/ip27-init.c |    3 ++-
>>   8 files changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
>> index 6ec04da..181a1bc 100644
>> --- a/arch/mips/mm/c-octeon.c
>> +++ b/arch/mips/mm/c-octeon.c
>> @@ -280,8 +280,10 @@ void __cpuinit octeon_cache_init(void)
>>
>>         __flush_kernel_vmap_range       = octeon_flush_kernel_vmap_range;
>>
>> -       build_clear_page();
>> -       build_copy_page();
>> +       if (smp_processor_id() == 0) {
>> +               build_clear_page();
>> +               build_copy_page();
>> +       }
>>
>>         board_cache_error_setup = octeon_cache_error_setup;
>>   }
>> diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
>> index 031c4c2..b7b0cfd 100644
>> --- a/arch/mips/mm/c-r3k.c
>> +++ b/arch/mips/mm/c-r3k.c
>> @@ -342,6 +342,8 @@ void __cpuinit r3k_cache_init(void)
>>         printk("Primary data cache %ldkB, linesize %ld bytes.\n",
>>                 dcache_size >> 10, dcache_lsize);
>>
>> -       build_clear_page();
>> -       build_copy_page();
>> +       if (smp_processor_id() == 0) {
>> +               build_clear_page();
>> +               build_copy_page();
>> +       }
>>   }
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 5f9171d..3f671d6 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -1548,8 +1548,10 @@ void __cpuinit r4k_cache_init(void)
>>         }
>>   #endif
>>
>> -       build_clear_page();
>> -       build_copy_page();
>> +       if (smp_processor_id() == 0) {
>> +               build_clear_page();
>> +               build_copy_page();
>> +       }
>>   #if !defined(CONFIG_MIPS_CMP)
>>         local_r4k___flush_cache_all(NULL);
>>   #endif
>> diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
>> index 87d23ca..1e42e12 100644
>> --- a/arch/mips/mm/c-tx39.c
>> +++ b/arch/mips/mm/c-tx39.c
>> @@ -434,7 +434,9 @@ void __cpuinit tx39_cache_init(void)
>>         printk("Primary data cache %ldkB, linesize %d bytes\n",
>>                 dcache_size >> 10, current_cpu_data.dcache.linesz);
>>
>> -       build_clear_page();
>> -       build_copy_page();
>> +       if (smp_processor_id() == 0) {
>> +               build_clear_page();
>> +               build_copy_page();
>> +       }
>>         tx39h_flush_icache_all();
>>   }
>> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
>> index a63d1ed..86b4a79 100644
>> --- a/arch/mips/mm/tlb-r3k.c
>> +++ b/arch/mips/mm/tlb-r3k.c
>> @@ -280,5 +280,6 @@ void __cpuinit tlb_init(void)
>>   {
>>         local_flush_tlb_all();
>>
>> -       build_tlb_refill_handler();
>> +       if (smp_processor_id() == 0)
>> +               build_tlb_refill_handler();
>>   }
>> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> index 0113330..db19624 100644
>> --- a/arch/mips/mm/tlb-r4k.c
>> +++ b/arch/mips/mm/tlb-r4k.c
>> @@ -439,5 +439,6 @@ void __cpuinit tlb_init(void)
>>                         printk("Ignoring invalid argument ntlb=%d\n",
>> ntlb);
>>         }
>>
>> -       build_tlb_refill_handler();
>> +       if (smp_processor_id() == 0)
>> +               build_tlb_refill_handler();
>>   }
>> diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
>> index 91c2499..43fe634 100644
>> --- a/arch/mips/mm/tlb-r8k.c
>> +++ b/arch/mips/mm/tlb-r8k.c
>> @@ -244,5 +244,6 @@ void __cpuinit tlb_init(void)
>>
>>         local_flush_tlb_all();
>>
>> -       build_tlb_refill_handler();
>> +       if (smp_processor_id() == 0)
>> +               build_tlb_refill_handler();
>>   }
>> diff --git a/arch/mips/sgi-ip27/ip27-init.c
>> b/arch/mips/sgi-ip27/ip27-init.c
>> index 923c080..62c41ab 100644
>> --- a/arch/mips/sgi-ip27/ip27-init.c
>> +++ b/arch/mips/sgi-ip27/ip27-init.c
>> @@ -84,7 +84,8 @@ static void __cpuinit per_hub_init(cnodeid_t cnode)
>>
>>                 memcpy((void *)(CKSEG0 + 0x100), &except_vec2_generic,
>> 0x80);
>>                 memcpy((void *)(CKSEG0 + 0x180), &except_vec3_generic,
>> 0x80);
>> -               build_tlb_refill_handler();
>> +               if (smp_processor_id() == 0)
>> +                       build_tlb_refill_handler();
>>                 memcpy((void *)(CKSEG0 + 0x100), (void *) CKSEG0, 0x80);
>>                 memcpy((void *)(CKSEG0 + 0x180), &except_vec3_generic,
>> 0x100);
>>                 __flush_cache_all();
>>
>
>
