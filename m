Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 15:47:00 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34577 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006918AbbLROq5dEVe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2015 15:46:57 +0100
Received: by mail-ob0-f173.google.com with SMTP id iw8so80841383obc.1
        for <linux-mips@linux-mips.org>; Fri, 18 Dec 2015 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5foSTx3CVIMkWwabIobMFLMhFPIAddxChA4mUFe9FdU=;
        b=cswkZanNzDaYIC9nuRcADOYc3A3RDt0s/BywXajMr4dYszUTpADFsG8rDHdbP0HCbz
         J2MyI2fHO+3hX40kCV9px7KaRb2YrapYjcE+F1RQb6WR2NsHd7Y5hkakaPpPeXNWaJR7
         Z9XlfediTCDPb5Pj+kAMozAGbsUxlZYCkrje8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5foSTx3CVIMkWwabIobMFLMhFPIAddxChA4mUFe9FdU=;
        b=jd7dE//QrMhTT40YF6xmf/WUT3MlAv8EL4attxErfaO//S5f5MfgddkJwDTbelDazs
         zl9f/EcYfejvZ4rsUZzGu7Zo0THNhns4MWpLGu5EdXnXiIyDcfBGI4kL94dTevlY/hkO
         VdK6t5Z4ymGEU7gJjFrbijFEwK0EOSuMBoqtbaqoXUanALXkCvTNK3/e6PI2vghgFS30
         jxsr97MNRRsCcvZHsfHmXSAYhctT4eI8obsZB8ra0QFZB8ibXb4m0bS+MYsaqcPxtNFa
         MUixx8ZEte1alto/DOHixHd0wLYvR8AxMkRHMwSx9g1eftfXLqeAdBjP+Hfz4nO8237m
         8ZSQ==
X-Gm-Message-State: ALoCoQmBm7vorIGS06uOnxZARClypVzl+6mdVJ/ECI74NhDFIaY2v+Z3JGYASxecMg9urUJOULrBnKG8C1++vSxt6Z9x9wDq8p9AkAqTVdzrbZazBoUcPcA=
MIME-Version: 1.0
X-Received: by 10.182.247.105 with SMTP id yd9mr1701945obc.21.1450450011898;
 Fri, 18 Dec 2015 06:46:51 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Fri, 18 Dec 2015 06:46:51 -0800 (PST)
In-Reply-To: <CAKdAkRR6kEzEOtjxXqS4BPToEzKGBsLb=SzePFAiLSDhh+=qnw@mail.gmail.com>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
        <20151209193034.GE27131@dtor-ws>
        <CACRpkdZDFPFOH=9FfYzLeKo5b-oXG4rPjoU4Rpq9Wv1-RvY6uQ@mail.gmail.com>
        <CAKdAkRR6kEzEOtjxXqS4BPToEzKGBsLb=SzePFAiLSDhh+=qnw@mail.gmail.com>
Date:   Fri, 18 Dec 2015 15:46:51 +0100
Message-ID: <CACRpkdb+jJyt1DLqsMfbFJ+md1mUrFprzG1m+6W2S-9pZV+PxA@mail.gmail.com>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50688
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

On Tue, Dec 15, 2015 at 8:25 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 1:18 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> At this point we have to cross-reference the pointer to my chip to
>> find the chip to remove. This goes for anything that takes the struct
>> gpio_chip *
>> as parameter, like gpiochip_add_pin_range(), gpiochip_request_own_desc()
>> etc etc. So something inside gpiolib must take a gpio_chip * pointer and
>> turn that into the actual state container, e.g, a struct gpio_device.
>> Since struct gpio_chip needs to be static and stateless, it cannot contain
>> a pointer back to its struct gpio_device.
>
> Why does gpio_chip have to be stateless? I am not saying that it
> should or should not, I just want to better understand what you are
> trying to achieve.

Because the allocation of gpio_chip is currently inside each driver
(often as part of their own state struct) and will go away with the
driver. I want to make that const parameter that the drivers supply
to the core gpiolib, and the gpiolib handled all states using something
like that struct gpio_device you suggested or a more elaborate
solution.

>> If I compare to how struct input_dev is done, you appear to also use the
>> pattern Russell suggested with input_dev_allocate() akin to
>> netdev_alloc(), and the allocated struct holds all the vtable and states etc,
>> and I think it is a good pattern, and that GPIO should conform.
>
> The main difference between gpio_chip (at least as it stands
> currently) and input devices and corresponding private driver data is
> that input device and driver data has different lifetimes; input
> devices may stick around even though driver is unbound from
> corresponding device and driver's private data freed.

I would like to achieve something similar for GPIO devices.

Yours,
Linus Walleij
