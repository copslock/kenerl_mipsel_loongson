Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 21:00:37 +0200 (CEST)
Received: from mail-io0-x22a.google.com ([IPv6:2607:f8b0:4001:c06::22a]:49377
        "EHLO mail-io0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdIRTAbUTxkn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 21:00:31 +0200
Received: by mail-io0-x22a.google.com with SMTP id 21so4575022iof.6
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6nLP9K73TIQJcdlvY3qC0XE//y6fHOI4ylTAtAJv73g=;
        b=DHjg//ouDjQD2AWZ347gq5CbmdiRtsSUOg0WUSXdr00L/6aNYhIfHPMsyqsVW2fbgt
         Sf/n6op+vPLct1lxxyv65VhqNgCzGYuicQG/n0aiXU7vC/4BJ6snQ/fB6oOJV9FxmG4T
         /EjrS1oflj07Utzw95yO1yNxMKNj/oY3Q0fas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6nLP9K73TIQJcdlvY3qC0XE//y6fHOI4ylTAtAJv73g=;
        b=sXdyY0KlyLUkOxc6+W12PlgVQWwgFygo6ZECYQn427+9rLHTz5RDAq+LR+06z1BmH0
         kl+cjWLjN1EWNvx5tAl92z2x5AMwUdRwQ9FZtyEcvkDjX3hrqXX4e+FjQLoLQI8aTA2m
         W0Qo0NPGkJABbE/sfKX+/bBoPgRdSlj27E2a1FC5XdyPXKL9bC+t5IVsCqdK6dRZHhN5
         I94oPXc1+t0ih5MTF2LPSA9pSaUjrAeDCTpGyrANjjmrzv7EnfN7j+7sO90vdIbgbf0i
         CbhZaWIgGyKA+ikgnx/d+HrixxZ7YyUNaM6MDyjz2xzacPzQzm1RLFBmWbP3ldC8CKA+
         tYzg==
X-Gm-Message-State: AHPjjUhDoFkzV2WXqd5QKeYvq6T6mJ0fVjFUMJ4tMsrM0x/3GXb0QOrl
        7kROQhbpJWfg2hHiJEoZpzETUZo0wGEPUGB8BwNhkQ==
X-Google-Smtp-Source: AOwi7QDRKe3IPmSNudMnBNNYHuv25Gl5oB9lL8fgLGdI/xWqnVKBOjikV/zFKoZxYOhdMxNHoHtPucU+K8oKEWQX8uI=
X-Received: by 10.107.197.198 with SMTP id v189mr21945457iof.94.1505761219864;
 Mon, 18 Sep 2017 12:00:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.164.78 with HTTP; Mon, 18 Sep 2017 12:00:18 -0700 (PDT)
In-Reply-To: <20170918083629.qn4dlrmk7ffipfsz@dell>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org> <20170918083629.qn4dlrmk7ffipfsz@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Sep 2017 21:00:18 +0200
Message-ID: <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Mon, Sep 18, 2017 at 10:36 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sun, 17 Sep 2017, Linus Walleij wrote:

>> Lee: requesting ACK for Wolfram to take this patch.
>
> This ...
>
>> SM501 users: requesting Tested-by on this patch.
>
> ... loosely depends on this (until it doesn't).

Yeah I did my best to scout around the commit logs
to figure out who's been contributing to the SM501 and
using it, I hope someone will step up and test it.

Linus
