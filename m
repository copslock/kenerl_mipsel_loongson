Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:34:59 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:4757 "EHLO
	europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225397AbUDXHe6>; Sat, 24 Apr 2004 08:34:58 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7YuN12599;
	Sat, 24 Apr 2004 09:34:57 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 09:34:56 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7YtN13820;
	Sat, 24 Apr 2004 09:34:55 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 09:34:55 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <Pine.LNX.4.55.0404240855580.14494@jurand.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10404240931500.13336-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

>  I know.  I build using (n)64 consistently for two years successfully --
> it's OK even with gcc 2.95.x.  Making a choice between the ABIs for gas
> user-selectable is on my to-do list for some time.  For now I think `make
> gas-abi=64 ...' is probably the easiest workaround, though you'll need to
> objcopy the resulting image to a 32-bit ELF file manually if your firmware
> or loader cannot cope with 64-bit ELF binaries.  Well, I don't like the
> automatic copy anyway -- it wastes too much disk space in the long run;
> perhaps as a compromise it should be user-selectable, too (ditto about
> SREC).

True, the kernel is *huge* (some 7 MB). But there *will* be pointer crops
if I'm using the xkphys, and I can't use ckseg0 because there are only 16
kilobytes of RAM mapped there for exceptions. So I have to use abi=64. It
does work for me, anyway.

I think it really should be a config option. Even if not actually
user-selectable (why should it be?), it should default to 'y' for Octanes
and 'n' for everything else :)

Thank you for all your explanations. My idea about modules was because I
noticed some int->ptr conversion warnings I don't like at all.

Stanislaw Skowronek
