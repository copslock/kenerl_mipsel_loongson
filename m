Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 14:06:28 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:25248
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225360AbTJBNGZ>; Thu, 2 Oct 2003 14:06:25 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA16750;
	Thu, 2 Oct 2003 09:06:12 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA08506;
	Thu, 2 Oct 2003 09:06:12 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 2 Oct 2003 09:06:12 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: jeff <jeff_lee@coventive.com>
cc: linux-mips@linux-mips.org
Subject: Re: sound drivers
In-Reply-To: <032601c38888$67cf6240$c117a8c0@jefflee>
Message-ID: <Pine.GSO.4.44.0310020901500.8498-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I just beginning to develop drivers for our SOC that includes a 5kf and
our own custom dsp for audio playback. The target market is the settop. Am
I correct in thinking that all audio drivers (mpeg,mp3,pcm) should be
integrated with ALSA? When you say "still can't work" are you getting it
compile with the linux-mips.org sources or something else?
Thanks,
David

On Thu, 2 Oct 2003, jeff wrote:

> What CPU are you using ?
> We are under development about ALSA on VR4181A but still can't work.
> Only playback is OK. Capture is failed.
>
> Regards,
>
> Jeff
> ----- Original Message -----
> From: "David Kesselring" <dkesselr@mmc.atmel.com>
> To: <linux-mips@linux-mips.org>
> Sent: Wednesday, October 01, 2003 11:27 PM
> Subject: sound drivers
>
>
> > Has anyone used alsa on mips? I need to impement a sound driver for our
> > dsp. It seems like all sound drivers should be developed for alsa. Is that
> > true? I've tried to build alsa and its' drivers but ran into a cross
> > compile problem.
> > Thanks,
> >
> > David Kesselring
> >
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
