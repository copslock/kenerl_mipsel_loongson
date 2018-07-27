Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 15:08:08 +0200 (CEST)
Received: from mail-vk0-x241.google.com ([IPv6:2607:f8b0:400c:c05::241]:41340
        "EHLO mail-vk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeG0NIENZoox (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2018 15:08:04 +0200
Received: by mail-vk0-x241.google.com with SMTP id o82-v6so2403882vko.8
        for <linux-mips@linux-mips.org>; Fri, 27 Jul 2018 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VAOeTaWahPDyn3xqk869/J06OLHjBONgOekfjZQfzEY=;
        b=JbUm7urgYbL0YD4z4Jr073sInpctIkiqHx4o5yy8N2qMaBax8+P2SpX/DLyFxWmHWj
         qL6XQxExDo2XiC6kNLAvbN5fY8uwK/pp35dItVRJ5saMOqFIrvsg6ttiqDCDH3hj17SW
         uiRtsztTCHsAM/OXZgCwJr4PJ98eD2W/WehZENHG1NjDmj5TwwX7jNU5liBIvIyQgyOE
         eMfMfJVDmQA1F4j6wGR38EPCIEhmtnxIk2RzfxFu8Pz6vpmUt/snv4pX+ADXMMfR0cu3
         l4DVYGRfYJNrWNOEFuyK+Q4w+BPDkTlDzmVTvow1+4huOjDlW5WMXgXXVKB+H2kvO2HI
         Zumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VAOeTaWahPDyn3xqk869/J06OLHjBONgOekfjZQfzEY=;
        b=YcIF4ztnTOR7DeBypLsTXRpYHFvPs0okm94aFx5aTLr/CS08YgYoUx22Kg+s9uE3b7
         6PElJ6K8ckPoknJ8oJAmRnd8NFoaw/IBAAZzXk2PBmpA0uq8znCMZc7lenuxUrjHof+9
         I7H5XEi1vDOOCa3OdIke1JYWADU7BRPpLM5/4fdlsnpII7ADawinK8gGuAvFtP/C7ORn
         NIlEQlG7NU7jA1WdkMGrORSedlmt2UsMwQaE5JbKIjw5sOypvco1WPWqc1k9R6ahYrKL
         jyjn1+scqj1fdWHlAJsaz0RUGUNbSYB6ZEa7OPEPOlJX63k4rUmMAGoH4C3ReQlgTrlZ
         Baog==
X-Gm-Message-State: AOUpUlHh3hAkN08+Ss7sYf8TKQBw2UGjUwLRhLyzaAAfE8g3yV4qjgEd
        /Pey9ZagIHJYDFkQjDFcrcvcZWJRuUUh1JVrUDw=
X-Google-Smtp-Source: AAOMgpfToTtndqUmJ8r45TBgSc4ABWGdq6Y8xu9djuYI4RvBredxD8DZ+ItoFQuqbMaEpMXAqUCn7dCiemEhhq/pf6o=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr3881974vkd.58.1532696876039;
 Fri, 27 Jul 2018 06:07:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 06:07:54
 -0700 (PDT)
In-Reply-To: <20180727120535.16504-3-alexandre.belloni@bootlin.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com> <20180727120535.16504-3-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 16:07:54 +0300
Message-ID: <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65202
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

On Fri, Jul 27, 2018 at 3:05 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.

Thanks for an update! My comments below (most of them just about style).

First of all, can we use 'controller' over the 'master' in the code?

>  .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-

>  Required properties:
> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> -  register set is required (named ICPU_CFG:SPI_MST)
> +- compatible : "snps,dw-apb-ssi"
> +- reg : The register base for the controller.

This hunk is odd.

>  struct dw_spi_mmio {
>         struct dw_spi  dws;
>         struct clk     *clk;
> +       void           *priv;
>  };

> +#define MSCC_SPI_MST_SW_MODE                   0x14
> +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)

+ blank line ?

> +struct dw_spi_mscc {
> +       struct regmap       *syscon;

> +       void __iomem        *spi_mst;

A nit: do we need to repeat "spi" here?

> +};

> +       if (!enable)
> +               dw_writel(dws, DW_SPI_SER, BIT(cs));

This sounds like

dw_set_cs(spi, enable);

> +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
> +                              GFP_KERNEL);

sizeof(*dwsmcc)  and one line in the result?

> +       /* Deassert all CS */
> +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);

Hmm... Don't we need to call dw_set_cs() for all of them as well?
If yes, perhaps better to call custom set_cs() in a loop?

-- 
With Best Regards,
Andy Shevchenko
