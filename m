Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 07:50:08 +0200 (CEST)
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35570 "EHLO
        mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026111AbcEMFuDwCZVL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2016 07:50:03 +0200
Received: by mail-ig0-f193.google.com with SMTP id jn6so682854igb.2;
        Thu, 12 May 2016 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=TOq96nsV2CT832zIK5ax2sJ6wowMXiJTNDuA10C6tFY=;
        b=pTaSKfV+CD8//GO+HmsnkGxixtTikn3Bh8VGz7wLZv5L/qNe4Ck/YbPdd6NtX6GL85
         /Mmk24hRx27BuODykTmeb/Y5plQis2otIDT62QtHHHKjgKF0xXRz8n7Hgk+1FpB4cGIQ
         SAcJWoqAutLftkK0jkbEvBwSE/LID2iL1QO1SndtOrgGD+gAWUua+rLmsUPTYbLgYYqC
         GFsE+JT1Of4+ja9/ATS5ARpIbTi3giRigoNpuPNPh7fUDYoJ2SRIQsLCvRw7mhDBbLVG
         iWMkBrHL9QwS2otiWpPnRtzJWnsamUfyRr7gbtOL6iO+YrcC1VHNkIb2CokNbLdTHIBz
         LtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=TOq96nsV2CT832zIK5ax2sJ6wowMXiJTNDuA10C6tFY=;
        b=HOUTsPfeDqNoyZN40++f3wsXprYa/FWmo0obG9+rLOXiSp/VJ+9JKiB8/T+K+AhrY+
         yTWu8OEWNp+DHIh755AJXICEymVgQFIm8Lftm9wpechcoklIBpvzJpTRTg16Rzno5rCA
         n7il+UreOBzwVmKEubiqcFKOlV/JshWuSwJ/6eLkRfQ3oDMNjVl4SCvMaaWITH4aFFmN
         ROdM4nXYRSQvoNapkpjOz/n6wxMVMFFCFuLax9CM/Bl7EODFhg8gbSeKUIyaj4exscG4
         zpievdju5PoRUekASMO/ZeS9X6aHt7K8P2uOCQlqaTr/eBgOyWEDY9c34MJB4tezPZHK
         lTYA==
X-Gm-Message-State: AOPr4FW+2ukcTbXTS9JibQ/C3Glf9/WUasRbrTiTebCMsswHcVOHE8YKjKUQsCBlQT/OhiBT5HQOYeliLj3pmw==
MIME-Version: 1.0
X-Received: by 10.50.85.14 with SMTP id d14mr1078345igz.31.1463118598146; Thu,
 12 May 2016 22:49:58 -0700 (PDT)
Received: by 10.36.94.70 with HTTP; Thu, 12 May 2016 22:49:58 -0700 (PDT)
In-Reply-To: <57354E33.8080905@roeck-us.net>
References: <20160420025454.GA17200@roeck-us.net>
        <tencent_5BBD94596E55516D1B4FED5F@qq.com>
        <5717090E.2050004@roeck-us.net>
        <CAAhV-H6Br2r0yMX2+2gCqjY=+LxSh4Pf9pwvZhDu4MYx5b_jZQ@mail.gmail.com>
        <57354E33.8080905@roeck-us.net>
Date:   Fri, 13 May 2016 13:49:58 +0800
X-Google-Sender-Auth: firr7LLwLlKOE8EKXPvS2ewwRJs
Message-ID: <CAAhV-H6s4EmFOqrGFR2YSDV4nyPX_hZDzQ8kt6bYBqDMGNWDJw@mail.gmail.com>
Subject: Re: next: fuloong2e qemu boot failure due to 'MIPS: Loongson:
 AddLoongson-3A R2 basic support'
From:   Huacai Chen <chenhc@lemote.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53422
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

I'll send a patch, but it seems be ignored by maintainer.
https://patchwork.linux-mips.org/patch/13136/

Huacai

On Fri, May 13, 2016 at 11:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/19/2016 10:41 PM, Huacai Chen wrote:
>>
>> This is a kernel bug, I'll send a patch.
>>
>
> Did you ever send a patch to fix this problem ? It is still broken in
> next-20160512.
>
> Guenter
>
>
>> Huacai
>>
>> On Wed, Apr 20, 2016 at 12:43 PM, Guenter Roeck <linux@roeck-us.net>
>> wrote:
>>>
>>> On 04/19/2016 08:37 PM, 陈华才 wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> Could you please remove the line "#define cpu_hwrena_impl_bits
>>>> 0xc0000000" in
>>>> arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>>>> and try again?Thanks.
>>>>
>>>
>>> That fixes the problem.
>>>
>>> Does this need to be addressed in qemu or in the Linux kernel ?
>>>
>>> Thanks,
>>> Guenter
>>>
>>>
>>>> Huacai
>>>>
>>>> ------------------ Original ------------------
>>>> From:  "Guenter Roeck"<linux@roeck-us.net>;
>>>> Date:  Wed, Apr 20, 2016 10:54 AM
>>>> To:  "Huacai Chen"<chenhc@lemote.com>;
>>>> Cc:  "Ralf Baechle"<ralf@linux-mips.org>;
>>>> "linux-mips"<linux-mips@linux-mips.org>;
>>>> "linux-next"<linux-next@vger.kernel.org>;
>>>> "linux-kernel"<linux-kernel@vger.kernel.org>;
>>>> Subject:  next: fuloong2e qemu boot failure due to 'MIPS: Loongson:
>>>> AddLoongson-3A R2 basic support'
>>>>
>>>> Hi,
>>>>
>>>> qemu fails to boot in -next for machine fulong2e with configuration
>>>> fuloong2e_defconfig. Bisect points to commit 'MIPS: Loongson: Add
>>>> Loongson-3A R2 basic support'. qemu hangs in boot, after displaying
>>>> "Inode-cache hash table entries: 16384 (order: 3, 131072 bytes)".
>>>>
>>>> Bisect log is attached.
>>>>
>>>> Guenter
>>>>
>>>> ---
>>>> # bad: [1bd7a2081d2c7b096f75aa934658e404ccaba5fd] Add linux-next
>>>> specific
>>>> files for 20160418
>>>> # good: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
>>>> git bisect start 'HEAD' 'v4.6-rc3'
>>>> # bad: [493ac92ff65ec4c4cd4c43870e778760a012951d] Merge remote-tracking
>>>> branch 'ipvs-next/master'
>>>> git bisect bad 493ac92ff65ec4c4cd4c43870e778760a012951d
>>>> # bad: [20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792] Merge remote-tracking
>>>> branch 'btrfs-kdave/for-next'
>>>> git bisect bad 20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792
>>>> # good: [c454e65fb9ade11d0f84718d06a6888e2c92804d] Merge remote-tracking
>>>> branch 'omap/for-next'
>>>> git bisect good c454e65fb9ade11d0f84718d06a6888e2c92804d
>>>> # good: [6f5c70fb9b4fc0534157bfa40cea9b402e6f2506] Merge remote-tracking
>>>> branch 'microblaze/next'
>>>> git bisect good 6f5c70fb9b4fc0534157bfa40cea9b402e6f2506
>>>> # bad: [7f053cd68fd14243c8f202b4086d7dd75c409e6f] MIPS: Loongson-3:
>>>> Introduce CONFIG_LOONGSON3_ENHANCEMENT
>>>> git bisect bad 7f053cd68fd14243c8f202b4086d7dd75c409e6f
>>>> # good: [e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8] MIPS: Allow RIXI to
>>>> be
>>>> used on non-R2 or R6 cores
>>>> git bisect good e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8
>>>> # good: [d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d] MAINTAINERS: add
>>>> Loongson1 architecture entry
>>>> git bisect good d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d
>>>> # good: [13ff6275bb389c3669082d3ef8483592a31eb0ea] MIPS: Fix siginfo.h
>>>> to
>>>> use strict posix types
>>>> git bisect good 13ff6275bb389c3669082d3ef8483592a31eb0ea
>>>> # good: [66e74bdd51e617023fa2e79a807b704fb3eed8aa] MIPS: Enable ptrace
>>>> hw
>>>> watchpoints on MIPS R6
>>>> git bisect good 66e74bdd51e617023fa2e79a807b704fb3eed8aa
>>>> # good: [f7cabc2dac8adf5986dbc700584bc3b8fe493d4d] MIPS: Loongson-3:
>>>> Adjust irq dispatch to speedup processing
>>>> git bisect good f7cabc2dac8adf5986dbc700584bc3b8fe493d4d
>>>> # bad: [4978c8477e96fb9e9d870d8f42328dcabf1a65e9] MIPS: Loongson-3: Set
>>>> cache flush handlers to cache_noop
>>>> git bisect bad 4978c8477e96fb9e9d870d8f42328dcabf1a65e9
>>>> # bad: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add
>>>> Loongson-3A R2 basic support
>>>> git bisect bad 04a35922c1dac1b4864b8b366a37474e9e51d8c0
>>>> # first bad commit: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS:
>>>> Loongson: Add Loongson-3A R2 basic support
>>>>
>>>
>>>
>>
>
>
