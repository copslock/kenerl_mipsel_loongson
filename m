Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 20:16:47 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:55378 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993081AbeGaSQojglqL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 20:16:44 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0192B207AA; Tue, 31 Jul 2018 20:16:38 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C80A720756;
        Tue, 31 Jul 2018 20:16:27 +0200 (CEST)
Date:   Tue, 31 Jul 2018 20:16:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Message-ID: <20180731181628.GX28585@piout.net>
References: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
 <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65333
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

On 31/07/2018 10:38:09-0700, Paul Burton wrote:
> Hi Alexandre,
> 
> On Tue, Jul 31, 2018 at 04:38:52PM +0200, Alexandre Belloni wrote:
> > Hello,
> > 
> > This series only contains the DT documentation and the corresponding DT addition
> > since it has been rebased on spi-next.
> > 
> > Alexandre Belloni (3):
> >   spi: dw: document Microsemi integration
> >   mips: dts: mscc: Add spi on Ocelot
> >   mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
> > 
> >  .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
> >  arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
> >  arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> Thanks - looks like the DT binding has been accepted, so I've applied
> patches 2 & 3 to mips-next for 4.19.
> 

Thank you, it is great to see that going in as this makes the platform
much more useful !


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
