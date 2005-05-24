Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 11:51:36 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:22249 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225205AbVEXKuo>; Tue, 24 May 2005 11:50:44 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4OAoce22132;
	Tue, 24 May 2005 12:50:39 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 24 May 2005 12:50:36 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4OAlQh25508;
	Tue, 24 May 2005 12:47:26 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 24 May 2005 12:47:26 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	Richard Sandiford <rsandifo@redhat.com>, linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10505241242020.25134-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> > It allows me to boot all Indys and O2s off the same binary. Nice for boot
> > CDs. Especially that Octanes and Origins should be bootable from another
> > one... just like IRIX.

>  Do they use a different load address so that you keep an "almost fully 
> linked" relocatable (i.e. with all objects already included, but still 
> done with "-r") and do the final link differently for each of them?

Yes, exactly.

> If this is the case you should be able to keep that "almost fully
> linked"  relocatable as ELF and then just do the final link using ELF
> and then `objcopy' to ECOFF.

I tried objcopy (it was my first thought), for one reason or another it
didn't work (internal BFD error something). Reportedly ECOFF is belly-up
in current GNU binutils - at least it is what I heard.

>  Trying to support GNU extensions in ECOFF is probably hopeless and not 
> worth the hassle and the file format is likely to be obsoleted by the 
> toolchain soon (if not already done), except from BFD -- which'll let you 
> continue doing `objcopy', `objdump', etc.

My input is elf32-tradbigmips. So I entirely don't care for binutils'
ECOFF anymore, and I consider this a good thing. As I said, objcopy didn't
work at all. Fixing BFD is not my job (it's a monster of Frankensteinian
proportions), I think that it is actually much easier to write my own
converter (well, I did it, and it works - except that funny HI/LO mismatch
I'm going to work around).

Stanislaw
