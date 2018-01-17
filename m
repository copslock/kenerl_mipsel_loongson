Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 14:20:21 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:42902
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994679AbeAQNUIIKvN4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jan 2018 14:20:08 +0100
Received: by mail-lf0-x241.google.com with SMTP id q17so11744945lfa.9;
        Wed, 17 Jan 2018 05:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GeiPfXvu6FwFgaloYzOlN0xgF/+mmZSVHSxtq3BSpb0=;
        b=cau/fJssZk1PKXThbjetOovedsne/Ys9gpsWy/tZS+G9fqgeNB1uzz1jxirkyKFixE
         Lkfv7z6YMYBtmdJ3jZnQ+q33X9Q5nmo38ywzgbkNxNclGgG6ro+S/DDHlbSv8+SbDZjX
         /eF8HChBP9PE2uytukAok5YIYS9urf8IJCnwf9QhoYrSfYoEKM31YXfzYV1UTJG6DAiX
         tjqDG+uLZC8nmvbgabRfpMJR2PUeGYfsjW3sXpy+40+G9SQUwtMcdZ6kYAEFrOmdxp+E
         aH0GkGk9pwqHglw7NcDvmunIjA4/BV3avYKVTTObehs3wU61ngtFN+TBLYfCrkkYDS6g
         qgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GeiPfXvu6FwFgaloYzOlN0xgF/+mmZSVHSxtq3BSpb0=;
        b=YAJjtWvhQYJTf7jejUCDJ5zlPw/wNBgvH1XdPS7KeVM9x2ce5I7nJd+EYM55o7PgYe
         DosFeAbtqNAuYKTDl+AFE6TKBVY92sAKNyFU1/ZHDCfSHNCzt7TkxSWkuPL7nU3MYlTd
         8ZIrkM4RS+pknCj0Vfe6mPXE1TOATkVvApIdTU+pt1BK2B4ZseeMKGt0Ta4aRAhHYEEZ
         Nf72qFTNohmUfGkCxZIjn14JAtd2imPl0blHzmQh2rHrhlPYqT8oWV4qongPaH6H+Q2J
         tObHWx5ZkUh4FcK8XQFqN6vvqTUk1PLj9b0EVO3O8Vt8/VNU8kbcmo5wWvW4mbyBv9p/
         S00Q==
X-Gm-Message-State: AKwxytdsppWcatKOowER0qtX8bhUiuySz8mfIrejUG6RiDgWogfTm71V
        bxmTyiHOsahlSYRedA3AJbI=
X-Google-Smtp-Source: ACJfBosNVBmSBLkte4iiLmCK0r3P4IFQmxTQWeg1qOBB3ApnF3L8Q7Lr13glKOSQfpWnltDq8SHcoQ==
X-Received: by 10.46.83.74 with SMTP id t10mr23790989ljd.127.1516195202237;
        Wed, 17 Jan 2018 05:20:02 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id i130sm420223lfi.46.2018.01.17.05.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 05:20:01 -0800 (PST)
Date:   Wed, 17 Jan 2018 16:34:18 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>,
        "Palmer Dabbelt" <palmer@sifive.com>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: use generic GCC library routines from lib/
Message-Id: <20180117163418.ba77b2f72298092fb843fda7@gmail.com>
In-Reply-To: <20180117090348.GA20406@mredfearn-linux>
References: <20180117065121.30437-1-antonynpavlov@gmail.com>
        <20180117090348.GA20406@mredfearn-linux>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.25; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62200
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

On Wed, 17 Jan 2018 09:03:48 +0000
Matt Redfearn <matt.redfearn@mips.com> wrote:

> Hi,
> 
> On Wed, Jan 17, 2018 at 09:51:21AM +0300, Antony Pavlov wrote:
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
> 
> Please preserve alphabetical order

Ok, I'll fix order in v2 patch.

> > --- a/arch/mips/lib/ucmpdi2.c
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/export.h>
> > -
> > -#include "libgcc.h"
> > -
> > -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
> 
> The version of __ucmpdi2 in /lib/ is not marked notrace. We have seen
> issues before with compiler intrinsics not being marked notrace - see
> aedcfbe06558 ("MIPS: lib: Mark intrinsics notrace")
> 
> Please ensure that the /lib/ version is equivalent before switching to
> that version.

Good shot! I have missed this 'notrace'.

lib/ucmpdi2.c differ from other GCC library routines files from lib
related to my patch (ashldi3.c, ashrdi3.c, cmpdi2.c, lshrdi3.c):
only lib/ucmpdi2.c has no 'notrace' flag. In other details the files
look equivalent. The files arch/mips/lib/libgcc.h and include/linux/libgcc.h
have no fundamental differences.

to Palmer:
Can we add notrace to lib/ucmpdi2.c?
It looks like that nobody (even RISC-V code)
uses GENERIC_CMPDI2 and GENERIC_UCMPDI2. Why?
Do you use them in your local branches?

-- 
Best regards,
  Antony Pavlov
