Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 14:44:13 +0100 (BST)
Received: from 202-145-53-89.adsl.ttn.net ([IPv6:::ffff:202.145.53.89]:4759
	"EHLO miao.coventive.com") by linux-mips.org with ESMTP
	id <S8225360AbTJBNoJ>; Thu, 2 Oct 2003 14:44:09 +0100
Received: from jefflee (PC193.ia.kh.coventive.com [192.168.23.193] (may be forged))
	by miao.coventive.com (8.11.6/8.11.6) with SMTP id h92Dhc710254;
	Thu, 2 Oct 2003 21:43:38 +0800
Message-ID: <04a701c388ec$10b9b050$c117a8c0@jefflee>
From: "jeff" <jeff_lee@coventive.com>
To: "David Kesselring" <dkesselr@mmc.atmel.com>
Cc: <linux-mips@linux-mips.org>
References: <Pine.GSO.4.44.0310020901500.8498-100000@ares.mmc.atmel.com>
Subject: Re: sound drivers
Date: Thu, 2 Oct 2003 21:49:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <jeff_lee@coventive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff_lee@coventive.com
Precedence: bulk
X-list: linux-mips

In here, we can use madplay to play MP3, vplay to run WAV file, etc.
Yes, we get the kernel source from linux-mips.org but we porting the ALSA
driver base on many others code. For example, we will refer the VIA
, StrongARM, ESS.... source code and combine to VR4181A ALSA
driver. BUT..... Capture still can't work :-(

Regards,

Jeff
----- Original Message ----- 
From: "David Kesselring" <dkesselr@mmc.atmel.com>
To: "jeff" <jeff_lee@coventive.com>
Cc: <linux-mips@linux-mips.org>
Sent: Thursday, October 02, 2003 9:06 PM
Subject: Re: sound drivers


> I just beginning to develop drivers for our SOC that includes a 5kf and
> our own custom dsp for audio playback. The target market is the settop. Am
> I correct in thinking that all audio drivers (mpeg,mp3,pcm) should be
> integrated with ALSA? When you say "still can't work" are you getting it
> compile with the linux-mips.org sources or something else?
> Thanks,
> David
>
> On Thu, 2 Oct 2003, jeff wrote:
>
> > What CPU are you using ?
> > We are under development about ALSA on VR4181A but still can't work.
> > Only playback is OK. Capture is failed.
> >
> > Regards,
> >
> > Jeff
> > ----- Original Message -----
> > From: "David Kesselring" <dkesselr@mmc.atmel.com>
> > To: <linux-mips@linux-mips.org>
> > Sent: Wednesday, October 01, 2003 11:27 PM
> > Subject: sound drivers
> >
> >
> > > Has anyone used alsa on mips? I need to impement a sound driver for
our
> > > dsp. It seems like all sound drivers should be developed for alsa. Is
that
> > > true? I've tried to build alsa and its' drivers but ran into a cross
> > > compile problem.
> > > Thanks,
> > >
> > > David Kesselring
> > >
> >
> >
>
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
>
