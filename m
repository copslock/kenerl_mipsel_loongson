Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 16:11:19 +0100 (CET)
Received: from mail-lf0-x235.google.com ([IPv6:2a00:1450:4010:c07::235]:33830
        "EHLO mail-lf0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990484AbdLTPLMLOqdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2017 16:11:12 +0100
Received: by mail-lf0-x235.google.com with SMTP id y78so18760606lfd.1
        for <linux-mips@linux-mips.org>; Wed, 20 Dec 2017 07:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bXuOoDdD5mVnOvmQZ3PyGtQcsDH//+kbobv//PrJqH0=;
        b=Wq2p6TBpk/l8tNSnctXQ0BezK+bsB8y6PQB96vhLmMeF12CnWZgk4014kLKE+HDKXI
         ZZTbKpVL4pZSvPdYCko8ng1ynODLgJP37NxDigszZ+EK8mwXf8/JvQO9L1lyG8ePYwcD
         7c/zHu4WCA3ed9P22OE4hJOLcrq8PGVowJuwKXRQ1oSWjIMs4U9HB2Ml945ThDjYtBz4
         mQpSuqtIaqHEWNvojIGwT7prdTppALRJz8hClgdnH1tQPMP9/BthKd0jaKlgjoIXGAKX
         UOPPDdmr5gpdX1DrebEk5O7Si4LPOnRWoGSp4opSWiUFUD6lOw1LVhaKaFIKbrsyteCL
         FrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bXuOoDdD5mVnOvmQZ3PyGtQcsDH//+kbobv//PrJqH0=;
        b=mGXr/58oUq+kuV7ws9eUz7ozLrIsvKpDBkAGk9ZGy4wPGy67HLpmbYxoGrf2QbVbnx
         GqOJlogfB3ss0jiw3mdUFqtYK5gNdf3PVWwfmpDHsrf2FhCuCi7a+o3lodoiNcj4hL2e
         p95swb13sBs3oOp2ylL4YfsTQEOM8xkuoQWsBwkGWPUyzMvqqHocD4TP99U7TqA0wC/5
         mvJiqMrCuBBwGR4xfCPGLuZRXpx7+B1+aLx/14vhHnhhIbnTj+bTzanuyb6vp5QektsW
         DfxFL/ZRjK9TEMCbHzRYMlZKOXG0spp2HV8TSfiHpA1AwPRQfSGs7erCjFxuhe9UCX0C
         xDOA==
X-Gm-Message-State: AKGB3mI9498fW5UX/WOi2lLfjeNyGsW2yufrWtLirey9cvgdiJYyfj2w
        +EAPVzmGCz9x+tarIrdWQMbp/axr
X-Google-Smtp-Source: ACJfBotttTrVWoTsF0crp9ilrq5NDOeQDLolI7DrPj0AusCadqe8nYRTMygBjwNRzeP5vDugyDFe7Q==
X-Received: by 10.25.56.16 with SMTP id f16mr4614133lfa.31.1513782666269;
        Wed, 20 Dec 2017 07:11:06 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id q62sm3613017ljq.24.2017.12.20.07.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 07:11:05 -0800 (PST)
Subject: Re: [P5600 && EVA memory caching question] PCI region
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
 <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
 <20171215232821.GA5027@jhogan-linux.mipstec.com>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
Date:   Wed, 20 Dec 2017 18:11:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171215232821.GA5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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

Hi, James

On 12/16/2017 02:28 AM, James Hogan wrote:
> On Fri, Dec 15, 2017 at 05:05:12PM +0300, Yuri Frolov wrote:
>> Hi, James
>>
>> On 12/14/2017 06:21 PM, James Hogan wrote:
>>> Hi Yuri,
>>>
>>> On Thu, Dec 14, 2017 at 06:03:11PM +0300, Yuri Frolov wrote:
>>>> Hi, James.
>>>>
>>>> Do I understand correctly, that in case of CONFIG_EVA=y, any logical
>>>> address from 0x00000000 - 0xBFFFFFFF (3G) range accessed from the kernel
>>>> space is:
>>>> 1) Unmapped (no TLB translations)
>>>> 2) Is mapped 1:1 to physical addresses? E.g, readl from 0x20000000 is,
>>>> in fact a read from physical address 0x20000000? I mean, in legacy
>>>> memory mapping scheme, logical addresses 0x80000000 - 0xBFFFFFFF in
>>>> kernel space were being translated to the physical addresses from the
>>>> low 512Mb (phys 0x00000000 - 0x20000000), no such bits stripping or
>>>> something for EVA, the mapping is 1:1?
>>> That depends on the EVA configuration. The hardware is fairly flexible
>>> (which is both useful and painful - making supporting EVA from
>>> multiplatform kernels particularly awkward), but that is one possible
>>> configuration.
>>>
>>> E.g. ideally you probably want to keep seg5 (0x00000000..0x3FFFFFFF)
>>> MUSK (TLB mapped for user & kernel) so that null dereferences from
>>> kernel code are safely caught, but that costs you 1GB of directly
>>> accessible physical address space from kernel mode.
>> So, do I understand correctly, that provided we have these TLB entries
>> in kernel,
>>
>> Index: 71 pgmask=16kb va=c0038000 asid=00
>>           [ri=0 xi=0 pa=200e0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=00000000
>> c=0 d=0 v=0 g=1]
>> Index: 72 pgmask=16kb va=c0040000 asid=00
>>           [ri=0 xi=0 pa=200c0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=200c4000
>> c=2 d=1 v=1 g=1]
>>
>> u32 l;
>>
>> l = readl((const volatile void *)(0x200c0000 + 0x20))
> assuming you have segment5 (0x00000000..0x3FFFFFFF) set to MUSUK, with
> PA 0 (i.e. direct 1:1 mapping), it'd access PA 0x200c0020, but
> presumably the segment will be configured to be cached (CCA 3) or cached
> coherent (CCA 5).
>
>> and
>> l = *(u32 *)(0xc0040000+ 0x20)
> this will access physical addres 0x200c0020 uncached (CCA 2).
>
>> should return the same value?
> So that would depend I think on whether there is a dirty value in the
> cache. Possibly not. The cached mapping would see the dirty value. The
> uncached mapping may see a stale value straight from RAM.
>
> Cheers
> James
I'm looking at arch/mips/include/asm//mach-malta/kernel-entry-init.h and 
there is a definition for SegCtl2:

         /* SegCtl2 */
         li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |      \
                 (6 << MIPS_SEGCFG_PA_SHIFT) |                           \
                 (1 << MIPS_SEGCFG_EU_SHIFT)) |                          \
                 (((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |         \
                 (4 << MIPS_SEGCFG_PA_SHIFT) |                           \
                 (1 << MIPS_SEGCFG_EU_SHIFT)) << 16)

it defines, that kernel logical addresses from the range 0x00000000 - 
0x7fffffff are unmapped (no tlbs) and dictates, that in order to get a 
physical address for any logical addresses from 0x00000000 - 0x3fffffff 
range in kernel space, bits [31:29] of the logical address must be 
changed to 100,
and (again in kernel space) for any logical addresses from 0x40000000 - 
0x7fffffff range, bits [31:29] of the logical address must be changed to 
110, right?

What physical addresses will logical addresses 0x00000000 and 0x20000000 
be translated in kernel space?.. logical 0x00000000 --> physical 
0x80000000, and logical 0x20000000 --> .... 0x80000000 too?
Since we must to change bits [31:29], we have to change bit 29 ('1') in 
logical address 0x200000000 to '0' (since PA for this range is 100).

So, what physical addresses will all logical addresses which have '1' at 
29 bit be translated, if we define PA as 100 and 110 in SegCtl2? It 
looks like there's no flat translation of logical addresses to physical 
addresses in kernel space, and this is obviously just not correct, there 
is something simple I've been overlooking.

Thank you,
Yuri
