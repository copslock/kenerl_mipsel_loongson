Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 23:40:34 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:37623 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993032AbeGQVk3pvBd8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 23:40:29 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E190B207AB; Tue, 17 Jul 2018 23:40:23 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B1131206A6;
        Tue, 17 Jul 2018 23:40:23 +0200 (CEST)
Date:   Tue, 17 Jul 2018 23:40:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] spi: dw-mmio: add MSCC Ocelot support
Message-ID: <20180717214024.GD3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-4-alexandre.belloni@bootlin.com>
 <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64905
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

On 18/07/2018 00:34:37+0300, Andy Shevchenko wrote:
> On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
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
> > +       ret = dw_spi_mscc_init(pdev, dwsmmio);
> > +       if (ret)
> > +               goto out;
> 
> > +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
> 
> Looks like you were thinking about something like
> 
> init_func = device_get_match_data(...);
> if (init_func) {
>  ret = init_func();
>  if (ret)
>    return ret;
> }
> 
> ?
> 

Ah sure, I forgot to do that after testing.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
