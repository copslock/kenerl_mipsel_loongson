Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 09:15:07 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:36058 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006833AbbLHIPEZ0wlE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2015 09:15:04 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E9EAB3CA; Tue,  8 Dec 2015 09:14:56 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-5-91.w83-193.abo.wanadoo.fr [83.193.130.91])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 32846382;
        Tue,  8 Dec 2015 09:14:56 +0100 (CET)
Date:   Tue, 8 Dec 2015 09:14:51 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Subject: Re: [linux-sunxi] [PATCH 01/23] mtd: kill the ecclayout->oobavail
 field
Message-ID: <20151208091451.4eef0b50@bbrezillon>
In-Reply-To: <1449556985.25438.8.camel@plaes.org>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
        <1449527178-5930-2-git-send-email-boris.brezillon@free-electrons.com>
        <1449556985.25438.8.camel@plaes.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Hi Priit,

On Tue, 08 Dec 2015 08:43:05 +0200
Priit Laes <plaes@plaes.org> wrote:

> On Mon, 2015-12-07 at 23:25 +0100, Boris Brezillon wrote:
> > ecclayout->oobavail is just redundant with the mtd->oobavail field.
> > Moreover, it prevents static const definition of ecc layouts since
> > the
> > NAND framework is calculating this value based on the ecclayout-
> > >oobfree
> > field.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/devices/docg3.c                   |  5 ++-
> >  drivers/mtd/mtdswap.c                         | 16 ++++-----
> >  drivers/mtd/nand/brcmnand/brcmnand.c          |  3 --
> >  drivers/mtd/nand/docg4.c                      |  1 -
> >  drivers/mtd/nand/hisi504_nand.c               |  1 -
> >  drivers/mtd/nand/nand_base.c                  | 12 +++----
> >  drivers/mtd/onenand/onenand_base.c            | 16 ++++-----
> >  drivers/mtd/tests/oobtest.c                   | 49 +++++++++++++--
> > ------------
> >  drivers/staging/mt29f_spinand/mt29f_spinand.c |  1 -
> >  fs/jffs2/wbuf.c                               |  6 ++--
> >  include/linux/mtd/mtd.h                       |  1 -
> >  11 files changed, 48 insertions(+), 63 deletions(-)
> > 
> [..]
> >  
> > diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c
> > b/drivers/mtd/nand/brcmnand/brcmnand.c
> > index 35d78f7..a906ec2 100644
> > --- a/drivers/mtd/nand/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/brcmnand/brcmnand.c
> > @@ -845,9 +845,6 @@ static struct nand_ecclayout *brcmnand_create_layout(int ecc_level,
> >  			break;
> >  	}
> >  out:
> > -	/* Sum available OOB */
> > -	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES_LARGE; i++)
> > -		layout->oobavail += layout->oobfree[i].length;
> >  	return layout;
> >  }
> 
> You can get rid of the 'out' label and replace the single goto in this
> function with 'return layout'.

Yep, I'll fix that.

> 
> [...]
> >  
> > diff --git a/drivers/mtd/nand/nand_base.c
> > b/drivers/mtd/nand/nand_base.c
> > index 0748a13..1107f5c1 100644
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -2037,7 +2037,7 @@ static int nand_do_read_oob(struct mtd_info
> > *mtd, loff_t from,
> >  	stats = mtd->ecc_stats;
> >  
> >  	if (ops->mode == MTD_OPS_AUTO_OOB)
> > -		len = chip->ecc.layout->oobavail;
> > +		len = mtd->oobavail;
> >  	else
> >  		len = mtd->oobsize;
> >  
> > @@ -2728,7 +2728,7 @@ static int nand_do_write_oob(struct mtd_info
> > *mtd, loff_t to,
> >  			 __func__, (unsigned int)to, (int)ops-
> > >ooblen);
> >  
> >  	if (ops->mode == MTD_OPS_AUTO_OOB)
> > -		len = chip->ecc.layout->oobavail;
> > +		len = mtd->oobavail;
> >  	else
> >  		len = mtd->oobsize;
> >  
> [...]
> > diff --git a/drivers/mtd/onenand/onenand_base.c
> > b/drivers/mtd/onenand/onenand_base.c
> > index 43b3392..d70bbfd 100644
> > --- a/drivers/mtd/onenand/onenand_base.c
> > +++ b/drivers/mtd/onenand/onenand_base.c
> > @@ -1125,7 +1125,7 @@ static int onenand_mlc_read_ops_nolock(struct
> > mtd_info *mtd, loff_t from,
> >  			(int)len);
> >  
> >  	if (ops->mode == MTD_OPS_AUTO_OOB)
> > -		oobsize = this->ecclayout->oobavail;
> > +		oobsize = mtd->oobavail;
> >  	else
> >  		oobsize = mtd->oobsize;
> >  
> > @@ -1230,7 +1230,7 @@ static int onenand_read_ops_nolock(struct
> > mtd_info *mtd, loff_t from,
> >  			(int)len);
> >  
> >  	if (ops->mode == MTD_OPS_AUTO_OOB)
> > -		oobsize = this->ecclayout->oobavail;
> > +		oobsize = mtd->oobavail;
> >  	else
> >  		oobsize = mtd->oobsize;
> >  
> > @@ -1365,7 +1365,7 @@ static int onenand_read_oob_nolock(struct
> > mtd_info *mtd, loff_t from,
> >  	ops->oobretlen = 0;
> >  
> >  	if (mode == MTD_OPS_AUTO_OOB)
> > -		oobsize = this->ecclayout->oobavail;
> > +		oobsize = mtd->oobavail;
> >  	else
> >  		oobsize = mtd->oobsize;
> >  
> > @@ -1887,7 +1887,7 @@ static int onenand_write_ops_nolock(struct
> > mtd_info *mtd, loff_t to,
> >  		return 0;
> >  
> >  	if (ops->mode == MTD_OPS_AUTO_OOB)
> > -		oobsize = this->ecclayout->oobavail;
> > +		oobsize = mtd->oobavail;
> >  	else
> >  		oobsize = mtd->oobsize;
> >  
> > @@ -2063,7 +2063,7 @@ static int onenand_write_oob_nolock(struct
> > mtd_info *mtd, loff_t to,
> >  	ops->oobretlen = 0;
> >  
> >  	if (mode == MTD_OPS_AUTO_OOB)
> > -		oobsize = this->ecclayout->oobavail;
> > +		oobsize = mtd->oobavail;
> >  	else
> >  		oobsize = mtd->oobsize;
> 
> This identical construction seems to occur multiple times in multiple
> files. Would it make sense to create a macro for it?

Right, I'll make another patch move this logic into an inline function.

Thanks for the review.

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
