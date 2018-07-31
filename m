Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:29:50 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993094AbeGaO3ql0Cnh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 16:29:46 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B0BF20789; Tue, 31 Jul 2018 16:29:38 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2601320731;
        Tue, 31 Jul 2018 16:29:38 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:29:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 0/6] Add support for MSCC Ocelot i2c
Message-ID: <20180731142939.GU28585@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
 <6e7a3b340635f73e3c748b97184b181b7698b978.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7a3b340635f73e3c748b97184b181b7698b978.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65312
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

On 31/07/2018 17:17:47+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > Because the designware IP was not able to handle the SDA hold time
> > before
> > version 1.11a, MSCC has its own implementation. Add support for it and
> > then add
> > i2c on ocelot boards.
> > 
> > I would expect patches 1 to 4 to go through the i2c tree and 5-6
> > through
> > the mips tree once patch 4 has been reviewed by the DT maintainers.
> > 
> 
> Thanks for an update, looks quite nice!
> I gave my tags wherever it is appropriate.
> 
> > Changes in v2:
> >  - removed first patch as a similar one is in i2c-next
> 
> >  - rebase on top of i2c-next
> 
> It seems you also took my patches which are not yet in i2c/for-next.
> 

That is right, I also based on https://patchwork.ozlabs.org/project/linux-i2c/list/?series=57551
but it is not a hard dependency.

> >  - Added two patches to implement ideas from Andy
> > 
> > Alexandre Belloni (6):
> >   i2c: designware: use generic table matching
> >   i2c: designware: move #ifdef CONFIG_OF to the top
> >   i2c: designware: allow IP specific sda_hold_time
> >   i2c: designware: add MSCC Ocelot support
> >   mips: dts: mscc: Add i2c on ocelot
> >   mips: dts: mscc: enable i2c on ocelot_pcb123
> > 
> >  .../bindings/i2c/i2c-designware.txt           |  9 ++-
> >  arch/mips/boot/dts/mscc/ocelot.dtsi           | 18 ++++++
> >  arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
> >  drivers/i2c/busses/i2c-designware-common.c    |  2 +
> >  drivers/i2c/busses/i2c-designware-core.h      |  4 ++
> >  drivers/i2c/busses/i2c-designware-platdrv.c   | 62 +++++++++++++++---
> > -
> >  6 files changed, 87 insertions(+), 14 deletions(-)
> > 
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
