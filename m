Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 16:31:27 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54139 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1GZObW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2011 16:31:22 +0200
Received: from rakim.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 3DEEA750055;
        Tue, 26 Jul 2011 15:31:15 +0100 (BST)
Received: by rakim.wolfsonmicro.main (Postfix, from userid 1000)
        id 0A958878B954; Tue, 26 Jul 2011 15:31:13 +0100 (BST)
Date:   Tue, 26 Jul 2011 15:31:13 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio support
Message-ID: <20110726143112.GF7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
 <1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
X-Cookie: Save energy: be apathetic.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18647

On Mon, Jul 25, 2011 at 01:44:45PM +0200, Manuel Lauss wrote:

Looks good, I'll apply this but a few minor comments you might want to
look at incrementally.

> +#define ALCHEMY_PCM_FMTS					\
> +	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |	\
> +	 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |	\
> +	 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |	\
> +	 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |	\
> +	 SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |	\
> +	 0)

Why the | 0?  Same for the other one.

> +	case (DMA_D0 | DMA_D1):
> +		pr_debug("DMA %d missed interrupt.\n", stream->dma);
> +		au1000_dma_stop(stream);
> +		au1000_dma_start(stream);
> +		break;
> +	case (~DMA_D0 & ~DMA_D1):
> +		pr_debug("DMA %d empty irq.\n", stream->dma);

This case should return IRQ_NONE really since it didn't handle an
interrupt...
