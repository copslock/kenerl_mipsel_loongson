Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 13:44:24 +0100 (WEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40849 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S20022690AbZFHMoR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 13:44:17 +0100
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id E3D69110024;
	Mon,  8 Jun 2009 13:44:11 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>)
	id 1MDeCx-0000vh-ER; Mon, 08 Jun 2009 13:44:11 +0100
Date:	Mon, 8 Jun 2009 13:44:11 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio
	support.
Message-ID: <20090608124411.GA3396@rakim.wolfsonmicro.main>
References: <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com> <20090608092521.GA7858@sirena.org.uk> <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com> <20090608102018.GA6547@rakim.wolfsonmicro.main> <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com> <20090608115336.GA25827@rakim.wolfsonmicro.main> <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Jun 08, 2009 at 02:21:18PM +0200, Manuel Lauss wrote:

> I see now what you mean, but this is ugly as sin:
> I now need to register 2 platform devices in the board code: 1 for the DAI
> (with resources mmio + irq) and 1 for the DMA engine (with ddma id resources),
> or register the DMA engine device from within the AC97/I2S drivers.

> This is in my opinion even worse than the current scheme, which at least allows
> me to group all PSC resources into one struct resource which all audio-related
> drivers can share without too much uglyness.

If you trigger registration the DMA engine from within the I2S and AC97
devices you can still group everything together like you want to so I
don't really see the problem - they're peering at a different device for
the data but other than that things are unchanged.  At the minute you're
loosing a lot of sharing by having this in the individual machine
drivers.

Note that one of the possibilities once multiple sound card support is
introduced is that DAIs could be shared between multiple cards.  This is
only going to be at all useful for CPU DAIs which allow separate
configuration of the RX and TX paths and will never be the common case
but it's something to bear in mind.
