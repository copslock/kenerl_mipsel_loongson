Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2012 14:53:34 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:56023 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903678Ab2ASNx2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2012 14:53:28 +0100
Received: by yenq11 with SMTP id q11so2398942yen.36
        for <multiple recipients>; Thu, 19 Jan 2012 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WWjBx+0Q1HAvBofe2lJgOo/gmM9rcYdBwI+QmxB5wiU=;
        b=ZVj3CUc7w8CHWoTycF0gPwAbbskMhr2ZvpYBCpOnXATrl9wiXc6Q5p1/aBz2cRslzf
         5tZPvRCiZyfijhYFm7Tl77ZsEZpgDHa69zJZOc5LcDDxk1r2UwJ35m/DArAyV8fRisWR
         ZLCKZ+rV/+nBAWuCn+Rnyd02x3Bj4ofRLAD3U=
MIME-Version: 1.0
Received: by 10.236.185.8 with SMTP id t8mr39417777yhm.30.1326981202654; Thu,
 19 Jan 2012 05:53:22 -0800 (PST)
Received: by 10.146.167.5 with HTTP; Thu, 19 Jan 2012 05:53:22 -0800 (PST)
In-Reply-To: <1326874624-17867-1-git-send-email-zhzhl555@gmail.com>
References: <1326874624-17867-1-git-send-email-zhzhl555@gmail.com>
Date:   Thu, 19 Jan 2012 14:53:22 +0100
X-Google-Sender-Auth: 5W650dofBqf57SOlMFCKhTsCwkM
Message-ID: <CAKnu2Mp9pV+aGb1r2q4h=CfOzsKN8Nz3tRbmEQOiRGOZ_Nw91Q@mail.gmail.com>
Subject: Re: [PATCH V3] MIPS: Add RTC support for loongson1B
From:   Linus Walleij <linus.walleij@linaro.org>
To:     zhzhl555@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/1/18  <zhzhl555@gmail.com>:

> From: zhao zhang <zhzhl555@gmail.com>
>
> This patch adds RTC support(TOY counter0) for loongson1B SOC
>
> change log:
> V3:Remove sync instruction.
> V2:Use new module_platform_driver macro.
> V1:Replace __raw_writel/__raw_readl with writel/readl.
>
> Signed-off-by: zhao zhang <zhzhl555@gmail.com>

I think this is looking good now.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

You need Andrew to pick it up though, so send it directly to him
as well.

Yours,
Linus Walleij
