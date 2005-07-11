Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 15:07:29 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:10713 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226463AbVGKOHN>; Mon, 11 Jul 2005 15:07:13 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6BE85S14079;
	Mon, 11 Jul 2005 16:08:06 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 11 Jul 2005 16:08:04 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6BE81Y23782;
	Mon, 11 Jul 2005 16:08:01 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Mon, 11 Jul 2005 16:08:00 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Origin 200 Status
In-Reply-To: <20050711135718.GU2765@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10507111605570.23550-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Of course there's a NIC.  The driver has no special handling for IP27 and
> is capable of reading the NICs on some machines at least.  That would be
> a rather suprising ability if there was no NIC associated with that IOC3 ;-)

There is only a MAC NIC on a machine ths has. Remember that the Octane
does not have the BaseIO NIC at the IOC3; both NICs placed there are
actually hacks because of XBOW MicroLAN bug.

> > This is weird. This means the keyboard will not be operational, and I wish
> > somebody (Ralf) looks into this. The IOC3 on IP27 BaseIO is a dual-slot
> > device (takes two IRQs, the INTA and INTA+2).
> All information that I have says only INTA is being used for IP27.  It
> will probably take a bit of testing.

Yeah, change the interrupt assignments in ioc3.c, plug in a keyboard and
try. If it works, everybody wins :)

Stanislaw
