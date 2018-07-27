Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 17:27:04 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992891AbeG0P1BofeyS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 17:27:01 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34A1B20730; Fri, 27 Jul 2018 17:26:55 +0200 (CEST)
Received: from localhost (unknown [88.128.80.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id E94B320618;
        Fri, 27 Jul 2018 17:26:54 +0200 (CEST)
Date:   Fri, 27 Jul 2018 17:26:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
Message-ID: <20180727152655.GD7701@piout.net>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
 <20180727120535.16504-3-alexandre.belloni@bootlin.com>
 <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 27/07/2018 16:07:54+0300, Andy Shevchenko wrote:
> On Fri, Jul 27, 2018 at 3:05 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > Because the SPI controller deasserts the chip select when the TX fifo is
> > empty (which may happen in the middle of a transfer), the CS should be
> > handled by linux. Unfortunately, some or all of the first four chip
> > selects are not muxable as GPIOs, depending on the SoC.
> >
> > There is a way to bitbang those pins by using the SPI boot controller so
> > use it to set the chip selects.
> >
> > At init time, it is also necessary to give control of the SPI interface to
> > the Designware IP.
> 
> Thanks for an update! My comments below (most of them just about style).
> 
> First of all, can we use 'controller' over the 'master' in the code?
> 
> >  .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
> 
> >  Required properties:
> > -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> > -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> > -  register set is required (named ICPU_CFG:SPI_MST)
> > +- compatible : "snps,dw-apb-ssi"
> > +- reg : The register base for the controller.
> 
> This hunk is odd.
> 

Indeed, I'm not exactly sure what happened. I'll make sure it is
removed.

> >  struct dw_spi_mmio {
> >         struct dw_spi  dws;
> >         struct clk     *clk;
> > +       void           *priv;
> >  };
> 
> > +#define MSCC_SPI_MST_SW_MODE                   0x14
> > +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> > +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)
> 
> + blank line ?
> 
> > +struct dw_spi_mscc {
> > +       struct regmap       *syscon;
> 
> > +       void __iomem        *spi_mst;
> 
> A nit: do we need to repeat "spi" here?
> 

The register set is named SPI_MST in the datasheet so I would prefer
keeping it that way. I don't think this is an issue as it is MSCC
specific anyway.
The SI interface can be controlled by three different IPs, their name in
the datasheet are SPI boot, SPI slave and SPI master. The DW IP in what
is referred to as SPI master. The two other IPs can't be used under
linux.

So I'd like to keep spi_mst in the defines and variable but I can
probably tweak the comment to avoid the confusion.

> > +};
> 
> > +       if (!enable)
> > +               dw_writel(dws, DW_SPI_SER, BIT(cs));
> 
> This sounds like
> 
> dw_set_cs(spi, enable);
> 

That's right, I can probably use dw_spi_set_cs here

> > +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
> > +                              GFP_KERNEL);
> 
> sizeof(*dwsmcc)  and one line in the result?
> 
> > +       /* Deassert all CS */
> > +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
> 
> Hmm... Don't we need to call dw_set_cs() for all of them as well?
> If yes, perhaps better to call custom set_cs() in a loop?
> 

Most likely not, for the same reason why the common code is not doing
it. The FIFO is definitively empty so the CS will be unset.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
