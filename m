Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jul 2005 07:13:31 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:46747
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226229AbVGJGNP>; Sun, 10 Jul 2005 07:13:15 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6A6DwT27493;
	Sun, 10 Jul 2005 08:13:58 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sun, 10 Jul 2005 08:13:57 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6A6Dvx07147;
	Sun, 10 Jul 2005 08:13:57 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sun, 10 Jul 2005 08:13:56 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Origin 200 Status
In-Reply-To: <20050709205406.GF1586@hattusa.textio>
Message-ID: <Pine.GSO.4.10.10507100808410.6614-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> [4294678.019000] IOC3 part: [], serial: [] => class IP27 BaseIO

This is not really weird, the IOC3 on the IP27 board has no NICs. We'd
have to trace the BRIDGE NICs or even HUB NICs to get the serials, so I
decided that it's an overkill. Although it will be required for reliably
detecting MENET (which has a serial# NIC on the BRIDGE).

> [4294678.020000] ioc3_probe : request_irq fails for IRQ 0x4

This is weird. This means the keyboard will not be operational, and I wish
somebody (Ralf) looks into this. The IOC3 on IP27 BaseIO is a dual-slot
device (takes two IRQs, the INTA and INTA+2).

> [4294678.020000]  ttyS0 at IOC3 0x8620178 (irq = 0) is a 16550A
> [4294678.027000] ttyS1 at IOC3 0x8620170 (irq = 0) is a 16550A

Serial ports will not use IRQs on IP27 unless somebody does dynirqs for
this arch. Nevertheless, if you pass 0 to register_serial() it will use
polling. Note that this is exactly the way IP27 always handled the serial
ports in ioc3-eth.c, so shed no tears :)

> [4294678.033000] Ethernet address is 08:00:69:0d:52:e7.

Good news this works. Anyone with Origin 2000 that had problems with MAC
NICs care to test?

Stanislaw
