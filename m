Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 14:56:52 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:39078
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeAIN4nTJkIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jan 2018 14:56:43 +0100
Received: by mail-io0-x243.google.com with SMTP id g70so18617917ioj.6
        for <linux-mips@linux-mips.org>; Tue, 09 Jan 2018 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jukwQVc8zqp0Mop2VItzw93zOSSEuvd3Qp2hHeNV5y0=;
        b=SAj8YeF/keTjjeZZb5XG6WHvEcYTOCT5C2vYDawJfFDNfswfSCKVPyBT9ZZ1aWtjFH
         Sb7D2ijhjYOueFMfw7SnSbnRmthHVO6zUDgPya00uHSUj6PlRZNmJJAvpA36XVe6u1ke
         njXaVnjzy74LBACXN+O+HpJAVCZNmAHu3L+C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jukwQVc8zqp0Mop2VItzw93zOSSEuvd3Qp2hHeNV5y0=;
        b=TSLPafjgm2IYLzYDMaHWQGh5sRje002YDxgU/6lURx6aZdXPOsJ2Hxc70DODx94iY1
         pg70QzmWKVPQfHwGjkHMfHMZLN6sc+cYPZ6YzOqWDf7XQtD7m6Y6Gj1jYNypxxsaa/2e
         OUK7hr7QebE81BwKdCYocq9soJtysnbkv65xkI+hce7LLX7pHFmk/rNSWYW9NYXY895i
         nOeVA17M6nWYc2yqFmDwydTAXQx4abb+IuiqNAGrdqA/XrpBhg0dQs2cTTELXZU/ZXHf
         Aiy4WS+VYSU+d7M7IHuFi6VmHUjB4m3ehnmT82sQw96xPEXxZh+MgwApfh8yPU8TFULq
         MhHg==
X-Gm-Message-State: AKGB3mKx0pn6YmLu/j6dxqo3Lp5IG3AUH33gJzV9soXTcd3uuGvXbbI8
        EoJiyawvRVQ61E27siMKYaN+clo0h4fhGjOb/VjFAA==
X-Google-Smtp-Source: ACJfBotCyrYKDH9MKQ+J6j4o1wqNQVOXS7zY0QsvXyhpKL+urex5BDdeze7FHAb5XK1wTTZbu96EoHrLKJ/Kv2VGjDs=
X-Received: by 10.107.131.157 with SMTP id n29mr15864168ioi.260.1515506197019;
 Tue, 09 Jan 2018 05:56:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.198.7 with HTTP; Tue, 9 Jan 2018 05:56:36 -0800 (PST)
In-Reply-To: <20180106000926.13770-1-alexandre.belloni@free-electrons.com>
References: <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
 <20180106000926.13770-1-alexandre.belloni@free-electrons.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jan 2018 14:56:36 +0100
Message-ID: <CACRpkdaCfjW7hWS1VnC6MR+j48=Q0uo7OSMA_6G90D7Cz7NMZA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: Add Microsemi Ocelot SoC driver
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     linux-gpio@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61957
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

On Sat, Jan 6, 2018 at 1:09 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> The Microsemi Ocelot SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing and the GPIOs.
>
> There is currently no support for interrupts.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  - use  pinctrl_gpio_direction_input/output from
>    ocelot_gpio_direction_input/output
>  - add a comment for ALT0/ALT1
>  - fill .max_register of ocelot_pinctrl_regmap_config

Patch applied. And it looks very good too.

This was all I had to do, right? No dependent patches?

Yours,
Linus Walleij
