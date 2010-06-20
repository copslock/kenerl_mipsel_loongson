Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 15:11:52 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54510 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490950Ab0FTNLt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jun 2010 15:11:49 +0200
Received: from finisterre.wolfsonmicro.main (cpc3-sgyl4-0-0-cust125.sgyl.cable.virginmedia.com [82.41.240.126])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 367331104FA;
        Sun, 20 Jun 2010 14:11:39 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.72)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1OQKJV-0000do-Ga; Sun, 20 Jun 2010 14:11:53 +0100
Date:   Sun, 20 Jun 2010 14:11:53 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3] alsa: ASoC: Add JZ4740 codec driver
Message-ID: <20100620131153.GA2405@opensource.wolfsonmicro.com>
References: <1276924111-11158-21-git-send-email-lars@metafoo.de>
 <1276958993-9012-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276958993-9012-1-git-send-email-lars@metafoo.de>
X-Cookie: Is this really happening?
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13775

On Sat, Jun 19, 2010 at 04:49:53PM +0200, Lars-Peter Clausen wrote:

This looks good, just one thing:

> +#ifdef CONFIG_PM_SLEEP
> +
> +static int jz4740_codec_suspend(struct device *dev)
> +{
> +	struct jz4740_codec *jz4740_codec = dev_get_drvdata(dev);
> +	return jz4740_codec_set_bias_level(&jz4740_codec->codec,
> +		SND_SOC_BIAS_OFF);
> +}

You've got these set up on the CODEC platform device rather than the
ASoC CODEC.  This means that the suspend and resume will happen out of
sequence with the rest of the ASoC suspend and resume which could result
in poor performance or bugs if the device is suspended while the core
still thinks it's active.  For example, ASoC will use DAPM to shut down
the CODEC and it's possible that the CODEC could be suspended (and
generate an audible noise) while an external amplifier is still powered,
worsening the problem.
