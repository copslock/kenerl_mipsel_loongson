Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 18:16:08 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:33459 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028989AbcFBQQGIRqu2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 18:16:06 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3D776388; Thu,  2 Jun 2016 18:16:00 +0200 (CEST)
Received: from bbrezillon (LStLambert-657-1-97-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id D7F8322;
        Thu,  2 Jun 2016 18:15:59 +0200 (CEST)
Date:   Thu, 2 Jun 2016 18:15:59 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH V3] mtd: nand: add Loongson1 NAND driver
Message-ID: <20160602181559.54aa9f67@bbrezillon>
In-Reply-To: <1464429250-27670-1-git-send-email-keguang.zhang@gmail.com>
References: <1464429250-27670-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53770
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

On Sat, 28 May 2016 17:54:10 +0800
Keguang Zhang <keguang.zhang@gmail.com> wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch adds NAND driver for Loongson1B.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> ---
> v3:
>    Replace __raw_readl/__raw_writel with readl/writel.
>    Split ls1x_nand into two structures: ls1x_nand_chip and ls1x_nand_controller.
> V2:
>    Modify the dependency in Kconfig due to the changes of DMA module.
> ---
>  drivers/mtd/nand/Kconfig          |   8 +
>  drivers/mtd/nand/Makefile         |   1 +
>  drivers/mtd/nand/loongson1_nand.c | 555 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 564 insertions(+)
>  create mode 100644 drivers/mtd/nand/loongson1_nand.c
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f05e0e9..be20fb8 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -563,4 +563,12 @@ config MTD_NAND_QCOM
>  	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
>  	  controller. This controller is found on IPQ806x SoC.
>  
> +config MTD_NAND_LOONGSON1
> +	tristate "Support for Loongson1 SoC NAND controller"
> +	depends on MACH_LOONGSON32
> +	select DMADEVICES
> +	select LOONGSON1_DMA
> +	help
> +		Enables support for NAND Flash on Loongson1 SoC based boards.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index f553353..0310c0b 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -57,5 +57,6 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
>  obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
> +obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> diff --git a/drivers/mtd/nand/loongson1_nand.c b/drivers/mtd/nand/loongson1_nand.c
> new file mode 100644
> index 0000000..86831773
> --- /dev/null
> +++ b/drivers/mtd/nand/loongson1_nand.c
> @@ -0,0 +1,555 @@
> +/*
> + * NAND Flash Driver for Loongson 1 SoC
> + *
> + * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/sizes.h>
> +
> +#include <nand.h>
> +
> +/* Loongson 1 NAND Register Definitions */
> +#define NAND_CMD		0x0
> +#define NAND_ADDRL		0x4
> +#define NAND_ADDRH		0x8
> +#define NAND_TIMING		0xc
> +#define NAND_IDL		0x10
> +#define NAND_IDH		0x14
> +#define NAND_STATUS		0x14
> +#define NAND_PARAM		0x18
> +#define NAND_OP_NUM		0x1c
> +#define NAND_CS_RDY		0x20
> +
> +#define NAND_DMA_ADDR		0x40
> +
> +/* NAND Command Register Bits */
> +#define OP_DONE			BIT(10)
> +#define OP_SPARE		BIT(9)
> +#define OP_MAIN			BIT(8)
> +#define CMD_STATUS		BIT(7)
> +#define CMD_RESET		BIT(6)
> +#define CMD_READID		BIT(5)
> +#define BLOCKS_ERASE		BIT(4)
> +#define CMD_ERASE		BIT(3)
> +#define CMD_WRITE		BIT(2)
> +#define CMD_READ		BIT(1)
> +#define CMD_VALID		BIT(0)
> +
> +#define	LS1X_NAND_TIMEOUT	20
> +
> +/* macros for registers read/write */
> +#define nand_readl(nandc, off)		\
> +	readl((nandc)->reg_base + (off))
> +
> +#define nand_writel(nandc, off, val)	\
> +	writel((val), (nandc)->reg_base + (off))
> +
> +#define set_cmd(nandc, ctrl)		\
> +	nand_writel(nandc, NAND_CMD, ctrl)
> +
> +#define start_nand(nandc)		\
> +	nand_writel(nandc, NAND_CMD, nand_readl(nandc, NAND_CMD) | CMD_VALID)
> +
> +struct ls1x_nand_chip {
> +	struct nand_chip chip;
> +	struct plat_ls1x_nand *pdata;
> +};
> +
> +struct ls1x_nand_controller {

ls1x_nand_controller should inherit from nand_hw_ctrl.

	struct nand_hw_ctrl base;

> +	struct clk *clk;
> +	void __iomem *reg_base;
> +
> +	int cmd_ctrl;
> +	char datareg[8];
> +	char *data_ptr;
> +
> +	/* DMA stuff */
> +	unsigned char *dma_buf;
> +	unsigned int buf_off;
> +	unsigned int buf_len;
> +
> +	/* DMA Engine stuff */
> +	unsigned int dma_chan_id;
> +	struct dma_chan *dma_chan;
> +	dma_cookie_t dma_cookie;
> +	struct completion dma_complete;
> +	void __iomem *dma_desc;
> +};
> +
> +static inline struct ls1x_nand_chip *to_ls1x_nand_chip(struct mtd_info *mtd)
> +{
> +	return container_of(mtd_to_nand(mtd), struct ls1x_nand_chip, chip);
> +}
> +
> +static void dma_callback(void *data)
> +{
> +	struct mtd_info *mtd = (struct mtd_info *)data;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);

And you should not retrieve the controller this way. You should have
the following function to do that:

static struct ls1x_nand_controller *
to_ls1x_nand_controller(struct nand_hw_control *controller)
{
	return container_of(controller, struct ls1x_nand_controller,
			    base);
}

and then do
	struct ls1x_nand_controller *nandc =
			to_ls1x_nand_controller(chip->controller);

nand_{get,set}_controller_data() are here to retrieve/assign per-chip
private data, so in you case, you could store your pdata in there. 

> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =
> +	    dmaengine_tx_status(nandc->dma_chan, nandc->dma_cookie, &state);
> +	if (likely(status == DMA_COMPLETE))
> +		dev_dbg(mtd->dev.parent, "DMA complete with cookie=%d\n",
> +			nandc->dma_cookie);
> +	else
> +		dev_err(mtd->dev.parent, "DMA error with cookie=%d\n",
> +			nandc->dma_cookie);
> +
> +	complete(&nandc->dma_complete);
> +}
> +
> +static int setup_dma(struct mtd_info *mtd)
> +{
> +	struct ls1x_nand_chip *nand = to_ls1x_nand_chip(mtd);
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +	struct dma_slave_config cfg;
> +	dma_cap_mask_t mask;
> +	int ret;
> +
> +	if (!nand->pdata->dma_filter) {
> +		dev_err(mtd->dev.parent, "no DMA filter\n");
> +		return -ENOENT;
> +	}
> +
> +	/* allocate DMA buffer */
> +	nandc->dma_buf = devm_kzalloc(mtd->dev.parent,
> +				      mtd->writesize + mtd->oobsize,
> +				      GFP_KERNEL);
> +	if (!nandc->dma_buf)
> +		return -ENOMEM;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	nandc->dma_chan = dma_request_channel(mask, nand->pdata->dma_filter,
> +					      &nandc->dma_chan_id);
> +	if (!nandc->dma_chan) {
> +		dev_err(mtd->dev.parent, "failed to request DMA channel\n");
> +		return -EBUSY;
> +	}
> +	dev_info(mtd->dev.parent, "got %s for %s access\n",
> +		 dma_chan_name(nandc->dma_chan), dev_name(mtd->dev.parent));
> +
> +	cfg.src_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
> +	cfg.dst_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	ret = dmaengine_slave_config(nandc->dma_chan, &cfg);
> +	if (ret) {
> +		dev_err(mtd->dev.parent, "failed to config DMA channel\n");
> +		dma_release_channel(nandc->dma_chan);
> +		return ret;
> +	}
> +
> +	init_completion(&nandc->dma_complete);
> +
> +	return 0;
> +}
> +
> +static int start_dma(struct mtd_info *mtd, unsigned int len, bool is_write)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +	struct dma_chan *chan = nandc->dma_chan;
> +	struct dma_async_tx_descriptor *desc;
> +	enum dma_data_direction data_dir =
> +	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +	enum dma_transfer_direction xfer_dir =
> +	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> +	dma_addr_t dma_addr;
> +	int ret;
> +
> +	dma_addr =
> +	    dma_map_single(chan->device->dev, nandc->dma_buf, len, data_dir);
> +	if (dma_mapping_error(chan->device->dev, dma_addr)) {
> +		dev_err(mtd->dev.parent, "failed to map DMA buffer\n");
> +		return -ENXIO;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, len, xfer_dir,
> +					   DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(mtd->dev.parent, "failed to prepare DMA descriptor\n");
> +		ret = PTR_ERR(desc);
> +		goto err;
> +	}
> +	desc->callback = dma_callback;
> +	desc->callback_param = mtd;
> +
> +	nandc->dma_cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(nandc->dma_cookie);
> +	if (ret) {
> +		dev_err(mtd->dev.parent, "failed to submit DMA descriptor\n");
> +		goto err;
> +	}
> +
> +	dev_dbg(mtd->dev.parent, "issue DMA with cookie=%d\n",
> +		nandc->dma_cookie);
> +	dma_async_issue_pending(chan);
> +
> +	ret = wait_for_completion_timeout(&nandc->dma_complete,
> +					  msecs_to_jiffies(LS1X_NAND_TIMEOUT));
> +	if (ret <= 0) {
> +		dev_err(mtd->dev.parent, "DMA timeout\n");
> +		dmaengine_terminate_all(chan);
> +		ret = -EIO;
> +	}
> +	ret = 0;
> +err:
> +	dma_unmap_single(chan->device->dev, dma_addr, len, data_dir);
> +
> +	return ret;
> +}
> +
> +static void ls1x_nand_select_chip(struct mtd_info *mtd, int chip)
> +{
> +}
> +
> +static int ls1x_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +
> +	if (nand_readl(nandc, NAND_CMD) & OP_DONE)

If the OP_DONE flag is really encoding the R/B pin status (as you
explained in a previous answer), then I would rename it NAND_RDY or
something like that.

> +		return 1;
> +
> +	return 0;
> +}
> +
> +static uint8_t ls1x_nand_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +
> +	return *(nandc->data_ptr++);
> +}
> +
> +static void ls1x_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +
> +	int real_len = min_t(size_t, len, nandc->buf_len - nandc->buf_off);
> +
> +	memcpy(buf, nandc->dma_buf + nandc->buf_off, real_len);
> +	nandc->buf_off += real_len;
> +}
> +
> +static void ls1x_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> +				int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
> +
> +	int real_len = min_t(size_t, len, nandc->buf_len - nandc->buf_off);
> +
> +	memcpy(nandc->dma_buf + nandc->buf_off, buf, real_len);
> +	nandc->buf_off += real_len;
> +}

Still not happy with these ->{read,write}_{buf,byte}() implementations.
As explained, you should not guess how many bytes will be read when
->cmdfunc() is called, and this is what your doing.
What if you didn't get it right?

Just try to send the command when you really know how much should be
read/written.

The other approach would be to switch to this "high-level NAND
controller" driver design, but it's not there yet.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
