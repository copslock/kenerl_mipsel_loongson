Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 17:43:48 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36851 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27037552AbcE1Pnpbwl0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 17:43:45 +0200
Received: by mail-pa0-f66.google.com with SMTP id fg1so16251426pad.3
        for <linux-mips@linux-mips.org>; Sat, 28 May 2016 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oLV0qmZM959k/CZs/5PISuoMFzLpUg+Db7HTOAKfunA=;
        b=MP2R9upSNiDT5t8dUP+Sa0wiHl85gReFYn/gNEuaYsgNlfPV+q7lxLCAEj8V5VeNvs
         vLN1IgaNarMpKr+MZAwHS3Bgg5n3oBaMd+xFyK091YSMZdlKARPmbKcl9qAu42SSkGdd
         c7j6+7jdE9PlPS2LxwN4sCSelFWyngy+sagc3jWCt1jNTIMLT60pHMx8YURxKzCoTZGc
         4vgDP8oY7a0awpL2jIkQkroPzuJkwWaGEG/9Ejt7lXly9X69td0JS0hkAshAViR9mDeQ
         rEc0O6YEaG0fBHM9iRxOABOMfRmN+LN3Bn0O7IhW0a+bx9COT87yyOv/L1ENiPxyTQkU
         KjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oLV0qmZM959k/CZs/5PISuoMFzLpUg+Db7HTOAKfunA=;
        b=D8hdSvD6h5Czj4ym7hrxH8Zj8P9eflCk/0YVjrPL+kAvPTsxR1wehnrrdMHrBCECR/
         F72Z5eA36Q6AKxlgIeU6lulptWr/zPf7kiJ1nXaMckgzpXUxxvs3StnH1qWkVOty5Vd9
         ZUAKfVuxdZkefoYtXFlFxJZm7qSQfM4CBiJ+YLHE8BlFt6YRalDHoTxeE8r/Xsn06WYy
         5hAXSaawuYlduRCyPRHsuxYs01gL+jy6M+Dbzu3povWN2oinDHQHNPvNIg6SxQt5okJh
         VjuVXHfnz2sm6xQ0R4FbQsvnI5CIdrdRgWxN2yuS8X688rOwVT7+E94O+iaXMJ+HKsQN
         iWzQ==
X-Gm-Message-State: ALyK8tIY4gyBWjrP5QOiVhEc0bjLbRVY61OKVQiiWR3JslrJ3IGjfbT9e2d+oT88cop6IA==
X-Received: by 10.66.66.10 with SMTP id b10mr31770267pat.12.1464450218901;
        Sat, 28 May 2016 08:43:38 -0700 (PDT)
Received: from [192.168.100.100] (li410-35.members.linode.com. [106.187.90.35])
        by smtp.googlemail.com with ESMTPSA id ut1sm36093122pac.46.2016.05.28.08.43.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2016 08:43:37 -0700 (PDT)
Subject: Re: [PATCH V3] mtd: nand: add Loongson1 NAND driver
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Mychaela Falconia <falcon@ivan.Harhan.ORG>
References: <1464429250-27670-1-git-send-email-keguang.zhang@gmail.com>
 <20160528141213.6da8e461@bbrezillon>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <5749BC8B.4010608@gmail.com>
Date:   Sat, 28 May 2016 23:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160528141213.6da8e461@bbrezillon>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

Hi Boris,
I have the same feeling as Mychaela, and suffered from the 'high-level
controllers' as well.
Looking forward to your review, thanks!

Best regards,

Keguang Zhang

On 05/28/2016 08:12 PM, Boris Brezillon wrote:
> Hi Kelvin,
>
> On Sat, 28 May 2016 17:54:10 +0800
> Keguang Zhang <keguang.zhang@gmail.com> wrote:
>
>> From: Kelvin Cheung <keguang.zhang@gmail.com>
>>
>> This patch adds NAND driver for Loongson1B.
> I think your controller matches Mychaela's "high-level NAND controller"
> definition [1]. Mychaela, can you confirm the Loongson controller
> looks like yours?
>
> I'll do a detailed review of the code soon.
>
> Thanks,
>
> Boris
>
> [1]http://thread.gmane.org/gmane.linux.drivers.mtd/67346
>
>> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
>>
>> ---
>> v3:
>>    Replace __raw_readl/__raw_writel with readl/writel.
>>    Split ls1x_nand into two structures: ls1x_nand_chip and ls1x_nand_controller.
>> V2:
>>    Modify the dependency in Kconfig due to the changes of DMA module.
>> ---
>>  drivers/mtd/nand/Kconfig          |   8 +
>>  drivers/mtd/nand/Makefile         |   1 +
>>  drivers/mtd/nand/loongson1_nand.c | 555 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 564 insertions(+)
>>  create mode 100644 drivers/mtd/nand/loongson1_nand.c
>>
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index f05e0e9..be20fb8 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -563,4 +563,12 @@ config MTD_NAND_QCOM
>>  	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
>>  	  controller. This controller is found on IPQ806x SoC.
>>  
>> +config MTD_NAND_LOONGSON1
>> +	tristate "Support for Loongson1 SoC NAND controller"
>> +	depends on MACH_LOONGSON32
>> +	select DMADEVICES
>> +	select LOONGSON1_DMA
>> +	help
>> +		Enables support for NAND Flash on Loongson1 SoC based boards.
>> +
>>  endif # MTD_NAND
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index f553353..0310c0b 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -57,5 +57,6 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
>>  obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>> +obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
>>  
>>  nand-objs := nand_base.o nand_bbt.o nand_timings.o
>> diff --git a/drivers/mtd/nand/loongson1_nand.c b/drivers/mtd/nand/loongson1_nand.c
>> new file mode 100644
>> index 0000000..86831773
>> --- /dev/null
>> +++ b/drivers/mtd/nand/loongson1_nand.c
>> @@ -0,0 +1,555 @@
>> +/*
>> + * NAND Flash Driver for Loongson 1 SoC
>> + *
>> + * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/nand.h>
>> +#include <linux/sizes.h>
>> +
>> +#include <nand.h>
>> +
>> +/* Loongson 1 NAND Register Definitions */
>> +#define NAND_CMD		0x0
>> +#define NAND_ADDRL		0x4
>> +#define NAND_ADDRH		0x8
>> +#define NAND_TIMING		0xc
>> +#define NAND_IDL		0x10
>> +#define NAND_IDH		0x14
>> +#define NAND_STATUS		0x14
>> +#define NAND_PARAM		0x18
>> +#define NAND_OP_NUM		0x1c
>> +#define NAND_CS_RDY		0x20
>> +
>> +#define NAND_DMA_ADDR		0x40
>> +
>> +/* NAND Command Register Bits */
>> +#define OP_DONE			BIT(10)
>> +#define OP_SPARE		BIT(9)
>> +#define OP_MAIN			BIT(8)
>> +#define CMD_STATUS		BIT(7)
>> +#define CMD_RESET		BIT(6)
>> +#define CMD_READID		BIT(5)
>> +#define BLOCKS_ERASE		BIT(4)
>> +#define CMD_ERASE		BIT(3)
>> +#define CMD_WRITE		BIT(2)
>> +#define CMD_READ		BIT(1)
>> +#define CMD_VALID		BIT(0)
>> +
>> +#define	LS1X_NAND_TIMEOUT	20
>> +
>> +/* macros for registers read/write */
>> +#define nand_readl(nandc, off)		\
>> +	readl((nandc)->reg_base + (off))
>> +
>> +#define nand_writel(nandc, off, val)	\
>> +	writel((val), (nandc)->reg_base + (off))
>> +
>> +#define set_cmd(nandc, ctrl)		\
>> +	nand_writel(nandc, NAND_CMD, ctrl)
>> +
>> +#define start_nand(nandc)		\
>> +	nand_writel(nandc, NAND_CMD, nand_readl(nandc, NAND_CMD) | CMD_VALID)
>> +
>> +struct ls1x_nand_chip {
>> +	struct nand_chip chip;
>> +	struct plat_ls1x_nand *pdata;
>> +};
>> +
>> +struct ls1x_nand_controller {
>> +	struct clk *clk;
>> +	void __iomem *reg_base;
>> +
>> +	int cmd_ctrl;
>> +	char datareg[8];
>> +	char *data_ptr;
>> +
>> +	/* DMA stuff */
>> +	unsigned char *dma_buf;
>> +	unsigned int buf_off;
>> +	unsigned int buf_len;
>> +
>> +	/* DMA Engine stuff */
>> +	unsigned int dma_chan_id;
>> +	struct dma_chan *dma_chan;
>> +	dma_cookie_t dma_cookie;
>> +	struct completion dma_complete;
>> +	void __iomem *dma_desc;
>> +};
>> +
>> +static inline struct ls1x_nand_chip *to_ls1x_nand_chip(struct mtd_info *mtd)
>> +{
>> +	return container_of(mtd_to_nand(mtd), struct ls1x_nand_chip, chip);
>> +}
>> +
>> +static void dma_callback(void *data)
>> +{
>> +	struct mtd_info *mtd = (struct mtd_info *)data;
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +	struct dma_tx_state state;
>> +	enum dma_status status;
>> +
>> +	status =
>> +	    dmaengine_tx_status(nandc->dma_chan, nandc->dma_cookie, &state);
>> +	if (likely(status == DMA_COMPLETE))
>> +		dev_dbg(mtd->dev.parent, "DMA complete with cookie=%d\n",
>> +			nandc->dma_cookie);
>> +	else
>> +		dev_err(mtd->dev.parent, "DMA error with cookie=%d\n",
>> +			nandc->dma_cookie);
>> +
>> +	complete(&nandc->dma_complete);
>> +}
>> +
>> +static int setup_dma(struct mtd_info *mtd)
>> +{
>> +	struct ls1x_nand_chip *nand = to_ls1x_nand_chip(mtd);
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +	struct dma_slave_config cfg;
>> +	dma_cap_mask_t mask;
>> +	int ret;
>> +
>> +	if (!nand->pdata->dma_filter) {
>> +		dev_err(mtd->dev.parent, "no DMA filter\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	/* allocate DMA buffer */
>> +	nandc->dma_buf = devm_kzalloc(mtd->dev.parent,
>> +				      mtd->writesize + mtd->oobsize,
>> +				      GFP_KERNEL);
>> +	if (!nandc->dma_buf)
>> +		return -ENOMEM;
>> +
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_SLAVE, mask);
>> +	nandc->dma_chan = dma_request_channel(mask, nand->pdata->dma_filter,
>> +					      &nandc->dma_chan_id);
>> +	if (!nandc->dma_chan) {
>> +		dev_err(mtd->dev.parent, "failed to request DMA channel\n");
>> +		return -EBUSY;
>> +	}
>> +	dev_info(mtd->dev.parent, "got %s for %s access\n",
>> +		 dma_chan_name(nandc->dma_chan), dev_name(mtd->dev.parent));
>> +
>> +	cfg.src_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
>> +	cfg.dst_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +	ret = dmaengine_slave_config(nandc->dma_chan, &cfg);
>> +	if (ret) {
>> +		dev_err(mtd->dev.parent, "failed to config DMA channel\n");
>> +		dma_release_channel(nandc->dma_chan);
>> +		return ret;
>> +	}
>> +
>> +	init_completion(&nandc->dma_complete);
>> +
>> +	return 0;
>> +}
>> +
>> +static int start_dma(struct mtd_info *mtd, unsigned int len, bool is_write)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +	struct dma_chan *chan = nandc->dma_chan;
>> +	struct dma_async_tx_descriptor *desc;
>> +	enum dma_data_direction data_dir =
>> +	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>> +	enum dma_transfer_direction xfer_dir =
>> +	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
>> +	dma_addr_t dma_addr;
>> +	int ret;
>> +
>> +	dma_addr =
>> +	    dma_map_single(chan->device->dev, nandc->dma_buf, len, data_dir);
>> +	if (dma_mapping_error(chan->device->dev, dma_addr)) {
>> +		dev_err(mtd->dev.parent, "failed to map DMA buffer\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	desc = dmaengine_prep_slave_single(chan, dma_addr, len, xfer_dir,
>> +					   DMA_PREP_INTERRUPT);
>> +	if (!desc) {
>> +		dev_err(mtd->dev.parent, "failed to prepare DMA descriptor\n");
>> +		ret = PTR_ERR(desc);
>> +		goto err;
>> +	}
>> +	desc->callback = dma_callback;
>> +	desc->callback_param = mtd;
>> +
>> +	nandc->dma_cookie = dmaengine_submit(desc);
>> +	ret = dma_submit_error(nandc->dma_cookie);
>> +	if (ret) {
>> +		dev_err(mtd->dev.parent, "failed to submit DMA descriptor\n");
>> +		goto err;
>> +	}
>> +
>> +	dev_dbg(mtd->dev.parent, "issue DMA with cookie=%d\n",
>> +		nandc->dma_cookie);
>> +	dma_async_issue_pending(chan);
>> +
>> +	ret = wait_for_completion_timeout(&nandc->dma_complete,
>> +					  msecs_to_jiffies(LS1X_NAND_TIMEOUT));
>> +	if (ret <= 0) {
>> +		dev_err(mtd->dev.parent, "DMA timeout\n");
>> +		dmaengine_terminate_all(chan);
>> +		ret = -EIO;
>> +	}
>> +	ret = 0;
>> +err:
>> +	dma_unmap_single(chan->device->dev, dma_addr, len, data_dir);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ls1x_nand_select_chip(struct mtd_info *mtd, int chip)
>> +{
>> +}
>> +
>> +static int ls1x_nand_dev_ready(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	if (nand_readl(nandc, NAND_CMD) & OP_DONE)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static uint8_t ls1x_nand_read_byte(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	return *(nandc->data_ptr++);
>> +}
>> +
>> +static void ls1x_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	int real_len = min_t(size_t, len, nandc->buf_len - nandc->buf_off);
>> +
>> +	memcpy(buf, nandc->dma_buf + nandc->buf_off, real_len);
>> +	nandc->buf_off += real_len;
>> +}
>> +
>> +static void ls1x_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
>> +				int len)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	int real_len = min_t(size_t, len, nandc->buf_len - nandc->buf_off);
>> +
>> +	memcpy(nandc->dma_buf + nandc->buf_off, buf, real_len);
>> +	nandc->buf_off += real_len;
>> +}
>> +
>> +static inline void set_addr_len(struct mtd_info *mtd, unsigned int command,
>> +				int column, int page_addr)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +	int page_shift, addr_low, addr_high;
>> +
>> +	if (command == NAND_CMD_ERASE1)
>> +		page_shift = chip->page_shift;
>> +	else
>> +		page_shift = chip->page_shift + 1;
>> +
>> +	addr_low = page_addr << page_shift;
>> +
>> +	if (column != -1) {
>> +		if (command == NAND_CMD_READOOB)
>> +			column += mtd->writesize;
>> +		addr_low += column;
>> +		nandc->buf_off = 0;
>> +	}
>> +
>> +	addr_high =
>> +	    page_addr >> (sizeof(page_addr) * BITS_PER_BYTE - page_shift);
>> +
>> +	if (command == NAND_CMD_ERASE1)
>> +		nandc->buf_len = 1;
>> +	else
>> +		nandc->buf_len = mtd->writesize + mtd->oobsize - column;
>> +
>> +	nand_writel(nandc, NAND_ADDRL, addr_low);
>> +	nand_writel(nandc, NAND_ADDRH, addr_high);
>> +	nand_writel(nandc, NAND_OP_NUM, nandc->buf_len);
>> +}
>> +
>> +static void ls1x_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
>> +			      int column, int page_addr)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	dev_dbg(mtd->dev.parent, "cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
>> +		command, column, page_addr);
>> +
>> +	if (command == NAND_CMD_RNDOUT) {
>> +		nandc->buf_off = column;
>> +		return;
>> +	}
>> +
>> +	/*set address, buffer length and buffer offset */
>> +	if (column != -1 || page_addr != -1)
>> +		set_addr_len(mtd, command, column, page_addr);
>> +
>> +	/*prepare NAND command */
>> +	switch (command) {
>> +	case NAND_CMD_RESET:
>> +		nandc->cmd_ctrl = CMD_RESET;
>> +		break;
>> +	case NAND_CMD_STATUS:
>> +		nandc->cmd_ctrl = CMD_STATUS;
>> +		break;
>> +	case NAND_CMD_READID:
>> +		nandc->cmd_ctrl = CMD_READID;
>> +		break;
>> +	case NAND_CMD_READ0:
>> +		nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_READ;
>> +		break;
>> +	case NAND_CMD_READOOB:
>> +		nandc->cmd_ctrl = OP_SPARE | CMD_READ;
>> +		break;
>> +	case NAND_CMD_ERASE1:
>> +		nandc->cmd_ctrl = CMD_ERASE;
>> +		break;
>> +	case NAND_CMD_PAGEPROG:
>> +		break;
>> +	case NAND_CMD_SEQIN:
>> +		if (column < mtd->writesize)
>> +			nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_WRITE;
>> +		else
>> +			nandc->cmd_ctrl = OP_SPARE | CMD_WRITE;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	/*set NAND command */
>> +	set_cmd(nandc, nandc->cmd_ctrl);
>> +	/*trigger NAND operation */
>> +	start_nand(nandc);
>> +	/*trigger DMA for R/W operation */
>> +	if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
>> +		start_dma(mtd, nandc->buf_len, false);
>> +	else if (command == NAND_CMD_PAGEPROG)
>> +		start_dma(mtd, nandc->buf_len, true);
>> +	nand_wait_ready(mtd);
>> +
>> +	if (command == NAND_CMD_STATUS) {
>> +		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_STATUS) >> 8);
>> +		/*work around hardware bug for invalid STATUS */
>> +		nandc->datareg[0] |= 0xc0;
>> +		nandc->data_ptr = nandc->datareg;
>> +	} else if (command == NAND_CMD_READID) {
>> +		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_IDH));
>> +		nandc->datareg[1] = (char)(nand_readl(nandc, NAND_IDL) >> 24);
>> +		nandc->datareg[2] = (char)(nand_readl(nandc, NAND_IDL) >> 16);
>> +		nandc->datareg[3] = (char)(nand_readl(nandc, NAND_IDL) >> 8);
>> +		nandc->datareg[4] = (char)(nand_readl(nandc, NAND_IDL));
>> +		nandc->data_ptr = nandc->datareg;
>> +	}
>> +
>> +	nandc->cmd_ctrl = 0;
>> +}
>> +
>> +static void ls1x_nand_hw_init(struct mtd_info *mtd, int hold_cycle,
>> +			      int wait_cycle)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +	int chipsize = (int)(chip->chipsize >> 20);
>> +	int cell_size = 0x0;
>> +
>> +	switch (chipsize) {
>> +	case SZ_128:		/*128M */
>> +		cell_size = 0x0;
>> +		break;
>> +	case SZ_256:		/*256M */
>> +		cell_size = 0x1;
>> +		break;
>> +	case SZ_512:		/*512M */
>> +		cell_size = 0x2;
>> +		break;
>> +	case SZ_1K:		/*1G */
>> +		cell_size = 0x3;
>> +		break;
>> +	case SZ_2K:		/*2G */
>> +		cell_size = 0x4;
>> +		break;
>> +	case SZ_4K:		/*4G */
>> +		cell_size = 0x5;
>> +		break;
>> +	case SZ_8K:		/*8G */
>> +		cell_size = 0x6;
>> +		break;
>> +	case SZ_16K:		/*16G */
>> +		cell_size = 0x7;
>> +		break;
>> +	default:
>> +		dev_warn(mtd->dev.parent, "unsupported chip size: %d MB\n",
>> +			 chipsize);
>> +	}
>> +
>> +	nand_writel(nandc, NAND_TIMING, (hold_cycle << 8) | wait_cycle);
>> +	nand_writel(nandc, NAND_PARAM,
>> +		    (nand_readl(nandc, NAND_PARAM) & 0xfffff0ff) | (cell_size <<
>> +								    8));
>> +}
>> +
>> +static int ls1x_nand_init(struct platform_device *pdev,
>> +			  struct ls1x_nand_controller *nandc)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ls1x_nand_chip *nand;
>> +	struct plat_ls1x_nand *pdata;
>> +	struct nand_chip *chip;
>> +	struct mtd_info *mtd;
>> +	int ret = 0;
>> +
>> +	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
>> +	if (!nand)
>> +		return -ENOMEM;
>> +
>> +	pdata = dev_get_platdata(dev);
>> +	if (!pdata) {
>> +		dev_err(dev, "platform data missing\n");
>> +		return -EINVAL;
>> +	}
>> +	nand->pdata = pdata;
>> +
>> +	chip = &nand->chip;
>> +	chip->read_byte		= ls1x_nand_read_byte;
>> +	chip->read_buf		= ls1x_nand_read_buf;
>> +	chip->write_buf		= ls1x_nand_write_buf;
>> +	chip->select_chip	= ls1x_nand_select_chip;
>> +	chip->dev_ready		= ls1x_nand_dev_ready;
>> +	chip->cmdfunc		= ls1x_nand_cmdfunc;
>> +	chip->options		= NAND_NO_SUBPAGE_WRITE;
>> +	chip->ecc.mode		= NAND_ECC_SOFT;
>> +	nand_set_controller_data(chip, nandc);
>> +
>> +	mtd = nand_to_mtd(chip);
>> +	mtd->name = "ls1x-nand";
>> +	mtd->owner = THIS_MODULE;
>> +	mtd->dev.parent = dev;
>> +
>> +	ret = nand_scan_ident(mtd, 1, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ls1x_nand_hw_init(mtd, pdata->hold_cycle, pdata->wait_cycle);
>> +
>> +	ret = setup_dma(mtd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nand_scan_tail(mtd);
>> +	if (ret) {
>> +		dma_release_channel(nandc->dma_chan);
>> +		return ret;
>> +	}
>> +
>> +	ret = mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register MTD device: %d\n", ret);
>> +		dma_release_channel(nandc->dma_chan);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, mtd);
>> +	return ret;
>> +}
>> +
>> +static int ls1x_nand_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ls1x_nand_controller *nandc;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	nandc = devm_kzalloc(dev, sizeof(*nandc), GFP_KERNEL);
>> +	if (!nandc)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "failed to get I/O memory\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	nandc->reg_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(nandc->reg_base))
>> +		return PTR_ERR(nandc->reg_base);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> +	if (!res) {
>> +		dev_err(dev, "failed to get DMA information\n");
>> +		return -ENXIO;
>> +	}
>> +	nandc->dma_chan_id = res->start;
>> +
>> +	nandc->clk = devm_clk_get(dev, pdev->name);
>> +	if (IS_ERR(nandc->clk)) {
>> +		dev_err(dev, "failed to get %s clock\n", pdev->name);
>> +		return PTR_ERR(nandc->clk);
>> +	}
>> +	clk_prepare_enable(nandc->clk);
>> +
>> +	ret = ls1x_nand_init(pdev, nandc);
>> +	if (ret) {
>> +		clk_disable_unprepare(nandc->clk);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Loongson1 NAND driver registered\n");
>> +	return 0;
>> +}
>> +
>> +static int ls1x_nand_remove(struct platform_device *pdev)
>> +{
>> +	struct mtd_info *mtd = platform_get_drvdata(pdev);
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct ls1x_nand_controller *nandc = nand_get_controller_data(chip);
>> +
>> +	if (nandc->dma_chan)
>> +		dma_release_channel(nandc->dma_chan);
>> +	nand_release(mtd);
>> +	clk_disable_unprepare(nandc->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver ls1x_nand_driver = {
>> +	.probe	= ls1x_nand_probe,
>> +	.remove	= ls1x_nand_remove,
>> +	.driver	= {
>> +		.name	= "ls1x-nand",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +};
>> +
>> +module_platform_driver(ls1x_nand_driver);
>> +
>> +MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
>> +MODULE_DESCRIPTION("Loongson1 NAND Flash driver");
>> +MODULE_LICENSE("GPL");
>
>
