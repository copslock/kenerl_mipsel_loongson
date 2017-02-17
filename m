Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 03:29:20 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:35225
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbdBQC3NfOawC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2017 03:29:13 +0100
Received: by mail-ot0-x244.google.com with SMTP id y13so3412971oty.2;
        Thu, 16 Feb 2017 18:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a4OQvaVT7MlhXlgVf8rvpyGK7as3lsYsP0cpNaP5SlI=;
        b=Q6DEoppmjl9B9W5bS3Khg2s2asByHOk23/misbljl82WH7rHNoyVHgT5M8n0We3TOz
         7MycnpWjYw/MGdG3Ktwt/SkTCtTMMFwD6E9AE6kfIRLXt2UjHEzSNG6rks5MqjB4mVUN
         LCA7YsOlUnUCcUqmTCV5+l1Jd2srPpialSjE4eKPBVSTsAG5NZhdIgpi8AmUPAI3yebU
         84X/GyS9163eNQotwG5En6jOGTtrGf6MGjjI//UCoaqoEH9iB4poXiM0hVGoWUvnjp3i
         1qHnvMFDrjg0TiEVzg9bWFtYisjxJHg6+3tjrQOUEXaEBlwHKy1LqH8dy2sn6m8J+1/V
         zG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a4OQvaVT7MlhXlgVf8rvpyGK7as3lsYsP0cpNaP5SlI=;
        b=ZG6WGIdbCdVV0SgUONfCVWPwFsylva2FUMcvkq8JC3mWDW9+LSdeRd+a8Ek4NtB4Go
         WkqHyH4ek9YTwLsehbZwEbMg+XrMNimtJe9M0Pkyb5cO4/9iVkvtNCcbe2ZCbMk8vdTi
         9EIUIF6xl2DVufuGS4F2HRjbsyPiyZ7TPt+Zem5KICFYlxIknmFcBAk8IxA5tAo0+GS+
         LwRl5ukWyb8+Ifbpe9wVjOpgF+KM1khF0ymFkJ34RjdasUdtUNnMd5gOYg8pZbE3C+HC
         h13imLLpp/8W66DlxlqGTQtdU/NoBvoDHRYq1SplP61GBuvBJJQA4bfg8N5hi5dRr/Gq
         14ug==
X-Gm-Message-State: AMke39noMpSwSqRfcISvlxp5VuwjgPilHtNiyfaE9V20oz+vviZJgnwFt/F3/fyZEvxq+15U6F4sVi1ny9dokQ==
X-Received: by 10.157.19.43 with SMTP id f40mr3350386ote.189.1487298547629;
 Thu, 16 Feb 2017 18:29:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.139.114 with HTTP; Thu, 16 Feb 2017 18:29:07 -0800 (PST)
In-Reply-To: <20170213152017.GK24226@jhogan-linux.le.imgtec.org>
References: <1486519069-9364-1-git-send-email-zhoubb@lemote.com> <20170213152017.GK24226@jhogan-linux.le.imgtec.org>
From:   Aaron Chou <zhoubb.aaron@gmail.com>
Date:   Fri, 17 Feb 2017 10:29:07 +0800
Message-ID: <CAMpQs4+AKJsVrcojENGhK8L-U+WWzCtTgc3T+mqJQoCVAwQS=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] MIPS: Loongson: Add the Loongson-1A processor support
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>, Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb.aaron@gmail.com
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

Hi, James:

I appreciate your advis！

On Mon, Feb 13, 2017 at 11:20 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On Wed, Feb 08, 2017 at 09:57:41AM +0800, Binbin Zhou wrote:
>> The Loongson-1A CPU is similar with Loongson-1B/1C, which is a 32-bit SoC.
>>
>> It is a cost-effective single chip system based on LS232 processor core,
>> and is applicable to fields such as industrial control, and security applications.
>>
>> It implements the MIPS32 release 2 instruction set.
>>
>> They share the same PRID, so we rewrite them into PRID_REV_LOONGSON1ABC,
>> and use their CPU macros to distinguish.
>>
>> Changes since v1:
>>
>> 1. According commit c908656a7531771ae7642990a7c5f3c7307bd612
>>    (MIPS: Loongson: Naming style cleanup and rework) to fix the naming style.
>>
>> Changes since v2:
>>
>> 1. Remove __irq_set_handler_locked()
>> 2. Rebases on top of v4.5-rc5.
>>
>> Changes since v3:
>>
>> 1. Rename the Loongson-1 series's PRID name
>> 2. Rewite Loongson-1A's clk driver
>> 2. Rebases on top of v4.10-rc2.
>>
>> Changes since v4:
>>
>> 1. Fix some commit message error
>
> Please can you look back at review comments from previous revisions, as
> most of them seem to be unaddressed & unanswered unless I'm missing
> something, and the common clock framework maintainers still aren't Cc'd
> on the relevant patches.

It's my falut .I will review the comments once again .
And, the relevant people I thought needed have been added. For
example, the Loongson-1B/1C patches' authors.
The common clock framework maintainers will be cc'd in my resend series patch.

>
> Regarding switching to devicetree, note that it can usually be done
> incrementally and without any boot ABI changes by embedding the
> flattened devicetree(s) in the kernel.
>
Due to historic reasons, devicetree is not supported on Loongson-1 platform.
I think it should be improved step by step !

Overall, I will resend the series patch,.plesase review it again.

THS

Cheers
BinBin Zhou


> Cheers
> James
>
>>
>> Binbin Zhou(8):
>>  MIPS: Loongson: Merge PRID macro for Loongson-1A/1B/1C
>>  MIPS: Loongson: Expand Loongson-1's register definition
>>  MIPS: Loongson: Add basic Loongson-1A CPU support
>>  MIPS: Loongson: Add Loongson-1A Kconfig options
>>  MIPS: Loongson: Add platform devices for Loongson-1A
>>  MIPS: Loongson: Add Loongson-1A board support
>>  clk: Loongson: Add Loongson-1A clock support
>>  MIPS: Loongson: Add Loongson-1A default config file
>>
>> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> --
>>  arch/mips/Kconfig                                 |  12 +++++++++
>>  arch/mips/configs/loongson1a_defconfig            | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/mips/include/asm/cpu-type.h                  |   3 ++-
>>  arch/mips/include/asm/cpu.h                       |   3 +--
>>  arch/mips/include/asm/mach-loongson32/irq.h       |  16 ++++++++----
>>  arch/mips/include/asm/mach-loongson32/loongson1.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
>>  arch/mips/include/asm/mach-loongson32/platform.h  |   2 ++
>>  arch/mips/include/asm/mach-loongson32/regs-clk.h  |  30 ++++++++++++++++++++-
>>  arch/mips/include/asm/mach-loongson32/regs-mux.h  |  36 ++++++++++++++++++++++++-
>>  arch/mips/kernel/cpu-probe.c                      |   6 ++++-
>>  arch/mips/loongson32/Kconfig                      |  20 ++++++++++++++
>>  arch/mips/loongson32/Makefile                     |   6 +++++
>>  arch/mips/loongson32/Platform                     |   1 +
>>  arch/mips/loongson32/common/irq.c                 |   2 +-
>>  arch/mips/loongson32/common/platform.c            |  83 ++++++++++++++++++++++++++++++++++++++++++++++++----------
>>  arch/mips/loongson32/common/setup.c               |   6 +++--
>>  arch/mips/loongson32/ls1a/Makefile                |   5 ++++
>>  arch/mips/loongson32/ls1a/board.c                 |  31 ++++++++++++++++++++++
>>  arch/mips/mm/c-r4k.c                              |  10 +++++++
>>  drivers/clk/loongson1/Makefile                    |   1 +
>>  drivers/clk/loongson1/clk-loongson1a.c            |  75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  21 files changed, 593 insertions(+), 58 deletions(-)
>>  create mode 100644 arch/mips/configs/loongson1a_defconfig
>>  create mode 100644 arch/mips/loongson32/ls1a/Makefile
>>  create mode 100644 arch/mips/loongson32/ls1a/board.c
>>  create mode 100644 drivers/clk/loongson1/clk-loongson1a.c
>> --
>> 1.9.0
>>
>>
