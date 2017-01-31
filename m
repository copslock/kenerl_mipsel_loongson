Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 15:06:01 +0100 (CET)
Received: from mail-io0-x22e.google.com ([IPv6:2607:f8b0:4001:c06::22e]:34559
        "EHLO mail-io0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993877AbdAaOFxeXrxe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 15:05:53 +0100
Received: by mail-io0-x22e.google.com with SMTP id l66so132116585ioi.1
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=007qv2Ag4gl9F/MN4JfwN3TylwJRik6dyplO76nhZN4=;
        b=AEsirikDQVN+oksl4DHQsPiPJB4HZyFx3sOdNhKc8Mo05nNyzgLBBR8VWPwKAzTd82
         nA76uftthXibW3uPSf8VUSUZeSrdbbDIRkxZXR44RHrUtwEBvzoCbTtBzJw/K7fmZUPX
         iQsGEKb3qzn+N39yyhY9edTw/7w35nch57kDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=007qv2Ag4gl9F/MN4JfwN3TylwJRik6dyplO76nhZN4=;
        b=a5cKekniAaX9nzOX29fXJswQggYil53TOGUgDsjdVwNZTb6FXORhXoUhEAyIklHeyN
         /tQ2QYdYzdrFix0z1olIOWhiU/sZUZNoOJ75JH2Lga4b1aSh7BipzGb8bcDZ84bmIxcL
         Wz78go8Qa88butRuJhM0mXWY5wRv8C9LZktl7H3Y2MjJbT8dsJMfUkPdsgmBCxDxHAya
         WI9KsYUgzPuP+wqnalIKTCDT6mcFC6a91+i54/lOddLyj7Jqg0wmLsmp+RMbguZ5OsFB
         sp+Ao6rposj4olkmyEGb8nwPK8IgoE/0rm6fVJb8vZaawZx7ep8OK+UTyhLlA92LMgBl
         LvNw==
X-Gm-Message-State: AIkVDXLB07gXe3fWaqOwi1PyGKq746Z/LWbJWkKYOHCqDa9urqrxqmKjsuYl2JieoUjN4cgBC21YeKFoaoP6LGGe
X-Received: by 10.107.146.139 with SMTP id u133mr25266402iod.173.1485871545407;
 Tue, 31 Jan 2017 06:05:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Tue, 31 Jan 2017 06:05:43 -0800 (PST)
In-Reply-To: <20170125185207.23902-4-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-4-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 15:05:43 +0100
Message-ID: <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] pinctrl-ingenic: add a pinctrl driver for the
 Ingenic jz47xx SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56545
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

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> This driver handles pin configuration and pin muxing for the
> JZ4740 and JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

This is starting to look very nice.

> +#include <linux/compiler.h>
> +#include <linux/gpio.h>

Use <linux/gpio/driver.h> if it is a GPIO driver. I should
be enough ... I think.

> +static int ingenic_pinctrl_parse_dt_func(struct ingenic_pinctrl *jzpc,
> +               struct device_node *np)
> +{
> +       unsigned int num_groups;
> +       struct device_node *group_node;
> +       unsigned int i, j;
> +       int err, npins, *pins, *confs;
> +       const char **groups;
> +
> +       num_groups = of_get_child_count(np);
> +       groups = devm_kzalloc(jzpc->dev,
> +                       sizeof(*groups) * num_groups, GFP_KERNEL);
> +       if (!groups)
> +               return -ENOMEM;
> +
> +       i = 0;
> +       for_each_child_of_node(np, group_node) {
> +               groups[i++] = group_node->name;
> +
> +               npins = of_property_count_elems_of_size(group_node,
> +                               "ingenic,pins", 8);
> +               if (npins < 0)
> +                       return npins;
> +
> +               pins = devm_kzalloc(jzpc->dev,
> +                               sizeof(*pins) * npins, GFP_KERNEL);
> +               confs = devm_kzalloc(jzpc->dev,
> +                               sizeof(*confs) * npins, GFP_KERNEL);
> +               if (!pins || !confs)
> +                       return -ENOMEM;
> +
> +               for (j = 0; j < npins; j++) {
> +                       of_property_read_u32_index(group_node,
> +                                       "ingenic,pins", j * 2, &pins[j]);
> +
> +                       of_property_read_u32_index(group_node,
> +                                       "ingenic,pins", j * 2 + 1, &confs[j]);

If I didn't mention before this could pperhaps just use "pins"?

Or does these DT entries not match the generic bindings?

> +               }
> +
> +               err = pinctrl_generic_add_group(jzpc->pctl, group_node->name,
> +                               pins, npins, confs);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return pinmux_generic_add_function(jzpc->pctl, np->name,
> +                       groups, num_groups, NULL);
> +}

If you just use "pins" can this even be parsed by a generic parser function
pinconf_generic_dt_subnode_to_map()?

Yours,
Linus Walleij
