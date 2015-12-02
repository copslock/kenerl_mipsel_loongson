Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 19:04:13 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37253 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007502AbbLBSEF403BG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 19:04:05 +0100
Received: by igcto18 with SMTP id to18so37451981igc.0
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=As7YkBTSU4/luvzL2a17ICksU6zlbYeJoD8OegUHdYY=;
        b=YsnpDXgRvhfoVQeKj7iDVcBlodW5BbcF0RwMHMMlQQzRNWC7GDO2Kv6kBlc8tEXGNr
         A5i0902bIl/6Ea+7drjbd0fVvwH5mPo7P7fvU0ZO//3vQQq1Kob6lBEcEpfK41uVaMuS
         ZKY//03mKbcrxZTMautYO9K/cbrT3KRMm2u+o6rhgP0Bc+b+IND8OpbI8VQ4EkmMeO+a
         XhPERyaf3cf+xLVPWCiFGZSDGD0cYd2cp9kLGmu5jEyQowGbh+dQTVSGuLxn5S/X9DDL
         OjpCFje2XvvtfHslh7E2ZTkNhekI2xMIU8C6OBbt7AJx5YHl+dUiIG89J8EvZSwam1L5
         CgMw==
X-Received: by 10.50.155.4 with SMTP id vs4mr5286240igb.34.1449079440097; Wed,
 02 Dec 2015 10:04:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.17 with HTTP; Wed, 2 Dec 2015 10:03:20 -0800 (PST)
In-Reply-To: <565CB86F.4040303@simon.arlott.org.uk>
References: <565CB83B.7010000@simon.arlott.org.uk> <565CB86F.4040303@simon.arlott.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 2 Dec 2015 10:03:20 -0800
Message-ID: <CAGVrzcbjdsbGLuH6T6DSoC5SGN5WDFdM1h1xB5nQyX8wm-Esow@mail.gmail.com>
Subject: Re: [PATCH 2/2] reset: bcm63xx: Add support for the BCM63xx
 soft-reset controller
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-11-30 12:58 GMT-08:00 Simon Arlott <simon@fire.lp0.eu>:
> The BCM63xx contains a soft-reset controller activated by setting
> a bit (that must previously have cleared).
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/reset/Kconfig         |   9 +++
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-bcm63xx.c | 134 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 drivers/reset/reset-bcm63xx.c


Could you create a bcm directory and then add your reset-bcm63xx.c
file there? I have a pending submission for the BCM63138 reset
controller which is not at all using the same structure and will share
nothing with your driver.

[snip]

> +static int bcm63xx_reset_xlate(struct reset_controller_dev *rcdev,
> +       const struct of_phandle_args *reset_spec)
> +{
> +       struct bcm63xx_reset_priv *priv = to_bcm63xx_reset_priv(rcdev);
> +
> +       if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
> +               return -EINVAL;
> +
> +       if (reset_spec->args[0] >= rcdev->nr_resets)
> +               return -EINVAL;

Should not these two things be moved to the core reset controller code
based on the #reset-cells value?

[snip]

> +       if (of_property_read_u32(np, "offset", &priv->offset))
> +               return -EINVAL;
> +
> +       /* valid reset bits */
> +       if (of_property_read_u32(np, "mask", &priv->mask))
> +               priv->mask = 0xffffffff;
> +
> +       priv->rcdev.owner = THIS_MODULE;
> +       priv->rcdev.ops = &bcm63xx_reset_ops;
> +       priv->rcdev.nr_resets = 32;

Should not that come from Device Tree, or be computed based on the
mask property, like hweight_long() or something along these lines?

> +       priv->rcdev.of_node = pdev->dev.of_node;
> +       priv->rcdev.of_reset_n_cells = 1;
> +       priv->rcdev.of_xlate = bcm63xx_reset_xlate;

-- 
Florian
