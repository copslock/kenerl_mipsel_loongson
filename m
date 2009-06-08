Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 14:45:54 +0100 (WEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50451 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S20021940AbZFHNpr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 14:45:47 +0100
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id CB10B110024;
	Mon,  8 Jun 2009 14:45:41 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>)
	id 1MDfAT-0001QL-Cj; Mon, 08 Jun 2009 14:45:41 +0100
Date:	Mon, 8 Jun 2009 14:45:41 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio
	support.
Message-ID: <20090608134541.GA4765@rakim.wolfsonmicro.main>
References: <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com> <20090608092521.GA7858@sirena.org.uk> <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com> <20090608102018.GA6547@rakim.wolfsonmicro.main> <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com> <20090608115336.GA25827@rakim.wolfsonmicro.main> <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com> <20090608124411.GA3396@rakim.wolfsonmicro.main> <f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
X-Cookie: Crazee Edeee, his prices are INSANE!!!
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Jun 08, 2009 at 03:11:39PM +0200, Manuel Lauss wrote:

> All 3 drivers are now platform_devices -- and now I still have the
> same problem as
> before: I can't really share the whole struct resource;  i need to allocate
> a new resource struct, fill in the dma ids and register the dma device with it.

I don't understand the problem you're seeing here?  I don't see any
fundamental difference between the before and after pictures in terms of
what you're saying.  Note that there is no requirement that the DMA
driver be a separate device - it can be if you want but if you want to
make it part of the DAI driver that works too.  As I say, the DAI and
DMA drivers can peer into each other's implementations as much as they
like.  They're split up since on most CPUs the same DMA back end is used
by all the DAIs the CPU supports so there's normally some opportunity
for code sharing but they're never truly independent of each other.

It's not terribly clear from what you're saying but it *sounds* like for
your platform the DMA driver should be essentially a library for the DAI
driver, registered by the DAI driver when it probes.  Otherwise could
you please go into a bit more detail about what you mean when you say
you need to "allocate a new resource struct..." and so on - when do you
need to allocate the resource struct and why do you need to do this?

In the overwhelming majority of systems I've seen there are no resources
associated with the actual machine driver itself - all the resources are
for the DMA and DAI.

> Btw, the davinci-evm in asoc-git also registers mmio and dma from within
> the machine code.

Not in the davinci branch I pointed you at, there the drivers have been
converted to use the standard device model for this.  The old DaVinci
code you were looking at predates the ability to register things
separately.

> I can't shake the feeling that there's something wrong with the whole asoc
> device model (and that asoc was designed with pxa2xx devices in mind which
> have single audio units with fixed resources that the driver code can
> hardcode inside it).

Could you articulate what your concerns are here in more detail?

Previously I've heard a lot of people complaining (with reason) about
the fact that it didn't use the standard device model at all, especially
for the CODECs, but this is the first time I've ever heard any concerns
about the standard device model.  The problems you're mentioning with
hard coding things are problems which are for most people fixed by using
the standard device model and passing the resources for the DAIs up from
the architecture code using the standard mechanisms since it makes it
trivial to add or move new instances of the same IP block.

Doing this by putting everything into the machine drivers gets a bit
tricky once you have multiple DAIs in play on a single card since it
gets more error prone to tie the resources to the DAIs.

> To put an end to this thread:  I really don't want to change the machine code
> or dai drivers at this time, because I have the feeling that it's a few steps
> backwards.  If you don't agree with this then I'll leave the audio parts out of

It'd be really good to try to understand and address your concerns now
before we've been through the transition for more machines - the longer
it's left the harder it will be to change.  The drivers don't have to
change now, I just want to understand what your concerns are.

> the submission; I don't really care if it goes in or not, I just saw
> it as a nice
> sample machine driver for both AC97 and I2S on Alchemy.

Please submit anyway but at some point someone is going to have to
convert the driver - I'm intending to leave as long a transition period
as I can but at some point it's going to block other enhancements.
