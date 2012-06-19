Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 12:44:56 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64466 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2FSKot convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 12:44:49 +0200
Received: by lbbgg6 with SMTP id gg6so5866508lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tggjG55otA5w3xC5qx4TfqgSuDag17lsfyt+E18FdRc=;
        b=c2EcJUmBLqytdOC0Mad32O6tA1FrkFJ2hdrgUWnuPkhJR9EXaP6FOTqtE9ypBQC4yv
         HmLU54xK6TSCwOulWju4pMHVb01153aNOXseMS+/o4+RaVCNqO1/9ywQBUrWtHI/fy9u
         W7rX6elVAQlFEKi9eMy8C5uOEX6jiwxvuAK9JunVGc9AGl7Ln0W6Cj15In8tXY2ejuwe
         EI6bzL8No5P/fmr3aQcu2x7yFmMvOJz9IcljvVx8rerGiAWQaCUibygvR41+kpBdZ8Fq
         BBgRJPAW0Ix8qfLA2v93p6nzVBo2ixo4m3/uHSUU45GKWN08sGMKFKsKbIFNERS3Fz2B
         4jvw==
MIME-Version: 1.0
Received: by 10.152.122.116 with SMTP id lr20mr17700636lab.42.1340102683321;
 Tue, 19 Jun 2012 03:44:43 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 03:44:43 -0700 (PDT)
In-Reply-To: <1686045.33sK9Drd7j@flexo>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-2-git-send-email-chenhc@lemote.com>
        <1686045.33sK9Drd7j@flexo>
Date:   Tue, 19 Jun 2012 18:44:43 +0800
Message-ID: <CAAhV-H52bUnfvKvyJTBwUZep0V3LfQ=1QVi6i=LCSzFNSGRUOQ@mail.gmail.com>
Subject: Re: [PATCH V2 01/16] MIPS: Loongson: Add basic Loongson-3 definition.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33715
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

When designing CPU, Loongson-2 is single-core and Loongson-3 is
multi-core, but their core is the same. So, there IMP field is also
the same.

On Tue, Jun 19, 2012 at 5:36 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hi,
>
> On Tuesday 19 June 2012 14:50:09 Huacai Chen wrote:
>> Loongson-3 is a multi-core MIPS family CPU, it support MIPS64R2
>> fully. Loongson-3 has the same IMP field (0x6300) as Loongson-2.
>
> Then what is the purpose of having a PrID if you don't increment it when you
> make a new CPU? Especially in this case where there are major architectural
> changes. Anyway, you seem to have a dedicated revision number which is good
> enough.
>
>>
>> Loongson-3 has a hardware-maintained cache, system software doesn't
>> need to maintain coherency.
>>
>> Loongson-3A is the first revision of Loongson-3, and it is the quad-
>> core version of Loongson-2G. Loongson-3A has a simplified version named
>> Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
>> HyperTransport controller but 2Gq has only one. HT0 is used for cross-
>> chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
>> cannot support NUMA but 3A can.
>>
>> Exsisting Loongson family CPUs:
>> Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
>> Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G(including Loongson-
>>             2Gq), they are 64-bit MIPS CPUs.
>> Loongson-3: Loongson-3A, it is a 64-bit MIPS CPU.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> ---
>>  arch/mips/include/asm/addrspace.h            |    6 ++++++
>>  arch/mips/include/asm/cpu.h                  |    6 ++++--
>>  arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++++++++++++
>>  arch/mips/include/asm/module.h               |    2 ++
>>  arch/mips/include/asm/pgtable-bits.h         |    7 +++++++
>>  arch/mips/loongson/Platform                  |    1 +
>>  6 files changed, 35 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
>>
>> diff --git a/arch/mips/include/asm/addrspace.h
> b/arch/mips/include/asm/addrspace.h
>> index 569f80a..cf62bfb 100644
>> --- a/arch/mips/include/asm/addrspace.h
>> +++ b/arch/mips/include/asm/addrspace.h
>> @@ -116,7 +116,13 @@
>>  #define K_CALG_UNCACHED              2
>>  #define K_CALG_NONCOHERENT   3
>>  #define K_CALG_COH_EXCL              4
>> +
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +#define K_CALG_COH_SHAREABLE 3
>> +#else
>>  #define K_CALG_COH_SHAREABLE 5
>> +#endif
>> +
>>  #define K_CALG_NOTUSED               6
>>  #define K_CALG_UNCACHED_ACCEL        7
>>
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index 95e40c1..3fa996a 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -72,6 +72,7 @@
>>  #define PRID_IMP_R5432               0x5400
>>  #define PRID_IMP_R5500               0x5500
>>  #define PRID_IMP_LOONGSON2   0x6300
>> +#define PRID_IMP_LOONGSON3   0x6300
>>
>>  #define PRID_IMP_UNKNOWN     0xff00
>>
>> @@ -199,6 +200,7 @@
>>  #define PRID_REV_34K_V1_0_2  0x0022
>>  #define PRID_REV_LOONGSON2E  0x0002
>>  #define PRID_REV_LOONGSON2F  0x0003
>> +#define PRID_REV_LOONGSON3A  0x0005
>>
>>  /*
>>   * Older processors used to encode processor version and revision in two
>> @@ -267,8 +269,8 @@ enum cpu_type_enum {
>>        * MIPS64 class processors
>>        */
>>       CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
>> -     CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
>> -     CPU_XLR, CPU_XLP,
>> +     CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
>> +     CPU_CAVIUM_OCTEON2, CPU_XLR, CPU_XLP,
>>
>>       CPU_LAST
>>  };
>> diff --git a/arch/mips/include/asm/mach-loongson/spaces.h
> b/arch/mips/include/asm/mach-loongson/spaces.h
>> new file mode 100644
>> index 0000000..1e82804
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson/spaces.h
>> @@ -0,0 +1,15 @@
>> +#ifndef __ASM_MACH_LOONGSON_SPACES_H_
>> +#define __ASM_MACH_LOONGSON_SPACES_H_
>> +
>> +#ifndef CAC_BASE
>> +#if defined(CONFIG_64BIT)
>> +#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_CPU_LOONGSON3)
>> +#define CAC_BASE        _AC(0x9800000000000000, UL)
>> +#else
>> +#define CAC_BASE        _AC(0xa800000000000000, UL)
>> +#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_CPU_LOONGSON3 */
>> +#endif /* CONFIG_64BIT */
>> +#endif /* CONFIG_CAC_BASE */
>> +
>> +#include <asm/mach-generic/spaces.h>
>> +#endif
>> diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
>> index 5300080..375964a 100644
>> --- a/arch/mips/include/asm/module.h
>> +++ b/arch/mips/include/asm/module.h
>> @@ -119,6 +119,8 @@ search_module_dbetables(unsigned long addr)
>>  #define MODULE_PROC_FAMILY "SB1 "
>>  #elif defined CONFIG_CPU_LOONGSON2
>>  #define MODULE_PROC_FAMILY "LOONGSON2 "
>> +#elif defined CONFIG_CPU_LOONGSON3
>> +#define MODULE_PROC_FAMILY "LOONGSON3 "
>>  #elif defined CONFIG_CPU_CAVIUM_OCTEON
>>  #define MODULE_PROC_FAMILY "OCTEON "
>>  #elif defined CONFIG_CPU_XLR
>> diff --git a/arch/mips/include/asm/pgtable-bits.h
> b/arch/mips/include/asm/pgtable-bits.h
>> index e9fe7e9..1afd39a 100644
>> --- a/arch/mips/include/asm/pgtable-bits.h
>> +++ b/arch/mips/include/asm/pgtable-bits.h
>> @@ -206,6 +206,13 @@ static inline uint64_t pte_to_entrylo(unsigned long
> pte_val)
>>  #define _CACHE_UNCACHED                  _CACHE_UC_B
>>  #define _CACHE_CACHABLE_NONCOHERENT _CACHE_WB
>>
>> +#elif defined(CONFIG_CPU_LOONGSON3)
>> +
>> +#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
>> +#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
>> +#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
>> +#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
>> +
>>  #else
>>
>>  #define _CACHE_CACHABLE_NO_WA            (0<<_CACHE_SHIFT)  /* R4600 only      */
>> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
>> index 29692e5..6205372 100644
>> --- a/arch/mips/loongson/Platform
>> +++ b/arch/mips/loongson/Platform
>> @@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
>>  cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-
> loongson -mno-branch-likely
>>  load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
>>  load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
>> +load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
>> --
>> 1.7.7.3
>>
>>
