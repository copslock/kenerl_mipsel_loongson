Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 17:06:08 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:42292
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeARQGAQJ1An (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 17:06:00 +0100
Received: by mail-pg0-x241.google.com with SMTP id q67so14596081pga.9
        for <linux-mips@linux-mips.org>; Thu, 18 Jan 2018 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=v2TKKQZbIePiJCi/hVZ5vkWBTBrpv0HSgByaEoB/Km0=;
        b=ljgI7gm1uosVg5yOzxKrOnoLhUgeMAWrNsvahf8SG3cX4uFo9MDim2Y3/UCy+09NGe
         AQM0ehCZhdh5EgCc/4OyXntALm0NbnHqzS2l5NKejI5nyYnBHAfZjXxbzdY8BLRpQZVp
         pqFVgeAlxvSw0gP3srxJXRKViqPVf7zxsdE4tTOz9H975SR7nVqULwIwBn6C6ddIo/ka
         /BKVbjihePmYbK05LyiXQIHuxTl3lPEoBGMT/ZCVLRfPU0nWMgg9HkVz/BtmFfqJcWVA
         0kg4grqxiuH0lSuWXvVSJRPYqneym61RGEFoaVomARPeunErhhewmpmre/c5teWI53aT
         DTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=v2TKKQZbIePiJCi/hVZ5vkWBTBrpv0HSgByaEoB/Km0=;
        b=rE9JsDVlDrJCwgc1kNDC5oaKXSC48SjHV9AxoqXEHW+cROkwh/OPA5C8UjuPWKa9xA
         ZHjSmimxvNtbUvLomQkIdIBEywk3wB5NX9oVMY4LtybeIx3bzhC1e0yNQg9nNeo8DapH
         CZ8ROEq9uDUJ2qDMxOZkgARv2Oa3TTrMGdcdOFmbUWmPQv0bov6miwZtlJEx05f3Nth7
         V+p00iiYVfjm0kyakHdJdba7XnkQePYFrQdtOA2CM3CBokEyKr/Qa3PyoCjHJXIKVCn1
         cW+Fz4hdSod+zueer+YjTdmhz27NsmWCUyENWqrJVjrsYzQlZkfFBeJH5OI5H+1wOIOl
         4DqA==
X-Gm-Message-State: AKwxytdf1dcs0xG8+jmxLJCmkBitW9zTUcaUTHNg6keSpOO5cMdNs9uG
        nhGULOVtVMDeXKOyWJMgwglhZg==
X-Google-Smtp-Source: ACJfBosNqutvHsYbdi0tInJzxzXr6oXdtVQrWRtQYyeMI+FUtPdsueA/zfVNhd5rMhyR7AL8YFzkKg==
X-Received: by 10.98.161.16 with SMTP id b16mr17505876pff.34.1516291553210;
        Thu, 18 Jan 2018 08:05:53 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f1sm11232587pgo.46.2018.01.18.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 08:05:52 -0800 (PST)
Date:   Thu, 18 Jan 2018 08:05:52 -0800 (PST)
X-Google-Original-Date: Thu, 18 Jan 2018 08:01:55 PST (-0800)
Subject:     Re: [PATCH] MIPS: use generic GCC library routines from lib/
In-Reply-To: <20180117090348.GA20406@mredfearn-linux>
CC:     antonynpavlov@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     matt.redfearn@mips.com
Message-ID: <mhng-ba1775dd-1e19-4734-ae7b-24683d58037a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Wed, 17 Jan 2018 01:03:48 PST (-0800), matt.redfearn@mips.com wrote:
> Hi,
>
> On Wed, Jan 17, 2018 at 09:51:21AM +0300, Antony Pavlov wrote:
>> The commit b35cd9884fa5 ("lib: Add shared copies of
>> some GCC library routines") makes it possible
>> to share generic GCC library routines by several
>> architectures.
>>
>> This commit removes several generic GCC library
>> routines from arch/mips/lib/ in favour of similar
>> routines from lib/.
>>
>> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/mips/Kconfig       |  5 +++++
>>  arch/mips/lib/Makefile  |  2 +-
>>  arch/mips/lib/ashldi3.c | 30 ------------------------------
>>  arch/mips/lib/ashrdi3.c | 32 --------------------------------
>>  arch/mips/lib/cmpdi2.c  | 28 ----------------------------
>>  arch/mips/lib/lshrdi3.c | 30 ------------------------------
>>  arch/mips/lib/ucmpdi2.c | 22 ----------------------
>>  7 files changed, 6 insertions(+), 143 deletions(-)
>>  delete mode 100644 arch/mips/lib/ashldi3.c
>>  delete mode 100644 arch/mips/lib/ashrdi3.c
>>  delete mode 100644 arch/mips/lib/cmpdi2.c
>>  delete mode 100644 arch/mips/lib/lshrdi3.c
>>  delete mode 100644 arch/mips/lib/ucmpdi2.c
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 350a990fc719..9cd49ee848c6 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -73,6 +73,11 @@ config MIPS
>>  	select RTC_LIB if !MACH_LOONGSON64
>>  	select SYSCTL_EXCEPTION_TRACE
>>  	select VIRT_TO_BUS
>> +	select GENERIC_ASHLDI3
>> +	select GENERIC_ASHRDI3
>> +	select GENERIC_LSHRDI3
>> +	select GENERIC_CMPDI2
>> +	select GENERIC_UCMPDI2
>
> Please preserve alphabetical order
>
>>
>>  menu "Machine selection"
>>
>> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>> index 78c2affeabf8..195ab4cb0840 100644
>> --- a/arch/mips/lib/Makefile
>> +++ b/arch/mips/lib/Makefile
>> @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>>  obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>>
>>  # libgcc-style stuff needed in the kernel
>> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
>> +obj-y += bswapsi.o bswapdi.o
>> diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
>> deleted file mode 100644
>> index 24cd6903e797..000000000000
>> --- a/arch/mips/lib/ashldi3.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __ashldi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		w.s.low = 0;
>> -		w.s.high = (unsigned int) uu.s.low << -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
>> -
>> -		w.s.low = (unsigned int) uu.s.low << b;
>> -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__ashldi3);
>> diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
>> deleted file mode 100644
>> index 23f5295af51e..000000000000
>> --- a/arch/mips/lib/ashrdi3.c
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __ashrdi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		/* w.s.high = 1..1 or 0..0 */
>> -		w.s.high =
>> -		    uu.s.high >> 31;
>> -		w.s.low = uu.s.high >> -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> -
>> -		w.s.high = uu.s.high >> b;
>> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__ashrdi3);
>> diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
>> deleted file mode 100644
>> index 93cfc785927d..000000000000
>> --- a/arch/mips/lib/cmpdi2.c
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -word_type notrace __cmpdi2(long long a, long long b)
>> -{
>> -	const DWunion au = {
>> -		.ll = a
>> -	};
>> -	const DWunion bu = {
>> -		.ll = b
>> -	};
>> -
>> -	if (au.s.high < bu.s.high)
>> -		return 0;
>> -	else if (au.s.high > bu.s.high)
>> -		return 2;
>> -
>> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> -		return 0;
>> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> -		return 2;
>> -
>> -	return 1;
>> -}
>> -
>> -EXPORT_SYMBOL(__cmpdi2);
>> diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
>> deleted file mode 100644
>> index 914b971aca3b..000000000000
>> --- a/arch/mips/lib/lshrdi3.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __lshrdi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		w.s.high = 0;
>> -		w.s.low = (unsigned int) uu.s.high >> -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> -
>> -		w.s.high = (unsigned int) uu.s.high >> b;
>> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__lshrdi3);
>> diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
>> deleted file mode 100644
>> index c31c78ca4175..000000000000
>> --- a/arch/mips/lib/ucmpdi2.c
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>
> The version of __ucmpdi2 in /lib/ is not marked notrace. We have seen
> issues before with compiler intrinsics not being marked notrace - see
> aedcfbe06558 ("MIPS: lib: Mark intrinsics notrace")
>
> Please ensure that the /lib/ version is equivalent before switching to
> that version.

IIRC we marked the others as notrace for a similar reason, I must have just 
missed this one somehow.  I can submit a patch.

Thanks!

>
> Thanks,
> Matt
>
>> -{
>> -	const DWunion au = {.ll = a};
>> -	const DWunion bu = {.ll = b};
>> -
>> -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
>> -		return 0;
>> -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
>> -		return 2;
>> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> -		return 0;
>> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> -		return 2;
>> -	return 1;
>> -}
>> -
>> -EXPORT_SYMBOL(__ucmpdi2);
>> --
>> 2.15.1
>>
>>
