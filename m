Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 20:31:43 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:36637
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994231AbdE3Sbg6LOth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2017 20:31:36 +0200
Received: by mail-qk0-x244.google.com with SMTP id y128so13044582qka.3;
        Tue, 30 May 2017 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=15XoyYQOurkG23qHjxWc7bLcbjHKcMYM++vP3j4/n+Y=;
        b=ahF6t2237jOQX5Hots5OwjqcUmeVNmNHPTPKobTq+fcdxj47h0hflqVNgHkK0aSCKn
         Xq4vNc4S/Ab7WujJuA/tnCfr0D+7Zey5uVZbBJvplIg2Qd6OErm7UEEmtiOQYmmaG21y
         Al+y/crhWFDfp2NSTlnPysmDpKN0H/Dg8K9PGoWPdP4VZhxmL2RvyRR5yguZtjYifm5Q
         CRAAnOenhTKgUEmPmvr/NceNRZEP1G90Rj2fJv/Pl+6AijFbR+U/l94GRdbpIl4u/CQV
         dH3q5BbD2HmVXAkg1nGOsodJtskGtCm0XC2K8uZRiZ3cV6dHUS7yJCw0Rup2rschx3gp
         qJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=15XoyYQOurkG23qHjxWc7bLcbjHKcMYM++vP3j4/n+Y=;
        b=IOL1NnIgWXufuW4vrdrrm2QyFEkO6kUTmPfUSLglkCjpS9l7ogT/KpOgMbQ1caljx5
         yrWg4L9KTR5zOEBIDtw7NIP508LCahl0GA5RXu/Lk/dEEReiZpgy+gbLk/RvzfpofXwK
         sTvoaaKRHUshQ3OicvjjRxxkpGrWo7ArvYvm39GwgkOgQwLS6NaMLWXG2TtLB5SxAY5S
         7Q7HkpcB0Ur4j3n+x67mmCkrhy+C+KGz9XMdgmxfBNam/YbKVyDUYy9nBcGnYdBW4BhT
         IOffaBG6a1t0n0GKHgiTMuxlJZSgQKadFuU8OzcSOm0A2kTRhJWnOJiAZIx9hQkXEwuA
         Un4Q==
X-Gm-Message-State: AODbwcB6BDk+v+OKH/FSPwU42fRqfIc/g+AIdNp6Q/w1Af6RhaJNgjca
        JBWu6zwed8xRr3hQMLdnbHn/oqwxLw==
X-Received: by 10.55.40.151 with SMTP id o23mr17626917qko.210.1496169088226;
 Tue, 30 May 2017 11:31:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.152.71 with HTTP; Tue, 30 May 2017 11:31:27 -0700 (PDT)
In-Reply-To: <20170528184006.31668-15-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-15-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 May 2017 21:31:27 +0300
Message-ID: <CAHp75Ve9bV99=WCzmXU-Rth-gar5gqvy4taZ7NMQQHGKcVbHHw@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sun, May 28, 2017 at 9:40 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.

> +static void ltq_rcu_usb2_start_cores(struct platform_device *pdev)

It should return int. See below.

> +{

> +       /* Power on the USB core. */
> +       if (clk_prepare_enable(priv->ctrl_gate_clk)) {

You basically shadow the error, why?

> +               dev_err(dev, "failed to enable CTRL gate\n");
> +               return;
> +       }

> +       if (clk_prepare_enable(priv->phy_gate_clk)) {
> +               dev_err(dev, "failed to enable PHY gate\n");
> +               return;
> +       }

Ditto.

> +static int ltq_rcu_usb2_of_probe(struct device_node *phynode,
> +                                   struct ltq_rcu_usb2_priv *priv)
> +{
> +       struct device *dev = priv->dev;
> +       const struct of_device_id *match =
> +               of_match_node(ltq_rcu_usb2_phy_of_match, phynode);
> +       int ret;
> +

> +       if (!match) {
> +               dev_err(dev, "Not a compatible Lantiq RCU USB PHY\n");
> +               return -EINVAL;
> +       }

Can it ever happen?

> +
> +       priv->reg_bits = match->data;

I think there is a helper to get driver data directly from node.

> +       if (priv->reg_bits->have_ana_cfg) {
> +               ret = device_property_read_u32(dev, "offset-ana",
> +                                              &priv->ana_cfg1_reg_offset);
> +               if (ret) {
> +                       dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
> +                       return ret;
> +               }
> +       }

ret = device_property_...(...);
if (ret && priv->reg_bits->have_ana_cfg) {
 ...
 return ret;
}

?


> +       priv->dev = &pdev->dev;

> +       dev_set_drvdata(priv->dev, priv);

Move this to the end of function. Ideally it should be run if and only
if the function returns 0.

> +       provider = devm_of_phy_provider_register(&pdev->dev,
> +                                                of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(provider);

I would do explicitly, though it's up to you and maintainer.

if (IS_ERR(provider))
 return PTR_ERR();

return 0;

-- 
With Best Regards,
Andy Shevchenko
