Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 20:55:03 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:39003
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARTyznSizc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 20:54:55 +0100
Received: by mail-wr0-x242.google.com with SMTP id z48so23829308wrz.6
        for <linux-mips@linux-mips.org>; Thu, 18 Jan 2018 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=4bUJHdYnGF/TTP3dTbnzxcCRITQm/zpiWmwI0CtpPTg=;
        b=pymbTkmDRtt9bObdmBXdL6H6x7CWAg+f+UKu9MfahEIQt5V0Tyla6IzWsYHZf5OG+i
         WDk8jJP7BEzkMcNmbHb3nCZsMzrHfO1NuMXSBoy2HvXXbGBjgmgPLDHcZprRJrYdL0uN
         6dEhIcIBRvXOP7UbBMlDW5ETwfuK4ZA4gAXZPHWqJZNJ/5e0B93tWmz4aPZMQNvECjik
         jFzdVWmJmPxZIWyrTxajAi17iE4s5FJqGTbyL9oz17XUFEpg+gqmiTirHFf29lnK/gGB
         FjhJcQaP3AzSCVhrMPpJcgJR0jnZv2Ur/zbjmZMUe3oQG/RPwvr9iVb0QG95w0YI2b0C
         LKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=4bUJHdYnGF/TTP3dTbnzxcCRITQm/zpiWmwI0CtpPTg=;
        b=aPiFISep5pP/zC+T4HQF5es6DibsJYx6AfqphN5W/zyDHrzJEqHheJc84beprafgtE
         /mgXvEArRaayYROCeEhKjC3l38Er4PvlHHeL/+nWVNPtbOF2ZKLPKhhPautSCy2sRib2
         pC48l/S8gU6RNKlBhbDV1ZHPOIQ0jB1gB1N/cYBlheiT+p6cb/SYEFG4Lkg++w6zZc41
         kiHEJUpY1dbodRaP+VqddupiJySjCqLpsTi3EyXM97UJ0EivAV1Rp2JMRj1wFmSa/1r+
         u7kj43KwLWW61ZUBWSuSQWQFICDFe2KJNqb2UTKLkEeNPkmYd7RcXomvuQDs4AZ+Z1lR
         seZA==
X-Gm-Message-State: AKwxytfCc/c4LE/N+P+NDkphevZ/voi0G2KFgqjQgj85ej/tj+5yWDbT
        0JXx9ebvkzIhXqMGxi8xhjGXpQ==
X-Google-Smtp-Source: ACJfBou6IdJ0Dl9mFC3Wn/wR6Ia9ZHmLUxDJjtNkyAZicNh3MztGXKaa+RM5KsDimjGn8dtcw2EL8Q==
X-Received: by 10.223.170.150 with SMTP id h22mr7610047wrc.21.1516305290280;
        Thu, 18 Jan 2018 11:54:50 -0800 (PST)
Received: from android-f8911984c6e3e13 (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id y19sm6138492wrg.84.2018.01.18.11.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 11:54:49 -0800 (PST)
Date:   Thu, 18 Jan 2018 19:54:49 +0000
In-Reply-To: <20180118230505.31af9784f543a2e067af5a39@gmail.com>
References: <20180117065121.30437-1-antonynpavlov@gmail.com> <mhng-796aa108-a59e-433a-a037-925fbfaf905e@palmer-si-x1c4> <20180118230505.31af9784f543a2e067af5a39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] MIPS: use generic GCC library routines from lib/
To:     Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, Matt Redfearn <matt.redfearn@mips.com>
From:   James Hogan <james@albanarts.com>
Message-ID: <57124790-F7C9-4180-AE89-A7FAA3DBDC9A@albanarts.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@albanarts.com
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

On 18 January 2018 20:05:05 GMT+00:00, Antony Pavlov <antonynpavlov@gmail.com> wrote:
>On Wed, 17 Jan 2018 17:34:59 -0800 (PST)
>Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> Ah, thanks for reminding me -- I'd originally posted a patch set that
>converted 
>> every other port to use these routines, but I ended up dropping all
>those.  
>> Here's my original MIPS attempt
>> 
>>     https://marc.info/?l=linux-mips&m=149677651707103&w=2
>
>Now I see that I have dubbed your June 2017 patch. Sorry!
>
>Alas in June 2017 there was no chance to push your patch to linux-mips
>repo.
>Linus merged your patches in November 2017. Ralf merged your RISC-V
>changes
>into linux-mips repo AFAIR just several days ago.
>
>> Given that, I think you can also drop arch/mips/lib/libgcc.h -- if
>it's used 
>> from anywhere else, it should be possible to use
>include/linux/libgcc.h 
>> instead.
>
>I agree with you.

actually theres a patch in mips-next which implements __multi3 for mips64r6, which uses that file, and in fact extends it for 128bit types.

cheers
James

>
>> 
>> Assuming it still seems sane do to that I can go give the rest of the
>patch set 
>> another shot.  I'm a bit new to this, but I think I should do
>something like
>> 
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
>I suppose that it's better to resurrect you patch and abandon my patch.
>
>Your original patch series
>(https://www.linux-mips.org/archives/linux-mips/2017-06/msg00148.html)
>has a disadvantage: it tries to change several architectures at once.
>
>I propose to create new short separate patch series for MIPS
>architecture.
>
>This patch series should contain two patches:
>
>   [PATCH 1/2] Add notrace to lib/ucmpdi2.c
>   [PATCH 2/2] MIPS: Use generic libgcc intrinsics
>
>
>> Thanks!
>> 
>> On Tue, 16 Jan 2018 22:51:21 PST (-0800), antonynpavlov@gmail.com
>wrote:
>> > The commit b35cd9884fa5 ("lib: Add shared copies of
>> > some GCC library routines") makes it possible
>> > to share generic GCC library routines by several
>> > architectures.
>> >
>> > This commit removes several generic GCC library
>> > routines from arch/mips/lib/ in favour of similar
>> > routines from lib/.
>> >
>> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: linux-mips@linux-mips.org
>> > Cc: linux-kernel@vger.kernel.org
>> > ---
>> >  arch/mips/Kconfig       |  5 +++++
>> >  arch/mips/lib/Makefile  |  2 +-
>> >  arch/mips/lib/ashldi3.c | 30 ------------------------------
>> >  arch/mips/lib/ashrdi3.c | 32 --------------------------------
>> >  arch/mips/lib/cmpdi2.c  | 28 ----------------------------
>> >  arch/mips/lib/lshrdi3.c | 30 ------------------------------
>> >  arch/mips/lib/ucmpdi2.c | 22 ----------------------
>> >  7 files changed, 6 insertions(+), 143 deletions(-)
>> >  delete mode 100644 arch/mips/lib/ashldi3.c
>> >  delete mode 100644 arch/mips/lib/ashrdi3.c
>> >  delete mode 100644 arch/mips/lib/cmpdi2.c
>> >  delete mode 100644 arch/mips/lib/lshrdi3.c
>> >  delete mode 100644 arch/mips/lib/ucmpdi2.c
>> >
>> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> > index 350a990fc719..9cd49ee848c6 100644
>> > --- a/arch/mips/Kconfig
>> > +++ b/arch/mips/Kconfig
>> > @@ -73,6 +73,11 @@ config MIPS
>> >  	select RTC_LIB if !MACH_LOONGSON64
>> >  	select SYSCTL_EXCEPTION_TRACE
>> >  	select VIRT_TO_BUS
>> > +	select GENERIC_ASHLDI3
>> > +	select GENERIC_ASHRDI3
>> > +	select GENERIC_LSHRDI3
>> > +	select GENERIC_CMPDI2
>> > +	select GENERIC_UCMPDI2
>> >
>> >  menu "Machine selection"
>> >
>> > diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>> > index 78c2affeabf8..195ab4cb0840 100644
>> > --- a/arch/mips/lib/Makefile
>> > +++ b/arch/mips/lib/Makefile
>> > @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>> >  obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>> >
>> >  # libgcc-style stuff needed in the kernel
>> > -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o
>lshrdi3.o ucmpdi2.o
>> > +obj-y += bswapsi.o bswapdi.o
>> > diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
>> > deleted file mode 100644
>> > index 24cd6903e797..000000000000
>> > --- a/arch/mips/lib/ashldi3.c
>> > +++ /dev/null
>> > @@ -1,30 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -long long notrace __ashldi3(long long u, word_type b)
>> > -{
>> > -	DWunion uu, w;
>> > -	word_type bm;
>> > -
>> > -	if (b == 0)
>> > -		return u;
>> > -
>> > -	uu.ll = u;
>> > -	bm = 32 - b;
>> > -
>> > -	if (bm <= 0) {
>> > -		w.s.low = 0;
>> > -		w.s.high = (unsigned int) uu.s.low << -bm;
>> > -	} else {
>> > -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
>> > -
>> > -		w.s.low = (unsigned int) uu.s.low << b;
>> > -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
>> > -	}
>> > -
>> > -	return w.ll;
>> > -}
>> > -
>> > -EXPORT_SYMBOL(__ashldi3);
>> > diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
>> > deleted file mode 100644
>> > index 23f5295af51e..000000000000
>> > --- a/arch/mips/lib/ashrdi3.c
>> > +++ /dev/null
>> > @@ -1,32 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -long long notrace __ashrdi3(long long u, word_type b)
>> > -{
>> > -	DWunion uu, w;
>> > -	word_type bm;
>> > -
>> > -	if (b == 0)
>> > -		return u;
>> > -
>> > -	uu.ll = u;
>> > -	bm = 32 - b;
>> > -
>> > -	if (bm <= 0) {
>> > -		/* w.s.high = 1..1 or 0..0 */
>> > -		w.s.high =
>> > -		    uu.s.high >> 31;
>> > -		w.s.low = uu.s.high >> -bm;
>> > -	} else {
>> > -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> > -
>> > -		w.s.high = uu.s.high >> b;
>> > -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> > -	}
>> > -
>> > -	return w.ll;
>> > -}
>> > -
>> > -EXPORT_SYMBOL(__ashrdi3);
>> > diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
>> > deleted file mode 100644
>> > index 93cfc785927d..000000000000
>> > --- a/arch/mips/lib/cmpdi2.c
>> > +++ /dev/null
>> > @@ -1,28 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -word_type notrace __cmpdi2(long long a, long long b)
>> > -{
>> > -	const DWunion au = {
>> > -		.ll = a
>> > -	};
>> > -	const DWunion bu = {
>> > -		.ll = b
>> > -	};
>> > -
>> > -	if (au.s.high < bu.s.high)
>> > -		return 0;
>> > -	else if (au.s.high > bu.s.high)
>> > -		return 2;
>> > -
>> > -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> > -		return 0;
>> > -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> > -		return 2;
>> > -
>> > -	return 1;
>> > -}
>> > -
>> > -EXPORT_SYMBOL(__cmpdi2);
>> > diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
>> > deleted file mode 100644
>> > index 914b971aca3b..000000000000
>> > --- a/arch/mips/lib/lshrdi3.c
>> > +++ /dev/null
>> > @@ -1,30 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -long long notrace __lshrdi3(long long u, word_type b)
>> > -{
>> > -	DWunion uu, w;
>> > -	word_type bm;
>> > -
>> > -	if (b == 0)
>> > -		return u;
>> > -
>> > -	uu.ll = u;
>> > -	bm = 32 - b;
>> > -
>> > -	if (bm <= 0) {
>> > -		w.s.high = 0;
>> > -		w.s.low = (unsigned int) uu.s.high >> -bm;
>> > -	} else {
>> > -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> > -
>> > -		w.s.high = (unsigned int) uu.s.high >> b;
>> > -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> > -	}
>> > -
>> > -	return w.ll;
>> > -}
>> > -
>> > -EXPORT_SYMBOL(__lshrdi3);
>> > diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
>> > deleted file mode 100644
>> > index c31c78ca4175..000000000000
>> > --- a/arch/mips/lib/ucmpdi2.c
>> > +++ /dev/null
>> > @@ -1,22 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -word_type notrace __ucmpdi2(unsigned long long a, unsigned long
>long b)
>> > -{
>> > -	const DWunion au = {.ll = a};
>> > -	const DWunion bu = {.ll = b};
>> > -
>> > -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
>> > -		return 0;
>> > -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
>> > -		return 2;
>> > -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> > -		return 0;
>> > -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> > -		return 2;
>> > -	return 1;
>> > -}
>> > -
>> > -EXPORT_SYMBOL(__ucmpdi2);


-- 
Cheers
James Hogan
