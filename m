Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 18:04:47 +0100 (CET)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:36580
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABREjiKpwp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 18:04:39 +0100
Received: by mail-ua0-x243.google.com with SMTP id a25so27736504uak.3;
        Tue, 02 Jan 2018 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xsUJu+ZeISfn5JWEccgMSM4JR5XGKmg25uXAIVWSwvg=;
        b=AgEfnb/DqucYH6SEYYaP/GvIymxgu1IlDQ1dzP//Y4pifobazLF7jIyXZKLpGZ16t2
         l7awPKb+1sljtSoq9c7xpIpdft9binYq4u3v0+dY4Nai54m1G6B3Wl1x9viOK+zRciZn
         /sK1i8G79jsEGrjnwRkYjGWp6RMq/1d6vhoh4uCqJt6Z7pCjL66Yp7PMuEvhFlQqD/Oz
         9WJ7Ekb97q+L/EoKEFyr5pMpPSfxYoAnCZi5omd7NJH2hYZgQBv7P/iI6YTwtUHdmexy
         prJ+c81HnCNpkipFClm7vdeiemGfRqJxFnF/d1YFxAdX8dLQS3bIPVE5D3zKcOK+2ZKd
         TEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xsUJu+ZeISfn5JWEccgMSM4JR5XGKmg25uXAIVWSwvg=;
        b=QRn7ZxoGKM5Zhz0a52KvvxQG81v1M4jED9VjGJJ2NFsIJjgi7zX0K16SFY25DcJBy+
         W+de6QvNbv4XoR1irp/nT7oKwGsLVsj5kDQCSOsBFEPkd+bRhkas1EzyPbE1hNJZAEA2
         6JTTG5Jr6gxH1DQkw+iPef8GXVQkXEZUI2D1N6fdEqTjH20J/laVJrmUr1+ZMzhDVSlV
         nU/CpJVNqVlGaxO27OY9W2umApgm0Ve09hzDOEXDW09JwRSxQyWPxXUUXRE7SaINTqZL
         U6B5+Z+AF2LBEEMvR0Zjaq8tiY1rM5BqK7PYDBdTw3g/u7bEOKavRg7w0ZKzFKB1h4ea
         /bGA==
X-Gm-Message-State: AKGB3mLuVqs+CFNHJOtaRTT8EBtVfV+JELv/n+qJhabNro4Q7tRm6yJj
        D6HBWpcPzcJSOfic56VU9vIPFTHc1ldRl6/oN8Y=
X-Google-Smtp-Source: ACJfBouzQIpjwCpXOOUTaJMyWYy7gtzkuvqKM87aTyKnrqvf+c9BweSIWSnFrWmtj5CX5rYpI8Z64/bucKkeb7iD0cw=
X-Received: by 10.176.92.40 with SMTP id q40mr43052143uaf.85.1514912673329;
 Tue, 02 Jan 2018 09:04:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.4.199 with HTTP; Tue, 2 Jan 2018 09:04:12 -0800 (PST)
In-Reply-To: <20180102150848.11314-15-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-15-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 2 Jan 2018 18:04:12 +0100
X-Google-Sender-Auth: rYtQWVqE2zODQGAV3YeieNm5qcY
Message-ID: <CA+7wUsw0+dsvmY3wCq=VcfRsovhPPLEJjyEwV5pYUWLcC3i2dA@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] MIPS: ingenic: Initial GCW Zero support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Tue, Jan 2, 2018 at 4:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> The GCW Zero (http://www.gcw-zero.com) is a retro-gaming focused
> handheld game console, successfully kickstarted in ~2012, running Linux.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/Makefile |  1 +
>  arch/mips/boot/dts/ingenic/gcw0.dts | 61 +++++++++++++++++++++++++++++++++++++
>  arch/mips/configs/gcw0_defconfig    | 27 ++++++++++++++++
>  arch/mips/jz4740/Kconfig            |  4 +++
>  arch/mips/jz4740/boards.c           |  1 +
>  5 files changed, 94 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
>  create mode 100644 arch/mips/configs/gcw0_defconfig
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>      Drop custom CROSS_COMPILE from defconfig

Thanks for removing CROSS_COMPILE.

Acked-by: Mathieu Malaterre <malat@debian.org>
