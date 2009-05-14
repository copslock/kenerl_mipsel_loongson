Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 19:59:55 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44489 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20026457AbZENS7s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2009 19:59:48 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M4g9i-0008Mj-12; Thu, 14 May 2009 19:59:46 +0100
Date:	Thu, 14 May 2009 19:59:46 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
Message-ID: <20090514185945.GO28291@sirena.org.uk>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Thu, May 14, 2009 at 11:50:04PM +0900, Atsushi Nemoto wrote:

This all looks basically fine - just a few comments below, the main one
being the way you're registering things.

> +#ifdef CONFIG_PM
> +static int txx9aclc_ac97_suspend(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +static int txx9aclc_ac97_resume(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +#else
> +#define txx9aclc_ac97_suspend	NULL
> +#define txx9aclc_ac97_resume	NULL
> +#endif

Just remove all this if there's no implementation.

> +static int __init txx9aclc_ac97_init(void)
> +{
> +	return snd_soc_register_dai(&txx9aclc_ac97_dai);
> +}
> +
> +static void __exit txx9aclc_ac97_exit(void)
> +{
> +	snd_soc_unregister_dai(&txx9aclc_ac97_dai);
> +}

Ideally you'd be registering a platform device in your arch code and
then the DAI would only be registered when the device is probed.  This
(and similar stuff for the DMA) would mean that...

> +static int __init txx9aclc_generic_probe(struct platform_device *pdev)
> +{
> +	struct txx9aclc_soc_device *dev = &txx9aclc_generic_soc_device;
> +	struct platform_device *soc_pdev;
> +	struct resource *r;
> +	int ret;
> +	int i;
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +	dev->irq = irq;

...all this resource stuff wouldn't need to be done by the machine
driver, it'd be done by your DAI and DMA drivers.  That means less
duplication of code for multiple machines both in the machine driver and
in registering the resources along with the platform device.

> +static int __init txx9aclc_soc_platform_init(void)
> +{
> +	return snd_soc_register_platform(&txx9aclc_soc_platform);
> +}
> +
> +static void __exit txx9aclc_soc_platform_exit(void)
> +{
> +	snd_soc_unregister_platform(&txx9aclc_soc_platform);
> +}

Same comment applies here.
