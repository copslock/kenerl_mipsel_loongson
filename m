Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Apr 2004 19:28:53 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:16776
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225463AbUDVS2u>; Thu, 22 Apr 2004 19:28:50 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3MISmN19091;
	Thu, 22 Apr 2004 20:28:48 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Thu, 22 Apr 2004 20:28:47 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3MISkQ27607;
	Thu, 22 Apr 2004 20:28:47 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Thu, 22 Apr 2004 20:28:46 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Alex Deucher <agd5f@yahoo.com>
cc: linux-mips@linux-mips.org
Subject: Re: few questions about linux on sgi machines
In-Reply-To: <20040422174916.42579.qmail@web11309.mail.yahoo.com>
Message-ID: <Pine.GSO.4.10.10404222022560.27253-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Also, out of curiosity, is there a list somewhere of all the asics in
> the Octane?  e.g., sound chip(s), ethernet, parallel/serial, etc.

Yes! (It depends what do you call an ASIC. I use it for a SGI-specific
chip with no docs at all.)

-- Base I/O --
HEART	memory controller, Xtalk bridge
IOC3	multi-I/O
RAD1	audio
BRIDGE	Xtalk-PCI bridge?
-- Frontplane --
XBOW	Xtalk router
-- PCI card cage (correct this) --
BRIDGE	Xtalk-PCI bridge
-- MardiGras (this is one big mystery) --
HQ4	Xtalk bridge
GE11	geometry engine
RE4	raster engine
PP1	?
VC3	video controller?
CMAP	colormap?

I'm writing this from memory, so correct me please.

Stanislaw Skowronek
