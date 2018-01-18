Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 17:06:32 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:38911
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeARQGA5sFKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 17:06:00 +0100
Received: by mail-pg0-x244.google.com with SMTP id y27so8597908pgc.5
        for <linux-mips@linux-mips.org>; Thu, 18 Jan 2018 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7DTgaP6T2CXSU3utq8eVBvjt0pxh/0uLv3M6kDseys=;
        b=G6CokSPzQ8CKmFhjnvRg4NSVAazvhe6+P+KgnNAtPepJPkFlZvdHmP0zyiPxE0algi
         nODezfd7AZ5sppUyvOt21zvMBqOF3wVmx/OaL2P7mb0svHsOeKRLiu82xlelfbcDpRGR
         +Zi7OpnT64OFYHmI/NUt04ETkZSYuqu98Cjo3m8wCBl8u5jJns7e+tJ1OQk9hD36mBka
         +0FgiXdZtwaJOh1ghwE7xWSu92k00jgc23jEjMIUsiJsycxANoYe81V/rABFbpQhqgcA
         MTtBp/aC9+44Vyv9S9TnFo+qJE6GI+cBxi1WYHGsM3TpnGzAa0KR8GUHMRWQlHLz+4Pm
         REhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Y7DTgaP6T2CXSU3utq8eVBvjt0pxh/0uLv3M6kDseys=;
        b=SjRfqyW7cNfW3WtQP7lu51KDWBFaP8YdQMJYaXEZqeZMj7MoW9LGdVZuHvlfYsT+TE
         QPnNMTCFTG2lFUl+mh7K7B+i2kHjrGeN0gbKOyomtAIxrOpzzMPozl6FlgU7xpfXIeza
         rq3/FVFU1Eoqy2GQ/mwATmG5eP/RH03JWtH13oiBSM1IbkTchPYzjCzVm1H+XYZVkVgq
         mOSytw+hOt0foz8HPdU27gEaSI9sAPUPj4K3/cn0UGPqHwAvnTnEUCI93XJETBbjPUpR
         B/mwTQ5sbTXOmIRXHUyfwsapBQU97bKNeGlaj0c36yp9xn+a0RQ+BdbWzbhsA2ZIAeBh
         KkcQ==
X-Gm-Message-State: AKwxyte9yjNLWUd5P7KZZhDdaOg/TPUMSX+ufh3u25jDupb0c6elnwb/
        F2FPS0vqWyv1BPFGH88BpmWYbA==
X-Google-Smtp-Source: ACJfBotVfck7rZBbX2dvr5YMfPyQrou2W7oPd5mgE4ZXf+oggEFhvFuPhwLj/S2U+WbfwC87z29P3Q==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr6631plh.272.1516291554501;
        Thu, 18 Jan 2018 08:05:54 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n7sm974854pgd.10.2018.01.18.08.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 08:05:54 -0800 (PST)
Date:   Thu, 18 Jan 2018 08:05:54 -0800 (PST)
X-Google-Original-Date: Thu, 18 Jan 2018 08:05:33 PST (-0800)
Subject:     Re: [PATCH] MIPS: use generic GCC library routines from lib/
In-Reply-To: <20180117163418.ba77b2f72298092fb843fda7@gmail.com>
CC:     matt.redfearn@mips.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     antonynpavlov@gmail.com
Message-ID: <mhng-f0aef9cf-df3a-41a8-a108-1a409394351a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62236
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

On Wed, 17 Jan 2018 05:34:18 PST (-0800), antonynpavlov@gmail.com wrote:
> On Wed, 17 Jan 2018 09:03:48 +0000
> Matt Redfearn <matt.redfearn@mips.com> wrote:
>
>> Hi,
>> 
>> On Wed, Jan 17, 2018 at 09:51:21AM +0300, Antony Pavlov wrote:
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
>> 
>> Please preserve alphabetical order
>
> Ok, I'll fix order in v2 patch.
>
>> > --- a/arch/mips/lib/ucmpdi2.c
>> > +++ /dev/null
>> > @@ -1,22 +0,0 @@
>> > -// SPDX-License-Identifier: GPL-2.0
>> > -#include <linux/export.h>
>> > -
>> > -#include "libgcc.h"
>> > -
>> > -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>> 
>> The version of __ucmpdi2 in /lib/ is not marked notrace. We have seen
>> issues before with compiler intrinsics not being marked notrace - see
>> aedcfbe06558 ("MIPS: lib: Mark intrinsics notrace")
>> 
>> Please ensure that the /lib/ version is equivalent before switching to
>> that version.
>
> Good shot! I have missed this 'notrace'.
>
> lib/ucmpdi2.c differ from other GCC library routines files from lib
> related to my patch (ashldi3.c, ashrdi3.c, cmpdi2.c, lshrdi3.c):
> only lib/ucmpdi2.c has no 'notrace' flag. In other details the files
> look equivalent. The files arch/mips/lib/libgcc.h and include/linux/libgcc.h
> have no fundamental differences.
>
> to Palmer:
> Can we add notrace to lib/ucmpdi2.c?

Works for me.  Do you want to add a patch to this set?  Since it's a dependency 
of this patch it seems to make a bit more sense to just keep here.  Mine looks like

    commit dba01764391cbd6e636595f7b957357b2cf2c14a
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Thu Jan 18 07:47:35 2018 -0800
    
        Add notrace to lib/ucmpdi2.c
    
        As part of the MIPS conversion to use the generic GCC library routines,
        Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
        patch rectifies the problem.
    
        CC: Matt Redfearn <matt.redfearn@mips.com>
        CC: Antony Pavlov <antonynpavlov@gmail.com>
        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
    
    diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
    index 25ca2d4c1e19..597998169a96 100644
    --- a/lib/ucmpdi2.c
    +++ b/lib/ucmpdi2.c
    @@ -17,7 +17,7 @@
     #include <linux/module.h>
     #include <linux/libgcc.h>
    
    -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
    +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
     {
     	const DWunion au = {.ll = a};
     	const DWunion bu = {.ll = b};

> It looks like that nobody (even RISC-V code)
> uses GENERIC_CMPDI2 and GENERIC_UCMPDI2. Why?
> Do you use them in your local branches?

I'd meant to convert every arch port over to using the generic routines, but it 
sort of just got lost in the shuffle.  I'll resurrect that patch set.
