Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 16:12:11 +0000 (GMT)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:4574 "EHLO
	athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224921AbVBFQL4>; Sun, 6 Feb 2005 16:11:56 +0000
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j16GBsu16938;
	Sun, 6 Feb 2005 17:11:55 +0100 (MET)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sun, 6 Feb 2005 17:11:54 +0100 (MET)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j16GBrH20251;
	Sun, 6 Feb 2005 17:11:53 +0100 (MET)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sun, 6 Feb 2005 17:11:53 +0100 (MET)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: patch like kexec for MIPS possible?
In-Reply-To: <20050206155649.GA11452@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10502061710140.20130-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> > Yeah. And, speaking from experience, it is often caused by the hardware
> > entering such an invalid state that requires a hard reset anyway.

> I guess only the big iron fraction among us will really be missing
> something like kexec - firmware reinitialization may take minutes on that
> calibre of system so being able to get around that would be a good thing.

Well, a firmware reinitialization on my Octane (the old one) takes
minutes. Still, the kernel requires the hardware to be initalized by PROM
(just like on Origins, really) so kexec is of no help here.

Stanislaw
