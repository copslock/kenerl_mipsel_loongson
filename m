Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 15:53:32 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:21466
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225619AbUEJOx3>; Mon, 10 May 2004 15:53:29 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AErOg06489;
	Mon, 10 May 2004 16:53:24 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 10 May 2004 16:53:24 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AErN922358;
	Mon, 10 May 2004 16:53:23 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Mon, 10 May 2004 16:53:23 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Emmanuel Michon <em@realmagic.fr>
cc: linux-mips@linux-mips.org
Subject: Re: new platform
In-Reply-To: <1084199090.12536.1314.camel@avalon.france.sdesigns.com>
Message-ID: <Pine.GSO.4.10.10405101648140.21907-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Q2- Most hardware platforms have their SDRAM chips mapped at
> physical address 0x0. Mine does not. Am I going ahead of problems?
> It seems to be assumed at a lot of places (I have already ported YAMON).

I have run into very few problems of the sort on the Octane, which has all
its memory just over CKSEG0. Most, if not all, of them would be gone if
the Octane had anything at all in CKSEG0, not counting exception vectors
(that reminds me, how do you handle exceptions? Linux assumes you *DO*
have some writeable space at CKSEG0, at least a kilobyte - all exception
handlers are copied there at runtime).

You will have to change the kernel link address to the beginning of your
physical RAM (or any other place you like, as long as it is under 512MB).
It is easily done and I don't think it will cause any problems.

Stanislaw Skowronek
