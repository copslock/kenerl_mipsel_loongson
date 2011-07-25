Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 11:41:15 +0200 (CEST)
Received: from bear.ext.ti.com ([192.94.94.41]:54102 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490992Ab1GYJlK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2011 11:41:10 +0200
Received: from dlep36.itg.ti.com ([157.170.170.91])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6P9f8jd007370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 25 Jul 2011 04:41:08 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
        by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9f85i025834;
        Mon, 25 Jul 2011 04:41:08 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
        by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9f8Kt021035;
        Mon, 25 Jul 2011 04:41:08 -0500 (CDT)
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dlee74.ent.ti.com
 (157.170.170.8) with Microsoft SMTP Server id 8.3.106.1; Mon, 25 Jul 2011
 04:41:08 -0500
Received: from [172.24.64.9] (h64-9.vpn.ti.com [172.24.64.9])   by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9f7gs016491;      Mon, 25 Jul
 2011 04:41:07 -0500
Message-ID: <4E2D3A32.2060706@ti.com>
Date:   Mon, 25 Jul 2011 10:41:06 +0100
From:   Liam Girdwood <lrg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] ASoC: au1x: remove automatic DMA device registration
 from PSC drivers
References: <1311513088-18802-1-git-send-email-manuel.lauss@googlemail.com> <1311513088-18802-2-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311513088-18802-2-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-archive-position: 30710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17501

On 24/07/11 14:11, Manuel Lauss wrote:
> The PSC audio drivers (psc-ac97/psc-i2s) register the DMA platform_device
> on their own.  This is frowned upon, from now on board code must
> register a simple pcm dma platform device for each PSC with sound duties.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
>  arch/mips/alchemy/devboards/db1200/platform.c |    6 ++
>  sound/soc/au1x/dbdma2.c                       |   83 ++++---------------------
>  sound/soc/au1x/psc-ac97.c                     |   34 +++++++---
>  sound/soc/au1x/psc-i2s.c                      |   32 +++++++---
>  sound/soc/au1x/psc.h                          |    5 --
>  5 files changed, 64 insertions(+), 96 deletions(-)
> 
> diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
> index fbb5593..cfb71ae 100644
> --- a/arch/mips/alchemy/devboards/db1200/platform.c
> +++ b/arch/mips/alchemy/devboards/db1200/platform.c
> @@ -434,12 +434,18 @@ static struct platform_device db1200_stac_dev = {
>  	.id		= 1,	/* on PSC1 */
>  };
>  
> +static struct platform_device db1200_audiodma_dev = {
> +	.name		= "au1xpsc-pcm",
> +	.id		= 1,	/* PSC ID */
> +};
> +
>  static struct platform_device *db1200_devs[] __initdata = {
>  	NULL,		/* PSC0, selected by S6.8 */
>  	&db1200_ide_dev,
>  	&db1200_eth_dev,
>  	&db1200_rtc_dev,
>  	&db1200_nand_dev,
> +	&db1200_audiodma_dev,
>  	&db1200_audio_dev,
>  	&db1200_stac_dev,
>  };
> diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
> index 10fdd28..cc53607 100644
> --- a/sound/soc/au1x/dbdma2.c
> +++ b/sound/soc/au1x/dbdma2.c
> @@ -293,6 +293,16 @@ au1xpsc_pcm_pointer(struct snd_pcm_substream *substream)
>  
>  static int au1xpsc_pcm_open(struct snd_pcm_substream *substream)
>  {
> +	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	int stype = SUBSTREAM_TYPE(substream), *dmaids;
> +
> +	dmaids = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +	if (!dmaids)
> +		return -ENODEV;	/* whoa, has ordering changed? */
> +
> +	pcd->ddma_id = dmaids[stype];
> +
>  	snd_soc_set_runtime_hwparams(substream, &au1xpsc_pcm_hardware);
>  	return 0;
>  }
> @@ -339,36 +349,18 @@ struct snd_soc_platform_driver au1xpsc_soc_platform = {
>  static int __devinit au1xpsc_pcm_drvprobe(struct platform_device *pdev)
>  {
>  	struct au1xpsc_audio_dmadata *dmadata;
> -	struct resource *r;
>  	int ret;
>  
>  	dmadata = kzalloc(2 * sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
>  	if (!dmadata)
>  		return -ENOMEM;
>  
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!r) {
> -		ret = -ENODEV;
> -		goto out1;
> -	}
> -	dmadata[PCM_TX].ddma_id = r->start;
> -
> -	/* RX DMA */
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!r) {
> -		ret = -ENODEV;
> -		goto out1;
> -	}
> -	dmadata[PCM_RX].ddma_id = r->start;
> -
>  	platform_set_drvdata(pdev, dmadata);
>  
>  	ret = snd_soc_register_platform(&pdev->dev, &au1xpsc_soc_platform);
> -	if (!ret)
> -		return ret;
> +	if (ret)
> +		kfree(dmadata);
>  
> -out1:
> -	kfree(dmadata);
>  	return ret;
>  }
>  
> @@ -404,57 +396,6 @@ static void __exit au1xpsc_audio_dbdma_unload(void)
>  module_init(au1xpsc_audio_dbdma_load);
>  module_exit(au1xpsc_audio_dbdma_unload);
>  
> -
> -struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev)
> -{
> -	struct resource *res, *r;
> -	struct platform_device *pd;
> -	int id[2];
> -	int ret;
> -
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!r)
> -		return NULL;
> -	id[0] = r->start;
> -
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!r)
> -		return NULL;
> -	id[1] = r->start;
> -
> -	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
> -	if (!res)
> -		return NULL;
> -
> -	res[0].start = res[0].end = id[0];
> -	res[1].start = res[1].end = id[1];
> -	res[0].flags = res[1].flags = IORESOURCE_DMA;
> -
> -	pd = platform_device_alloc("au1xpsc-pcm", pdev->id);
> -	if (!pd)
> -		goto out;
> -
> -	pd->resource = res;
> -	pd->num_resources = 2;
> -
> -	ret = platform_device_add(pd);
> -	if (!ret)
> -		return pd;
> -
> -	platform_device_put(pd);
> -out:
> -	kfree(res);
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(au1xpsc_pcm_add);
> -
> -void au1xpsc_pcm_destroy(struct platform_device *dmapd)
> -{
> -	if (dmapd)
> -		platform_device_unregister(dmapd);
> -}
> -EXPORT_SYMBOL_GPL(au1xpsc_pcm_destroy);
> -
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Au12x0/Au1550 PSC Audio DMA driver");
>  MODULE_AUTHOR("Manuel Lauss");
> diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
> index d0db66f..44296ab 100644
> --- a/sound/soc/au1x/psc-ac97.c
> +++ b/sound/soc/au1x/psc-ac97.c
> @@ -324,12 +324,21 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
>  	return ret;
>  }
>  
> +static int au1xpsc_ac97_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct au1xpsc_audio_data *pscdata = snd_soc_dai_get_drvdata(dai);
> +	snd_soc_dai_set_dma_data(dai, substream, &pscdata->dmaids[0]);
> +	return 0;
> +}
> +
>  static int au1xpsc_ac97_probe(struct snd_soc_dai *dai)
>  {
>  	return au1xpsc_ac97_workdata ? 0 : -ENODEV;
>  }
>  
>  static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
> +	.startup	= au1xpsc_ac97_startup,
>  	.trigger	= au1xpsc_ac97_trigger,
>  	.hw_params	= au1xpsc_ac97_hw_params,
>  };
> @@ -379,6 +388,16 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
>  	if (!wd->mmio)
>  		goto out1;
>  
> +	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (!r)
> +		goto out2;
> +	wd->dmaids[PCM_TX] = r->start;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +	if (!r)
> +		goto out2;
> +	wd->dmaids[PCM_RX] = r->start;
> +
>  	/* configuration: max dma trigger threshold, enable ac97 */
>  	wd->cfg = PSC_AC97CFG_RT_FIFO8 | PSC_AC97CFG_TT_FIFO8 |
>  		  PSC_AC97CFG_DE_ENABLE;
> @@ -401,15 +420,13 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
>  
>  	ret = snd_soc_register_dai(&pdev->dev, &wd->dai_drv);
>  	if (ret)
> -		goto out1;
> +		goto out2;
>  
> -	wd->dmapd = au1xpsc_pcm_add(pdev);
> -	if (wd->dmapd) {
> -		au1xpsc_ac97_workdata = wd;
> -		return 0;
> -	}
> +	au1xpsc_ac97_workdata = wd;
> +	return 0;
>  
> -	snd_soc_unregister_dai(&pdev->dev);
> +out2:
> +	iounmap(wd->mmio);
>  out1:
>  	release_mem_region(r->start, resource_size(r));
>  out0:
> @@ -422,9 +439,6 @@ static int __devexit au1xpsc_ac97_drvremove(struct platform_device *pdev)
>  	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
>  	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> -	if (wd->dmapd)
> -		au1xpsc_pcm_destroy(wd->dmapd);
> -
>  	snd_soc_unregister_dai(&pdev->dev);
>  
>  	/* disable PSC completely */
> diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
> index fca0912..1b7ab5d 100644
> --- a/sound/soc/au1x/psc-i2s.c
> +++ b/sound/soc/au1x/psc-i2s.c
> @@ -257,7 +257,16 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return ret;
>  }
>  
> +static int au1xpsc_i2s_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct au1xpsc_audio_data *pscdata = snd_soc_dai_get_drvdata(dai);
> +	snd_soc_dai_set_dma_data(dai, substream, &pscdata->dmaids[0]);
> +	return 0;
> +}
> +
>  static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
> +	.startup	= au1xpsc_i2s_startup,
>  	.trigger	= au1xpsc_i2s_trigger,
>  	.hw_params	= au1xpsc_i2s_hw_params,
>  	.set_fmt	= au1xpsc_i2s_set_fmt,
> @@ -304,6 +313,16 @@ static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
>  	if (!wd->mmio)
>  		goto out1;
>  
> +	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (!r)
> +		goto out2;
> +	wd->dmaids[PCM_TX] = r->start;

It's best to use the SNDRV_PCM_STREAM_PLAYBACK and CAPTURE for these indexes. Makes the code easier to read :)

> +
> +	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +	if (!r)
> +		goto out2;
> +	wd->dmaids[PCM_RX] = r->start;
> +
>  	/* preserve PSC clock source set up by platform (dev.platform_data
>  	 * is already occupied by soc layer)
>  	 */
> @@ -330,15 +349,11 @@ static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wd);
>  
>  	ret = snd_soc_register_dai(&pdev->dev, &wd->dai_drv);
> -	if (ret)
> -		goto out1;
> -
> -	/* finally add the DMA device for this PSC */
> -	wd->dmapd = au1xpsc_pcm_add(pdev);
> -	if (wd->dmapd)
> +	if (!ret)
>  		return 0;
>  
> -	snd_soc_unregister_dai(&pdev->dev);
> +out2:
> +	iounmap(wd->mmio);
>  out1:
>  	release_mem_region(r->start, resource_size(r));
>  out0:
> @@ -351,9 +366,6 @@ static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
>  	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
>  	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> -	if (wd->dmapd)
> -		au1xpsc_pcm_destroy(wd->dmapd);
> -
>  	snd_soc_unregister_dai(&pdev->dev);
>  
>  	au_writel(0, I2S_CFG(wd));
> diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
> index c59b9e5..1b21c4f 100644
> --- a/sound/soc/au1x/psc.h
> +++ b/sound/soc/au1x/psc.h
> @@ -19,10 +19,6 @@
>  #define SUBSTREAM_TYPE(substream) \
>  	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)
>  
> -/* PSC/DBDMA helpers */
> -extern struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev);
> -extern void au1xpsc_pcm_destroy(struct platform_device *dmapd);
> -
>  struct au1xpsc_audio_data {
>  	void __iomem *mmio;
>  
> @@ -34,7 +30,6 @@ struct au1xpsc_audio_data {
>  	unsigned long pm[2];
>  	struct mutex lock;
>  	int dmaids[2];
> -	struct platform_device *dmapd;
>  };
>  
>  /* easy access macros */
