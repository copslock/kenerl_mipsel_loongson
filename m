Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 19:57:24 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34420 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492670Ab0FCR5V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 19:57:21 +0200
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id A408F110504;
        Thu,  3 Jun 2010 18:57:15 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.71)
        (envelope-from <broonie@rakim.wolfsonmicro.main>)
        id 1OKEfL-00017r-4z; Thu, 03 Jun 2010 18:57:15 +0100
Date:   Thu, 3 Jun 2010 18:57:15 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC][PATCH 26/26] alsa: ASoC: JZ4740: Add qi_lb60 board driver
Message-ID: <20100603175714.GJ2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275506132-17519-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275506132-17519-2-git-send-email-lars@metafoo.de>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2662

On Wed, Jun 02, 2010 at 09:15:32PM +0200, Lars-Peter Clausen wrote:

> +	ret = gpio_request(QI_LB60_SND_GPIO, "SND");
> +	if (ret) {
> +		pr_err("qi_lb60 snd: Failed to request SND GPIO(%d): %d\n",
> +				QI_LB60_SND_GPIO, ret);
> +		goto err_device_put;
> +	}
> +
> +	ret = gpio_request(QI_LB60_AMP_GPIO, "AMP");
> +	if (ret) {
> +		pr_err("qi_lb60 snd: Failed to request AMP GPIO(%d): %d\n",
> +				QI_LB60_AMP_GPIO, ret);
> +		goto err_gpio_free_snd;
> +	}
> +
> +	gpio_direction_output(JZ_GPIO_PORTB(29), 0);
> +	gpio_direction_output(JZ_GPIO_PORTD(4), 0);

You're referring to the GPIOs by multiple different names - it'd be more
robust to pick one way of naming them and use it consistently (probably
the #define).
