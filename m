Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 01:56:26 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:32944 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491808Ab1GUX4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2011 01:56:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 4F0A57FF;
        Fri, 22 Jul 2011 01:56:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1FdFKk0KShTp; Fri, 22 Jul 2011 01:56:12 +0200 (CEST)
Received: from [192.168.123.134] (e177126024.adsl.alicedsl.de [85.177.126.24])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 533177FE;
        Fri, 22 Jul 2011 01:55:51 +0200 (CEST)
Message-ID: <4E28BC1F.50804@metafoo.de>
Date:   Fri, 22 Jul 2011 01:54:07 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110702 Icedove/3.0.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     alsa-devel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio support
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com> <1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15627

You should always Cc Mark and Liam on ASoC patch. Also the proper commit title
prefix is ASoC.

On 07/21/2011 06:34 PM, Manuel Lauss wrote:
> This patch adds ASoC support for the AC97 and I2S controllers
> on the old Au1000/Au1500/Au1100 chips and a universal machine
> driver for the Db1000/Db1500/Db1100 boards.
> 
> AC97 Tested on a Db1500.  I2S untested since none of the boards
> actually have and I2S codec wired up.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V2: added untested I2S controller driver for completeness, removed the audio
>     defines from the au1000 header as well.
> 
>  arch/mips/alchemy/devboards/db1x00/platform.c |   37 ++
>  arch/mips/include/asm/mach-au1x00/au1000.h    |   61 ----
>  sound/soc/au1x/Kconfig                        |   28 ++
>  sound/soc/au1x/Makefile                       |   10 +
>  sound/soc/au1x/ac97c.c                        |  398 +++++++++++++++++++++
>  sound/soc/au1x/db1000.c                       |   75 ++++
>  sound/soc/au1x/dma.c                          |  470 +++++++++++++++++++++++++
>  sound/soc/au1x/i2sc.c                         |  353 +++++++++++++++++++
>  sound/soc/au1x/psc.h                          |   31 ++-
>  9 files changed, 1393 insertions(+), 70 deletions(-)
>  create mode 100644 sound/soc/au1x/ac97c.c
>  create mode 100644 sound/soc/au1x/db1000.c
>  create mode 100644 sound/soc/au1x/dma.c
>  create mode 100644 sound/soc/au1x/i2sc.c

It might make sense to split this into multiple patches. Especially the
platform part should be put in a seperate patch, since there isn't really any
compile time dependency to the other parts it could go via the MIPS tree.

> diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
> new file mode 100644
> index 0000000..8fc25d0
> --- /dev/null
> +++ b/sound/soc/au1x/ac97c.c
> @@ -0,0 +1,398 @@
> +/*
> + * Au1000/Au1500/Au1100 AC97C controller driver for ASoC
> + *
> + * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
> + *
> + * based on the old ALSA driver by Charles Eidsness.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/suspend.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-au1x00/au1xxx_psc.h>
> +
> +#include "psc.h"
> +
> +/*#define AC_DEBUG*/
> +
> +#define MSG(x...)	printk(KERN_ERR "ac97c: " x)

dev_err or pr_err

> +#ifdef AC_DEBUG
> +#define DBG(x...)	MSG(x)
> +#else
> +#define DBG(x...)	do {} while (0)
> +#endif

dev_dbg or pr_dbg

> [...]
> +
> +/* how often to retry failed codec register reads/writes */
> +#define AC97_RW_RETRIES	5
> +
> +#define AC97_DIR	\
> +	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
Unused

>[...]
> +
> +static int au1xac97c_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +static int au1xac97c_trigger(struct snd_pcm_substream *substream,
> +			     int cmd, struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +

If you don't want to do anything in the callbacks just leave them out.

> +static int au1xac97c_dai_probe(struct snd_soc_dai *dai)
> +{
> +	return ac97c_workdata ? 0 : -ENODEV;
> +}
> +
> +static struct snd_soc_dai_ops au1xac97c_dai_ops = {
const

> +	.trigger	= au1xac97c_trigger,
> +	.hw_params	= au1xac97c_hw_params,
> +};
> +
> [...]
> diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
> new file mode 100644
> index 0000000..9368b5d
> [...]
> +static int __init db1000_audio_load(void)
> +{
> +	int ret, id;
> +
> +	/* impostor check */
> +	id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
> +
> +	ret = -ENOMEM;
> +	db1000_asoc97_dev = platform_device_alloc("soc-audio", 0);

New drivers shouldn't user soc-audio anymore, just register a normal platform
device driver.

> +	if (!db1000_asoc97_dev)
> +		goto out;
> +
> +	platform_set_drvdata(db1000_asoc97_dev, &db1000_ac97_machine);
> +	ret = platform_device_add(db1000_asoc97_dev);
> +
> +	if (ret) {
> +		platform_device_put(db1000_asoc97_dev);
> +		db1000_asoc97_dev = NULL;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static void __exit db1000_audio_unload(void)
> +{
> +	platform_device_unregister(db1000_asoc97_dev);
> +}
> +
> +module_init(db1000_audio_load);
> +module_exit(db1000_audio_unload);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("DB1000/DB1500/DB1100 ASoC audio support");
> +MODULE_AUTHOR("Manuel Lauss");
> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
> new file mode 100644
> index 0000000..0f7d90a
> --- /dev/null
> +++ b/sound/soc/au1x/dma.c
> @@ -0,0 +1,470 @@
> [...]
> +
> +static struct platform_driver alchemy_ac97pcm_driver = {
> +	.driver	= {
> +		.name	= AC97C_DMANAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= alchemy_pcm_drvprobe,
> +	.remove		= __devexit_p(alchemy_pcm_drvremove),
> +};
> +
> +static struct platform_driver alchemy_i2spcm_driver = {
> +	.driver	= {
> +		.name	= I2SC_DMANAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= alchemy_pcm_drvprobe,
> +	.remove		= __devexit_p(alchemy_pcm_drvremove),
> +};

You shouldn't really have to register two identical drivers for this. If you
really want to be able to instantiate the driver with two different names use
platform_device_id. But in my opinion it should be enough to just have one
generic name, since there is nothing AC97 or I2S specific in this driver.

> [...]
> +
> +struct platform_device *alchemy_pcm_add(struct platform_device *pdev, int type)
> +{
+	struct resource *res, *r;
+	struct platform_device *pd;
+	char *pdevname;
+	int id[2];
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r)
+		return NULL;
+	id[0] = r->start;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r)
+		return NULL;
+	id[1] = r->start;
+
+	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	res[0].start = res[0].end = id[0];
+	res[1].start = res[1].end = id[1];
+	res[0].flags = res[1].flags = IORESOURCE_DMA;
+
+	/* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
+	pdevname = (type == 0) ? AC97C_DMANAME : I2SC_DMANAME;
+	pd = platform_device_alloc(pdevname, -1);
+	if (!pd)
+		goto out;
+
+	pd->resource = res;
+	pd->num_resources = 2;
+
+	ret = platform_device_add(pd);
+	if (!ret)
+		return pd;
+
+	platform_device_put(pd);
+out:
+	kfree(res);
+	return NULL;
> +}

This function looks a bit fishy. The pcm driver should be registered by the
platform code file as well. If you need different DMA regions for I2C and AC97
use snd_soc_dai_set_dma_data and snd_soc_dai_get_dma_data to pass them to the
PCM driver from the I2S or AC97 driver.

> [...]
> diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
> new file mode 100644
> index 0000000..1a31d51
> --- /dev/null
> +++ b/sound/soc/au1x/i2sc.c
> @@ -0,0 +1,353 @@
> [...]
> +
> +/* supported I2S DAI hardware formats */
> +#define AU1XI2SC_DAIFMT \
> +	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J |	\
> +	 SND_SOC_DAIFMT_NB_NF)
Unused


> +
> +/* supported I2S direction */
> +#define AU1XI2SC_DIR \
> +	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
Unused

> +
> +#define AU1XI2SC_RATES \
> +	SNDRV_PCM_RATE_8000_192000
> +
> +#define AU1XI2SC_FMTS \
> +	SNDRV_PCM_FMTBIT_S16_LE
> +
> +struct i2sc_ctx {
> +	void __iomem *mmio;
> +	unsigned long cfg, rate;
> +	struct platform_device *dmapd;
> +};
> +
> [...]
> +
> +static int au1xi2s_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct i2sc_ctx *ctx = snd_soc_dai_get_drvdata(dai);
> +	unsigned long stat, v;
> +
> +	v = msbits_to_reg(params->msbits);
> +	/* check if the PSC is already streaming data */

Use .symmetric_rates = 1 in your dai_driver struct for this.

> +	stat = RD(ctx, I2S_CONFIG);
> +	if (stat & (CFG_TN | CFG_RN)) {
> +		/* reject parameters not currently set up in hardware */
> +		if ((ctx->rate != params_rate(params)) ||
> +		    ((stat & CFG_SZ_MASK) != v))
> +			return -EINVAL;
> +	} else {
> +		/* set sample bitdepth */
> +		ctx->cfg &= ~CFG_SZ_MASK;
> +		if (v)
> +			ctx->cfg |= v;
> +		else
> +			return -EINVAL;
> +		/* remember current rate for other stream */
> +		ctx->rate = params_rate(params);
> +	}
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_ops au1xi2s_dai_ops = {
const

> +	.trigger	= au1xi2s_trigger,
> +	.hw_params	= au1xi2s_hw_params,
> +	.set_fmt	= au1xi2s_set_fmt,
> +};
> +
> [...]
