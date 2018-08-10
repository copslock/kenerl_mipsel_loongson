Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 20:12:03 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994796AbeHJSMA1V1u0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 20:12:00 +0200
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com [209.85.220.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0A022450
        for <linux-mips@linux-mips.org>; Fri, 10 Aug 2018 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533924713;
        bh=yZhlFZ8gprzMmtXCdMKVygb8ooVXZfynNtY3c6jYjW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RI0suXjP/eUwYtq8s2LfzNkoSXjO42ogtS37/lcsdi32phorfy/OyzBbe31R5Wtmq
         wAhi4Fbqc1v/Nu7UrQ9onIYv2rIUyqfPqnoBBRJ0q9TGkLGtE1KANJmGO60TTMIhLE
         HNvhtwBk4ZYFD76NBIZKRpTRqkT4j123Shmpo/pY=
Received: by mail-qk0-f174.google.com with SMTP id z74-v6so6966553qkb.10
        for <linux-mips@linux-mips.org>; Fri, 10 Aug 2018 11:11:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlE9joe/xec65DuJeWj9H+t2+tb8jAM9jHIQ2LAc9Ydy/TIn2RtK
        +MPK1f4lEjXF+2L+AftxjlM54z/TpIbostfEDw==
X-Google-Smtp-Source: AA+uWPwm53GWQ7QRW4Pi5vtzQqBsXkVH/wrVWk9wM321i/GxIuPM5foxG2LNNGx45AuhKmjGmDeDV062qsmPFpWjp+I=
X-Received: by 2002:a37:a0c8:: with SMTP id j191-v6mr2820818qke.375.1533924712734;
 Fri, 10 Aug 2018 11:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de> <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
 <0aa77961-fe60-6afe-e6c5-d2db4250cb22@suse.de>
In-Reply-To: <0aa77961-fe60-6afe-e6c5-d2db4250cb22@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Aug 2018 12:11:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LOqe9h1t9nYeothfV96ntkWb6X+anSryLqbVTX+XSWw@mail.gmail.com>
Message-ID: <CAL_Jsq+LOqe9h1t9nYeothfV96ntkWb6X+anSryLqbVTX+XSWw@mail.gmail.com>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com,
        Michael Allwright <allsey87@gmail.com>,
        Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Aug 10, 2018 at 11:45 AM Andreas Färber <afaerber@suse.de> wrote:
>
> Am 10.08.2018 um 19:34 schrieb Rob Herring:
> > On Sun, Aug 5, 2018 at 5:27 PM Andreas Färber <afaerber@suse.de> wrote:
> >>
> >> This is to allow using serdev.
> >>
> >> Signed-off-by: Andreas Färber <afaerber@suse.de>
> >> ---
> >>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> >> index 243c96025053..ad7267274f65 100644
> >> --- a/drivers/tty/serial/sc16is7xx.c
> >> +++ b/drivers/tty/serial/sc16is7xx.c
> >> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
> >>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
> >>
> >>         for (i = 0; i < devtype->nr_uart; ++i) {
> >> +#ifdef CONFIG_OF
> >> +               struct device_node *np;
> >> +               struct platform_device *pdev;
> >> +               char name[6] = "uartx";
> >> +#endif
> >> +
> >>                 s->p[i].line            = i;
> >>                 /* Initialize port data */
> >> +#ifdef CONFIG_OF
> >> +               name[4] = '0' + i;
> >> +               np = of_get_child_by_name(dev->of_node, name);
> >> +               if (IS_ERR(np)) {
> >> +                       ret = PTR_ERR(np);
> >> +                       goto out_ports;
> >> +               }
> >> +               pdev = of_platform_device_create(np, NULL, dev);
> >
> > Ideally, you would use of_platform_default_populate here. I think
> > you'd have to add a compatible to the child nodes, but that wouldn't
> > be a bad thing. I could envision that the child nodes ultimately
> > become their own driver utilizing the standard 8250 driver and a
> > compatible string would be needed in that case.
>
> Separate compatibles would mean separate drivers.

No. Having a compatible doesn't mean you have to have a driver.

> Unlike your DUART example this is not an MMIO device that we can easily
> split but a SPI slave (well, regmap due to some I2C models).

A SPI slave could provide a regmap, right?

> I don't see how separate drivers could work, given that the whole
> spi_device has a single interrupt for all functions of this device.

A shared interrupt or a parent driver that creates an irqchip like MFD
drivers often do.

>
> That left me with this ugly but working construct.

In any case, I'm was suggesting that you do any of this now. I just
want the binding to be designed to work either way.

> Is the uartX naming correct, or should it be serialX?

Ah, yes. Should be serial@... I'm fine if both the parent and child
are named serial@...

Rob
