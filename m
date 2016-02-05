Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 08:35:29 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:58300 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009823AbcBEHf0x3l0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 08:35:26 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 813871F5; Fri,  5 Feb 2016 08:35:20 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-1060-10.w83-193.abo.wanadoo.fr [83.193.174.10])
        by mail.free-electrons.com (Postfix) with ESMTPSA id ABECD20;
        Fri,  5 Feb 2016 08:35:19 +0100 (CET)
Date:   Fri, 5 Feb 2016 08:35:18 +0100
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
Message-ID: <20160205083518.7b54e9a7@bbrezillon>
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
X-archive-position: 51805
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

[...]

> +
> +/**
> + * mtd_ooblayout_count_bytes - count the number of bytes in a OOB category
> + * @mtd: mtd info structure
> + * @iter: category iterator
> + *
> + * Count the number of bytes in a given category.
> + *
> + * Returns a positive value on success, a negative error code otherwise.
> + */
> +static int mtd_ooblayout_count_bytes(struct mtd_info *mtd,
> +				int (*iter)(struct mtd_info *,
> +					    int section,
> +					    struct mtd_oob_region *oobregion))
> +{
> +	struct mtd_oob_region oobregion = { };
> +	int section = 0, ret, nbytes = 0;
> +
> +	while (1) {
> +		ret = iter(mtd, section, &oobregion);

				^ section++

Oops, will fix that in next version.

> +		if (ret) {
> +			if (ret == -ERANGE)
> +				ret = nbytes;
> +			break;
> +		}
> +
> +		nbytes += oobregion.length;
> +	}
> +
> +	return ret;
> +}


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
