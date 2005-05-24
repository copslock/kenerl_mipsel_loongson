Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 15:50:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:8 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225264AbVEXOu0>; Tue, 24 May 2005 15:50:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5CA00F59AA; Tue, 24 May 2005 16:50:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20061-07; Tue, 24 May 2005 16:50:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6E24EF599A; Tue, 24 May 2005 16:50:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4OEo7bD026969;
	Tue, 24 May 2005 16:50:07 +0200
Date:	Tue, 24 May 2005 15:50:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <20050524142245.GG4383@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0505241548330.13738@blysk.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl>
 <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
 <20050524142245.GG4383@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/893/Tue May 24 08:27:20 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 May 2005, Ralf Baechle wrote:

> >  Do they use a different load address so that you keep an "almost fully 
> > linked" relocatable (i.e. with all objects already included, but still 
> > done with "-r") and do the final link differently for each of them?  If 
> > this is the case you should be able to keep that "almost fully linked" 
> > relocatable as ELF and then just do the final link using ELF and then 
> > `objcopy' to ECOFF.  That should work for most of the cases, although I've 
> > seen problems with firmware not recognizing MIPS III ECOFF binaries 
> > expecting a MIPS I one instead.  AFAIK, `objcopy' doesn't allow you to 
> > force a different magic number upon a conversion -- this is probably the 
> > last reason `elf2ecoff' hasn't been removed from the Linux tree yet (and 
> > you can use the tool indeed if you hit this problem).
> 
> The kernel ELF binary is too complicated for objcopy to cope with.  Fixing
> objcopy to handle this case correctly turned out to be hopeless but with
> a little linker script magic it's possible to keep the kernel vmlinux file
> within what elf2ecoff can deal with.

 Well, it used to work for me the few times I tried, except from that MIPS 
III magic number problem.  But that's not a binutils' fault.

  Maciej
