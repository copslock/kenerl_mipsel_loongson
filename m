Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 10:47:55 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:37700 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903705Ab1KVJrv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 10:47:51 +0100
Received: by iapp10 with SMTP id p10so10681483iap.36
        for <multiple recipients>; Tue, 22 Nov 2011 01:47:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.68.20 with SMTP id t20mr4417181ibi.18.1321955265232; Tue,
 22 Nov 2011 01:47:45 -0800 (PST)
Received: by 10.50.17.228 with HTTP; Tue, 22 Nov 2011 01:47:45 -0800 (PST)
In-Reply-To: <1321864620-8925-1-git-send-email-zhzhl555@gmail.com>
References: <1321864620-8925-1-git-send-email-zhzhl555@gmail.com>
Date:   Tue, 22 Nov 2011 10:47:45 +0100
Message-ID: <CACRpkda_M0voVTFAHUU8XaMrpgTfac2fiQY7-RhkwZ_BHYT+0w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add RTC support for loongson1B
From:   Linus Walleij <linus.walleij@linaro.org>
To:     zhzhl555@gmail.com
Cc:     a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18369

On Mon, Nov 21, 2011 at 9:37 AM,  <zhzhl555@gmail.com> wrote:

> From: zhao zhang <zhzhl555@gmail.com>
>
> This patch add RTC support(TOY counter0) for loongson1B
> Signed-off-by: zhao zhang <zhzhl555@gmail.com>
(...)
> +       __raw_writel(v, SYS_TOYWRITE0);

Why are you using __raw_* accessors everywhere?
Is something wrong with just writel()/readl() on loongson?

When I look in arch/mips/include/asm/io.h they actually
seem to be #defined to their __raw_* counterparts anyway
so it cannot hurt.

Yours,
Linus Walleij
