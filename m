Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 02:50:36 +0100 (BST)
Received: from 202-145-53-89.adsl.ttn.net ([IPv6:::ffff:202.145.53.89]:17558
	"EHLO miao.coventive.com") by linux-mips.org with ESMTP
	id <S8225430AbTJBBue>; Thu, 2 Oct 2003 02:50:34 +0100
Received: from jefflee (PC193.ia.kh.coventive.com [192.168.23.193] (may be forged))
	by miao.coventive.com (8.11.6/8.11.6) with SMTP id h921oD709379;
	Thu, 2 Oct 2003 09:50:14 +0800
Message-ID: <032601c38888$67cf6240$c117a8c0@jefflee>
From: "jeff" <jeff_lee@coventive.com>
To: "David Kesselring" <dkesselr@mmc.atmel.com>,
	<linux-mips@linux-mips.org>
References: <Pine.GSO.4.44.0310011123390.7534-100000@hydra.mmc.atmel.com>
Subject: Re: sound drivers
Date: Thu, 2 Oct 2003 09:56:31 +0800
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
X-archive-position: 3354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff_lee@coventive.com
Precedence: bulk
X-list: linux-mips

What CPU are you using ?
We are under development about ALSA on VR4181A but still can't work.
Only playback is OK. Capture is failed.

Regards,

Jeff
----- Original Message ----- 
From: "David Kesselring" <dkesselr@mmc.atmel.com>
To: <linux-mips@linux-mips.org>
Sent: Wednesday, October 01, 2003 11:27 PM
Subject: sound drivers


> Has anyone used alsa on mips? I need to impement a sound driver for our
> dsp. It seems like all sound drivers should be developed for alsa. Is that
> true? I've tried to build alsa and its' drivers but ran into a cross
> compile problem.
> Thanks,
>
> David Kesselring
>
