Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2017 22:53:31 +0200 (CEST)
Received: from mail-it0-x235.google.com ([IPv6:2607:f8b0:4001:c0b::235]:43406
        "EHLO mail-it0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994876AbdIKUxWuDSHd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2017 22:53:22 +0200
Received: by mail-it0-x235.google.com with SMTP id g142so13356688ita.0
        for <linux-mips@linux-mips.org>; Mon, 11 Sep 2017 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DdrE35nkwBRXf8AQZk1vOA+vtmPTqsmYAbSGDIbRwiU=;
        b=Lnz4i75r6d2zur4M4rzarjrZkTTNJltwjmKbWP0fXO75JTcDVFUIUxTVpdjE9GzkXN
         VpiuTSYz4A/xsoBLare4cGbc1/uN21d57nbqGiYL+b10PCQvy5Bz1oMV/y18h5gAYGR5
         oWowER4PS3hCq1BnP90gvFGCyWDqVQp+aWVLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DdrE35nkwBRXf8AQZk1vOA+vtmPTqsmYAbSGDIbRwiU=;
        b=fr99yK9t9/v5wkPSebDYShYo2EKI7lLmxy1yeSEOdosAJRpqeQTol26cZQlDTqBP8Q
         PbCyi0borFNsZLNPe/teYUnGK1NLtWQIahkdYRWSW6ytaCS6M6Kcn/xtyUYcxfUzwRmE
         81pgtaqGNR6b/avgmDuARvR3w/tXfktR/wPjIQPr/HOzE3Ujr/mtSWxflgeAB5aBrr50
         oi7frrCrzx94dobVXHmNSaz5CfhHRHlBZqmQtZTIBLbBp7dRj1antHsWB8klYdpiFEQB
         xE+dRtct69CW9G/GiVj3EvLdyRlMBt74vWrP1dgmrK+0i8ttGFro+zq94NYFH0S4EJux
         sTkA==
X-Gm-Message-State: AHPjjUizQBNngxEAE+j2JfqBzO/Gq3dxjgexNWarTAQaHw2OCXh53qol
        JUR/VoDEk3rCdb8dB94W9x0sNqhs0SJDrbrdlMP2xg==
X-Google-Smtp-Source: ADKCNb6YbJSDHRwB0kTbAlvflPSxbjov7UZ0CYvG66DcI0sjqyotTODz1wwOCc0ZOc99cb0oiKcX6ZYm5F7O1qINHNg=
X-Received: by 10.36.41.132 with SMTP id p126mr16666483itp.84.1505163195103;
 Mon, 11 Sep 2017 13:53:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.164.78 with HTTP; Mon, 11 Sep 2017 13:53:14 -0700 (PDT)
In-Reply-To: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org> <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2017 22:53:14 +0200
Message-ID: <CACRpkdYePt_reWhVUDR9XZoR_Agscr8T9cEXk7XMpn9umO8yCg@mail.gmail.com>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Steven Miao <realmz6@gmail.com>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59988
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

On Mon, Sep 11, 2017 at 1:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> FYI, I recently posted a series to deprecate (at least for DT) this error
> prone indexing, in favor of using named GPIOs:
>
>     [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
>     http://www.spinics.net/lists/devicetree/msg191936.html

Grrr I seem to have fallen off the list and don't have these mails
in my inbox ....

Anyways [1/3]:

>  Required properties:
>   - compatible = "i2c-gpio";
> - - gpios: sda and scl gpio
> -
> + - sda-gpios: gpio used for the sda signal
> + - scl-gpios: gpio used for the scl signal
> + - gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)

Say that the GPIOs should *always* be flagged as open drain
using e.g. (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) as flags.

>  Optional properties:
>   - i2c-gpio,sda-open-drain: sda as open drain

These should be deprecated. Nobody understands what they mean
anyway, but they mean "I set this line up as open drain behind your
back so don't try to do open drain emulation on me", which is just
totally convoluted.

The GPIO subsystems has ways to indicate this directly to the driver
nowadays.

Add an example?

Patch [2/3]: needs to be rewritten on top of the descriptor code.
(I can do it if you like.)

Patch [3/3] should be:

+ sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+ scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Yours,
Linus Walleij
