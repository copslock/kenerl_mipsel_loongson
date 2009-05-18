Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 15:23:19 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50022 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022071AbZEROXI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 15:23:08 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M63k9-0006JJ-TR; Mon, 18 May 2009 15:23:05 +0100
Date:	Mon, 18 May 2009 15:23:05 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
	(v2)
Message-ID: <20090518142305.GE1629@sirena.org.uk>
References: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, May 18, 2009 at 11:10:12PM +0900, Atsushi Nemoto wrote:

> +static int txx9aclc_ac97_probe(struct platform_device *pdev,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct txx9aclc_soc_device *dev =
> +		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
> +	struct platform_device *aclc_pdev = dev->aclc_pdev;
> +	struct resource *r;
> +	int err;
> +	int irq;
> +
> +	dev->irq = -1;
> +	irq = platform_get_irq(aclc_pdev, 0);

This isn't what I meant by moving the resources to the DAI and DMA
drivers.  You have moved the calls to read the resources to these
drivers (which is good) but the resources are still being obtained from
the main ASoC device rather than by themselves from the device code.

There aren't too many platforms using this approach yet but take a look
at the way the pxa2xx-ac97 driver deals with registering the DAI (it
doesn't do anything with resources ATM) - you want to be registering
your DAI and grabbing the resources from a platform driver probe like it
does.
