Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 13:06:46 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:34204
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994583AbeHFLGmQ7Huo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2018 13:06:42 +0200
Received: by mail-io0-x242.google.com with SMTP id l7-v6so10668179ioj.1
        for <linux-mips@linux-mips.org>; Mon, 06 Aug 2018 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kgyf+xozKBERQ/3jTZWyHubUeF9g8qmF9GMdrpyuHg=;
        b=Hn5PfxGY9VeXtd1JVZ9z+7XY/kpanOGzMKp38t8fOv90Z+y0SLcXGdhLX3A7DWR4Pb
         lpm22QSncoLBONvROz90BBOyyNkDl1vazz9BxbTqiohl7udGHc+bVVQVTcEjaY/mzbyH
         maFxRzqiE2dBR0Ux0lEi+vGkGREDP+W47/SLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kgyf+xozKBERQ/3jTZWyHubUeF9g8qmF9GMdrpyuHg=;
        b=fflOwEiK4Hgl9yuqvrxoNnI2wQ0VkALhU69hTcDvbFOfn58OZ7LD+1HYDwRaTa6xSq
         5k8i/vH/xRfga5YYtIWn5NSoocii6Xv0aV6+XxeRAIWki7TEKwhRjk9TLMBTE9+aimDv
         vAThxR0P67h1thZvlVn+WdOGM4BqP3okmWO4Tzm+Ara8sWstyZPYzRn9Z01ZeNrU08cs
         UX6eQQjAWjs3cPgrp+hytWksvHI8R23k2LRNUWnvJ7Knxwz/RjTDtV+hbDLGtOlJhRka
         +vice9pEY+/fy0jtcXldt7+6nMdv5rxvyioNROHlOlyUl09tsYG7wd4WOMIVJTbjhhrL
         CKSQ==
X-Gm-Message-State: AOUpUlFOFZUfWMgxep36ev415rRjTqBYU1QbJriN0mYdKoEy5m2ncIJZ
        BMJ2BEag6NJ0yeWVhRi89TqNQ+NyTy6uVhjgLB+nPw==
X-Google-Smtp-Source: AA+uWPzRo4vouDXnCCplavPjkNK9iwMnmkz+XlDL/ei03F1kg/M+PI/j7BfApAUMOzNSegGx2z7iII/0+oohPMBjTK0=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr14328616iof.304.1533553595887;
 Mon, 06 Aug 2018 04:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180725122621.31713-1-quentin.schulz@bootlin.com> <20180725122621.31713-2-quentin.schulz@bootlin.com>
In-Reply-To: <20180725122621.31713-2-quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Aug 2018 13:06:23 +0200
Message-ID: <CACRpkdbq2Q-J8scsuaUS0hP1x12xh0zd+RMrCp0TYB773bOAdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: add support for interrupt controller
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65409
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

Hi Quentin, sorry for delays!

On Wed, Jul 25, 2018 at 2:27 PM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:

> This GPIO controller can serve as an interrupt controller as well on the
> GPIOs it handles.
>
> An interrupt is generated whenever a GPIO line changes and the
> interrupt for this GPIO line is enabled. This means that both the
> changes from low to high and high to low generate an interrupt.
>
> For some use cases, it makes sense to ignore the high to low change and
> not generate an interrupt. Such a use case is a line that is hold in a
> level high/low manner until the event holding the line gets acked.
> This can be achieved by making sure the interrupt on the GPIO controller
> side gets acked and masked only after the line gets hold in its default
> state, this is what's done with the fasteoi functions.
>
> Only IRQ_TYPE_EDGE_BOTH and IRQ_TYPE_LEVEL_HIGH are supported for now.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Patch applied, it's such a pretty and straight-forward patch.
Also IRQ is probably very nice to have, so let's get this in and
supported.

Please consider addressing the following in follow-up patch(es):

> +static int ocelot_irq_set_type(struct irq_data *data, unsigned int type);

Can't you just move the function above so you don't have to forward-declare
this?

> +static struct irq_chip ocelot_eoi_irqchip = {
> +       .name           = "gpio",
> +       .irq_mask       = ocelot_irq_mask,
> +       .irq_eoi        = ocelot_irq_ack,
> +       .irq_unmask     = ocelot_irq_unmask,
> +       .flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,

As you see the latter part of the define is "IF_HANDLED".

> +       .irq_set_type   = ocelot_irq_set_type,
> +};
> +
> +static struct irq_chip ocelot_irqchip = {
> +       .name           = "gpio",
> +       .irq_mask       = ocelot_irq_mask,
> +       .irq_ack        = ocelot_irq_ack,
> +       .irq_unmask     = ocelot_irq_unmask,
> +       .irq_set_type   = ocelot_irq_set_type,
> +};

Is it really neccessary to have two irqchips?

Is this to separate ACK and EOI because the EOI version
doesn't survive an ACK?

Yours,
Linus Walleij
