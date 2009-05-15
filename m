Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 20:06:09 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53175 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022876AbZEOTGC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 20:06:02 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M52jG-0003v5-SC; Fri, 15 May 2009 20:05:58 +0100
Date:	Fri, 15 May 2009 20:05:58 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
Message-ID: <20090515190558.GA13050@sirena.org.uk>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp> <20090514185945.GO28291@sirena.org.uk> <20090516.001202.173372394.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090516.001202.173372394.anemo@mba.ocn.ne.jp>
X-Cookie: Caution: Keep out of reach of children.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Sat, May 16, 2009 at 12:12:02AM +0900, Atsushi Nemoto wrote:

> OK, then I will move irq/mem resource stuff to the DAI driver and dma
> resource stuff to the DMA driver.

Either is fine - do whatever makes most sense for your system.

> OTOH, I want to keep arch code as is.  There are some TXx9 SoC
> variations and they can have different baseaddr/irq/dma.  I want to
> leave these details in arch code and make ASoC drivers generic as
> possible.

This is the common situation for SoC CPUs - most silicon vendors reuse
the same IPs in diffierent combinations on different CPUs.  The normal
approach is to have the generic code for each SoC set up the resources
for the devices that are present on that particular SoC.  This avoids
the need for each board using the SoC to have to replicate the
information.
