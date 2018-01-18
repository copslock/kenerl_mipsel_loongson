Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 20:51:02 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:45283
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARTuxrsp0c convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 20:50:53 +0100
Received: by mail-lf0-x244.google.com with SMTP id x196so8160979lfd.12;
        Thu, 18 Jan 2018 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80F4dcdOP221pTVGomwb0h73+0invtY8uqP34IFO1M8=;
        b=BGvk43wBcJS1oY0l7rTnOwrdMCNF+xnSMRh7xkqaj5wy2VE6Rfi2d8CRZaUoWZc4FO
         YV+LeBI6HRTr6KbgCLbGGXIs4K+aRIk2DDzE1WjIY3N93O/UiYHrjpgYCehy7Sfh5GIj
         AbrAb2i4EfR0FJsgqvLmLrrTC3jxyOBchefUrGnfRLV9Yob/y1lkvHQhZM862GTDbO78
         HClU9cJ5KIyAg+yFnNJPtfa02XyOJK//kbUa1qIRcsjpigljYj+vQrtg4VE3sQMxKwR+
         TakxejF8Am3kKTvu8t2IblhrpLl4faZAFLlWPlxnS4TPs97rQXlzIDI5i727gCqcE6n+
         ytiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80F4dcdOP221pTVGomwb0h73+0invtY8uqP34IFO1M8=;
        b=HNAZWYTe4ZhovVGu5Lrp/tAW2vkYG2Ad1yF53OlkqXvKzz3tqGOauJsZZtDu0OF+gO
         ljbgABaGcb8TgNFESYBl5G9evKUJZpIoHrM6Kqo9ARVWB8I1JyFLlNLceRncfNv65DMT
         lHgGvUyxVl8cL+AlUi/vZOK+Jg6Ez6S4+db1bIJuTwNRTk3lZ9e3aQR1Lbv1gnGunsZ8
         ZNiwR/8GBg8xaW8Yt/xYp9utKhnXsg8JWHy1Y6HJkfTagbGEhWv5nRsovr7rv6H4jM0J
         uYb/xjY4hgikNPRKsLt8i4FMwLr7brl1KlMiyHrXoVyr/fCSaf+kQeCjE3rbB485z4hp
         IEEg==
X-Gm-Message-State: AKGB3mL6cb4i1Zfg/ewuhPteohxdpd4fO9CHKhRueJOpjXssfIgCOkzK
        NGvSI1Jpo4zDOIlO4kYz21E=
X-Google-Smtp-Source: ACJfBot50gz9TegGvcszp+z8igbxvxTN686AzF96rUyQveGVbEUrPGs3jG60Na78kbl6iE+++vnjLQ==
X-Received: by 10.46.23.24 with SMTP id l24mr26691196lje.146.1516305047784;
        Thu, 18 Jan 2018 11:50:47 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id a86sm1412938ljb.88.2018.01.18.11.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 11:50:46 -0800 (PST)
Date:   Thu, 18 Jan 2018 23:05:05 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH] MIPS: use generic GCC library routines from lib/
Message-Id: <20180118230505.31af9784f543a2e067af5a39@gmail.com>
In-Reply-To: <mhng-796aa108-a59e-433a-a037-925fbfaf905e@palmer-si-x1c4>
References: <20180117065121.30437-1-antonynpavlov@gmail.com>
        <mhng-796aa108-a59e-433a-a037-925fbfaf905e@palmer-si-x1c4>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.25; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Wed, 17 Jan 2018 17:34:59 -0800 (PST)
Palmer Dabbelt <palmer@sifive.com> wrote:

> Ah, thanks for reminding me -- I'd originally posted a patch set that converted 
> every other port to use these routines, but I ended up dropping all those.  
> Here's my original MIPS attempt
> 
>     https://marc.info/?l=linux-mips&m=149677651707103&w=2

Now I see that I have dubbed your June 2017 patch. Sorry!

Alas in June 2017 there was no chance to push your patch to linux-mips repo.
Linus merged your patches in November 2017. Ralf merged your RISC-V changes
into linux-mips repo AFAIR just several days ago.

> Given that, I think you can also drop arch/mips/lib/libgcc.h -- if it's used 
> from anywhere else, it should be possible to use include/linux/libgcc.h 
> instead.

I agree with you.

> 
> Assuming it still seems sane do to that I can go give the rest of the patch set 
> another shot.  I'm a bit new to this, but I think I should do something like
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I suppose that it's better to resurrect you patch and abandon my patch.

Your original patch series (https://www.linux-mips.org/archives/linux-mips/2017-06/msg00148.html)
has a disadvantage: it tries to change several architectures at once.

I propose to create new short separate patch series for MIPS architecture.

This patch series should contain two patches:

   [PATCH 1/2] Add notrace to lib/ucmpdi2.c
   [PATCH 2/2] MIPS: Use generic libgcc intrinsics


> Thanks!
> 
> On Tue, 16 Jan 2018 22:51:21 PST (-0800), antonynpavlov@gmail.com wrote:
> > The commit b35cd9884fa5 ("lib: Add shared copies of
> > some GCC library routines") makes it possible
> > to share generic GCC library routines by several
> > architectures.
> >
> > This commit removes several generic GCC library
> > routines from arch/mips/lib/ in favour of similar
> > routines from lib/.
> >
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/mips/Kconfig       |  5 +++++
> >  arch/mips/lib/Makefile  |  2 +-
> >  arch/mips/lib/ashldi3.c | 30 ------------------------------
> >  arch/mips/lib/ashrdi3.c | 32 --------------------------------
> >  arch/mips/lib/cmpdi2.c  | 28 ----------------------------
> >  arch/mips/lib/lshrdi3.c | 30 ------------------------------
> >  arch/mips/lib/ucmpdi2.c | 22 ----------------------
> >  7 files changed, 6 insertions(+), 143 deletions(-)
> >  delete mode 100644 arch/mips/lib/ashldi3.c
> >  delete mode 100644 arch/mips/lib/ashrdi3.c
> >  delete mode 100644 arch/mips/lib/cmpdi2.c
> >  delete mode 100644 arch/mips/lib/lshrdi3.c
> >  delete mode 100644 arch/mips/lib/ucmpdi2.c
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 350a990fc719..9cd49ee848c6 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -73,6 +73,11 @@ config MIPS
> >  	select RTC_LIB if !MACH_LOONGSON64
> >  	select SYSCTL_EXCEPTION_TRACE
> >  	select VIRT_TO_BUS
> > +	select GENERIC_ASHLDI3
> > +	select GENERIC_ASHRDI3
> > +	select GENERIC_LSHRDI3
> > +	select GENERIC_CMPDI2
> > +	select GENERIC_UCMPDI2
> >
> >  menu "Machine selection"
> >
> > diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> > index 78c2affeabf8..195ab4cb0840 100644
> > --- a/arch/mips/lib/Makefile
> > +++ b/arch/mips/lib/Makefile
> > @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
> >  obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
> >
> >  # libgcc-style stuff needed in the kernel
> > -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
> > +obj-y += bswapsi.o bswapdi.o
> > diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
> > deleted file mode 100644
> > index 24cd6903e797..000000000000
> > --- a/arch/mips/lib/ashldi3.c
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -long long notrace __ashldi3(long long u, word_type b)
> > -{
> > -	DWunion uu, w;
> > -	word_type bm;
> > -
> > -	if (b == 0)
> > -		return u;
> > -
> > -	uu.ll = u;
> > -	bm = 32 - b;
> > -
> > -	if (bm <= 0) {
> > -		w.s.low = 0;
> > -		w.s.high = (unsigned int) uu.s.low << -bm;
> > -	} else {
> > -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
> > -
> > -		w.s.low = (unsigned int) uu.s.low << b;
> > -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
> > -	}
> > -
> > -	return w.ll;
> > -}
> > -
> > -EXPORT_SYMBOL(__ashldi3);
> > diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
> > deleted file mode 100644
> > index 23f5295af51e..000000000000
> > --- a/arch/mips/lib/ashrdi3.c
> > +++ /dev/null
> > @@ -1,32 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -long long notrace __ashrdi3(long long u, word_type b)
> > -{
> > -	DWunion uu, w;
> > -	word_type bm;
> > -
> > -	if (b == 0)
> > -		return u;
> > -
> > -	uu.ll = u;
> > -	bm = 32 - b;
> > -
> > -	if (bm <= 0) {
> > -		/* w.s.high = 1..1 or 0..0 */
> > -		w.s.high =
> > -		    uu.s.high >> 31;
> > -		w.s.low = uu.s.high >> -bm;
> > -	} else {
> > -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> > -
> > -		w.s.high = uu.s.high >> b;
> > -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> > -	}
> > -
> > -	return w.ll;
> > -}
> > -
> > -EXPORT_SYMBOL(__ashrdi3);
> > diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
> > deleted file mode 100644
> > index 93cfc785927d..000000000000
> > --- a/arch/mips/lib/cmpdi2.c
> > +++ /dev/null
> > @@ -1,28 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -word_type notrace __cmpdi2(long long a, long long b)
> > -{
> > -	const DWunion au = {
> > -		.ll = a
> > -	};
> > -	const DWunion bu = {
> > -		.ll = b
> > -	};
> > -
> > -	if (au.s.high < bu.s.high)
> > -		return 0;
> > -	else if (au.s.high > bu.s.high)
> > -		return 2;
> > -
> > -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> > -		return 0;
> > -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> > -		return 2;
> > -
> > -	return 1;
> > -}
> > -
> > -EXPORT_SYMBOL(__cmpdi2);
> > diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
> > deleted file mode 100644
> > index 914b971aca3b..000000000000
> > --- a/arch/mips/lib/lshrdi3.c
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -long long notrace __lshrdi3(long long u, word_type b)
> > -{
> > -	DWunion uu, w;
> > -	word_type bm;
> > -
> > -	if (b == 0)
> > -		return u;
> > -
> > -	uu.ll = u;
> > -	bm = 32 - b;
> > -
> > -	if (bm <= 0) {
> > -		w.s.high = 0;
> > -		w.s.low = (unsigned int) uu.s.high >> -bm;
> > -	} else {
> > -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> > -
> > -		w.s.high = (unsigned int) uu.s.high >> b;
> > -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> > -	}
> > -
> > -	return w.ll;
> > -}
> > -
> > -EXPORT_SYMBOL(__lshrdi3);
> > diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
> > deleted file mode 100644
> > index c31c78ca4175..000000000000
> > --- a/arch/mips/lib/ucmpdi2.c
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
> > -{
> > -	const DWunion au = {.ll = a};
> > -	const DWunion bu = {.ll = b};
> > -
> > -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
> > -		return 0;
> > -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
> > -		return 2;
> > -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> > -		return 0;
> > -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> > -		return 2;
> > -	return 1;
> > -}
> > -
> > -EXPORT_SYMBOL(__ucmpdi2);


-- 
Best regards,
  Antony Pavlov
