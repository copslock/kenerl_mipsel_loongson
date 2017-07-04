Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 10:30:25 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([IPv6:2001:67c:670:201:290:27ff:fe1d:cc33]:53321
        "EHLO metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdGDIaSpVnRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 10:30:18 +0200
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.84_2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1dSJDs-0006lS-Q0; Tue, 04 Jul 2017 10:30:16 +0200
Message-ID: <1499157009.4045.4.camel@pengutronix.de>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 04 Jul 2017 10:30:09 +0200
In-Reply-To: <e1160f30-eeff-3db2-884c-9cd4af35a37d@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
         <20170702224051.15109-11-hauke@hauke-m.de>
         <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
         <e1160f30-eeff-3db2-884c-9cd4af35a37d@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <p.zabel@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.zabel@pengutronix.de
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

On Mon, 2017-07-03 at 23:30 +0200, Hauke Mehrtens wrote:
> On 07/03/2017 09:51 AM, Andy Shevchenko wrote:
> > On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>
> >> The reset controllers (on xRX200 and newer SoCs have two of them) are
> >> provided by the RCU module. This was initially implemented as a simple
> >> reset controller. However, the RCU module provides more functionality
> >> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> >> The old reset controller driver implementation from
> >> arch/mips/lantiq/xway/reset.c did not honor this fact.
> >>
> >> For some devices the request and the status bits are different.
> > 
> >> +Required properties:
> >> +- compatible           : Should be one of
> >> +                               "lantiq,danube-reset"
> >> +                               "lantiq,xrx200-reset"
> >> +- offset-set           : Offset of the reset set register
> >> +- offset-status                : Offset of the reset status register
> > 
> > Just one side comment (I'm fine with either choice, just for your
> > information). Recently I have reviewed at24 patch which adds a
> > property for getting MAC offset and my reseach ends up with the naming
> > pattern mac-offset (as many others are doing this way). So, perhaps in
> > your case it might make sense to do that way? Anyway, it's a matter of
> > a (bit of a) chaos in DT bindings, whatever you decide users will live
> > with.
> > 
> I put the offset first to group them better together, but I have no
> problem in reversing the order, then it is in a more natural speaking form.

Either way, I would like to see an Acked-by from the device tree
maintainers for the bindings. Given that,

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to merge this driver through the mips tree, since a git merge with
    git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git drivers/reset-2
is conflict free.

regards
Philipp
