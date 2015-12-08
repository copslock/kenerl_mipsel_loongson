Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 11:33:55 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:39980 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012381AbbLHKdwVMQEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 11:33:52 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 385DE367; Tue,  8 Dec 2015 11:33:44 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-5-91.w83-193.abo.wanadoo.fr [83.193.130.91])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 51F9F223;
        Tue,  8 Dec 2015 11:33:43 +0100 (CET)
Date:   Tue, 8 Dec 2015 11:33:43 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Subject: Re: [PATCH 05/23] mtd: nand: jz4770: kill the ->ecc_layout field
Message-ID: <20151208113343.2b049993@bbrezillon>
In-Reply-To: <5666B150.2030406@imgtec.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
        <1449527178-5930-6-git-send-email-boris.brezillon@free-electrons.com>
        <5666B150.2030406@imgtec.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50418
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

On Tue, 8 Dec 2015 10:30:40 +0000
Harvey Hunt <harvey.hunt@imgtec.com> wrote:

> Hi Boris,
> 
> On 07/12/15 22:26, Boris Brezillon wrote:
> > ->ecc_layout is not used by any board file. Kill this field to avoid any
> > confusion. New boards are encouraged to use the default ECC layout defined
> > in NAND core.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >   arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 --
> >   drivers/mtd/nand/jz4740_nand.c                  | 3 ---
> >   2 files changed, 5 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
> > index 79cff26..398733e 100644
> > --- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
> > +++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
> > @@ -25,8 +25,6 @@ struct jz_nand_platform_data {
> >   	int			num_partitions;
> >   	struct mtd_partition	*partitions;
> >
> > -	struct nand_ecclayout	*ecc_layout;
> > -
> >   	unsigned char banks[JZ_NAND_NUM_BANKS];
> >
> >   	void (*ident_callback)(struct platform_device *, struct nand_chip *,
> > diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
> > index 5a99a93..c4fe446 100644
> > --- a/drivers/mtd/nand/jz4740_nand.c
> > +++ b/drivers/mtd/nand/jz4740_nand.c
> > @@ -446,9 +446,6 @@ static int jz_nand_probe(struct platform_device *pdev)
> >   	chip->ecc.bytes		= 9;
> >   	chip->ecc.strength	= 4;
> >
> > -	if (pdata)
> > -		chip->ecc.layout = pdata->ecc_layout;
> > -
> >   	chip->chip_delay = 50;
> >   	chip->cmd_ctrl = jz_nand_cmd_ctrl;
> >   	chip->select_chip = jz_nand_select_chip;
> >
> 
> Is there a typo in this commit title? The JZ4740 and JZ4770 have quite 
> different NAND controller interfaces, so I don't think that the JZ4740 
> driver will support the JZ4770.

Yes, it's a typo, I meant jz4740, I'll fix my commit message
accordingly.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
