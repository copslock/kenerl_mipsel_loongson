Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 14:49:15 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59059 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903479Ab2FPMtI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2012 14:49:08 +0200
Received: by lbbgg6 with SMTP id gg6so3597039lbb.36
        for <multiple recipients>; Sat, 16 Jun 2012 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EtxvzoHR9pdPwlCl/4DOTfQ6+Gd9/EIFe6pyCOWYqUI=;
        b=Lv7wAYpnP0gFG0oBc70RM3OvS7eSbybm73vZ1vwwCSDt1ZxGL+mW+FJgi3P03984Fr
         //qL+UhkYzPI5e86I5fQSfdoqN1QcmQA+/74NTley8yZSPCbSgNTcUYGafO+xpbZ/ika
         D4uRiaq/jnZpG3HipYvyo0PTdiCJM/5O15DOBVkyHVHOXz5nvhmtLQzepUwGFY7PMOJV
         J/IUaQ1fpOYaL/UzGkZsRD5LK/cy/zwuVsnASbbHNK3WG69Cu8pbbQNuS3swJpF03d9G
         A2G9e5i82jrUCoaqCOhZ3IJq2bVqDIqx0Dw2J3Uo25qz3MEZb/GbmY/4rIlYh2IbhdHt
         qQlA==
MIME-Version: 1.0
Received: by 10.112.41.130 with SMTP id f2mr3853026lbl.5.1339850942701; Sat,
 16 Jun 2012 05:49:02 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Sat, 16 Jun 2012 05:49:02 -0700 (PDT)
In-Reply-To: <20120615161304.GA6390@linux-mips.org>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-2-git-send-email-chenhc@lemote.com>
        <4FDB5BE9.1090303@gmail.com>
        <20120615161304.GA6390@linux-mips.org>
Date:   Sat, 16 Jun 2012 20:49:02 +0800
Message-ID: <CAAhV-H4AAy-k+9XR=SjAdGq9J1qcETuh9iC+bUpY0T_4Bi50=w@mail.gmail.com>
Subject: Re: [PATCH 01/14] MIPS: Loongson: Add basic Loongson 3 CPU support.
From:   huacai chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

OK, I'll split patches next week.

On Sat, Jun 16, 2012 at 12:13 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 15, 2012 at 08:59:37AM -0700, David Daney wrote:
>
>> On 06/15/2012 01:09 AM, Huacai Chen wrote:
>> >Loongson-3 is a multi-core MIPS family CPU, it support MIPS64R2
>> >fully. Loongson-3 has the same IMP field (0x6300) as Loongson-2.
>> >
>> >Loongson-3 has a hardware-maintained cache, system software doesn't
>> >need to maintain coherency.
>> >
>> >Loongson-3A is the first revision of Loongson-3, and it is the quad-
>> >core version of Loongson-2G. Loongson-3A has a simplified version named
>> >Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
>> >HyperTransport controller but 2Gq has only one. HT0 is used for cross-
>> >chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
>> >cannot support NUMA but 3A can.
>> >
>> >Exsisting Loongson family CPUs:
>> >Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
>> >Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G(including Loongson-
>> >             2Gq), they are 64-bit MIPS CPUs.
>> >Loongson-3: Loongson-3A, it is a 64-bit MIPS CPU.
>> >
>> >Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> >Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> >Signed-off-by: Hua Yan<yanh@lemote.com>
>> >---
>> >  arch/mips/Kconfig                            |   13 ++++
>> >  arch/mips/include/asm/addrspace.h            |    6 ++
>> >  arch/mips/include/asm/cpu.h                  |    6 +-
>> >  arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++
>> >  arch/mips/include/asm/module.h               |    2 +
>> >  arch/mips/include/asm/pgtable-bits.h         |    7 ++
>> >  arch/mips/kernel/Makefile                    |    1 +
>> >  arch/mips/kernel/cpu-probe.c                 |   12 +++-
>> >  arch/mips/lib/Makefile                       |    1 +
>> >  arch/mips/loongson/Kconfig                   |    4 +
>> >  arch/mips/loongson/Platform                  |    1 +
>> >  arch/mips/loongson/common/env.c              |    3 +
>> >  arch/mips/loongson/common/setup.c            |    6 +-
>> >  arch/mips/mm/Makefile                        |    1 +
>> >  arch/mips/mm/c-r4k.c                         |   84 ++++++++++++++++++++++++++
>> >  arch/mips/mm/tlb-r4k.c                       |    2 +-
>> >  arch/mips/mm/tlbex.c                         |    1 +
>> >  17 files changed, 156 insertions(+), 9 deletions(-)
>>
>> This patch is too big.  It should be split up into smaller but
>> related parts.
>>
>> For example, the parts that add new identifier constants should be
>> first.  Then a separate patch for cpu-probe.c where they are used.
>>
>> And...
>>
>> >  create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
>> >
>> >diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> >index c179461..38e460b 100644
>> >--- a/arch/mips/Kconfig
>> >+++ b/arch/mips/Kconfig
>> >@@ -1544,6 +1544,16 @@ config CPU_LOONGSON2
>> >     select CPU_SUPPORTS_64BIT_KERNEL
>> >     select CPU_SUPPORTS_HIGHMEM
>> >
>> >+config CPU_LOONGSON3
>> >+    bool "Loongson 3 CPU"
>> >+    depends on SYS_HAS_CPU_LOONGSON3
>> >+    select CPU_SUPPORTS_32BIT_KERNEL
>> >+    select CPU_SUPPORTS_64BIT_KERNEL
>> >+    select CPU_SUPPORTS_HIGHMEM
>> >+    help
>> >+            The Loongson 3 processor implements the MIPS III instruction set
>> >+            with many extensions.
>> >+
>>
>> This bit must be the very last patch of the entire set, not the first.
>>
>> Ask yourself what would happen if someone did a build selecting
>> CPU_LOONGSON3 after this patch were applied?  Would a runnable
>> kernel result?  If the answer is no, then you did it in the wrong
>> order.
>
> Just to clarify and also because I only recently had the discussion with
> somebody.  What is very important is that a patch series never ever
> break something when it gets only partially applied.  This is because
> all the automated testing and debugging that is being used today.  The
> most common example is git-bisect but lately aiaiai [1] is becoming
> fashionable, too.  So I rather spend some extra time on reviewing a big,
> complex patch now than living with the consequences of improper splitting
> later.  But of course properlz split patches are always preferred :-)
>
>  Ralf
>
> [1] http://lwn.net/Articles/488992/
