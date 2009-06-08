Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 12:26:10 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:43414 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023578AbZFHL0D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 12:26:03 +0100
Received: by bwz25 with SMTP id 25so2981410bwz.0
        for <multiple recipients>; Mon, 08 Jun 2009 04:25:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U3xyDqx+FH3Pa1IS5XGL8NTDmFAvAb09f5SnbOrf1W0=;
        b=Sc4QL6NDKO3bqzx7iAkepZb7GyjB8yWBfj6lHcCuTuWJuCL0fDpXFTJbRPPv9Qk05s
         e/acaYt42gb1oEAfr9n8eo7XcLh0ltMtGULlTUTInLOe09YT4bgpsrAkNFm3W+09gyt0
         R+I36/DANsbX2Pmcr9uzZdOQkhGMkW76SxIEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k+O3SfhNUuFy2OdQANsTu4EI1QpL3R4yYwo8mPZ8MgX2ecOk/rqGG6zrhWqSeGVi7Q
         DOObGUUBiaaCQHDhBySzN+3JbdCDsFkBJqZ3X88duFgnNCEt/BdwLoobsbx8gedojnYe
         BnylUzWPPQQP17X0ohv24XRclNgFdm1z+Z6hE=
MIME-Version: 1.0
Received: by 10.223.115.80 with SMTP id h16mr3888605faq.94.1244460357898; Mon, 
	08 Jun 2009 04:25:57 -0700 (PDT)
In-Reply-To: <20090608102018.GA6547@rakim.wolfsonmicro.main>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
Date:	Mon, 8 Jun 2009 13:25:57 +0200
Message-ID: <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Mark,

On Mon, Jun 8, 2009 at 12:20 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 08, 2009 at 11:43:41AM +0200, Manuel Lauss wrote:
>> On Mon, Jun 8, 2009 at 11:25 AM, Mark
>> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>
>> > If this is going to go in during the merge window I'm happy for it to go
>> > in via the MIPS tree but otherwise I'd much rather it goes via ASoC in
>> > case API changes cause merge issues.  I don't know what you prefer,
>> > Ralf?
>
>> I'd rather have it all go through the MIPS tree; this is the only patch of
>> 7 which touches files outside it, and it depends on another one to
>> apply cleanly.
>
> Well, like I say if it's going via MIPS I'd really prefer it to go in
> this merge window.  If not then I'd expect that splitting out the
> architecture parts from the machine driver as I suggested ought to deal
> with the merge issues.

I'll split it in two:  pure ASoC part and pure board part.  Agreed?


>> I'd actually love to move this file to the actual board code, however due
>> to the way ASoC is organized this isn't at all possible.  This is one of two
>> things I don't like about ASoC: the machine registration is extremely awkward
>> compared to other platform drivers. (the other being that ASoC doesn't
>> support multiple machines [i.e. I could actually run both AC97 and I2S
>> simultaneously one of my boards, as independent sound cards])
>
> I've got a board sitting on my desk here which has multiple sound
> systems.  Unfortunately the architecture code for it is a bit of a
> shambles at this point so it's more trouble to work on the platform
> than it's worth at the minute.

Alchemy's can have up to 4 PSCs with variable base addresses and variable
functions.  Currently, ASoC can't handle more than 1 AC97 codec (no idea
how to pass DAI private data to the ac97 callbacks), and I also don't see how
to handle for instance 2 I2S machines with a WM8731 attached to each
(i.e. how do I tell ASoC that wm8731 at bus0/0x1b belongs to machine A
 and wm8731 at bus0/0x1c belongs to machine B?)

This isn't a problem with the DB1200, as AC97 and I2S are connected to
the same PSC, but the DB1550 and DB1300 do have independent AC97 and
I2S.


>> >> +static struct resource psc1_res[] = {
>
>> > If you conver the I2S driver to use the standard device probing model
>> > this could all me moved into the architecture code rather than placed in
>> > machine drivers.
>
>> Again, I'd love to, but can't: the AC97/I2S/DBDMA drivers extract base address
>> and DMA information from the platform device resource structure;  however
>> I can't just copy the resource info from the this db1200_sound platform_driver
>> to the soc_audio platform driver because the driver core complains about
>> resource conflicts (two platform_devices sharing the same resources).
>> Unless I missed a flag which needs to be passed to the resource.flags member?
>
> If you move the selection of the switch position to the architecture
> code then it can arrange to register only the device that is in use in
> the current configuration.  If the DMA and DAI drivers both need the
> same resources they can cooperate with each other - the system will only
> bring the card on-line once both the DMA and DAI driver are present.

I think you misuderstood me.  Could you point out an in-kernel machine which
already implements what you suggested?

The AC97/I2S dai drivers (psc-ac97/psc-i2s) extract the base address of the PSC
they're supposed to drive from the platform_device passed via the probe()
callbacks, these in turn are called when a "soc_audio" platform device
is called.
I need to set either the ac97 or I2S platform data for soc_audio based on the
switch setting.  I can't register a "db1200_audio" platform device in the board
code which in turn registers the "soc_audio" device and have them share
the PSC mmio/irq/dma resources.

        Manuel Lauss
