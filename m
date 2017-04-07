Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 11:42:03 +0200 (CEST)
Received: from mail-it0-x235.google.com ([IPv6:2607:f8b0:4001:c0b::235]:37584
        "EHLO mail-it0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdDGJlyigmTG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 11:41:54 +0200
Received: by mail-it0-x235.google.com with SMTP id a140so40044012ita.0
        for <linux-mips@linux-mips.org>; Fri, 07 Apr 2017 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2A1No68D3Etdp6WZtFUp6hsIzbfnQJO0VHeECydv0Bo=;
        b=caMWsw4nXWBkyUwjWEsi3R6FSvQ912O5uWkpfAk/jqpzPH8cQvHHB9IDsmrWTLt283
         dyTVJ3Ud5u5QsDqqVuEJyumTlsAfgcD4yLQgbZbhpdqZMifZ2eWShblgNHQ3LNh+ZRPq
         VE7ghYy3uc6FRiNPkBsA9Os01bXWj4EvbsKgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2A1No68D3Etdp6WZtFUp6hsIzbfnQJO0VHeECydv0Bo=;
        b=LHQIOlQzJTgjY4tWsGW1jbliK80qp8UFPVpYk7X9shGcpxVg4oChp9bZgOH7gnB1nz
         HzHR408xlm+ahQYReBAJy/61BhbRitvntxb51MSmbdQiPbzYlwOXWZ9NqtPStpO0gLmd
         Dye1ewNByxHHKbdFKnDV4c8KgA04HjvucnXCV8liqd60N4Hd2BVxAjZ6bn5/Q323IxpX
         3Ldm2W8LDKFbz8FjSY29bnFnOtiC1MbMsgjurEf8Bmx48Kzzlhq9vHkt2Edx9JEsJWE7
         wfrShKrcdChVmHHeOxOFoEm+2yeVmg8YEcynNt5NnnpY0tD+//tuazXeUVWmDS2uKGOo
         qHAQ==
X-Gm-Message-State: AN3rC/5r9klYhf+nfb+T5vt/YqggbEmTtzJ52WDSooE6jsISBMnv8vpN
        sOGMnf0uqE6ly6OsbD4eth8w0M4VfdhM
X-Received: by 10.36.181.71 with SMTP id j7mr2654633iti.56.1491558105287; Fri,
 07 Apr 2017 02:41:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Fri, 7 Apr 2017 02:41:44 -0700 (PDT)
In-Reply-To: <20170402204244.14216-4-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-4-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Apr 2017 11:41:44 +0200
Message-ID: <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] pinctrl-ingenic: add a pinctrl driver for the
 Ingenic jz47xx SoCs
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57613
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

On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> This driver handles pin configuration and pin muxing for the
> JZ4740 and JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
(...)
> +       select MFD_CORE
(...)
> +#include <linux/mfd/core.h>

That's unorthodox. Still quite pretty!
I would nee Lee Jones to say something about this, as it is
essentially hijacking MFD into the pinctrl subsystem.

> +static struct mfd_cell ingenic_pinctrl_mfd_cells[] = {
> +       {
> +               .id = 0,
> +               .name = "GPIOA",
> +               .of_compatible = "ingenic,gpio-bank-a",
> +       },
> +       {
> +               .id = 1,
> +               .name = "GPIOB",
> +               .of_compatible = "ingenic,gpio-bank-b",
> +       },
> +       {
> +               .id = 2,
> +               .name = "GPIOC",
> +               .of_compatible = "ingenic,gpio-bank-c",
> +       },
> +       {
> +               .id = 3,
> +               .name = "GPIOD",
> +               .of_compatible = "ingenic,gpio-bank-d",
> +       },
> +       {
> +               .id = 4,
> +               .name = "GPIOE",
> +               .of_compatible = "ingenic,gpio-bank-e",
> +       },
> +       {
> +               .id = 5,
> +               .name = "GPIOF",
> +               .of_compatible = "ingenic,gpio-bank-f",
> +       },
> +};
(...)
> +       err = devm_mfd_add_devices(dev, 0, ingenic_pinctrl_mfd_cells,
> +                       ARRAY_SIZE(ingenic_pinctrl_mfd_cells), NULL, 0, NULL);
> +       if (err) {
> +               dev_err(dev, "Failed to add MFD devices\n");
> +               return err;
> +       }

I guess the alternative would be to reimplement the MFD structure.

Did you check the approach to use "simple-mfd" and just let the subnodes
spawn as devices that way? I guess you did and this adds something
necessary.

Yours,
Linus Walleij
