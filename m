Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 07:41:18 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:34681 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025499AbcDTFlQN6zQ4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 07:41:16 +0200
Received: by mail-io0-f195.google.com with SMTP id z133so5564953iod.1;
        Tue, 19 Apr 2016 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=k2xQKmW91aVKKZAHmGD2Sp24CJpmmknQA/w1R9YiLIc=;
        b=GWkj6K/DkJYDTIevGIf7RbNCPlV/1P1aUZg3qDVoBxINKXjR8E2SyvmKrVSJJpQA6l
         9BwBOq3ratvN50Gck5GuDqQHmmdiD3VZIlE2ryobQRxk4h9EvWHQIdHu2rST/24Gnw6/
         a23SeRcY00I0zBqppSRX49N2SHaO5aRkBR5/rL1JUd1Gmat0MRT4pKKJiIDCj517tyBh
         Guh8/u3NKQEpbfo4yxEsYZlj2K+raDgVspSnG3bwMEY88sSipPViep9hu5yw8QU7tmll
         t92VQnlWhgr3EeSZ3qzQtM2+Q3HRPmi1MP993FhK/EsbfVypIMeJ3yEKyigKVIrkroAx
         eZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=k2xQKmW91aVKKZAHmGD2Sp24CJpmmknQA/w1R9YiLIc=;
        b=kfkKE7QwVO0gRgLh/2BXrZikAAzYAWnN6hT5eoCgiDnRZxrROE3qos0DvvMohGvgsT
         9m32pLnheaYA7Gmme2cDEIkdYfdT7aiUuuXT2fk9Lhiqx6EvLLiFlOhmU4aAJplZ1/iZ
         ccrvUW1nYAQ2TDCRxgxcl0lMWTmKdfX78TdlWq7DRnNDca/XfY0ti/XZrD1BqTN1+ZGT
         oZGcoF72/aTzZ46bzaVyLqP4ZEF09Fw/9iaTbe5GX6jaRG+CCat/IiA490JcW4h+6zkf
         rblF8/Lhiq/FpI8pC8FXrO0EAB9g86JatHjBsur+VE0qk7HEaiZFYnQsCXw7KRnl2xN1
         NVEA==
X-Gm-Message-State: AOPr4FUqow5jVzT6nhtRzOPnpte+Vr3dr8UW1NOqX6V38J0rj7F+taz8znDKTUNiUAjy3LY11eX4QvWutZhpyQ==
MIME-Version: 1.0
X-Received: by 10.107.19.42 with SMTP id b42mr7659737ioj.75.1461130870399;
 Tue, 19 Apr 2016 22:41:10 -0700 (PDT)
Received: by 10.36.56.198 with HTTP; Tue, 19 Apr 2016 22:41:10 -0700 (PDT)
In-Reply-To: <5717090E.2050004@roeck-us.net>
References: <20160420025454.GA17200@roeck-us.net>
        <tencent_5BBD94596E55516D1B4FED5F@qq.com>
        <5717090E.2050004@roeck-us.net>
Date:   Wed, 20 Apr 2016 13:41:10 +0800
X-Google-Sender-Auth: Ph7jeZYHUaFYj7KRjp3cdobZ9NQ
Message-ID: <CAAhV-H6Br2r0yMX2+2gCqjY=+LxSh4Pf9pwvZhDu4MYx5b_jZQ@mail.gmail.com>
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
X-archive-position: 53115
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

This is a kernel bug, I'll send a patch.

Huacai

On Wed, Apr 20, 2016 at 12:43 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/19/2016 08:37 PM, 陈华才 wrote:
>>
>> Hi,
>>
>> Could you please remove the line "#define cpu_hwrena_impl_bits
>> 0xc0000000" in arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
>> and try again?Thanks.
>>
>
> That fixes the problem.
>
> Does this need to be addressed in qemu or in the Linux kernel ?
>
> Thanks,
> Guenter
>
>
>> Huacai
>>
>> ------------------ Original ------------------
>> From:  "Guenter Roeck"<linux@roeck-us.net>;
>> Date:  Wed, Apr 20, 2016 10:54 AM
>> To:  "Huacai Chen"<chenhc@lemote.com>;
>> Cc:  "Ralf Baechle"<ralf@linux-mips.org>;
>> "linux-mips"<linux-mips@linux-mips.org>;
>> "linux-next"<linux-next@vger.kernel.org>;
>> "linux-kernel"<linux-kernel@vger.kernel.org>;
>> Subject:  next: fuloong2e qemu boot failure due to 'MIPS: Loongson:
>> AddLoongson-3A R2 basic support'
>>
>> Hi,
>>
>> qemu fails to boot in -next for machine fulong2e with configuration
>> fuloong2e_defconfig. Bisect points to commit 'MIPS: Loongson: Add
>> Loongson-3A R2 basic support'. qemu hangs in boot, after displaying
>> "Inode-cache hash table entries: 16384 (order: 3, 131072 bytes)".
>>
>> Bisect log is attached.
>>
>> Guenter
>>
>> ---
>> # bad: [1bd7a2081d2c7b096f75aa934658e404ccaba5fd] Add linux-next specific
>> files for 20160418
>> # good: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
>> git bisect start 'HEAD' 'v4.6-rc3'
>> # bad: [493ac92ff65ec4c4cd4c43870e778760a012951d] Merge remote-tracking
>> branch 'ipvs-next/master'
>> git bisect bad 493ac92ff65ec4c4cd4c43870e778760a012951d
>> # bad: [20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792] Merge remote-tracking
>> branch 'btrfs-kdave/for-next'
>> git bisect bad 20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792
>> # good: [c454e65fb9ade11d0f84718d06a6888e2c92804d] Merge remote-tracking
>> branch 'omap/for-next'
>> git bisect good c454e65fb9ade11d0f84718d06a6888e2c92804d
>> # good: [6f5c70fb9b4fc0534157bfa40cea9b402e6f2506] Merge remote-tracking
>> branch 'microblaze/next'
>> git bisect good 6f5c70fb9b4fc0534157bfa40cea9b402e6f2506
>> # bad: [7f053cd68fd14243c8f202b4086d7dd75c409e6f] MIPS: Loongson-3:
>> Introduce CONFIG_LOONGSON3_ENHANCEMENT
>> git bisect bad 7f053cd68fd14243c8f202b4086d7dd75c409e6f
>> # good: [e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8] MIPS: Allow RIXI to be
>> used on non-R2 or R6 cores
>> git bisect good e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8
>> # good: [d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d] MAINTAINERS: add
>> Loongson1 architecture entry
>> git bisect good d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d
>> # good: [13ff6275bb389c3669082d3ef8483592a31eb0ea] MIPS: Fix siginfo.h to
>> use strict posix types
>> git bisect good 13ff6275bb389c3669082d3ef8483592a31eb0ea
>> # good: [66e74bdd51e617023fa2e79a807b704fb3eed8aa] MIPS: Enable ptrace hw
>> watchpoints on MIPS R6
>> git bisect good 66e74bdd51e617023fa2e79a807b704fb3eed8aa
>> # good: [f7cabc2dac8adf5986dbc700584bc3b8fe493d4d] MIPS: Loongson-3:
>> Adjust irq dispatch to speedup processing
>> git bisect good f7cabc2dac8adf5986dbc700584bc3b8fe493d4d
>> # bad: [4978c8477e96fb9e9d870d8f42328dcabf1a65e9] MIPS: Loongson-3: Set
>> cache flush handlers to cache_noop
>> git bisect bad 4978c8477e96fb9e9d870d8f42328dcabf1a65e9
>> # bad: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add
>> Loongson-3A R2 basic support
>> git bisect bad 04a35922c1dac1b4864b8b366a37474e9e51d8c0
>> # first bad commit: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS:
>> Loongson: Add Loongson-3A R2 basic support
>>
>
>
