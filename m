Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 02:15:12 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.138]:47449 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816481AbaCSBPJOILS9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 02:15:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 071CF2342E;
        Wed, 19 Mar 2014 09:15:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6gBfWtFaw2Gd; Wed, 19 Mar 2014 09:14:45 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id AB7432334B;
        Wed, 19 Mar 2014 09:14:34 +0800 (CST)
Received: from 222.92.8.142
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Wed, 19 Mar 2014 09:14:35 +0800
Message-ID: <f9b18940d721245b5348e108836cdafc.squirrel@mail.lemote.com>
In-Reply-To: <20140318140427.GC17197@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
    <1392537690-5961-3-git-send-email-chenhc@lemote.com>
    <20140318140427.GC17197@linux-mips.org>
Date:   Wed, 19 Mar 2014 09:14:35 +0800
Subject: Re: [PATCH V19 02/13] MIPS: Loongson: Add basic Loongson-3
 definition
From:   =?gb2312?Q?=22=B3=C2=BB=AA=B2=C5=22?= <chenhc@lemote.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        "Aurelien Jarno" <aurelien@aurel32.net>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39498
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

> On Sun, Feb 16, 2014 at 04:01:19PM +0800, Huacai Chen wrote:
>
>> diff --git a/arch/mips/include/asm/addrspace.h
>> b/arch/mips/include/asm/addrspace.h
>> index 3f74545..41c030e 100644
>> --- a/arch/mips/include/asm/addrspace.h
>> +++ b/arch/mips/include/asm/addrspace.h
>> @@ -116,7 +116,9 @@
>>  #define K_CALG_UNCACHED		2
>>  #define K_CALG_NONCOHERENT	3
>>  #define K_CALG_COH_EXCL		4
>> +#ifndef K_CALG_COH_SHAREABLE
>>  #define K_CALG_COH_SHAREABLE	5
>> +#endif
>
> It seems this segment isn't even necessary - can we just drop it?
>
> Octeon also uses cache mode 3 for coherent.
>
> Just to avoid yet another ifdef.
I think keep this segment is better, though without this Loongson can
work at present, but may be change in future.

>
>>  #define K_CALG_NOTUSED		6
>>  #define K_CALG_UNCACHED_ACCEL	7
>>
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index e195de5..35a4e18 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -230,6 +230,7 @@
>>  #define PRID_REV_LOONGSON1B	0x0020
>>  #define PRID_REV_LOONGSON2E	0x0002
>>  #define PRID_REV_LOONGSON2F	0x0003
>> +#define PRID_REV_LOONGSON3A	0x0005
>>
>>  /*
>>   * Older processors used to encode processor version and revision in
>> two
>> @@ -303,8 +304,8 @@ enum cpu_type_enum {
>>  	 * MIPS64 class processors
>>  	 */
>>  	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A,
>> CPU_LOONGSON2,
>> -	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
>> -	CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>> +	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
>> +	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>>
>>  	CPU_LAST
>>  };
>> diff --git a/arch/mips/include/asm/mach-loongson/spaces.h
>> b/arch/mips/include/asm/mach-loongson/spaces.h
>> new file mode 100644
>> index 0000000..d368d95
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson/spaces.h
>> @@ -0,0 +1,13 @@
>> +#ifndef __ASM_MACH_LOONGSON_SPACES_H_
>> +#define __ASM_MACH_LOONGSON_SPACES_H_
>> +
>> +#ifndef CAC_BASE
>
> This file should only be included from the top of <asm/addrspace.h> where
> CAC_BASE should not be defined yet.
Maybe I'm lost here... spaces.h is aready included in asm/addrspace.h, so
what's wrong?

>
>> +#if defined(CONFIG_64BIT)
>> +#define CAC_BASE        _AC(0x9800000000000000, UL)
>> +#endif /* CONFIG_64BIT */
>> +#endif /* CONFIG_CAC_BASE */
>
> The Symbol in this comment doesn't match the symbol used in the opening
> #ifndef.
Yes, this should be fix.

>
>> +
>> +#define K_CALG_COH_SHAREABLE	3
>> +
>> +#include <asm/mach-generic/spaces.h>
>> +#endif
>> diff --git a/arch/mips/include/asm/module.h
>> b/arch/mips/include/asm/module.h
>> index 44b705d..c2edae3 100644
>> --- a/arch/mips/include/asm/module.h
>> +++ b/arch/mips/include/asm/module.h
>> @@ -126,6 +126,8 @@ search_module_dbetables(unsigned long addr)
>>  #define MODULE_PROC_FAMILY "LOONGSON1 "
>>  #elif defined CONFIG_CPU_LOONGSON2
>>  #define MODULE_PROC_FAMILY "LOONGSON2 "
>> +#elif defined CONFIG_CPU_LOONGSON3
>> +#define MODULE_PROC_FAMILY "LOONGSON3 "
>>  #elif defined CONFIG_CPU_CAVIUM_OCTEON
>>  #define MODULE_PROC_FAMILY "OCTEON "
>>  #elif defined CONFIG_CPU_XLR
>> diff --git a/arch/mips/include/asm/pgtable-bits.h
>> b/arch/mips/include/asm/pgtable-bits.h
>> index 32aea48..e592f36 100644
>> --- a/arch/mips/include/asm/pgtable-bits.h
>> +++ b/arch/mips/include/asm/pgtable-bits.h
>> @@ -235,6 +235,15 @@ static inline uint64_t pte_to_entrylo(unsigned long
>> pte_val)
>>  #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
>>  #define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)
>>
>> +#elif defined(CONFIG_CPU_LOONGSON3)
>> +
>> +/* Using COHERENT flag for NONCOHERENT doesn't hurt. */
>> +
>> +#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON
>>  */
>> +#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON
>>  */
>> +#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3
>>  */
>> +#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON
>>  */
>> +
>>  #else
>
> Ok.
>
> Yes, it adds another #ifdef but cleaning up this should not be subject of
> this patch.
You means this segment should be a seprate patch? But, other parts of this
patch, such as K_CALG_COH_SHAREABLE and CAC_BASE definition, are all from
a same reason (cache attribute 3 is coherent), why this part is different?

>
>   Ralf
>
