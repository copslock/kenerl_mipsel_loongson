Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 19:10:16 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:56303 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeGJRKIJDcN3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jul 2018 19:10:08 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF3A5207BE; Tue, 10 Jul 2018 19:10:01 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6019F206A6;
        Tue, 10 Jul 2018 19:10:01 +0200 (CEST)
Date:   Tue, 10 Jul 2018 19:10:00 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 23/24] mtd: rawnand: jz4780: Drop the dependency on
 MACH_JZ4780
Message-ID: <20180710191000.2b7c95bb@bbrezillon>
In-Reply-To: <CANc+2y5vjUpM_ikegaoKTtqehSmBY3y_r+1E6y93AoivRQqmfg@mail.gmail.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
        <20180709200945.30116-24-boris.brezillon@bootlin.com>
        <CANc+2y5vjUpM_ikegaoKTtqehSmBY3y_r+1E6y93AoivRQqmfg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

Hi PrasannaKumar,

On Tue, 10 Jul 2018 22:16:50 +0530
PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com> wrote:

> Hi Boris,
> 
> On 10 July 2018 at 01:39, Boris Brezillon <boris.brezillon@bootlin.com>
> wrote:
> 
> > This MACH_JZ4780 dependency is taken care of by JZ4780_NEMC, no need
> > to repeat it here.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> >  drivers/mtd/nand/raw/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> > index 7b5e97719c25..d9cd9608bc2d 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -499,7 +499,7 @@ config MTD_NAND_JZ4740
> >
> >  config MTD_NAND_JZ4780
> >         tristate "Support for NAND on JZ4780 SoC"
> > -       depends on MACH_JZ4780 && JZ4780_NEMC
> > +       depends on JZ4780_NEMC
> >         help
> >           Enables support for NAND Flash connected to the NEMC on JZ4780
> > SoC
> >           based boards, using the BCH controller for hardware error
> > correction.
> > --
> > 2.14.1
> >
> >
> >  
> JZ4780 has MLC NAND.

Hm, the NAND controller supports both MLC and SLC NANDs. Maybe there
are only boards with MLC NANDs, but that doesn't mean we should remove
the driver for the controller. 

> As MLC NAND is not supported in mainline do you think
> this patch is required? Even wondering if the driver is required at all.

The fact that MLC NANDs are not supported by UBI is not necessarily
definitive. I have a branch with all the work we've done to add MLC
support to UBI [1]. If you have time to invest in it, feel free to take
over this work.

Anyway, the decision to remove this driver is not mine, and this patch
allows me to at least compile-test this driver.

Regards,

Boris

[1]https://github.com/bbrezillon/linux/commits/nand/mlc
