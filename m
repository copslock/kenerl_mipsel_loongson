Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 08:48:16 +0100 (CET)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:46051
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991128AbeAaHsCYrnyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 08:48:02 +0100
Received: by mail-vk0-x242.google.com with SMTP id j204so8457395vke.12;
        Tue, 30 Jan 2018 23:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RR4Cyl2bqWx4SXhL+b6aXeeeDGEW+Ibrj7NyT5ep3oc=;
        b=Bw9NuCvcweO5exYheP28Y29WxQgb4/dqUIObXkwZc6L4Afz5T+sSbVnNZqYcWqcX7L
         V6aw4BHrCaleHm/voN6oEvVxFrjZz+0wL9bD/q+SA++ge4NfFAUZU/L1ygBDXDKCjoT1
         eD6n12twOBUDuJnfo4RXqfwPvcQaT2PVN1u0ROc+iYGt+fAlyYFk8+fjDx2+F1lxNOiV
         L3R+HPAO4ocf8rWR5wCLaTcrVTo1ps+j48gabNH6NPJxtgBz2cWZeZq0UGu+NgucA7Du
         4ecrpAchSooykueB5TtuCDTN+578fK9vY3ea6xYLLzZ76YGGS+8tfjuE7nlPKCJoWBi3
         U2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RR4Cyl2bqWx4SXhL+b6aXeeeDGEW+Ibrj7NyT5ep3oc=;
        b=SR4lXy1taMidUGhthzqTzLpqbXEmEfZ2/1HyvCY7veLnNnBGyGl4m2TxkRSMPgbdj5
         NHFwjOKTq9/dWGcRVcQ/EP22mfbN6jXHd4gs3gMsi5JMQ2fDzCet1qE1w1Fyje43Xtma
         27GXQO8mOXqExwBQDOon2Y+dAhj3/d1ZzvXMySy5iWP4dfdntcxHI6MhOiOlIpYea+jn
         Xl3ATrCNC2NfzAhuwPdueOqX2/aaK4bEGLJiUaLVA4P5iyI3Guvqhs+pU909yztlSf8D
         cSzznxPcMDnCjfmXApQ8F4dzajsPvNSln9Qqz4lV7eJgXXwwUFrs4MA5cD4/3I2eHcQ5
         DQ8g==
X-Gm-Message-State: AKwxytdy6t3tgR11Tvh6g6PfkJhrGGyWCbTQ1nvUINzcYVUoCo/GrTuB
        KazpwHB/FEjgc0Hhm6KephaHSnVtoC2Wf16ouVY=
X-Google-Smtp-Source: AH8x225luAPKCp2NmAz2uJ+JTWnYyTdcjA4JpKuYCCUQeXr/24nSO79E9pEqrflmuCnM/Y0cdJeBtxmn0DFJbnOn39s=
X-Received: by 10.31.188.72 with SMTP id m69mr23601892vkf.86.1517384875932;
 Tue, 30 Jan 2018 23:47:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.78.22 with HTTP; Tue, 30 Jan 2018 23:47:35 -0800 (PST)
In-Reply-To: <20180123141756.GE22211@saruman>
References: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
 <20171221210100.12002-1-malat@debian.org> <20180123141756.GE22211@saruman>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 31 Jan 2018 08:47:35 +0100
X-Google-Sender-Auth: Ov7EhWba16yjvR4p8DwQTiMpvgk
Message-ID: <CA+7wUszKJbZTs-8W6s-4a-N7MB=7OrV3Uyp0v-ZZiHmRTVNazw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: fix incorrect mem=X@Y handling
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     "# v4 . 11" <stable@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62373
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

Hi Marcin,

Since it's been a week, could you confirm the patch is ok as-is or do
you think some comment(s) from James should be incorporated ?

On Tue, Jan 23, 2018 at 3:17 PM, James Hogan <jhogan@kernel.org> wrote:
> On Thu, Dec 21, 2017 at 10:00:59PM +0100, Mathieu Malaterre wrote:
>> From: Marcin Nowakowski <marcin.nowakowski@mips.com>
>>
>> Change 73fbc1eba7ff added a fix to ensure that the memory range between
>
> Please refer to commits with e.g. commit 73fbc1eba7ff ("MIPS: fix
> mem=X@Y commandline processing").
>
>> PHYS_OFFSET and low memory address specified by mem= cmdline argument is
>> not later processed by free_all_bootmem.
>> This change was incorrect for systems where the commandline specifies
>> more than 1 mem argument, as it will cause all memory between
>> PHYS_OFFSET and each of the memory offsets to be marked as reserved,
>> which results in parts of the RAM marked as reserved (Creator CI20's
>> u-boot has a default commandline argument 'mem=256M@0x0
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
>> Cc: <stable@vger.kernel.org> # v4.11
>
> I'm guessing that should technically be v4.11+

My fault, if this is the only change, I can re-submit.

>> ---
>> v2: Use updated email adress, add tag for stable.
>>  arch/mips/kernel/setup.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index 702c678de116..f19d61224c71 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>>       unsigned long reserved_end;
>>       unsigned long mapstart = ~0UL;
>>       unsigned long bootmap_size;
>> +     phys_addr_t ramstart = ~0UL;
>
> Although practically it might not matter, technically phys_addr_t may be
> 64-bits (CONFIG_PHYS_ADDR_T_64BIT) even on a 32-bit kernels, in which
> case ~0UL may not be sufficiently large.
>
> Maybe that should be ~(phys_addr_t)0, or perhaps (phys_addr_t)ULLONG_MAX
> to match add_memory_region().
>
>>       bool bootmap_valid = false;
>>       int i;
>>
>> @@ -395,6 +396,21 @@ static void __init bootmem_init(void)
>>       max_low_pfn = 0;
>>
>>       /*
>> +      * Reserve any memory between the start of RAM and PHYS_OFFSET
>> +      */
>> +     for (i = 0; i < boot_mem_map.nr_map; i++) {
>> +             if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>> +                     continue;
>> +
>> +             ramstart = min(ramstart, boot_mem_map.map[i].addr);
>
> Is it worth incorporating this into the existing loop below ...
>
>> +     }
>> +
>> +     if (ramstart > PHYS_OFFSET)
>> +             add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
>> +                               BOOT_MEM_RESERVED);
>
> ... and this then placed below that loop?
>
> Otherwise I can't find fault with this patch, though i'm not intimately
> familiar with bootmem.
>
> Cheers
> James
>
>> +
>> +
>> +     /*
>>        * Find the highest page frame number we have available.
>>        */
>>       for (i = 0; i < boot_mem_map.nr_map; i++) {
>> @@ -664,9 +680,6 @@ static int __init early_parse_mem(char *p)
>>
>>       add_memory_region(start, size, BOOT_MEM_RAM);
>>
>> -     if (start && start > PHYS_OFFSET)
>> -             add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>> -                             BOOT_MEM_RESERVED);
>>       return 0;
>>  }
>>  early_param("mem", early_parse_mem);
>> --
>> 2.11.0
>>
