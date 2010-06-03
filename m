Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 19:50:05 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38614 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492676Ab0FCRuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 19:50:01 +0200
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 006A9110504;
        Thu,  3 Jun 2010 18:49:53 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.71)
        (envelope-from <broonie@rakim.wolfsonmicro.main>)
        id 1OKEYD-00017W-Fk; Thu, 03 Jun 2010 18:49:53 +0100
Date:   Thu, 3 Jun 2010 18:49:53 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec driver
Message-ID: <20100603174953.GH2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275505950-17334-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275505950-17334-4-git-send-email-lars@metafoo.de>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2647

On Wed, Jun 02, 2010 at 09:12:26PM +0200, Lars-Peter Clausen wrote:

> This patch adds support for the JZ4740 internal codec.

This looks very good, there are some issues but nothing too major.  I
may be repeating some things others have said but hopefully not too
much.

>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> +snd-soc-jz4740-codec-objs := jz4740-codec.o

Keep the devices sorted in both Makefile and Kconfig.

> +static int jz4740_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This does nothing except validate some parameters.  Is there actually an
externally visible DAI for this CODEC?  If it's just integrated into the
SoC and there's nothing to configure then just omit the DAI
configuration since it's not even useful to document the signal format.

> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8,

You listed an 18 bit format in hw_params - one or other of this and
hw_params is presumably out of date.

> +static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
> +	enum snd_soc_bias_level level)
> +{
> +
> +	if (codec->bias_level == SND_SOC_BIAS_OFF && level != SND_SOC_BIAS_OFF) {
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_RESET, JZ4740_CODEC_1_RESET);
> +		udelay(2);

I'd expect to see this as part of the _OFF in the main switch
statement.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
> +			JZ4740_CODEC_1_VREF_DISABLE |
> +			JZ4740_CODEC_1_VREF_AMP_DISABLE |
> +			JZ4740_CODEC_1_HEADPHONE_POWER_DOWN_M |
> +			JZ4740_CODEC_1_VREF_LOW_CURRENT |
> +			JZ4740_CODEC_1_VREF_HIGH_CURRENT,
> +			0);

This looks suspiciously like you should be using DAPM for the headphone
at least, though if there's only headphone out that's possibly not worth
it.  Also, are you sure that you want both low and high current VREF
configuring here?  I'm not clear what these settings do but the way
they're being managed both here and in _PREPARE seems odd.

> +	codec = &jz4740_codec->codec;
> +
> +	codec->dev		= &pdev->dev;
> +	codec->name		= "jz-codec";

Seems a bit odd to use the part number in some places and not others.
