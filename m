Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 02:35:16 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:44809
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994706AbeARBfIYotKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 02:35:08 +0100
Received: by mail-pg0-x244.google.com with SMTP id m20so12585947pgc.11
        for <linux-mips@linux-mips.org>; Wed, 17 Jan 2018 17:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dO1mqa5mpFy3C9dsxFhM3g5Qye/hm791XlPQDQI8mFo=;
        b=WjN3kM1ZpmPlvM/UegWLG/FDbLuyXtjimsXNaZ3G1yYkzzmkrnjDOn07zLVx2gEE5p
         YdSsXn1u+rKdoKwX2zk4RZFpo+Hyj6A9Hrqz27LQzw1HKGxh+/1Xabtqvqkn4uvRqdrM
         zA+4Pym1Noh5zWy6AZfkmzQNFqniLH1RYEOmSpvAevqtwUyr5WEdd94JqoQ1j12/5lIV
         VxFj0R0xDWD19NymWdKkE0c1HSB4xn8ydZoplx4jNGfeUu39ZwVu7OO6hbTBQh195n98
         WB4+GlSwVGWRWpO9YwsbbO3eDjLJhGCXEJbCaPLEqARrMg7/Tc0bMHfZV0Q359fhjIoz
         wxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dO1mqa5mpFy3C9dsxFhM3g5Qye/hm791XlPQDQI8mFo=;
        b=tB/2aO32NHv2ar8RGkwGCnw7TGzJchGHa0QBNL2sWu5N26+qrhemV0nbNA9dIHXkIf
         3986fyWh+h3ufNvKP7LbsZL+aXOfY7OjL2fPYmMmegu47nSTLo1lxrzZnlEPJYGJ/m2c
         5cK/bmgRAuqyS7Tr1pKCA5fzVluRP5Aw5HBlUYB8ZCt3x+TTDp47goW/+P7+riBZmjaq
         OoQ7SO1X7sLBSyGgizWW+/IcuKzwbmrdX22nPm3E1WvuKB9tMY0gtODNzW84Qx84Sapz
         qDDnMcu+DUt9O38qov7ihaNKrcDkbH1AFgq4vEeUber99CNVqNJratdxHlSbH51w1q2j
         nvAA==
X-Gm-Message-State: AKwxytc/+AfgO7RByQkpG6/urCplZC5jR33bKSkyiBf2E7EKu10c3soO
        lzs11iwC/Ftu+9TRwQ6+LZviiBTKy/4=
X-Google-Smtp-Source: ACJfBouP5PVoIIrx0HnufEc0GBbDt3eF9RF2/H4JxWdbnu6iZwkabaf/wAuKljKC5V0GsNiQv9xlkQ==
X-Received: by 10.159.207.135 with SMTP id z7mr8869239plo.242.1516239300317;
        Wed, 17 Jan 2018 17:35:00 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s14sm10086050pfa.158.2018.01.17.17.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 17:34:59 -0800 (PST)
Date:   Wed, 17 Jan 2018 17:34:59 -0800 (PST)
X-Google-Original-Date: Wed, 17 Jan 2018 17:34:57 PST (-0800)
Subject:     Re: [PATCH] MIPS: use generic GCC library routines from lib/
In-Reply-To: <20180117065121.30437-1-antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     antonynpavlov@gmail.com
Message-ID: <mhng-796aa108-a59e-433a-a037-925fbfaf905e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62227
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

Ah, thanks for reminding me -- I'd originally posted a patch set that converted 
every other port to use these routines, but I ended up dropping all those.  
Here's my original MIPS attempt

    https://marc.info/?l=linux-mips&m=149677651707103&w=2

Given that, I think you can also drop arch/mips/lib/libgcc.h -- if it's used 
from anywhere else, it should be possible to use include/linux/libgcc.h 
instead.

Assuming it still seems sane do to that I can go give the rest of the patch set 
another shot.  I'm a bit new to this, but I think I should do something like

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!

On Tue, 16 Jan 2018 22:51:21 PST (-0800), antonynpavlov@gmail.com wrote:
> The commit b35cd9884fa5 ("lib: Add shared copies of
> some GCC library routines") makes it possible
> to share generic GCC library routines by several
> architectures.
>
> This commit removes several generic GCC library
> routines from arch/mips/lib/ in favour of similar
> routines from lib/.
>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/Kconfig       |  5 +++++
>  arch/mips/lib/Makefile  |  2 +-
>  arch/mips/lib/ashldi3.c | 30 ------------------------------
>  arch/mips/lib/ashrdi3.c | 32 --------------------------------
>  arch/mips/lib/cmpdi2.c  | 28 ----------------------------
>  arch/mips/lib/lshrdi3.c | 30 ------------------------------
>  arch/mips/lib/ucmpdi2.c | 22 ----------------------
>  7 files changed, 6 insertions(+), 143 deletions(-)
>  delete mode 100644 arch/mips/lib/ashldi3.c
>  delete mode 100644 arch/mips/lib/ashrdi3.c
>  delete mode 100644 arch/mips/lib/cmpdi2.c
>  delete mode 100644 arch/mips/lib/lshrdi3.c
>  delete mode 100644 arch/mips/lib/ucmpdi2.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..9cd49ee848c6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -73,6 +73,11 @@ config MIPS
>  	select RTC_LIB if !MACH_LOONGSON64
>  	select SYSCTL_EXCEPTION_TRACE
>  	select VIRT_TO_BUS
> +	select GENERIC_ASHLDI3
> +	select GENERIC_ASHRDI3
> +	select GENERIC_LSHRDI3
> +	select GENERIC_CMPDI2
> +	select GENERIC_UCMPDI2
>
>  menu "Machine selection"
>
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index 78c2affeabf8..195ab4cb0840 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>
>  # libgcc-style stuff needed in the kernel
> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
> +obj-y += bswapsi.o bswapdi.o
> diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
> deleted file mode 100644
> index 24cd6903e797..000000000000
> --- a/arch/mips/lib/ashldi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __ashldi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.low = 0;
> -		w.s.high = (unsigned int) uu.s.low << -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
> -
> -		w.s.low = (unsigned int) uu.s.low << b;
> -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashldi3);
> diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
> deleted file mode 100644
> index 23f5295af51e..000000000000
> --- a/arch/mips/lib/ashrdi3.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __ashrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		/* w.s.high = 1..1 or 0..0 */
> -		w.s.high =
> -		    uu.s.high >> 31;
> -		w.s.low = uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashrdi3);
> diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
> deleted file mode 100644
> index 93cfc785927d..000000000000
> --- a/arch/mips/lib/cmpdi2.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -word_type notrace __cmpdi2(long long a, long long b)
> -{
> -	const DWunion au = {
> -		.ll = a
> -	};
> -	const DWunion bu = {
> -		.ll = b
> -	};
> -
> -	if (au.s.high < bu.s.high)
> -		return 0;
> -	else if (au.s.high > bu.s.high)
> -		return 2;
> -
> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> -		return 0;
> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> -		return 2;
> -
> -	return 1;
> -}
> -
> -EXPORT_SYMBOL(__cmpdi2);
> diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
> deleted file mode 100644
> index 914b971aca3b..000000000000
> --- a/arch/mips/lib/lshrdi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __lshrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.high = 0;
> -		w.s.low = (unsigned int) uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = (unsigned int) uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__lshrdi3);
> diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
> deleted file mode 100644
> index c31c78ca4175..000000000000
> --- a/arch/mips/lib/ucmpdi2.c
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
> -{
> -	const DWunion au = {.ll = a};
> -	const DWunion bu = {.ll = b};
> -
> -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
> -		return 0;
> -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
> -		return 2;
> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> -		return 0;
> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> -		return 2;
> -	return 1;
> -}
> -
> -EXPORT_SYMBOL(__ucmpdi2);
