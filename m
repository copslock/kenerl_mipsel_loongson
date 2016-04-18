Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 17:05:27 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:50543 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007834AbcDRPFZ2pbPl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 17:05:25 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7C0AA25F; Mon, 18 Apr 2016 17:05:19 +0200 (CEST)
Received: from bbrezillon (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7DF80233;
        Mon, 18 Apr 2016 17:05:18 +0200 (CEST)
Date:   Mon, 18 Apr 2016 17:05:18 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-mips@linux-mips.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Stefan Agner <stefan@agner.ch>, <linux-sunxi@googlegroups.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        <devel@driverdev.osuosl.org>,
        Archit Taneja <architt@codeaurora.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Huang Shijie <shijie.huang@arm.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Han Xu <b45815@freescale.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Priit Laes <plaes@plaes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        <linux-api@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v5 39/50] mtd: nand: omap2: switch to mtd_ooblayout_ops
Message-ID: <20160418170518.363f732d@bbrezillon>
In-Reply-To: <5714F011.5080409@ti.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
        <1459354505-32551-40-git-send-email-boris.brezillon@free-electrons.com>
        <5714F011.5080409@ti.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53066
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

On Mon, 18 Apr 2016 17:32:49 +0300
Roger Quadros <rogerq@ti.com> wrote:

> Boris,
> 
> On 30/03/16 19:14, Boris Brezillon wrote:
> > Implementing the mtd_ooblayout_ops interface is the new way of exposing
> > ECC/OOB layout to MTD users.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/omap2.c | 194 +++++++++++++++++++++++++++--------------------
> >  1 file changed, 113 insertions(+), 81 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 4ebf16b..bca154a 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -169,8 +169,6 @@ struct omap_nand_info {
> >  	u_char				*buf;
> >  	int					buf_len;
> >  	struct gpmc_nand_regs		reg;
> > -	/* generated at runtime depending on ECC algorithm and layout selected */
> > -	struct nand_ecclayout		oobinfo;
> >  	/* fields specific for BCHx_HW ECC scheme */
> >  	struct device			*elm_dev;
> >  	struct device_node		*of_node;
> > @@ -1639,19 +1637,108 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
> >  	return true;
> >  }
> >  
> > +static int omap_ooblayout_ecc(struct mtd_info *mtd, int section,
> > +			      struct mtd_oob_region *oobregion)
> > +{
> > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > +	int off = chip->options & NAND_BUSWIDTH_16 ?
> > +		  BADBLOCK_MARKER_LENGTH : 1;
> 
> IMO "off = 1" is valid only for OMAP_ECC_HAM1_CODE_HW and 8-bit NAND.
> For all other layouts it is always set to BADBLOCK_MARKER_LENGTH.

Indeed.

[...]

> > -	/* all OOB bytes from oobfree->offset till end off OOB are free */
> > -	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
> >  	/* check if NAND device's OOB is enough to store ECC signatures */
> > -	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
> > +	min_oobbytes = (oobbytes_per_step *
> > +			(mtd->writesize / nand_chip->ecc.size)) +
> > +		       (nand_chip->options & NAND_BUSWIDTH_16 ?
> > +			BADBLOCK_MARKER_LENGTH : 1);
> 
> would it affect this as well?

And here as well.

I've generated a patch (see below) fixing those problems.

> 
> > +	if (mtd->oobsize < min_oobbytes) {
> >  		dev_err(&info->pdev->dev,
> >  			"not enough OOB bytes required = %d, available=%d\n",
> > -			ecclayout->eccbytes, mtd->oobsize);
> > +			min_oobbytes, mtd->oobsize);
> >  		err = -EINVAL;
> >  		goto return_error;
> >  	}
> > 
> 
> I will need to test this change with all possible configurations.
> The number of configurations on OMAP is a bit overwhelming :(.

Sorry about that, but at least now I have someone who can test it :).

Thanks,

Boris

--->8---

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 9b96f56..07d4039 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1640,9 +1640,13 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 static int omap_ooblayout_ecc(struct mtd_info *mtd, int section,
 			      struct mtd_oob_region *oobregion)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int off = chip->options & NAND_BUSWIDTH_16 ?
-		  BADBLOCK_MARKER_LENGTH : 1;
+	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct nand_chip *chip = &info->nand;
+	int off = BADBLOCK_MARKER_LENGTH;
+
+	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_HW &&
+	    !(chip->options & NAND_BUSWIDTH_16))
+		off = 1;
 
 	if (section)
 		return -ERANGE;
@@ -1656,9 +1660,13 @@ static int omap_ooblayout_ecc(struct mtd_info *mtd, int section,
 static int omap_ooblayout_free(struct mtd_info *mtd, int section,
 			       struct mtd_oob_region *oobregion)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int off = chip->options & NAND_BUSWIDTH_16 ?
-		  BADBLOCK_MARKER_LENGTH : 1;
+	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct nand_chip *chip = &info->nand;
+	int off = BADBLOCK_MARKER_LENGTH;
+
+	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_HW &&
+	    !(chip->options & NAND_BUSWIDTH_16))
+		off = 1;
 
 	if (section)
 		return -ERANGE;
@@ -1682,8 +1690,7 @@ static int omap_sw_ooblayout_ecc(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	int off = chip->options & NAND_BUSWIDTH_16 ?
-		  BADBLOCK_MARKER_LENGTH : 1;
+	int off = BADBLOCK_MARKER_LENGTH;
 
 	if (section >= chip->ecc.steps)
 		return -ERANGE;
@@ -1702,8 +1709,7 @@ static int omap_sw_ooblayout_free(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	int off = chip->options & NAND_BUSWIDTH_16 ?
-		  BADBLOCK_MARKER_LENGTH : 1;
+	int off = BADBLOCK_MARKER_LENGTH;
 
 	if (section)
 		return -ERANGE;
@@ -1737,7 +1743,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	dma_cap_mask_t			mask;
 	unsigned			sig;
 	struct resource			*res;
-	int				min_oobbytes;
+	int				min_oobbytes = BADBLOCK_MARKER_LENGTH;
 	int				oobbytes_per_step;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -1921,6 +1927,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.correct          = omap_correct_data;
 		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
 		oobbytes_per_step		= nand_chip->ecc.bytes;
+
+		if (nand_chip->options & NAND_BUSWIDTH_16)
+			min_oobbytes		= 1;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -2038,10 +2047,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* check if NAND device's OOB is enough to store ECC signatures */
-	min_oobbytes = (oobbytes_per_step *
-			(mtd->writesize / nand_chip->ecc.size)) +
-		       (nand_chip->options & NAND_BUSWIDTH_16 ?
-			BADBLOCK_MARKER_LENGTH : 1);
+	min_oobbytes += (oobbytes_per_step *
+			 (mtd->writesize / nand_chip->ecc.size));
 	if (mtd->oobsize < min_oobbytes) {
 		dev_err(&info->pdev->dev,
 			"not enough OOB bytes required = %d, available=%d\n",
