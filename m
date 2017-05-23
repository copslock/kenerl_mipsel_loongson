Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 09:52:28 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:35946
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdEWHwScoL2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 09:52:18 +0200
Received: by mail-qt0-x244.google.com with SMTP id j13so21246952qta.3;
        Tue, 23 May 2017 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JM42Co6C8ylzZj+uWO6/agg0CV3GNRSXO+6Oc4Nsi+E=;
        b=JYNG0nv+NWqofY6PAuzhConkxfGL6FrjUvokiRAnTUnDot7KSwMoBFoBU+OgKubAIW
         oWc4bR4Q+9bHOZ8q+8ux5VQ6TfrE31thXf580Hi+hunUh41zfLS51QKVaJ4124KqJ2NV
         AKDZSDFY52yHP1ohZ6F1NP7UcNgruNE2d6wDflSppxrRniFQvxqkWCJ2GEiP86IKKcfP
         rmZi2SRM69wB1eVZHH9BcgH+wPHzAt0TpqkfLzf7M762Oq6Grjs1yMvQ+qfWA5LDAzlO
         cWT7uj9u23mR7KRQA+76LcLLuWXfDQz/sSTFB67VxSnFtyRrGGvjA84TxzalbK62EHj9
         mLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JM42Co6C8ylzZj+uWO6/agg0CV3GNRSXO+6Oc4Nsi+E=;
        b=PCoh7eryEQE9nDyf1d1nQYBhwMadhfxObCTrfMxdwmLpbtAznczPSlWLGBcu8YqC1V
         6v5FnoRrLzB2OYxE44pbaGY2sp+H7unJbKQvYAgyx1k9ghHY4NzNUeGl8MGEbJvW/67l
         fXC/aRumbVtcjI9Shusu9beepMPm2xAlqehpxVxQoFYQkXbPzs2wbATCA5kb+vnXxG1W
         V4m5NPP0va7AdcdK/hdYJepgLfu8/Tv0Uky/AjZX/Z9wDPxVbNcMZkBbu2UxoLznGR5h
         wQkRIEZMiJtV1FnmjRk72nIh5TGkRR6k1bmO/ehritZxCCHc9bqHYmzZ2NrgagQeIKti
         TY+g==
X-Gm-Message-State: AODbwcBQeeuE7Dy2gm+4QQcy92WuGpaJAfjJzjyV5RcWqwRzzBbZmoNx
        rXvM6EfkGfP1QpxugbYuSdCluMERaQ==
X-Received: by 10.237.62.52 with SMTP id l49mr27834810qtf.261.1495525932824;
 Tue, 23 May 2017 00:52:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.152.71 with HTTP; Tue, 23 May 2017 00:52:12 -0700 (PDT)
In-Reply-To: <20170521130918.27446-12-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de> <20170521130918.27446-12-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 May 2017 10:52:12 +0300
Message-ID: <CAHp75VdSAGv0md8YsvwdZJX4Eo-K6Tv3TcyAVKfOmdk6De1iGQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57942
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

On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:

> Compared to the old xrx200_phy_fw driver the new version has multiple
> enhancements. The name of the firmware files does not have to be added
> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
> instead. Each GPHY can now also boot separate firmware (thus mixing of
> GE and FE GPHYs is now possible).
> The new implementation is based on the RCU syscon-mfd and uses the
> reeset_controller framework instead of raw RCU register reads/writes.

> +static int xway_gphy_load(struct platform_device *pdev,
> +                         const char *fw_name, dma_addr_t *dev_addr)
> +{
> +       const struct firmware *fw;
> +       void *fw_addr;
> +       size_t size;
> +       int ret;
> +

> +       dev_info(&pdev->dev, "requesting %s\n", fw_name);

Noise.

> +       ret = request_firmware(&fw, fw_name, &pdev->dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to load firmware: %s, error: %i\n",
> +                       fw_name, ret);
> +               return ret;
> +       }
> +

> +       /*
> +        * GPHY cores need the firmware code in a persistent and contiguous
> +        * memory area with a 16 kB boundary aligned start address

Add period to the end.

> +        */

> +static int xway_gphy_of_probe(struct platform_device *pdev,
> +                               struct xway_gphy_priv *priv)
> +{

> +       priv->gphy_reset = devm_reset_control_get(&pdev->dev, "gphy");
> +       if (IS_ERR_OR_NULL(priv->gphy_reset)) {

_OR_NULL part looks suspicious.
There is _optional() variant of reset API, AFAIR.

> +               if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Failed to lookup gphy reset\n");
> +               return PTR_ERR(priv->gphy_reset);
> +       }

> +       priv->gphy_reset2 = devm_reset_control_get_optional(&pdev->dev, "gphy2");
> +       if (IS_ERR(priv->gphy_reset2)) {
> +               if (PTR_ERR(priv->gphy_reset2) == -EPROBE_DEFER)
> +                       return PTR_ERR(priv->gphy_reset2);

> +               priv->gphy_reset2 = NULL;

Why?

If there is a problem in reset framework it should be fixed there, not here.

> +       }
> +
> +       if (of_property_read_u32(np, "lantiq,gphy-mode", &gphy_mode))

> +               /* Default to GE mode */

If you put more lines in the branch you perhaps need {}.

> +               gphy_mode = GPHY_MODE_GE;

> +static int xway_gphy_probe(struct platform_device *pdev)
> +{
> +       struct xway_gphy_priv *priv;
> +       dma_addr_t fw_addr = 0;
> +       int ret;

> +       if (!IS_ERR_OR_NULL(priv->gphy_clk_gate))

_OR_NULL is redundant.
IS_ERR should not happen here if clock is mandatory.

Thus, complete line is redundant.

> +               clk_prepare_enable(priv->gphy_clk_gate);

You need to check return value.

-- 
With Best Regards,
Andy Shevchenko
