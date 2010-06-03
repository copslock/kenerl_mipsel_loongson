Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 07:45:50 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:64079 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab0FCFpp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 07:45:45 +0200
Received: by pxi1 with SMTP id 1so3106003pxi.36
        for <multiple recipients>; Wed, 02 Jun 2010 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2ZE7mxWDX0xS3sER8s7imhAvshrEw4PMscp0IygrGPw=;
        b=Lr/xfNzUk51gfzrwZm5RYABWUFt6EY6BEm9L4obNJ3l2U+Ykldojy6ntAaa6EqSx0b
         VIKVttof6WmgLgQ9Tbq8aMy99II5jSy2+Q9Nh0UEIZSrEHT3e+No+6m2wT17b/voFe5g
         mlPowwHgqFhDOcrqkubdSps8VIGZTw08koZKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=X00SpzNx14XJhYqRaQHjJOoeKfvWUTV97iR7S+BcwmsKxrGF978/XWNCxRPNA0Bda5
         6cp+ORZjaworlgAGof4ThO/Ep+4EdTcMv3Si3QWE77nlaBrOhLZazQQySUwLJmbXcrb7
         iPNdv4DlS3u2llmpoXM5kOnNHpCtgpwMBmKoc=
Received: by 10.140.87.41 with SMTP id k41mr7657779rvb.109.1275543936117;
        Wed, 02 Jun 2010 22:45:36 -0700 (PDT)
Received: from [192.168.1.10] ([116.226.201.224])
        by mx.google.com with ESMTPS id h11sm2014957rvm.0.2010.06.02.22.45.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 22:45:35 -0700 (PDT)
Message-ID: <4C074171.2080106@gmail.com>
Date:   Thu, 03 Jun 2010 13:45:21 +0800
From:   Wan ZongShun <mcuos.com@gmail.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
 driver
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1275505950-17334-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcuos.com@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2083

Hi Lars-Peter Clausen,

Your all the patches have two kinds of 'WARNING:',as following:

(1)'WARNING: line over 80 characters' and

Please make a line less than 80 characters.

(2)'WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable'

I can illustrate by a example,bellow:

struct snd_soc_codec_device soc_codec_dev_jz4740_codec = {
        .probe = jz4740_codec_dev_probe,
        .remove = jz4740_codec_dev_remove,
};
EXPORT_SYMBOL_GPL(soc_codec_dev_jz4740_codec);

I think the ';' should be removed according to 'checkpatch.pl', but Andrew Morton just said the 'warning'
reason from the checkpatch script's own BUG, so far, I could not get any comments about this.

So, Mark & Liam, any comments regarding this 'checkpatch script's own BUG'?

Lars-Peter Clausen:
> This patch adds support for the JZ4740 internal codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: alsa-devel@alsa-project.org
> ---
>  sound/soc/codecs/Kconfig        |    4 +
>  sound/soc/codecs/Makefile       |    2 +
>  sound/soc/codecs/jz4740-codec.c |  502 +++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/jz4740-codec.h |   20 ++
>  4 files changed, 528 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/jz4740-codec.c
>  create mode 100644 sound/soc/codecs/jz4740-codec.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 31ac553..b8008df 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -23,6 +23,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_AK4671 if I2C
>  	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
>  	select SND_SOC_CS4270 if I2C
> +	select SND_SOC_JZ4740 if SOC_JZ4740
>  	select SND_SOC_MAX9877 if I2C
>  	select SND_SOC_DA7210 if I2C
>  	select SND_SOC_PCM3008
> @@ -269,6 +270,9 @@ config SND_SOC_WM9712
>  config SND_SOC_WM9713
>  	tristate
>  
> +config SND_SOC_JZ4740_CODEC
> +	tristate
> +
>  # Amp
>  config SND_SOC_MAX9877
>  	tristate
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 91429ea..4c7ee31 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -56,6 +56,7 @@ snd-soc-wm9705-objs := wm9705.o
>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> +snd-soc-jz4740-codec-objs := jz4740-codec.o
>  
>  # Amp
>  snd-soc-max9877-objs := max9877.o
> @@ -121,6 +122,7 @@ obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
>  obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
>  obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
>  obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
> +obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
>  
>  # Amp
>  obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
> diff --git a/sound/soc/codecs/jz4740-codec.c b/sound/soc/codecs/jz4740-codec.c
> new file mode 100644
> index 0000000..6e4b741
> --- /dev/null
> +++ b/sound/soc/codecs/jz4740-codec.c
> @@ -0,0 +1,502 @@
> +/*
> + * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/delay.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/soc.h>
> +
> +#define JZ4740_REG_CODEC_1 0x0
> +#define JZ4740_REG_CODEC_2 0x1
> +
> +#define JZ4740_CODEC_1_LINE_ENABLE BIT(29)
> +#define JZ4740_CODEC_1_MIC_ENABLE BIT(28)
> +#define JZ4740_CODEC_1_SW1_ENABLE BIT(27)
> +#define JZ4740_CODEC_1_ADC_ENABLE BIT(26)
> +#define JZ4740_CODEC_1_SW2_ENABLE BIT(25)
> +#define JZ4740_CODEC_1_DAC_ENABLE BIT(24)
> +#define JZ4740_CODEC_1_VREF_DISABLE BIT(20)
> +#define JZ4740_CODEC_1_VREF_AMP_DISABLE BIT(19)
> +#define JZ4740_CODEC_1_VREF_PULL_DOWN BIT(18)
> +#define JZ4740_CODEC_1_VREF_LOW_CURRENT BIT(17)
> +#define JZ4740_CODEC_1_VREF_HIGH_CURRENT BIT(16)
> +#define JZ4740_CODEC_1_HEADPHONE_DISABLE BIT(14)
> +#define JZ4740_CODEC_1_HEADPHONE_AMP_CHANGE_ANY BIT(13)
> +#define JZ4740_CODEC_1_HEADPHONE_CHANGE BIT(12)
> +#define JZ4740_CODEC_1_HEADPHONE_PULL_DOWN_M BIT(11)
> +#define JZ4740_CODEC_1_HEADPHONE_PULL_DOWN_R BIT(10)
> +#define JZ4740_CODEC_1_HEADPHONE_POWER_DOWN_M BIT(9)
> +#define JZ4740_CODEC_1_HEADPHONE_POWER_DOWN BIT(8)
> +#define JZ4740_CODEC_1_SUSPEND BIT(1)
> +#define JZ4740_CODEC_1_RESET BIT(0)
> +
> +#define JZ4740_CODEC_1_LINE_ENABLE_OFFSET 29
> +#define JZ4740_CODEC_1_MIC_ENABLE_OFFSET 28
> +#define JZ4740_CODEC_1_SW1_ENABLE_OFFSET 27
> +#define JZ4740_CODEC_1_ADC_ENABLE_OFFSET 26
> +#define JZ4740_CODEC_1_SW2_ENABLE_OFFSET 25
> +#define JZ4740_CODEC_1_DAC_ENABLE_OFFSET 24
> +#define JZ4740_CODEC_1_HEADPHONE_DISABLE_OFFSET 14
> +#define JZ4740_CODEC_1_HEADPHONE_POWER_DOWN_OFFSET 8
> +
> +#define JZ4740_CODEC_2_INPUT_VOLUME_MASK		0x1f0000
> +#define JZ4740_CODEC_2_SAMPLE_RATE_MASK			0x000f00
> +#define JZ4740_CODEC_2_MIC_BOOST_GAIN_MASK		0x000030
> +#define JZ4740_CODEC_2_HEADPHONE_VOLUME_MASK	0x000003
> +
> +#define JZ4740_CODEC_2_INPUT_VOLUME_OFFSET		16
> +#define JZ4740_CODEC_2_SAMPLE_RATE_OFFSET		 8
> +#define JZ4740_CODEC_2_MIC_BOOST_GAIN_OFFSET	 4
> +#define JZ4740_CODEC_2_HEADPHONE_VOLUME_OFFSET	 0
> +
> +struct jz4740_codec {
> +	void __iomem *base;
> +	struct resource *mem;
> +
> +	uint32_t reg_cache[2];
> +	struct snd_soc_codec codec;
> +};
> +
> +static inline struct jz4740_codec *codec_to_jz4740(struct snd_soc_codec *codec)
> +{
> +	return container_of(codec, struct jz4740_codec, codec);
> +}
> +
> +static unsigned int jz4740_codec_read(struct snd_soc_codec *codec, unsigned int reg)
> +{
> +	struct jz4740_codec *jz4740_codec = codec_to_jz4740(codec);
> +	return readl(jz4740_codec->base + (reg << 2));
> +}
> +
> +static int jz4740_codec_write(struct snd_soc_codec *codec, unsigned int reg,
> +	unsigned int val)
> +{
> +	struct jz4740_codec *jz4740_codec = codec_to_jz4740(codec);
> +	jz4740_codec->reg_cache[reg] = val;
> +
> +	writel(val, jz4740_codec->base + (reg << 2));
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new jz4740_codec_controls[] = {
> +	SOC_SINGLE("Master Playback Volume", JZ4740_REG_CODEC_2,
> +			JZ4740_CODEC_2_HEADPHONE_VOLUME_OFFSET, 3, 0),
> +	SOC_SINGLE("Capture Volume", JZ4740_REG_CODEC_2,
> +			JZ4740_CODEC_2_INPUT_VOLUME_OFFSET, 31, 0),
> +	SOC_SINGLE("Master Playback Switch", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_HEADPHONE_DISABLE_OFFSET, 1, 1),
> +	SOC_SINGLE("Mic Capture Volume", JZ4740_REG_CODEC_2,
> +			JZ4740_CODEC_2_MIC_BOOST_GAIN_OFFSET, 3, 0),
> +};
> +
> +static const struct snd_kcontrol_new jz4740_codec_output_controls[] = {
> +	SOC_DAPM_SINGLE("Bypass Switch", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_SW1_ENABLE_OFFSET, 1, 0),
> +	SOC_DAPM_SINGLE("DAC Switch", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_SW2_ENABLE_OFFSET, 1, 0),
> +};
> +
> +static const struct snd_kcontrol_new jz4740_codec_input_controls[] = {
> +	SOC_DAPM_SINGLE("Line Capture Switch", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_LINE_ENABLE_OFFSET, 1, 0),
> +	SOC_DAPM_SINGLE("Mic Capture Switch", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_MIC_ENABLE_OFFSET, 1, 0),
> +};
> +
> +static const struct snd_soc_dapm_widget jz4740_codec_dapm_widgets[] = {
> +	SND_SOC_DAPM_ADC("ADC", "Capture", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_ADC_ENABLE_OFFSET, 0),
> +	SND_SOC_DAPM_DAC("DAC", "Playback", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_DAC_ENABLE_OFFSET, 0),
> +
> +	SND_SOC_DAPM_MIXER("Output Mixer", JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_HEADPHONE_POWER_DOWN_OFFSET, 1,
> +			jz4740_codec_output_controls,
> +			ARRAY_SIZE(jz4740_codec_output_controls)),
> +
> +	SND_SOC_DAPM_MIXER_NAMED_CTL("Input Mixer", SND_SOC_NOPM, 0, 0,
> +			jz4740_codec_input_controls,
> +			ARRAY_SIZE(jz4740_codec_input_controls)),
> +	SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +	SND_SOC_DAPM_OUTPUT("LOUT"),
> +	SND_SOC_DAPM_OUTPUT("ROUT"),
> +
> +	SND_SOC_DAPM_INPUT("MIC"),
> +	SND_SOC_DAPM_INPUT("LIN"),
> +	SND_SOC_DAPM_INPUT("RIN"),
> +};
> +
> +static const struct snd_soc_dapm_route jz4740_codec_dapm_routes[] = {
> +
> +	{"Line Input", NULL, "LIN"},
> +	{"Line Input", NULL, "RIN"},
> +
> +	{"Input Mixer", "Line Capture Switch", "Line Input"},
> +	{"Input Mixer", "Mic Capture Switch", "MIC"},
> +
> +	{"ADC", NULL, "Input Mixer"},
> +
> +	{"Output Mixer", "Bypass Switch", "Input Mixer"},
> +	{"Output Mixer", "DAC Switch", "DAC"},
> +
> +	{"LOUT", NULL, "Output Mixer"},
> +	{"ROUT", NULL, "Output Mixer"},
> +};
> +
> +static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	uint32_t val;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S8:
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +	case SNDRV_PCM_FORMAT_S18_3LE:
> +		break;
> +	default:
> +		return -EINVAL;
> +		break;
> +	}
> +
> +	switch (params_rate(params)) {
> +	case 8000:
> +		val = 0;
> +		break;
> +	case 11025:
> +		val = 1;
> +		break;
> +	case 12000:
> +		val = 2;
> +		break;
> +	case 16000:
> +		val = 3;
> +		break;
> +	case 22050:
> +		val = 4;
> +		break;
> +	case 24000:
> +		val = 5;
> +		break;
> +	case 32000:
> +		val = 6;
> +		break;
> +	case 44100:
> +		val = 7;
> +		break;
> +	case 48000:
> +		val = 8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val <<= JZ4740_CODEC_2_SAMPLE_RATE_OFFSET;
> +
> +	snd_soc_update_bits(codec, JZ4740_REG_CODEC_2,
> +				JZ4740_CODEC_2_SAMPLE_RATE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int jz4740_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_ops jz4740_codec_dai_ops = {
> +	.hw_params = jz4740_codec_hw_params,
> +	.set_fmt = jz4740_codec_set_fmt,
> +};
> +
> +struct snd_soc_dai jz4740_codec_dai = {
> +	.name = "jz-codec",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8,
> +	},
> +	.ops = &jz4740_codec_dai_ops,
> +	.symmetric_rates = 1,
> +};
> +EXPORT_SYMBOL_GPL(jz4740_codec_dai);
> +
> +static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
> +	enum snd_soc_bias_level level)
> +{
> +
> +	if (codec->bias_level == SND_SOC_BIAS_OFF && level != SND_SOC_BIAS_OFF) {
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_RESET, JZ4740_CODEC_1_RESET);
> +		udelay(2);
> +
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_SUSPEND | JZ4740_CODEC_1_RESET, 0);
> +	}
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_VREF_DISABLE |
> +			JZ4740_CODEC_1_VREF_AMP_DISABLE |
> +			JZ4740_CODEC_1_HEADPHONE_POWER_DOWN_M |
> +			JZ4740_CODEC_1_VREF_LOW_CURRENT |
> +			JZ4740_CODEC_1_VREF_HIGH_CURRENT,
> +			0);
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_VREF_LOW_CURRENT |
> +			JZ4740_CODEC_1_VREF_HIGH_CURRENT,
> +			JZ4740_CODEC_1_VREF_LOW_CURRENT |
> +			JZ4740_CODEC_1_VREF_HIGH_CURRENT);
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_VREF_DISABLE | JZ4740_CODEC_1_VREF_AMP_DISABLE,
> +			JZ4740_CODEC_1_VREF_DISABLE | JZ4740_CODEC_1_VREF_AMP_DISABLE);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_SUSPEND, JZ4740_CODEC_1_SUSPEND);
> +		break;
> +	}
> +	codec->bias_level = level;
> +
> +	return 0;
> +}
> +
> +
> +static struct snd_soc_codec *jz4740_codec_codec;
> +
> +static int jz4740_codec_dev_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = jz4740_codec_codec;
> +
> +	BUG_ON(!codec);
> +
> +	socdev->card->codec = codec;
> +
> +	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create pcms: %d\n", ret);
> +		return ret;
> +	}
> +
> +	snd_soc_add_controls(codec, jz4740_codec_controls,
> +		ARRAY_SIZE(jz4740_codec_controls));
> +
> +	snd_soc_dapm_new_controls(codec, jz4740_codec_dapm_widgets,
> +		ARRAY_SIZE(jz4740_codec_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(codec, jz4740_codec_dapm_routes,
> +		ARRAY_SIZE(jz4740_codec_dapm_routes));
> +
> +	snd_soc_dapm_new_widgets(codec);
> +
> +	return 0;
> +}
> +
> +static int jz4740_codec_dev_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	snd_soc_free_pcms(socdev);
> +	snd_soc_dapm_free(socdev);
> +
> +	return 0;
> +}
> +
> +struct snd_soc_codec_device soc_codec_dev_jz4740_codec = {
> +	.probe = jz4740_codec_dev_probe,
> +	.remove = jz4740_codec_dev_remove,
> +};
> +EXPORT_SYMBOL_GPL(soc_codec_dev_jz4740_codec);
> +
> +static int __devinit jz4740_codec_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct jz4740_codec *jz4740_codec;
> +	struct snd_soc_codec *codec;
> +
> +	jz4740_codec = kzalloc(sizeof(*jz4740_codec), GFP_KERNEL);
> +
> +	if (!jz4740_codec)
> +		return -ENOMEM;
> +
> +	jz4740_codec->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!jz4740_codec->mem) {
> +		dev_err(&pdev->dev, "Failed to get mmio memory resource\n");
> +		ret = -ENOENT;
> +		goto err_free_codec;
> +	}
> +
> +	jz4740_codec->mem = request_mem_region(jz4740_codec->mem->start,
> +				resource_size(jz4740_codec->mem), pdev->name);
> +
> +	if (!jz4740_codec->mem) {
> +		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
> +		ret = -EBUSY;
> +		goto err_free_codec;
> +	}
> +
> +	jz4740_codec->base = ioremap(jz4740_codec->mem->start, resource_size(jz4740_codec->mem));
> +
> +	if (!jz4740_codec->base) {
> +		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
> +		ret = -EBUSY;
> +		goto err_release_mem_region;
> +	}
> +
> +	jz4740_codec_dai.dev = &pdev->dev;
> +
> +	codec = &jz4740_codec->codec;
> +
> +	codec->dev		= &pdev->dev;
> +	codec->name		= "jz-codec";
> +	codec->owner		= THIS_MODULE;
> +
> +	codec->read		= jz4740_codec_read;
> +	codec->write		= jz4740_codec_write;
> +	codec->set_bias_level	= jz4740_codec_set_bias_level;
> +	codec->bias_level	= SND_SOC_BIAS_OFF;
> +
> +	codec->dai		= &jz4740_codec_dai;
> +	codec->num_dai		= 1;
> +
> +	codec->reg_cache	= jz4740_codec->reg_cache;
> +	codec->reg_cache_size	= 2;
> +
> +	mutex_init(&codec->mutex);
> +	INIT_LIST_HEAD(&codec->dapm_widgets);
> +	INIT_LIST_HEAD(&codec->dapm_paths);
> +
> +	jz4740_codec_codec = codec;
> +
> +	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +				JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
> +
> +
> +	platform_set_drvdata(pdev, jz4740_codec);
> +	ret = snd_soc_register_codec(codec);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register codec\n");
> +		goto err_iounmap;
> +	}
> +
> +	ret = snd_soc_register_dai(&jz4740_codec_dai);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register codec dai\n");
> +		goto err_unregister_codec;
> +	}
> +
> +	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	return 0;
> +err_unregister_codec:
> +	snd_soc_unregister_codec(codec);
> +err_iounmap:
> +	iounmap(jz4740_codec->base);
> +err_release_mem_region:
> +	release_mem_region(jz4740_codec->mem->start, resource_size(jz4740_codec->mem));
> +err_free_codec:
> +	kfree(jz4740_codec);
> +
> +	return ret;
> +}
> +
> +static int __devexit jz4740_codec_remove(struct platform_device *pdev)
> +{
> +	struct jz4740_codec *jz4740_codec = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_dai(&jz4740_codec_dai);
> +	snd_soc_unregister_codec(&jz4740_codec->codec);
> +
> +	iounmap(jz4740_codec->base);
> +	release_mem_region(jz4740_codec->mem->start, resource_size(jz4740_codec->mem));
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(jz4740_codec);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver jz4740_codec_driver = {
> +	.probe = jz4740_codec_probe,
> +	.remove = __devexit_p(jz4740_codec_remove),
> +	.driver = {
> +		.name = "jz4740-codec",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init jz4740_codec_init(void)
> +{
> +	return platform_driver_register(&jz4740_codec_driver);
> +}
> +module_init(jz4740_codec_init);
> +
> +static void __exit jz4740_codec_exit(void)
> +{
> +	platform_driver_unregister(&jz4740_codec_driver);
> +}
> +module_exit(jz4740_codec_exit);
> +
> +MODULE_DESCRIPTION("JZ4740 SoC internal codec driver");
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:jz-codec");
> diff --git a/sound/soc/codecs/jz4740-codec.h b/sound/soc/codecs/jz4740-codec.h
> new file mode 100644
> index 0000000..b5a0691
> --- /dev/null
> +++ b/sound/soc/codecs/jz4740-codec.h
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __SND_SOC_CODECS_JZ4740_CODEC_H__
> +#define __SND_SOC_CODECS_JZ4740_CODEC_H__
> +
> +extern struct snd_soc_dai jz4740_codec_dai;
> +extern struct snd_soc_codec_device soc_codec_dev_jz4740_codec;
> +
> +#endif
