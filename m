Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 06:02:45 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35759 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcA0FCnivv0Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 06:02:43 +0100
Received: by mail-wm0-f65.google.com with SMTP id 123so1139995wmz.2;
        Tue, 26 Jan 2016 21:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HvMHT3RE/oSrvsvjNsILHbP00NNxCHBCJZBOavLi9zw=;
        b=KYIAqCeww8fozS+jFTSTVs2/hMb2+00kqBDzTLJtoZGDxb4NZ87d0DQNAlBU1P+IE1
         DEbivQo04oAcdzhh0x7kJhBpe4Xt4tTsBktkGLJano40ACDW5UrPgpFIBjdhkWxhV1xS
         OX5/+4Ls+bKYf7xHgfCOC/gTsJliQ+80oJIuBs/FpdevNVkCk8bBDK30MIDsYiakF83K
         zd/L0G+e5M11sI3Xrf43mO0Cy7kfoP5ITpO+8FQxLgqP0pHShPoZeocuDPlT7ik716ds
         fNGetM3TWZz2Lt6YSIt2dv+WQukpIxZM+QxqH1yl5AFXnKSJ8ncIskiPVNLc9V93DOkA
         dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HvMHT3RE/oSrvsvjNsILHbP00NNxCHBCJZBOavLi9zw=;
        b=Tv+4e3mBrbpuJCbw+hFQF1N8Q+ezWnsDDJqxc78YHoljxFBfQ6JLrXFeDv2jcTB4BB
         Ws+ihRQ3Qc+csXtdHqj1ESwyhgpWlm1A0PRLua8m9RjSg23yyAzfEl32dgX0RScb60ck
         WyvJHvhH0CWpMXFr1XIoYzAXsUVaAXD5gHHBJ8ap+4ohXBC+D3h0VsVjNyWg+3fyyO7i
         4fTEmdFkQe9GOLyCYu3FXWT0d5d4IBCG4iZRSFqv7OEf4dxhgIA2uWagEmjX6Qi+DIwY
         3QpObEcabQkbHK1j7o+OvWC4rTOI+Kj6a9Gshn/oMVyvPLcNP+6rSwRFtpFpZ8roUn8l
         GX6A==
X-Gm-Message-State: AG10YOTExpbiO8YAaH0IOajve4JQye+RDNrYwArzQ0LQDhVESJzxM5/GMMGN/HWtFmOx8hUvZQ603xyhajdXEg==
MIME-Version: 1.0
X-Received: by 10.194.240.234 with SMTP id wd10mr30473683wjc.129.1453870958441;
 Tue, 26 Jan 2016 21:02:38 -0800 (PST)
Received: by 10.27.13.15 with HTTP; Tue, 26 Jan 2016 21:02:38 -0800 (PST)
In-Reply-To: <20160126141909.GB12365@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
        <1453814784-14230-7-git-send-email-chenhc@lemote.com>
        <20160126141909.GB12365@jhogan-linux.le.imgtec.org>
Date:   Wed, 27 Jan 2016 13:02:38 +0800
X-Google-Sender-Auth: BO8XrBcxm1mBuzj5H-Om0vE_z1c
Message-ID: <CAAhV-H5Gr_jR=D4JceExhqe0tyxH5JpbkHtw_cQFDmzSBeRErQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
From:   Huacai Chen <chenhc@lemote.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51453
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

STFill Buffer locate between core and L1 cache, it causes memory
access out of order, so writel/outl need a barrier. Loongson 3 has a
bug that di cannot save irqflag, so we need a mfc0.

On Tue, Jan 26, 2016 at 10:19 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Tue, Jan 26, 2016 at 09:26:24PM +0800, Huacai Chen wrote:
>> New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A R1,
>> Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as FTLB,
>> L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User Local
>> register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer), Fast
>> TLB refill support, etc.
>>
>> This patch introduce a config option, CONFIG_LOONGSON3_ENHANCEMENT, to
>> enable those enhancements which cannot be probed at run time. If you
>> want a generic kernel to run on all Loongson 3 machines, please say 'N'
>> here. If you want a high-performance kernel to run on new Loongson 3
>> machines only, please say 'Y' here.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/Kconfig                                      | 18 ++++++++++++++++++
>>  arch/mips/include/asm/hazards.h                        |  7 ++++---
>>  arch/mips/include/asm/io.h                             | 10 +++++-----
>>  arch/mips/include/asm/irqflags.h                       |  5 +++++
>>  .../include/asm/mach-loongson64/kernel-entry-init.h    | 12 ++++++++++++
>>  arch/mips/mm/c-r4k.c                                   |  3 +++
>>  arch/mips/mm/page.c                                    |  9 +++++++++
>>  7 files changed, 56 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 15faaf0..e6d6f7b 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -1349,6 +1349,24 @@ config CPU_LOONGSON3
>>               The Loongson 3 processor implements the MIPS64R2 instruction
>>               set with many extensions.
>>
>> +config LOONGSON3_ENHANCEMENT
>> +     bool "New Loongson 3 CPU Enhancements"
>> +     default n
>
> no need, n is the default.
>
>> +     select CPU_MIPSR2
>> +     select CPU_HAS_PREFETCH
>> +     depends on CPU_LOONGSON3
>> +     help
>> +       New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A
>> +       R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
>> +       FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User
>> +       Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
>> +       Fast TLB refill support, etc.
>> +
>> +       This option enable those enhancements which cannot be probed at run
>> +       time. If you want a generic kernel to run on all Loongson 3 machines,
>> +       please say 'N' here. If you want a high-performance kernel to run on
>> +       new Loongson 3 machines only, please say 'Y' here.
>> +
>>  config CPU_LOONGSON2E
>>       bool "Loongson 2E"
>>       depends on SYS_HAS_CPU_LOONGSON2E
>> diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
>> index 7b99efd..dbb1eb6 100644
>> --- a/arch/mips/include/asm/hazards.h
>> +++ b/arch/mips/include/asm/hazards.h
>> @@ -22,7 +22,8 @@
>>  /*
>>   * TLB hazards
>>   */
>> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
>> +#if (defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)) && \
>> +     !defined(CONFIG_CPU_CAVIUM_OCTEON) && !defined(CONFIG_LOONGSON3_ENHANCEMENT)
>>
>>  /*
>>   * MIPSR2 defines ehb for hazard avoidance
>> @@ -155,8 +156,8 @@ do {                                                                      \
>>  } while (0)
>>
>>  #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
>> -     defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
>> -     defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
>> +     defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_LOONGSON3_ENHANCEMENT) || \
>> +     defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
>>
>>  /*
>>   * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
>> index 2b4dc7a..ecabc00 100644
>> --- a/arch/mips/include/asm/io.h
>> +++ b/arch/mips/include/asm/io.h
>> @@ -304,10 +304,10 @@ static inline void iounmap(const volatile void __iomem *addr)
>>  #undef __IS_KSEG1
>>  }
>>
>> -#ifdef CONFIG_CPU_CAVIUM_OCTEON
>> -#define war_octeon_io_reorder_wmb()          wmb()
>> +#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
>> +#define war_io_reorder_wmb()         wmb()
>>  #else
>> -#define war_octeon_io_reorder_wmb()          do { } while (0)
>> +#define war_io_reorder_wmb()         do { } while (0)
>>  #endif
>
> Doesn't this slow things down when enabled, or is it required due to
> STFill buffer being enabled or something?
>
>>
>>  #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)                  \
>> @@ -318,7 +318,7 @@ static inline void pfx##write##bwlq(type val,                             \
>>       volatile type *__mem;                                           \
>>       type __val;                                                     \
>>                                                                       \
>> -     war_octeon_io_reorder_wmb();                                    \
>> +     war_io_reorder_wmb();                                   \
>>                                                                       \
>>       __mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));    \
>>                                                                       \
>> @@ -387,7 +387,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)        \
>>       volatile type *__addr;                                          \
>>       type __val;                                                     \
>>                                                                       \
>> -     war_octeon_io_reorder_wmb();                                    \
>> +     war_io_reorder_wmb();                                   \
>>                                                                       \
>>       __addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
>>                                                                       \
>> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
>> index 65c351e..12f80b5 100644
>> --- a/arch/mips/include/asm/irqflags.h
>> +++ b/arch/mips/include/asm/irqflags.h
>> @@ -41,7 +41,12 @@ static inline unsigned long arch_local_irq_save(void)
>>       "       .set    push                                            \n"
>>       "       .set    reorder                                         \n"
>>       "       .set    noat                                            \n"
>> +#if defined(CONFIG_LOONGSON3_ENHANCEMENT)
>> +     "       mfc0    %[flags], $12                                   \n"
>> +     "       di                                                      \n"
>
> Does this somehow help performance, or is it necessary when STFill
> buffer is enabled?
>
>> +#else
>>       "       di      %[flags]                                        \n"
>> +#endif
>>       "       andi    %[flags], 1                                     \n"
>>       "       " __stringify(__irq_disable_hazard) "                   \n"
>>       "       .set    pop                                             \n"
>> diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
>> index da83482..8393bc54 100644
>> --- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
>> +++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
>> @@ -26,6 +26,12 @@
>>       mfc0    t0, $5, 1
>>       or      t0, (0x1 << 29)
>>       mtc0    t0, $5, 1
>> +#ifdef CONFIG_LOONGSON3_ENHANCEMENT
>> +     /* Enable STFill Buffer */
>> +     mfc0    t0, $16, 6
>> +     or      t0, 0x100
>> +     mtc0    t0, $16, 6
>> +#endif
>>       _ehb
>>       .set    pop
>>  #endif
>> @@ -46,6 +52,12 @@
>>       mfc0    t0, $5, 1
>>       or      t0, (0x1 << 29)
>>       mtc0    t0, $5, 1
>> +#ifdef CONFIG_LOONGSON3_ENHANCEMENT
>> +     /* Enable STFill Buffer */
>> +     mfc0    t0, $16, 6
>> +     or      t0, 0x100
>> +     mtc0    t0, $16, 6
>> +#endif
>
> What does the STFill buffer do?
>
> Given that you can get a portable kernel without this, can this not be
> done from C code depending on the PRid?
>
>>       _ehb
>>       .set    pop
>>  #endif
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 65fb28c..903d8da 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -1170,6 +1170,9 @@ static void probe_pcache(void)
>>                                         c->dcache.ways *
>>                                         c->dcache.linesz;
>>               c->dcache.waybit = 0;
>> +#ifdef CONFIG_CPU_HAS_PREFETCH
>> +             c->options |= MIPS_CPU_PREFETCH;
>> +#endif
>
> Can't do that based on PRid?
>
> Cheers
> James
>
>>               break;
>>
>>       case CPU_CAVIUM_OCTEON3:
>> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
>> index 885d73f..c41953c 100644
>> --- a/arch/mips/mm/page.c
>> +++ b/arch/mips/mm/page.c
>> @@ -188,6 +188,15 @@ static void set_prefetch_parameters(void)
>>                       }
>>                       break;
>>
>> +             case CPU_LOONGSON3:
>> +                     /* Loongson-3 only support the Pref_Load/Pref_Store. */
>> +                     pref_bias_clear_store = 128;
>> +                     pref_bias_copy_load = 128;
>> +                     pref_bias_copy_store = 128;
>> +                     pref_src_mode = Pref_Load;
>> +                     pref_dst_mode = Pref_Store;
>> +                     break;
>> +
>>               default:
>>                       pref_bias_clear_store = 128;
>>                       pref_bias_copy_load = 256;
>> --
>> 2.4.6
>>
>>
>>
>>
>>
