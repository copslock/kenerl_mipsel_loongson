Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 11:41:41 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10249 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbVEXKlZ>; Tue, 24 May 2005 11:41:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EB3BDF5998; Tue, 24 May 2005 12:41:15 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30746-02; Tue, 24 May 2005 12:41:15 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9212CF5997; Tue, 24 May 2005 12:41:15 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4OAemYW016137;
	Tue, 24 May 2005 12:40:48 +0200
Date:	Tue, 24 May 2005 11:40:53 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	Richard Sandiford <rsandifo@redhat.com>, linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/892/Mon May 23 19:52:19 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 May 2005, Stanislaw Skowronek wrote:

> > Sorry if this is a dumb question, but why do you need to generate
> > _relocatable_ ECOFF?
> 
> It allows me to boot all Indys and O2s off the same binary. Nice for boot
> CDs. Especially that Octanes and Origins should be bootable from another
> one... just like IRIX.

 Do they use a different load address so that you keep an "almost fully 
linked" relocatable (i.e. with all objects already included, but still 
done with "-r") and do the final link differently for each of them?  If 
this is the case you should be able to keep that "almost fully linked" 
relocatable as ELF and then just do the final link using ELF and then 
`objcopy' to ECOFF.  That should work for most of the cases, although I've 
seen problems with firmware not recognizing MIPS III ECOFF binaries 
expecting a MIPS I one instead.  AFAIK, `objcopy' doesn't allow you to 
force a different magic number upon a conversion -- this is probably the 
last reason `elf2ecoff' hasn't been removed from the Linux tree yet (and 
you can use the tool indeed if you hit this problem).

 Trying to support GNU extensions in ECOFF is probably hopeless and not 
worth the hassle and the file format is likely to be obsoleted by the 
toolchain soon (if not already done), except from BFD -- which'll let you 
continue doing `objcopy', `objdump', etc.

  Maciej
