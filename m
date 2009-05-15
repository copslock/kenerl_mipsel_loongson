Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 16:12:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:56693 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022670AbZEOPMJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 16:12:09 +0100
Received: from localhost (p3076-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AD5CFACF4; Sat, 16 May 2009 00:12:01 +0900 (JST)
Date:	Sat, 16 May 2009 00:12:02 +0900 (JST)
Message-Id: <20090516.001202.173372394.anemo@mba.ocn.ne.jp>
To:	broonie@opensource.wolfsonmicro.com
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090514185945.GO28291@sirena.org.uk>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20090514185945.GO28291@sirena.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 14 May 2009 19:59:46 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> This all looks basically fine - just a few comments below, the main one
> being the way you're registering things.

Thank you for quick review!

> > +#define txx9aclc_ac97_suspend	NULL
> > +#define txx9aclc_ac97_resume	NULL
> > +#endif
> 
> Just remove all this if there's no implementation.

OK.  I will do.

> Ideally you'd be registering a platform device in your arch code and
> then the DAI would only be registered when the device is probed.  This
> (and similar stuff for the DMA) would mean that...
...
> ...all this resource stuff wouldn't need to be done by the machine
> driver, it'd be done by your DAI and DMA drivers.  That means less
> duplication of code for multiple machines both in the machine driver and
> in registering the resources along with the platform device.

OK, then I will move irq/mem resource stuff to the DAI driver and dma
resource stuff to the DMA driver.

I placed them in the machine driver because both DAI and DMA drivers
need the mem resource.  I can move the mem resource stuff into the DAI
driver since the DAI driver will be probed before the DMA driver.

OTOH, I want to keep arch code as is.  There are some TXx9 SoC
variations and they can have different baseaddr/irq/dma.  I want to
leave these details in arch code and make ASoC drivers generic as
possible.

---
Atsushi Nemoto
