Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 10:27:20 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:59848 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010034AbcBEJ1SbdPaM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 10:27:18 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 2D853C; Fri,  5 Feb 2016 10:27:12 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 539D2C;
        Fri,  5 Feb 2016 10:27:11 +0100 (CET)
Date:   Fri, 5 Feb 2016 10:27:10 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
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
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH v2 05/51] mtd: add mtd_ooblayout_xxx() helper functions
Message-ID: <20160205102710.39fa4244@bbrezillon>
In-Reply-To: <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
        <1454580434-32078-6-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51807
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

On Thu,  4 Feb 2016 11:06:28 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> In order to make the ecclayout definition completely dynamic we need to
> rework the way the OOB layout are defined and iterated.
> 
> Create a few mtd_ooblayout_xxx() helpers to ease OOB bytes manipulation
> and hide ecclayout internals to their users.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/mtdcore.c   | 401 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |  33 ++++
>  2 files changed, 434 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 3096251..14e46ca 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -997,6 +997,407 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(mtd_read_oob);
>  
> +/**
> + * mtd_ooblayout_ecc - Get the OOB region definition of a specific ECC section
> + * @mtd: MTD device structure
> + * @section: ECC section. Depending on the layout you may have all the ECC
> + *	     bytes stored in a single contiguous section, or one section
> + *	     per ECC chunk (and sometime several sections for a single ECC
> + *	     ECC chunk)
> + * @oobecc: OOB region struct filled with the appropriate ECC position
> + *	    information
> + *
> + * This functions return ECC section information in the OOB area. I you want
> + * to get all the ECC bytes information, then you should call
> + * mtd_ooblayout_ecc(mtd, section++, oobecc) until it returns -ERANGE.
> + *
> + * Returns zero on success, a negative error code otherwise.
> + */
> +int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
> +		      struct mtd_oob_region *oobecc)
> +{
> +	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
> +
> +	memset(oobecc, 0, sizeof(*oobecc));
> +
> +	if (!mtd || section < 0)
> +		return -EINVAL;
> +
> +	if (!mtd->ecclayout)
> +		return -ENOTSUPP;
> +
> +	if (mtd->ecclayout->eccbytes < 1)
> +		return -ERANGE;
> +
> +	/*
> +	 * This logic allows us to reuse the ->ecclayout information and
> +	 * expose them as ECC regions (as done for the OOB free regions).
> +	 *
> +	 * TODO: this should be dropped as soon as we get rid of the
> +	 * ->ecclayout field.
> +	 */
> +	for (eccbyte = 0; eccbyte < mtd->ecclayout->eccbytes; eccbyte++) {
> +		eccpos = mtd->ecclayout->eccpos[eccbyte];
> +
> +		if (eccbyte < mtd->ecclayout->eccbytes - 1) {
> +			int neccpos = mtd->ecclayout->eccpos[eccbyte + 1];
> +
> +			if (eccpos + 1 == neccpos) {
> +				length++;
> +				continue;
> +			}
> +		}
> +
> +		if (section == cursection)
> +			break;
> +
> +		length = 0;
> +		cursection++;
> +	}
> +
> +	if (cursection != section)

Should be
	if (cursection != section ||
	    eccbyte >= mtd->ecclayout->eccbytes)

Will fix that too.

> +		return -ERANGE;
> +
> +	oobecc->length = length + 1;
> +	oobecc->offset = eccpos - length;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtd_ooblayout_ecc);


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
