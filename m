Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 09:06:43 +0000 (GMT)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:54775
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224929AbVCUJG2>; Mon, 21 Mar 2005 09:06:28 +0000
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j2L96Ql04130;
	Mon, 21 Mar 2005 10:06:26 +0100 (MET)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 21 Mar 2005 10:06:26 +0100 (MET)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j2L96KC17596;
	Mon, 21 Mar 2005 10:06:20 +0100 (MET)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Mon, 21 Mar 2005 10:06:20 +0100 (MET)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Michael Stickel <michael@cubic.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
In-Reply-To: <423E7B9D.3040908@cubic.org>
Message-ID: <Pine.GSO.4.10.10503211005420.17488-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Most of the difference seems to be the PCI stuff, that has been removed 
> and the access method.
> Shouldn't we have a driver for the chip and one driver for each access 
> method (isa,pci,...).

Right! I'm entirely with you. SGI Octane required hacks to the 8250 driver
just to get a new access method.

Stanislaw
