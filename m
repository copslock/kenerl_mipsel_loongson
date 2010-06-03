Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 18:51:10 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:48929 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491063Ab0FCQvF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 18:51:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 217CAC3F;
        Thu,  3 Jun 2010 18:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dNOOh4CPNXzv; Thu,  3 Jun 2010 18:50:59 +0200 (CEST)
Received: from [172.31.16.228] (d078029.adsl.hansenet.de [80.171.78.29])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id E1FE0C3E;
        Thu,  3 Jun 2010 18:50:47 +0200 (CEST)
Message-ID: <4C07DD48.2050503@metafoo.de>
Date:   Thu, 03 Jun 2010 18:50:16 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Liam Girdwood <lrg@slimlogic.co.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC support
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>         <1275505950-17334-5-git-send-email-lars@metafoo.de> <1275569309.3593.106.camel@odin>
In-Reply-To: <1275569309.3593.106.camel@odin>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 27052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2591

Liam Girdwood wrote:
> On Wed, 2010-06-02 at 21:12 +0200, Lars-Peter Clausen wrote:
>   
>> This patch adds ASoC support for JZ4740 SoCs I2S module.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
>> Cc: alsa-devel@alsa-project.org
>> ---
>>  sound/soc/Kconfig             |    1 +
>>  sound/soc/Makefile            |    1 +
>>  sound/soc/jz4740/Kconfig      |   13 +
>>  sound/soc/jz4740/Makefile     |    9 +
>>  sound/soc/jz4740/jz4740-i2s.c |  568 +++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/jz4740/jz4740-i2s.h |   18 ++
>>  sound/soc/jz4740/jz4740-pcm.c |  350 +++++++++++++++++++++++++
>>  sound/soc/jz4740/jz4740-pcm.h |   22 ++
>>  8 files changed, 982 insertions(+), 0 deletions(-)
>>  create mode 100644 sound/soc/jz4740/Kconfig
>>  create mode 100644 sound/soc/jz4740/Makefile
>>  create mode 100644 sound/soc/jz4740/jz4740-i2s.c
>>  create mode 100644 sound/soc/jz4740/jz4740-i2s.h
>>  create mode 100644 sound/soc/jz4740/jz4740-pcm.c
>>  create mode 100644 sound/soc/jz4740/jz4740-pcm.h
>>
>> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>> index b1749bc..5a7a724 100644
>> --- a/sound/soc/Kconfig
>> +++ b/sound/soc/Kconfig
>> @@ -36,6 +36,7 @@ source "sound/soc/s3c24xx/Kconfig"
>>  source "sound/soc/s6000/Kconfig"
>>  source "sound/soc/sh/Kconfig"
>>  source "sound/soc/txx9/Kconfig"
>> +source "sound/soc/jz4740/Kconfig"
>>  
>>  # Supported codecs
>>  source "sound/soc/codecs/Kconfig"
>> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>> index 1470141..fdbe74d 100644
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_SND_SOC)	+= s3c24xx/
>>  obj-$(CONFIG_SND_SOC)	+= s6000/
>>  obj-$(CONFIG_SND_SOC)	+= sh/
>>  obj-$(CONFIG_SND_SOC)	+= txx9/
>> +obj-$(CONFIG_SND_SOC)	+= jz4740/
>> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
>> new file mode 100644
>> index 0000000..39df949
>> --- /dev/null
>> +++ b/sound/soc/jz4740/Kconfig
>> @@ -0,0 +1,13 @@
>> +config SND_JZ4740_SOC
>> +	tristate "SoC Audio for Ingenic JZ4740 SoC"
>> +	depends on SOC_JZ4740 && SND_SOC
>> +	help
>> +	  Say Y or M if you want to add support for codecs attached to
>> +	  the Jz4740 AC97, I2S or SSP interface. You will also need
>>     
>
> Do you have an AC97 or SSP interface ?
>
>   
Whoops. Copy-paste leftover...
>> +	[....]
>> +
>> +
>> +static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>> +	struct snd_soc_dai *dai)
>> +{
>> +	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
>> +	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
>> +
>> +	uint32_t ctrl;
>> +	uint32_t mask;
>> +
>> +	if (playback)
>>     
>
> It's best to use (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) here.
>
>   
hm, ok
>> +	[...]
>> --- /dev/null
>> +++ b/sound/soc/jz4740/jz4740-pcm.c
>> @@ -0,0 +1,350 @@
>> + [...] 
>> +static int jz4740_pcm_hw_params(struct snd_pcm_substream *substream,
>> +	struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct jz4740_runtime_data *prtd = runtime->private_data;
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct jz4740_pcm_config *config;
>> +
>> +	config = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
>> +	if (!prtd->dma) {
>> +		const char *dma_channel_name;
>> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +			dma_channel_name = "PCM Playback";
>> +		else
>> +			dma_channel_name = "PCM Capture";
>> +
>> +		prtd->dma = jz4740_dma_request(substream, dma_channel_name);
>>     
>
> dma_channel_name variable is not required here. Just use the const char
> * directly.
>
>   
I actually had it like that before, but I think it is much more readable
in its current form. Considering that stream value will either be 0 or 1
it might work to put the channel names into a static array.
>> +	[...]
>> +
>> +static snd_pcm_uframes_t jz4740_pcm_pointer(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct jz4740_runtime_data *prtd = runtime->private_data;
>> +	unsigned long count, pos;
>> +	snd_pcm_uframes_t offset;
>> +	struct jz4740_dma_chan *dma = prtd->dma;
>> +
>> +	count = jz4740_dma_get_residue(dma);
>> +	if (prtd->dma_pos == prtd->dma_start)
>> +		pos = prtd->dma_end - prtd->dma_start - count;
>> +	else
>> +		pos = prtd->dma_pos - prtd->dma_start - count;
>> +
>> +	offset = bytes_to_frames(runtime, pos);
>> +	if (offset >= runtime->buffer_size)
>> +		offset = 0;
>> +
>>     
>
> Could you comment your calculation a little more.
>   
Will do.
>
> Thanks
>
> Liam
>   
Thanks for the review
- Lars
