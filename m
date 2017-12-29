Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 13:37:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:47614 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdL2MhOgRwLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 13:37:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 29 Dec 2017 12:37:00 +0000
Received: from [192.168.159.81] (192.168.159.81) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Dec
 2017 04:35:52 -0800
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
To:     Mathieu Malaterre <malat@debian.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <Zubair.Kakakhel@mips.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
References: <20171228212954.2922-1-malat@debian.org>
 <20171228212954.2922-2-malat@debian.org>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <99ac0f77-b4f5-86bd-70be-56e11b248852@mips.com>
Date:   Fri, 29 Dec 2017 13:35:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171228212954.2922-2-malat@debian.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.81]
X-BESS-ID: 1514551020-321457-10892-52010-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188465
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Hi Mathieu,

On 28.12.2017 22:29, Mathieu Malaterre wrote:

> --- /dev/null
> +++ b/drivers/nvmem/jz4780-efuse.c
> @@ -0,0 +1,305 @@
> +/*
> + * JZ4780 EFUSE Memory Support driver
> + *
> + * Copyright (c) 2017 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + */
> +

Can you use SPDX identifier instead?

> +/*
> + * Currently supports JZ4780 efuse which has 8K programmable bit.
> + * Efuse is separated into seven segments as below:
> + *
> + * -----------------------------------------------------------------------
> + * | 64 bit | 128 bit | 128 bit | 3520 bit | 8 bit | 2296 bit | 2048 bit |
> + * -----------------------------------------------------------------------
> + *
> + * The rom itself is accessed using a 9 bit address line and an 8 word wide bus
> + * which reads/writes based on strobes. The strobe is configured in the config
> + * register and is based on number of cycles of the bus clock.
> + *
> + * Driver supports read only as the writes are done in the Factory.
> + */
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +
> +#define JZ_EFUCTRL			(0x0)	/* Control Register */
> +#define JZ_EFUCFG			(0x4)	/* Configure Register*/
> +#define JZ_EFUSTATE			(0x8)	/* Status Register */
> +#define JZ_EFUDATA(n)			(0xC + (n)*4)
> +
> +#define JZ_EFUSE_START_ADDR		0x200
> +#define JZ_EFUSE_SEG1_OFF		0x00	/* 64 bit Random Number */
> +#define JZ_EFUSE_SEG2_OFF		0x08	/* 128 bit Ingenic Chip ID */
> +#define JZ_EFUSE_SEG3_OFF		0x18	/* 128 bit Customer ID */
> +#define JZ_EFUSE_SEG4_OFF		0x28	/* 3520 bit Reserved */
> +#define JZ_EFUSE_SEG5_OFF		0x1E0	/* 8 bit Protect Segment */
> +#define JZ_EFUSE_SEG6_OFF		0x1E1	/* 2296 bit HDMI Key */
> +#define JZ_EFUSE_SEG7_OFF		0x300	/* 2048 bit Security boot key */
> +#define JZ_EFUSE_END_ADDR		0x5FF
> +
> +#define JZ_EFUSE_EFUCTRL_CS		BIT(30)
> +#define JZ_EFUSE_EFUCTRL_ADDR_MASK	0x1FF
> +#define JZ_EFUSE_EFUCTRL_ADDR_SHIFT	21
> +#define JZ_EFUSE_EFUCTRL_LEN_MASK	0x1F
> +#define JZ_EFUSE_EFUCTRL_LEN_SHIFT	16
> +#define JZ_EFUSE_EFUCTRL_PG_EN		BIT(15)
> +#define JZ_EFUSE_EFUCTRL_WR_EN		BIT(1)
> +#define JZ_EFUSE_EFUCTRL_RD_EN		BIT(0)
> +
> +#define JZ_EFUSE_EFUCFG_INT_EN		BIT(31)
> +#define JZ_EFUSE_EFUCFG_RD_ADJ_MASK	0xF
> +#define JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT	20
> +#define JZ_EFUSE_EFUCFG_RD_STR_MASK	0xF
> +#define JZ_EFUSE_EFUCFG_RD_STR_SHIFT	16
> +#define JZ_EFUSE_EFUCFG_WR_ADJ_MASK	0xF
> +#define JZ_EFUSE_EFUCFG_WR_ADJ_SHIFT	12
> +#define JZ_EFUSE_EFUCFG_WR_STR_MASK	0xFFF
> +#define JZ_EFUSE_EFUCFG_WR_STR_SHIFT	0
> +
> +#define JZ_EFUSE_EFUSTATE_WR_DONE	BIT(1)
> +#define JZ_EFUSE_EFUSTATE_RD_DONE	BIT(0)
> +
> +#define JZ_EFUSE_WORD_SIZE		16
> +#define JZ_EFUSE_STRIDE			8
> +
> +struct jz4780_efuse {
> +	struct device *dev;
> +	void __iomem *iomem;
> +	struct clk *clk;
> +	unsigned int rd_adj;
> +	unsigned int rd_strobe;
> +};
> +
> +/* We read 32 byte chunks to avoid complexity in the driver. */
> +static int jz4780_efuse_read_32bytes(struct jz4780_efuse *efuse, char *buf,
> +		unsigned int addr)
> +{
> +	unsigned int tmp = 0;
> +	int i = 0;
> +	int timeout = 1000;
> +	int size = 32;
> +
> +	/* 1. Set config register */
> +	tmp = readl(efuse->iomem + JZ_EFUCFG);
> +	tmp &= ~((JZ_EFUSE_EFUCFG_RD_ADJ_MASK << JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT)
> +	| (JZ_EFUSE_EFUCFG_RD_STR_MASK << JZ_EFUSE_EFUCFG_RD_STR_SHIFT));
> +	tmp |= (efuse->rd_adj << JZ_EFUSE_EFUCFG_RD_ADJ_SHIFT)
> +	| (efuse->rd_strobe << JZ_EFUSE_EFUCFG_RD_STR_SHIFT);
> +	writel(tmp, efuse->iomem + JZ_EFUCFG);
> +
> +	/*
> +	 * 2. Set control register to indicate what to read data address,
> +	 * read data numbers and read enable.
> +	 */
> +	tmp = readl(efuse->iomem + JZ_EFUCTRL);
> +	tmp &= ~(JZ_EFUSE_EFUCFG_RD_STR_SHIFT
> +		| (JZ_EFUSE_EFUCTRL_ADDR_MASK << JZ_EFUSE_EFUCTRL_ADDR_SHIFT)
> +		| JZ_EFUSE_EFUCTRL_PG_EN | JZ_EFUSE_EFUCTRL_WR_EN
> +		| JZ_EFUSE_EFUCTRL_WR_EN);
> +
> +	/* Need to select CS bit if address accesses upper 4Kbits memory */
> +	if (addr >= (JZ_EFUSE_START_ADDR + 512))
> +		tmp |= JZ_EFUSE_EFUCTRL_CS;
> +
> +	tmp |= (addr << JZ_EFUSE_EFUCTRL_ADDR_SHIFT)
> +		| ((size - 1) << JZ_EFUSE_EFUCTRL_LEN_SHIFT)
> +		| JZ_EFUSE_EFUCTRL_RD_EN;
> +	writel(tmp, efuse->iomem + JZ_EFUCTRL);
> +
> +	/*
> +	 * 3. Wait status register RD_DONE set to 1 or EFUSE interrupted,
> +	 * software can read EFUSE data buffer 0 - 8 registers.
> +	 */
> +	do {
> +		tmp = readl(efuse->iomem + JZ_EFUSTATE);
> +		usleep_range(1000, 2000);
> +		if (timeout--)
> +			break;
> +	} while (!(tmp & JZ_EFUSE_EFUSTATE_RD_DONE));
> +
> +	if (timeout <= 0) {
> +		dev_err(efuse->dev, "Timed out while reading\n");
> +		return -EAGAIN;
> +	}
> +
> +	for (i = 0; i < (size / 4); i++)
> +		*((unsigned int *)(buf + i * 4))
> +			 = readl(efuse->iomem + JZ_EFUDATA(i));
> +
> +	return 0;
> +}
> +
> +static unsigned int segments[][2] = {

const?

> +		/* offset	, size in bytes */
> +		{ JZ_EFUSE_SEG1_OFF,   64 >> 3 }, /* bit Random Number */
> +		{ JZ_EFUSE_SEG2_OFF,  128 >> 3 }, /* bit Ingenic Chip ID */
> +		{ JZ_EFUSE_SEG3_OFF,  128 >> 3 }, /* bit Customer ID */
> +		{ JZ_EFUSE_SEG4_OFF, 3520 >> 3 }, /* bit Reserved */
> +		{ JZ_EFUSE_SEG5_OFF,    8 >> 3 }, /* bit Protect Segment */
> +		{ JZ_EFUSE_SEG6_OFF, 2296 >> 3 }, /* bit HDMI Key */
> +		{ JZ_EFUSE_SEG7_OFF, 2048 >> 3 }  /* bit Security boot key */
> +};
> +
> +#define MAX(x, y) (((x) > (y)) ? (x) : (y))
> +#define MIN(x, y) (((x) < (y)) ? (x) : (y))
> +
> +/* PM recommends read/write each segment separately */
> +static int jz4780_efuse_read_segment(struct jz4780_efuse *efuse, int segid,
> +	unsigned int *offset, char *out, size_t *bytes)
> +{
> +	char buf[32];
> +	unsigned int lpos, buflen, ncount, remain;
> +	unsigned int *segment = segments[segid];
> +	int j;
> +	char *cur = out;
> +	int ret;
> +
> +	if (*bytes == 0 ||
> +		(*offset < segment[0] || *offset >= segment[0] + segment[1])) {
> +		// nothing to see, move along
> +		return 0;
> +	}
> +	lpos = MAX(segment[0], *offset);
> +	buflen = MIN(segment[1], *bytes);

if *offset > segment[0] then you may read past the current segment.
On the other hand some segments are smaller than 32 bytes, so when 
jz4780_efuse_read_32bytes() is used, there will often be accesses across 
segment boundaries.
For this reason I don't see much point in having this split for segment 
reads. If it is really recommended/required (I haven't read the SoC's 
PM) then the read_32bytes() method needs to be changed to allow reads of 
any length (which would allow simplifying this method a lot).
Alternatively if there isn't really such requirement, you could just 
read the whole memory without worrying about segment boundaries.

> +	ncount = buflen / 32;
> +	remain = buflen % 32;
> +
> +	for (j = 0; j < ncount ; ++j) {
> +		ret = jz4780_efuse_read_32bytes(efuse, buf, lpos);
> +		if (ret < 0)
> +			return ret;
> +
> +		memcpy(cur, buf, sizeof(buf));
> +		cur += sizeof(buf);
> +		lpos += sizeof(buf);
> +		}
> +	if (remain) {
> +		ret = jz4780_efuse_read_32bytes(efuse, buf, lpos);
> +		if (ret < 0)
> +			return ret;
> +
> +		memcpy(cur, buf, remain);
> +		cur += remain;
> +		}
> +	*offset += buflen;
> +	*bytes -= buflen;
> +	return buflen;
> +}
> +
> +/* main entry point */
> +static int jz4780_efuse_read(void *context, unsigned int offset,
> +					void *val, size_t bytes)
> +{
> +	static const int nsegments = sizeof(segments) / sizeof(*segments);

any particular reason nsegments is static?

> +	struct jz4780_efuse *efuse = context;
> +	char *cur = val;
> +	int i, ret;
> +
> +	for (i = 0; i < nsegments; ++i) {
> +		ret = jz4780_efuse_read_segment(efuse, i, &offset, cur, &bytes);
> +		if (ret < 0)
> +			return ret;
> +		cur += ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config jz4780_efuse_nvmem_config = {
> +	.name = "jz4780-efuse",
> +	.read_only = true,
> +	.word_size = JZ_EFUSE_WORD_SIZE,
> +	.stride = JZ_EFUSE_STRIDE,
> +	.owner = THIS_MODULE,
> +	.reg_read = jz4780_efuse_read,
> +};
> +
> +static int jz4780_efuse_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem;
> +	struct jz4780_efuse *efuse;
> +	struct resource *res;
> +	unsigned long clk_rate;
> +	struct device *dev = &pdev->dev;
> +
> +	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
> +	if (!efuse)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	efuse->iomem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(efuse->iomem))
> +		return PTR_ERR(efuse->iomem);
> +
> +	efuse->clk = devm_clk_get(&pdev->dev, "bus_clk");
> +	if (IS_ERR(efuse->clk))
> +		return PTR_ERR(efuse->clk);
> +
> +	clk_rate = clk_get_rate(efuse->clk);
> +	/*
> +	 * rd_adj and rd_strobe are 4 bit values
> +	 * bus clk period * (rd_adj + 1) > 6.5ns
> +	 * bus clk period * (rd_adj + 5 + rd_strobe) > 35ns
> +	 */
> +	efuse->rd_adj = (((6500 * (clk_rate / 1000000)) / 1000000) + 1) - 1;
> +	efuse->rd_strobe = ((((35000 * (clk_rate / 1000000)) / 1000000) + 1)
> +						- 5 - efuse->rd_adj);
> +
> +	if ((efuse->rd_adj > 0x1F) || (efuse->rd_strobe > 0x1F)) {
> +		dev_err(&pdev->dev, "Cannot set clock configuration\n");
> +		return -EINVAL;
> +	}
> +	efuse->dev = dev;
> +
> +	jz4780_efuse_nvmem_config.size = 1024;
> +	jz4780_efuse_nvmem_config.dev = &pdev->dev;
> +	jz4780_efuse_nvmem_config.priv = efuse;
> +
> +	nvmem = nvmem_register(&jz4780_efuse_nvmem_config);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
> +	platform_set_drvdata(pdev, nvmem);
> +
> +	return 0;
> +}
> +
> +static int jz4780_efuse_remove(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> +
> +	return nvmem_unregister(nvmem);
> +}
> +
> +static const struct of_device_id jz4780_efuse_match[] = {
> +	{ .compatible = "ingenic,jz4780-efuse" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_efuse_match);
> +
> +static struct platform_driver jz4780_efuse_driver = {
> +	.probe  = jz4780_efuse_probe,
> +	.remove = jz4780_efuse_remove,
> +	.driver = {
> +		.name = "jz4780-efuse",
> +		.of_match_table = jz4780_efuse_match,
> +	},
> +};
> +module_platform_driver(jz4780_efuse_driver);
> +
> +MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
> +MODULE_DESCRIPTION("Ingenic JZ4780 efuse driver");
> +MODULE_LICENSE("GPL v2");
> 
