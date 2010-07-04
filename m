Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 00:35:40 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57707 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab0GDWfd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 00:35:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 536E8962;
        Mon,  5 Jul 2010 00:35:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wgRnnzdFf7n6; Mon,  5 Jul 2010 00:35:26 +0200 (CEST)
Received: from [192.168.37.31] (port-92973.pppoe.wtnet.de [84.46.75.169])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 34144961;
        Mon,  5 Jul 2010 00:35:20 +0200 (CEST)
Message-ID: <4C310C95.1090902@metafoo.de>
Date:   Mon, 05 Jul 2010 00:35:01 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     "driver linux-mtd"@lists.infradead.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 17/26] MTD: Nand: Add JZ4740 NAND 
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <1276924111-11158-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1276924111-11158-18-git-send-email-lars@metafoo.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Hi

Any comments?

Thanks
- Lars

Lars-Peter Clausen wrote:
> This patch adds support for the NAND controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> 
> ---
> Changes since v1
> - JZ4740: Remove debug macro
> - Fix platform driver remove callback
> - Add custom nand read/write callback since we need to support more then 64 ecc
>   bytes
> ---
>  drivers/mtd/nand/Kconfig        |    6 +
>  drivers/mtd/nand/Makefile       |    1 +
>  drivers/mtd/nand/jz4740_nand.c  |  474 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/jz4740_nand.h |   34 +++
>  4 files changed, 515 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/jz4740_nand.c
>  create mode 100644 include/linux/mtd/jz4740_nand.h
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index ffc3720..362d177 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -526,4 +526,10 @@ config MTD_NAND_NUC900
>  	  This enables the driver for the NAND Flash on evaluation board based
>  	  on w90p910 / NUC9xx.
>  
> +config MTD_NAND_JZ4740
> +	tristate "Support for JZ4740 SoC NAND controller"
> +	depends on MACH_JZ4740
> +	help
> +		Enables support for NAND Flash on JZ4740 SoC based boards.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index e8ab884..ac83dcd 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -46,5 +46,6 @@ obj-$(CONFIG_MTD_NAND_NOMADIK)		+= nomadik_nand.o
>  obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
>  obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
>  obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
> +obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o
> diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
> new file mode 100644
> index 0000000..8c55f8a
> --- /dev/null
> +++ b/drivers/mtd/nand/jz4740_nand.c
> @@ -0,0 +1,474 @@
> +/*
> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *  JZ4740 SoC NAND controller driver
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <linux/mtd/jz4740_nand.h>
> +#include <linux/gpio.h>
> +
> +#define JZ_REG_NAND_CTRL	0x50
> +#define JZ_REG_NAND_ECC_CTRL	0x100
> +#define JZ_REG_NAND_DATA	0x104
> +#define JZ_REG_NAND_PAR0	0x108
> +#define JZ_REG_NAND_PAR1	0x10C
> +#define JZ_REG_NAND_PAR2	0x110
> +#define JZ_REG_NAND_IRQ_STAT	0x114
> +#define JZ_REG_NAND_IRQ_CTRL	0x118
> +#define JZ_REG_NAND_ERR(x)	(0x11C + (x << 2))
> +
> +#define JZ_NAND_ECC_CTRL_PAR_READY	BIT(4)
> +#define JZ_NAND_ECC_CTRL_ENCODING	BIT(3)
> +#define JZ_NAND_ECC_CTRL_RS		BIT(2)
> +#define JZ_NAND_ECC_CTRL_RESET		BIT(1)
> +#define JZ_NAND_ECC_CTRL_ENABLE		BIT(0)
> +
> +#define JZ_NAND_STATUS_ERR_COUNT	(BIT(31) | BIT(30) | BIT(29))
> +#define JZ_NAND_STATUS_PAD_FINISH	BIT(4)
> +#define JZ_NAND_STATUS_DEC_FINISH	BIT(3)
> +#define JZ_NAND_STATUS_ENC_FINISH	BIT(2)
> +#define JZ_NAND_STATUS_UNCOR_ERROR	BIT(1)
> +#define JZ_NAND_STATUS_ERROR		BIT(0)
> +
> +#define JZ_NAND_CTRL_ENABLE_CHIP(x) BIT(x << 1)
> +#define JZ_NAND_CTRL_ASSERT_CHIP(x) BIT((x << 1) + 1)
> +
> +#define JZ_NAND_DATA_ADDR ((void __iomem *)0xB8000000)
> +#define JZ_NAND_CMD_ADDR (JZ_NAND_DATA_ADDR + 0x8000)
> +#define JZ_NAND_ADDR_ADDR (JZ_NAND_DATA_ADDR + 0x10000)
> +
> +struct jz_nand {
> +	struct mtd_info mtd;
> +	struct nand_chip chip;
> +	void __iomem *base;
> +	struct resource *mem;
> +
> +	struct jz_nand_platform_data *pdata;
> +	bool is_reading;
> +};
> +
> +static inline struct jz_nand *mtd_to_jz_nand(struct mtd_info *mtd)
> +{
> +	return container_of(mtd, struct jz_nand, mtd);
> +}
> +
> +static void jz_nand_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
> +{
> +	struct jz_nand *nand = mtd_to_jz_nand(mtd);
> +	struct nand_chip *chip = mtd->priv;
> +	uint32_t reg;
> +
> +	if (ctrl & NAND_CTRL_CHANGE) {
> +		BUG_ON((ctrl & NAND_ALE) && (ctrl & NAND_CLE));
> +		if (ctrl & NAND_ALE)
> +			chip->IO_ADDR_W = JZ_NAND_ADDR_ADDR;
> +		else if (ctrl & NAND_CLE)
> +			chip->IO_ADDR_W = JZ_NAND_CMD_ADDR;
> +		else
> +			chip->IO_ADDR_W = JZ_NAND_DATA_ADDR;
> +
> +		reg = readl(nand->base + JZ_REG_NAND_CTRL);
> +		if (ctrl & NAND_NCE)
> +			reg |= JZ_NAND_CTRL_ASSERT_CHIP(0);
> +		else
> +			reg &= ~JZ_NAND_CTRL_ASSERT_CHIP(0);
> +		writel(reg, nand->base + JZ_REG_NAND_CTRL);
> +	}
> +	if (dat != NAND_CMD_NONE)
> +		writeb(dat, chip->IO_ADDR_W);
> +}
> +
> +static int jz_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct jz_nand *nand = mtd_to_jz_nand(mtd);
> +	return gpio_get_value_cansleep(nand->pdata->busy_gpio);
> +}
> +
> +static void jz_nand_hwctl(struct mtd_info *mtd, int mode)
> +{
> +	struct jz_nand *nand = mtd_to_jz_nand(mtd);
> +	uint32_t reg;
> +
> +	writel(0, nand->base + JZ_REG_NAND_IRQ_STAT);
> +	reg = readl(nand->base + JZ_REG_NAND_ECC_CTRL);
> +
> +	reg |= JZ_NAND_ECC_CTRL_RESET;
> +	reg |= JZ_NAND_ECC_CTRL_ENABLE;
> +	reg |= JZ_NAND_ECC_CTRL_RS;
> +
> +	switch (mode) {
> +	case NAND_ECC_READ:
> +		reg &= ~JZ_NAND_ECC_CTRL_ENCODING;
> +		nand->is_reading = true;
> +		break;
> +	case NAND_ECC_WRITE:
> +		reg |= JZ_NAND_ECC_CTRL_ENCODING;
> +		nand->is_reading = false;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	writel(reg, nand->base + JZ_REG_NAND_ECC_CTRL);
> +}
> +
> +static int jz_nand_calculate_ecc_rs(struct mtd_info *mtd, const uint8_t *dat,
> +	uint8_t *ecc_code)
> +{
> +	struct jz_nand *nand = mtd_to_jz_nand(mtd);
> +	uint32_t reg, status;
> +	int i;
> +	static uint8_t empty_block_ecc[] = {0xcd, 0x9d, 0x90, 0x58, 0xf4,
> +						0x8b, 0xff, 0xb7, 0x6f};
> +
> +	if (nand->is_reading)
> +		return 0;
> +
> +	do {
> +		status = readl(nand->base + JZ_REG_NAND_IRQ_STAT);
> +	} while (!(status & JZ_NAND_STATUS_ENC_FINISH));
> +
> +	reg = readl(nand->base + JZ_REG_NAND_ECC_CTRL);
> +	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
> +	writel(reg, nand->base + JZ_REG_NAND_ECC_CTRL);
> +
> +	for (i = 0; i < 9; ++i)
> +		ecc_code[i] = readb(nand->base + JZ_REG_NAND_PAR0 + i);
> +
> +	/* If the written data is completly 0xff, we also want to write 0xff as
> +	 * ecc, otherwise we will get in trouble when doing subpage writes. */
> +	if (memcmp(ecc_code, empty_block_ecc, 9) == 0)
> +		memset(ecc_code, 0xff, 9);
> +
> +	return 0;
> +}
> +
> +static void correct_data(uint8_t *dat, int index, int mask)
> +{
> +	int offset = index & 0x7;
> +	uint16_t data;
> +
> +	index += (index >> 3);
> +
> +	data = dat[index];
> +	data |= dat[index+1] << 8;
> +
> +	mask ^= (data >> offset) & 0x1ff;
> +	data &= ~(0x1ff << offset);
> +	data |= (mask << offset);
> +
> +	dat[index] = data & 0xff;
> +	dat[index+1] = (data >> 8) & 0xff;
> +}
> +
> +static int jz_nand_correct_ecc_rs(struct mtd_info *mtd, uint8_t *dat,
> +	uint8_t *read_ecc, uint8_t *calc_ecc)
> +{
> +	struct jz_nand *nand = mtd_to_jz_nand(mtd);
> +	int i, error_count, index;
> +	uint32_t reg, status, error;
> +	uint32_t t;
> +
> +	t = read_ecc[0];
> +
> +	if (t == 0xff) {
> +		for (i = 1; i < 9; ++i)
> +			t &= read_ecc[i];
> +
> +		t &= dat[0];
> +		t &= dat[nand->chip.ecc.size / 2];
> +		t &= dat[nand->chip.ecc.size - 1];
> +
> +		if (t == 0xff) {
> +			for (i = 1; i < nand->chip.ecc.size - 1; ++i)
> +				t &= dat[i];
> +			if (t == 0xff)
> +				return 0;
> +		}
> +	}
> +
> +	for (i = 0; i < 9; ++i)
> +		writeb(read_ecc[i], nand->base + JZ_REG_NAND_PAR0 + i);
> +
> +	reg = readl(nand->base + JZ_REG_NAND_ECC_CTRL);
> +	reg |= JZ_NAND_ECC_CTRL_PAR_READY;
> +	writel(reg, nand->base + JZ_REG_NAND_ECC_CTRL);
> +
> +	do {
> +		status = readl(nand->base + JZ_REG_NAND_IRQ_STAT);
> +	} while (!(status & JZ_NAND_STATUS_DEC_FINISH));
> +
> +	reg = readl(nand->base + JZ_REG_NAND_ECC_CTRL);
> +	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
> +	writel(reg, nand->base + JZ_REG_NAND_ECC_CTRL);
> +
> +	if (status & JZ_NAND_STATUS_ERROR) {
> +		if (status & JZ_NAND_STATUS_UNCOR_ERROR)
> +			return -1;
> +
> +		error_count = (status & JZ_NAND_STATUS_ERR_COUNT) >> 29;
> +
> +		for (i = 0; i < error_count; ++i) {
> +			error = readl(nand->base + JZ_REG_NAND_ERR(i));
> +			index = ((error >> 16) & 0x1ff) - 1;
> +			if (index >= 0 && index < 512)
> +				correct_data(dat, index, error & 0x1ff);
> +		}
> +
> +		return error_count;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/* Copy paste of nand_read_page_hwecc_oob_first except for different eccpos
> + * handling. The ecc area is for 4k chips 72 bytes long and thus does not fit
> + * into the eccpos array. */
> +static int jz_nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
> +	struct nand_chip *chip, uint8_t *buf, int page)
> +{
> +	int i, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	uint8_t *p = buf;
> +	unsigned int ecc_offset = chip->page_shift;
> +
> +	/* Read the OOB area first */
> +	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
> +	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
> +	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
> +
> +	for (i = ecc_offset; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
> +		int stat;
> +
> +		chip->ecc.hwctl(mtd, NAND_ECC_READ);
> +		chip->read_buf(mtd, p, eccsize);
> +
> +		stat = chip->ecc.correct(mtd, p, &chip->oob_poi[i], NULL);
> +		if (stat < 0)
> +			mtd->ecc_stats.failed++;
> +		else
> +			mtd->ecc_stats.corrected += stat;
> +	}
> +	return 0;
> +}
> +
> +/* Copy-and-paste of nand_write_page_hwecc with different eccpos handling. */
> +static void jz_nand_write_page_hwecc(struct mtd_info *mtd,
> +	struct nand_chip *chip, const uint8_t *buf)
> +{
> +	int i, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	const uint8_t *p = buf;
> +	unsigned int ecc_offset = chip->page_shift;
> +
> +	for (i = ecc_offset; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
> +		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
> +		chip->write_buf(mtd, p, eccsize);
> +		chip->ecc.calculate(mtd, p, &chip->oob_poi[i]);
> +	}
> +
> +	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +}
> +
> +#ifdef CONFIG_MTD_CMDLINE_PARTS
> +static const char *part_probes[] = {"cmdline", NULL};
> +#endif
> +
> +static int __devinit jz_nand_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct jz_nand *nand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	struct jz_nand_platform_data *pdata = pdev->dev.platform_data;
> +#ifdef CONFIG_MTD_PARTITIONS
> +	struct mtd_partition *partition_info;
> +	int num_partitions = 0;
> +#endif
> +
> +	nand = kzalloc(sizeof(*nand), GFP_KERNEL);
> +	if (!nand) {
> +		dev_err(&pdev->dev, "Failed to allocate device structure.\n");
> +		return -ENOMEM;
> +	}
> +
> +	nand->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!nand->mem) {
> +		dev_err(&pdev->dev, "Failed to get platform mmio memory\n");
> +		ret = -ENOENT;
> +		goto err_free;
> +	}
> +
> +	nand->mem = request_mem_region(nand->mem->start,
> +					resource_size(nand->mem), pdev->name);
> +	if (!nand->mem) {
> +		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
> +		ret = -EBUSY;
> +		goto err_free;
> +	}
> +
> +	nand->base = ioremap(nand->mem->start, resource_size(nand->mem));
> +	if (!nand->base) {
> +		dev_err(&pdev->dev, "Failed to ioremap mmio memory region\n");
> +		ret = -EBUSY;
> +		goto err_release_mem;
> +	}
> +
> +	if (pdata && gpio_is_valid(pdata->busy_gpio)) {
> +		ret = gpio_request(pdata->busy_gpio, "NAND busy pin");
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to request busy gpio %d: %d\n",
> +				pdata->busy_gpio, ret);
> +			goto err_iounmap;
> +		}
> +	}
> +
> +	mtd		= &nand->mtd;
> +	chip		= &nand->chip;
> +	mtd->priv	= chip;
> +	mtd->owner	= THIS_MODULE;
> +	mtd->name	= "jz4740-nand";
> +
> +	chip->ecc.hwctl		= jz_nand_hwctl;
> +	chip->ecc.calculate	= jz_nand_calculate_ecc_rs;
> +	chip->ecc.correct	= jz_nand_correct_ecc_rs;
> +	chip->ecc.mode		= NAND_ECC_HW_OOB_FIRST;
> +	chip->ecc.size		= 512;
> +	chip->ecc.bytes		= 9;
> +
> +	chip->ecc.read_page	= jz_nand_read_page_hwecc_oob_first;
> +	chip->ecc.write_page	= jz_nand_write_page_hwecc;
> +
> +	if (pdata)
> +		chip->ecc.layout = pdata->ecc_layout;
> +
> +	chip->chip_delay = 50;
> +	chip->cmd_ctrl = jz_nand_cmd_ctrl;
> +
> +	if (pdata && gpio_is_valid(pdata->busy_gpio))
> +		chip->dev_ready = jz_nand_dev_ready;
> +
> +	chip->IO_ADDR_R = JZ_NAND_DATA_ADDR;
> +	chip->IO_ADDR_W = JZ_NAND_DATA_ADDR;
> +
> +	nand->pdata = pdata;
> +	platform_set_drvdata(pdev, nand);
> +
> +	ret = nand_scan_ident(mtd, 1, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev,  "Failed to scan nand\n");
> +		goto err_gpio_free;
> +	}
> +
> +	if (pdata && pdata->ident_callback) {
> +		pdata->ident_callback(pdev, chip, &pdata->partitions,
> +					&pdata->num_partitions);
> +	}
> +
> +	ret = nand_scan_tail(mtd);
> +	if (ret) {
> +		dev_err(&pdev->dev,  "Failed to scan nand\n");
> +		goto err_gpio_free;
> +	}
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +#ifdef CONFIG_MTD_CMDLINE_PARTS
> +	num_partitions = parse_mtd_partitions(mtd, part_probes,
> +						&partition_info, 0);
> +#endif
> +	if (num_partitions <= 0 && pdata) {
> +		num_partitions = pdata->num_partitions;
> +		partition_info = pdata->partitions;
> +	}
> +
> +	if (num_partitions > 0)
> +		ret = add_mtd_partitions(mtd, partition_info, num_partitions);
> +	else
> +#endif
> +	ret = add_mtd_device(mtd);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add mtd device\n");
> +		goto err_nand_release;
> +	}
> +
> +	dev_info(&pdev->dev, "Successfully registered JZ4740 NAND driver\n");
> +
> +	return 0;
> +err_nand_release:
> +	nand_release(&nand->mtd);
> +err_gpio_free:
> +	platform_set_drvdata(pdev, NULL);
> +	gpio_free(pdata->busy_gpio);
> +err_iounmap:
> +	iounmap(nand->base);
> +err_release_mem:
> +	release_mem_region(nand->mem->start, resource_size(nand->mem));
> +err_free:
> +	kfree(nand);
> +	return ret;
> +}
> +
> +static int __devexit jz_nand_remove(struct platform_device *pdev)
> +{
> +	struct jz_nand *nand = platform_get_drvdata(pdev);
> +
> +	nand_release(&nand->mtd);
> +
> +	iounmap(nand->base);
> +	release_mem_region(nand->mem->start, resource_size(nand->mem));
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(nand);
> +
> +	return 0;
> +}
> +
> +struct platform_driver jz_nand_driver = {
> +	.probe = jz_nand_probe,
> +	.remove = __devexit_p(jz_nand_remove),
> +	.driver = {
> +		.name = "jz4740-nand",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init jz_nand_init(void)
> +{
> +	return platform_driver_register(&jz_nand_driver);
> +}
> +module_init(jz_nand_init);
> +
> +static void __exit jz_nand_exit(void)
> +{
> +	platform_driver_unregister(&jz_nand_driver);
> +}
> +module_exit(jz_nand_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("NAND controller driver for JZ4740 SoC");
> +MODULE_ALIAS("platform:jz4740-nand");
> diff --git a/include/linux/mtd/jz4740_nand.h b/include/linux/mtd/jz4740_nand.h
> new file mode 100644
> index 0000000..379f9b6
> --- /dev/null
> +++ b/include/linux/mtd/jz4740_nand.h
> @@ -0,0 +1,34 @@
> +/*
> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *  JZ4740 SoC NAND controller driver
> + *
> + *  This program is free software; you can redistribute	 it and/or modify it
> + *  under  the terms of	 the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the	License, or (at your
> + *  option) any later version.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __JZ_NAND_H__
> +#define __JZ_NAND_H__
> +
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +
> +struct jz_nand_platform_data {
> +	int			num_partitions;
> +	struct mtd_partition	*partitions;
> +
> +	struct nand_ecclayout	*ecc_layout;
> +
> +	unsigned int busy_gpio;
> +
> +	void (*ident_callback)(struct platform_device *, struct nand_chip *,
> +				struct mtd_partition **, int *num_partitions);
> +};
> +
> +#endif
