Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 07:55:43 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:45580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490989Ab1G2Fzi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jul 2011 07:55:38 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 7DF7E8FB75;
        Fri, 29 Jul 2011 07:55:37 +0200 (CEST)
Date:   Fri, 29 Jul 2011 07:55:36 +0200
Message-ID: <s5hd3gt636v.wl%tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lrg@ti.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] SOUND: Fix txx9aclc.c build
In-Reply-To: <20110728112616.GA27918@linux-mips.org>
References: <20110728112616.GA27918@linux-mips.org>
User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.7 Emacs/23.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
X-archive-position: 30760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21399

At Thu, 28 Jul 2011 12:26:16 +0100,
Ralf Baechle wrote:
> 
> 552d1ef6b5a98d7b95959d5b139071e3c90cebf1 [ASoC: core - Optimise and refactor
> pcm_new() to pass only rtd] breaks compilation of txx9aclc.c:
> 
>   CC [M]  sound/soc/txx9/txx9aclc.o
> /home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c: In function 'txx9aclc_pcm_new':
> /home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: error: 'card' undeclared (first use in this function)
> /home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: note: each undeclared identifier is reported only once for each function it appears in
> make[5]: *** [sound/soc/txx9/txx9aclc.o] Error 1
> 
> Fixed by providing a definition for card.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks, I applied now to fix/asoc branch of sound git tree.


Takashi

> 
>  sound/soc/txx9/txx9aclc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
> index 34aa972..3de99af 100644
> --- a/sound/soc/txx9/txx9aclc.c
> +++ b/sound/soc/txx9/txx9aclc.c
> @@ -290,6 +290,7 @@ static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
>  
>  static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_card *card = rtd->card->snd_card;
>  	struct snd_soc_dai *dai = rtd->cpu_dai;
>  	struct snd_pcm *pcm = rtd->pcm;
>  	struct platform_device *pdev = to_platform_device(dai->platform->dev);
> 
