Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 17:36:49 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:40189 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226401AbVGIQga>; Sat, 9 Jul 2005 17:36:30 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j69GbBS25358;
	Sat, 9 Jul 2005 18:37:12 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 9 Jul 2005 18:37:10 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j69Gb8o25243;
	Sat, 9 Jul 2005 18:37:08 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sat, 9 Jul 2005 18:37:08 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Current SGI Octane status
In-Reply-To: <20050709093403.GB1586@hattusa.textio>
Message-ID: <Pine.GSO.4.10.10507091833390.24862-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> - IOC3 networking works, with 2MB/s maximum for a 30MB http transfer

This is strange. Ask Ralf.

> - Serial console works, but start of output is delayed. The driver
>   probably lacks transfer bootstrap, and starts transmisssion only when
>   the first buffer is full.

Yuck. What should be done about it?

> - Rebooting for SMP works, but this patch apparently broke arcload (hangs
>   after "Entering Kernel").

This was an unrelated problem, fixed.

> - Serial console and framebuffer initializations seem to be mutually
>   exclusive, that's impractical if you plan to route console (debug)
>   output over serial while working on the graphics console.

Heh, I work on the graphics console using the graphics console. It's more
funny.

> - 'echo "foo" >/dev/fb0' kills the machine.

Oops.

I return -EINVAL in read and write on ImpactSR. Sick. Do you know where it
fails, exactly?

Stanislaw
