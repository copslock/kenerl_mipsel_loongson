Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:14:31 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:26007
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225951AbUDXIOR>; Sat, 24 Apr 2004 09:14:17 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O8EFN12964;
	Sat, 24 Apr 2004 10:14:16 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 10:14:15 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O8EDl15963;
	Sat, 24 Apr 2004 10:14:13 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 10:14:13 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <Pine.LNX.4.55.0404240959200.14494@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10404241008530.15622-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

>  Well, the exception arrangement requires RAM starting from the physical
> address 0.  It seems natural to place RAM just there, avoiding additional
> complexity to address decoders.  But then firmware has to be somewere
> around 0x1fc00000, so to support more than 508MB of RAM the designers
> would have to create a hole in RAM, which would have to be handled by the
> OS then.  Thus abandoning the idea of putting RAM low, placing it
> somewhere above 0x1fffffff and just mapping some of it at 0 for the
> exceptions seems a better solution.

OK, I forgot about the firmware placement. Why didn't they move it to
somewhere else when booting 64-bit? (A rhetorical question, I know.)

I would place some fixed code there. Or a different memory, maybe 16 kB of
static RAM so it will always be fast. With what is now, we have physical
and virtual aliasing and it's all a bit like a 

> Fortunately everything is not a PC. :-)

Yes, fortunately. The 386 memory management is a joke. The BIOS in the
middle is an even darker joke. Well, in my opinion the R8000 was right in
not having compatibility segments.

Stanislaw
