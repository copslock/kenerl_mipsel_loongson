Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 19:55:20 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34399 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492670Ab0FCRzR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 19:55:17 +0200
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id B4C97110504;
        Thu,  3 Jun 2010 18:55:11 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.71)
        (envelope-from <broonie@rakim.wolfsonmicro.main>)
        id 1OKEdL-00017k-6l; Thu, 03 Jun 2010 18:55:11 +0100
Date:   Thu, 3 Jun 2010 18:55:11 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC support
Message-ID: <20100603175511.GI2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275505950-17334-5-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275505950-17334-5-git-send-email-lars@metafoo.de>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2658

On Wed, Jun 02, 2010 at 09:12:27PM +0200, Lars-Peter Clausen wrote:

Again, overall very good.

> +static int jz4740_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
> +
> +	switch (div_id) {
> +	case JZ4740_I2S_BIT_CLK:
> +		if (div & 1 || div > 16)
> +			return -EINVAL;
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div - 1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

You can probably figure out the bit clock automatically by default...

> +	if (dai->active) {
> +		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> +		conf &= ~JZ_AIC_CONF_ENABLE;
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +
> +		clk_disable(i2s->clk_i2s);
> +	}
> +
> +	clk_disable(i2s->clk_aic);

Might make sense to manage this clock dynamically at runtime too for a
little extra power saving?

> +	i2s->clk_aic = clk_get(&pdev->dev, "aic");
> +	if (IS_ERR(i2s->clk_aic)) {
> +		ret = PTR_ERR(i2s->clk_aic);
> +		goto err_iounmap;
> +	}
> +
> +	i2s->clk_i2s = clk_get(&pdev->dev, "i2s");
> +	if (IS_ERR(i2s->clk_i2s)) {
> +		ret = PTR_ERR(i2s->clk_i2s);
> +		goto err_iounmap;
> +	}

Ideally you'd free the AIC clock when unwinding (and later stop it after
it was enabled).  Though since you don't do any error checking after
this point it's kind of academic :)
