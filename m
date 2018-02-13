Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 13:15:06 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:46428
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992896AbeBMMO4yB5xI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 13:14:56 +0100
Received: by mail-ua0-x244.google.com with SMTP id y17so9658898uaa.13;
        Tue, 13 Feb 2018 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gwsSFUr9k2BwJp6sZwYWJa4Yj8JsiLhPcFX025yHSMA=;
        b=UJQpNB20sJBRU0QwWtvMnoTXN5L7deZsmammya6fquiI5ehEDzXZ25MiFMQBmrKB06
         oJzrtc7CPCdCRj1/bqOkVTQE5p5HYX9Bvf298KD+BhRc+tqbU3zCUIoLvVb1+ltQblHX
         ebZ2xv/pa/7ImZ0QK46Njf0N6XBVk1TYUWtuA0FxAQZ0n9cmB582LHsM5MNbvBWn0r+n
         8IMEaiPPkJQw1FFkYlCnPSjEpBCTIE/L/xNdrW0kWnqGcS1ByxwmlyzKWXbSF85/i4QF
         SCjdrYJw9eHXJ5SgJJjiGWljCE7+Quzf7CU2tYwkvvydO2FWHbyVXMZ5fTvIDMGrgloQ
         bgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gwsSFUr9k2BwJp6sZwYWJa4Yj8JsiLhPcFX025yHSMA=;
        b=BvpZifFe0VByzRLqXcA0jBdBYJeNzms4ezCsQSNLwFZ1XT1a2KqmrLUHPO5ctEO30y
         7ivZRQjFFcUOZN205t1dqtZ+M9BZBIWHQpKgeCpWK3nLUByUt8rsUKhvANzuxmR1CfMY
         3ytkAxRpYCLEUrBelsVrXs/0YiI0Anlv5NJutAr1P+h5CLwmp3FHfadswZYppnJa9tv0
         g1ux/Li/jw6Epq37Ly778vQ6inVru+E8PqMxuwwwhK/SXCKZagmoii1ib06lMgcvSw7n
         MRO8i1vm05cG57EQ19/GeMKP4caM30msA9dH47v+Fg8/RAjQ9tN8Gzmr+rt1I0/VkqAd
         v5nQ==
X-Gm-Message-State: APf1xPCS3P9AS9D/WThz3uXhEX82Vt81j0VZ15HoK2ZCcx0JKD/pROJJ
        Dw3eXMDDl2Tfom9/eukDRfTs0K9rDM8YTs6CQ+w=
X-Google-Smtp-Source: AH8x225POk4na+idFU0b+ZfL8AMy6xwDM8cNxVWxNxgkxEPNqC0YZo3OuqBi/N+zRuC0mNfAbNQ4Wy+KTxBuVabyvQI=
X-Received: by 10.176.19.243 with SMTP id n48mr912718uae.14.1518524090306;
 Tue, 13 Feb 2018 04:14:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.38.193 with HTTP; Tue, 13 Feb 2018 04:14:29 -0800 (PST)
In-Reply-To: <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com> <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 13 Feb 2018 13:14:29 +0100
X-Google-Sender-Auth: SCf1Cs005Dc4lEYoD_xGnky8fjE
Message-ID: <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        linux-mips@linux-mips.org, "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

James,

On Thu, Feb 1, 2018 at 1:12 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Thu, Feb 1, 2018 at 12:37 PM, Marcin Nowakowski
> <marcin.nowakowski@mips.com> wrote:
>> Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
>> fix to ensure that the memory range between PHYS_OFFSET and low memory
>> address specified by mem= cmdline argument is not later processed by
>> free_all_bootmem.  This change was incorrect for systems where the
>> commandline specifies more than 1 mem argument, as it will cause all
>> memory between PHYS_OFFSET and each of the memory offsets to be marked
>> as reserved, which results in parts of the RAM marked as reserved
>> (Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
>> mem=768M@0x30000000').
>>
>> Change the behaviour to ensure that only the range between PHYS_OFFSET
>> and the lowest start address of the memories is marked as protected.
>>
>> This change also ensures that the range is marked protected even if it's
>> only defined through the devicetree and not only via commandline
>> arguments.
>>
>> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
>> Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
>> Cc: <stable@vger.kernel.org> # v4.11+
>> ---
>> v3: Update stable version, code cleanup as suggested by James Hogan
>> v2: Use updated email adress, add tag for stable.
>> ---
>>  arch/mips/kernel/setup.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index 702c678de116..e4a1581ce822 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>>         unsigned long reserved_end;
>>         unsigned long mapstart = ~0UL;
>>         unsigned long bootmap_size;
>> +       phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
>>         bool bootmap_valid = false;
>>         int i;
>>
>> @@ -395,7 +396,8 @@ static void __init bootmem_init(void)
>>         max_low_pfn = 0;
>>
>>         /*
>> -        * Find the highest page frame number we have available.
>> +        * Find the highest page frame number we have available
>> +        * and the lowest used RAM address
>>          */
>>         for (i = 0; i < boot_mem_map.nr_map; i++) {
>>                 unsigned long start, end;
>> @@ -407,6 +409,8 @@ static void __init bootmem_init(void)
>>                 end = PFN_DOWN(boot_mem_map.map[i].addr
>>                                 + boot_mem_map.map[i].size);
>>
>> +               ramstart = min(ramstart, boot_mem_map.map[i].addr);
>> +
>>  #ifndef CONFIG_HIGHMEM
>>                 /*
>>                  * Skip highmem here so we get an accurate max_low_pfn if low
>> @@ -436,6 +440,13 @@ static void __init bootmem_init(void)
>>                 mapstart = max(reserved_end, start);
>>         }
>>
>> +       /*
>> +        * Reserve any memory between the start of RAM and PHYS_OFFSET
>> +        */
>> +       if (ramstart > PHYS_OFFSET)
>> +               add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
>> +                                 BOOT_MEM_RESERVED);
>> +
>>         if (min_low_pfn >= max_low_pfn)
>>                 panic("Incorrect memory mapping !!!");
>>         if (min_low_pfn > ARCH_PFN_OFFSET) {
>> @@ -664,9 +675,6 @@ static int __init early_parse_mem(char *p)
>>
>>         add_memory_region(start, size, BOOT_MEM_RAM);
>>
>> -       if (start && start > PHYS_OFFSET)
>> -               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>> -                               BOOT_MEM_RESERVED);
>>         return 0;
>>  }
>>  early_param("mem", early_parse_mem);
>> --
>> 2.14.1
>>
>
> Looks good to me:
>
> $ cat /proc/cpuinfo
> system type : JZ4780
> machine : Creator CI20
> processor : 0
> cpu model : Ingenic JZRISC V4.15  FPU V0.0
> BogoMIPS : 956.00
> wait instruction : yes
> microsecond timers : no
> tlb_entries : 32
> extra interrupt vector : yes
> hardware watchpoint : yes, count: 1, address/irw mask: [0x0fff]
> isa : mips1 mips2 mips32r1 mips32r2
> ASEs implemented :
> shadow register sets : 1
> kscratch registers : 0
> package : 0
> core : 0
> VCED exceptions : not available
> VCEI exceptions : not available
> $ uname -a
> Linux ci20 4.15.0+ #323 PREEMPT Thu Feb 1 13:08:11 CET 2018 mips GNU/Linux
>
> Tested-by: Mathieu Malaterre <malat@debian.org>
>
> Thanks

Could you please review the patch v3 ?

Thanks,
