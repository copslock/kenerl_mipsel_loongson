Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 12:53:49 +0100 (WEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41638 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S20022588AbZFHLxn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 12:53:43 +0100
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id DB4F5110024;
	Mon,  8 Jun 2009 12:53:36 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>)
	id 1MDdQ0-0006uS-CO; Mon, 08 Jun 2009 12:53:36 +0100
Date:	Mon, 8 Jun 2009 12:53:36 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio
	support.
Message-ID: <20090608115336.GA25827@rakim.wolfsonmicro.main>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com> <20090608092521.GA7858@sirena.org.uk> <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com> <20090608102018.GA6547@rakim.wolfsonmicro.main> <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Jun 08, 2009 at 01:25:57PM +0200, Manuel Lauss wrote:
> On Mon, Jun 8, 2009 at 12:20 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > Well, like I say if it's going via MIPS I'd really prefer it to go in
> > this merge window.  If not then I'd expect that splitting out the
> > architecture parts from the machine driver as I suggested ought to deal
> > with the merge issues.

> I'll split it in two:  pure ASoC part and pure board part.  Agreed?

Yes, that's fine for me.

> how to pass DAI private data to the ac97 callbacks), and I also don't see how
> to handle for instance 2 I2S machines with a WM8731 attached to each
> (i.e. how do I tell ASoC that wm8731 at bus0/0x1b belongs to machine A
>  and wm8731 at bus0/0x1c belongs to machine B?)

When multiple cards are supported the struct device for the CODEC will
be used to distinguish between instances of the same device - this is
why the DAI registration functions are being encouraged to use to
provide a struct device, once the multi-card support is in place it will
become much more important to have this information.

> > If you move the selection of the switch position to the architecture
> > code then it can arrange to register only the device that is in use in
> > the current configuration.  If the DMA and DAI drivers both need the
> > same resources they can cooperate with each other - the system will only
> > bring the card on-line once both the DMA and DAI driver are present.

> I think you misuderstood me.  Could you point out an in-kernel machine which
> already implements what you suggested?
> The AC97/I2S dai drivers (psc-ac97/psc-i2s) extract the base address of the PSC
> they're supposed to drive from the platform_device passed via the probe()
> callbacks, these in turn are called when a "soc_audio" platform device
> is called.

Sure, that's exactly what I see you doing and what I'm suggesting that
you change.

> I need to set either the ac97 or I2S platform data for soc_audio based on the
> switch setting.  I can't register a "db1200_audio" platform device in the board
> code which in turn registers the "soc_audio" device and have them share
> the PSC mmio/irq/dma resources.

You should convert the DAI drivers to probe as normal platform devices
and attach the resources used by the CPU to those devices rather than
attaching the data to soc-audio.  pxa2xx-ac97 does this, as do the
PowerPC drivers and the s3c64xx-i2s driver.  The DaVinci drivers
currently on the davinci branch of my git for merge after the merge
window do this too.
