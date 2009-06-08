Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 11:20:31 +0100 (WEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39218 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S20022374AbZFHKUZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 11:20:25 +0100
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id CD81B76870A;
	Mon,  8 Jun 2009 11:20:18 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>)
	id 1MDbxi-0001mz-CW; Mon, 08 Jun 2009 11:20:18 +0100
Date:	Mon, 8 Jun 2009 11:20:18 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio
	support.
Message-ID: <20090608102018.GA6547@rakim.wolfsonmicro.main>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com> <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com> <20090608092521.GA7858@sirena.org.uk> <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
X-Cookie: Noone ever built a statue to a critic.
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Jun 08, 2009 at 11:43:41AM +0200, Manuel Lauss wrote:
> On Mon, Jun 8, 2009 at 11:25 AM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > If this is going to go in during the merge window I'm happy for it to go
> > in via the MIPS tree but otherwise I'd much rather it goes via ASoC in
> > case API changes cause merge issues.  I don't know what you prefer,
> > Ralf?

> I'd rather have it all go through the MIPS tree; this is the only patch of
> 7 which touches files outside it, and it depends on another one to
> apply cleanly.

Well, like I say if it's going via MIPS I'd really prefer it to go in
this merge window.  If not then I'd expect that splitting out the
architecture parts from the machine driver as I suggested ought to deal
with the merge issues.

> I'd actually love to move this file to the actual board code, however due
> to the way ASoC is organized this isn't at all possible.  This is one of two
> things I don't like about ASoC: the machine registration is extremely awkward

The main problem long term with trying to move it into the architecture
code is that the drivers for anything non-trivial get large enough to
qualify as actual drivers - add a jack or two in there, or some more
fancy clocking for example.  I also catch enough errors in the machine
drivers I'm reviewing that I'm a bit nervous about reducing the level of
review that they get.

At the minute the APIs are too fluid to make this realistic, anyway -
you'd just get constant merge issues.

> compared to other platform drivers. (the other being that ASoC doesn't
> support multiple machines [i.e. I could actually run both AC97 and I2S
> simultaneously one of my boards, as independent sound cards])

I've got a board sitting on my desk here which has multiple sound
systems.  Unfortunately the architecture code for it is a bit of a
shambles at this point so it's more trouble to work on the platform
than it's worth at the minute.

> >> +static struct resource psc1_res[] = {

> > If you conver the I2S driver to use the standard device probing model
> > this could all me moved into the architecture code rather than placed in
> > machine drivers.

> Again, I'd love to, but can't: the AC97/I2S/DBDMA drivers extract base address
> and DMA information from the platform device resource structure;  however
> I can't just copy the resource info from the this db1200_sound platform_driver
> to the soc_audio platform driver because the driver core complains about
> resource conflicts (two platform_devices sharing the same resources).
> Unless I missed a flag which needs to be passed to the resource.flags member?

If you move the selection of the switch position to the architecture
code then it can arrange to register only the device that is in use in
the current configuration.  If the DMA and DAI drivers both need the
same resources they can cooperate with each other - the system will only
bring the card on-line once both the DMA and DAI driver are present.

I'd not be too concerned about having the machine driver be able to flip
between the two at run time - it's unlikely to be a realistic concern
for anything except reference boards and even with those it's relatively
unlikely that anyone will be doing that on a regular basis.  The wins
for general users of the driver should cause an overall reduction in
pain.
