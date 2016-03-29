Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 04:16:03 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33842 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbcC2CQAikSuj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 04:16:00 +0200
Received: by mail-pf0-f193.google.com with SMTP id n5so290459pfn.1;
        Mon, 28 Mar 2016 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SuQ+F34MGRQrEcVKGwy6DiWd8yTo6hHMnMZF1433zw8=;
        b=v4zVF0zs6onzvUi5tHGXH2jSrlCtVtJquVfyZ3lxJ+7AU7yMJByq4SqsAxGGGANi6n
         58MXNzRSQyibuFFT7BPn1pgbKWcPEWZT1JBsko9rE63DApBzl7BN5i0So1/WGObaX6X5
         BhDPnTE9giWWj99imHJOwlNuF5hya9kuuzEASJXzmWv3NeDt3+GQ8O9a439TJIO+RE4j
         gsj9fTj/aj5r/Mbb55mo9i53SIW8hgBVKFH7ou6oiTnatzSRcPrpp1k6Xg4Pm1W3eF5c
         idkTSZBJGnk92iUsFsasGDTCOBHjvfC5GYLHqKl2F4NVUWUl49722ZVdN+OVpB/5PFdz
         KVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SuQ+F34MGRQrEcVKGwy6DiWd8yTo6hHMnMZF1433zw8=;
        b=PNLpstRLaha/Lnt/eToAlbjPxqLPuJ2+UeI8MrDYn/zTmylpwCiBr8Yx7Mfr/RD7SW
         9ejccLZMSUD497xEKVaG3SE43LSHWPt4nHM4bU7BZponZ2L96TgjMpIr8Ge894gGM72q
         MA4iGqf9ZwfOw/rLZAat8UGhV4bW4gowmgjo6YT4ZAJNehs66iaoL0W2sdZEKlbBkjPX
         ZL67QDa0d8XAqdXiv4YQrA34cUD6VUb/GQbh88aK9rCvqnQneGSteowUo/Y+Zpbv9Fw+
         ckIwZiabSkGox4qonx6q2q2akKfTZtGEfEP75Bwitin1bd45PVoCqHh8hskSMDFv/nwk
         dx5A==
X-Gm-Message-State: AD7BkJJU7n1+Owvi5TtDERr1LMIobCPdeUV0N3TKRy6zvJYVex7YlLkU/Y8GEFnrAWPW3w==
X-Received: by 10.98.16.210 with SMTP id 79mr47730019pfq.69.1459217754434;
        Mon, 28 Mar 2016 19:15:54 -0700 (PDT)
Received: from [192.168.0.15] ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id r68sm38570793pfb.51.2016.03.28.19.15.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 19:15:53 -0700 (PDT)
Subject: Re: [PATCH 07/31] Add mips-specific parity functions
To:     David Daney <ddaney.cavm@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F7785F.1090101@gmail.com> <56F968EE.1000307@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
From:   Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Message-ID: <56F9E554.8090204@gmail.com>
Date:   Tue, 29 Mar 2016 10:15:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F968EE.1000307@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <zhaoxiu.zeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhaoxiu.zeng@gmail.com
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



在 2016年03月29日 01:25, David Daney 写道:
> On 03/26/2016 11:06 PM, zhaoxiu.zeng wrote:
>> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>>
>
> There is nothing MIPS specific here.  Why not put it in asm-generic or 
> some similar place where it can be shared by all architectures?
>
> Also, are you sure __builtin_popcount() is available on all GCC 
> versions that are supported for building the kernel?
>
> David Daney
>

Refrence to arch_hweight.h.

In the 68th line of 
arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h, we can 
see:

#ifdef __OCTEON__
/*
  * All gcc versions that have OCTEON support define __OCTEON__ and have the
  *  __builtin_popcount support.
  */
#define ARCH_HAS_USABLE_BUILTIN_POPCOUNT 1
#endif

/*
  * All gcc versions that have OCTEON support define __OCTEON__ and have the
  *  __builtin_popcount support.
  */

>> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>> ---
>>   arch/mips/include/asm/arch_parity.h | 44 
>> +++++++++++++++++++++++++++++++++++++
>>   arch/mips/include/asm/bitops.h      |  3 +++
>>   2 files changed, 47 insertions(+)
>>   create mode 100644 arch/mips/include/asm/arch_parity.h
>>
>> diff --git a/arch/mips/include/asm/arch_parity.h 
>> b/arch/mips/include/asm/arch_parity.h
>> new file mode 100644
>> index 0000000..23b3c23
>> --- /dev/null
>> +++ b/arch/mips/include/asm/arch_parity.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU 
>> General Public
>> + * License.  See the file "COPYING" in the main directory of this 
>> archive
>> + * for more details.
>> + *
>> + */
>> +#ifndef _ASM_ARCH_PARITY_H
>> +#define _ASM_ARCH_PARITY_H
>> +
>> +#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
>> +
>> +#include <asm/types.h>
>> +
>> +static inline unsigned int __arch_parity32(unsigned int w)
>> +{
>> +    return __builtin_popcount(w) & 1;
>> +}
>> +
>> +static inline unsigned int __arch_parity16(unsigned int w)
>> +{
>> +    return __arch_parity32(w & 0xffff);
>> +}
>> +
>> +static inline unsigned int __arch_parity8(unsigned int w)
>> +{
>> +    return __arch_parity32(w & 0xff);
>> +}
>> +
>> +static inline unsigned int __arch_parity4(unsigned int w)
>> +{
>> +    return __arch_parity32(w & 0xf);
>> +}
>> +
>> +static inline unsigned int __arch_parity64(__u64 w)
>> +{
>> +    return (unsigned int)__builtin_popcountll(w) & 1;
>> +}
>> +
>> +#else
>> +#include <asm-generic/bitops/arch_hweight.h>
>> +#include <asm-generic/bitops/arch_parity.h>
>> +#endif
>> +
>> +#endif /* _ASM_ARCH_PARITY_H */
>> diff --git a/arch/mips/include/asm/bitops.h 
>> b/arch/mips/include/asm/bitops.h
>> index ce9666c..0b87734 100644
>> --- a/arch/mips/include/asm/bitops.h
>> +++ b/arch/mips/include/asm/bitops.h
>> @@ -626,6 +626,9 @@ static inline int ffs(int word)
>>   #include <asm/arch_hweight.h>
>>   #include <asm-generic/bitops/const_hweight.h>
>>
>> +#include <asm/arch_parity.h>
>> +#include <asm-generic/bitops/const_parity.h>
>> +
>>   #include <asm-generic/bitops/le.h>
>>   #include <asm-generic/bitops/ext2-atomic.h>
>>
>>
>
