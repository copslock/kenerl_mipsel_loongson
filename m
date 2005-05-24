Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 15:23:37 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:3598 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225256AbVEXOXW>; Tue, 24 May 2005 15:23:22 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4OEMken015970;
	Tue, 24 May 2005 15:22:46 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4OEMj44015969;
	Tue, 24 May 2005 15:22:45 +0100
Date:	Tue, 24 May 2005 15:22:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
Message-ID: <20050524142245.GG4383@linux-mips.org>
References: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl> <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 24, 2005 at 11:40:53AM +0100, Maciej W. Rozycki wrote:

> 
>  Do they use a different load address so that you keep an "almost fully 
> linked" relocatable (i.e. with all objects already included, but still 
> done with "-r") and do the final link differently for each of them?  If 
> this is the case you should be able to keep that "almost fully linked" 
> relocatable as ELF and then just do the final link using ELF and then 
> `objcopy' to ECOFF.  That should work for most of the cases, although I've 
> seen problems with firmware not recognizing MIPS III ECOFF binaries 
> expecting a MIPS I one instead.  AFAIK, `objcopy' doesn't allow you to 
> force a different magic number upon a conversion -- this is probably the 
> last reason `elf2ecoff' hasn't been removed from the Linux tree yet (and 
> you can use the tool indeed if you hit this problem).

The kernel ELF binary is too complicated for objcopy to cope with.  Fixing
objcopy to handle this case correctly turned out to be hopeless but with
a little linker script magic it's possible to keep the kernel vmlinux file
within what elf2ecoff can deal with.

>  Trying to support GNU extensions in ECOFF is probably hopeless and not 
> worth the hassle and the file format is likely to be obsoleted by the 
> toolchain soon (if not already done), except from BFD -- which'll let you 
> continue doing `objcopy', `objdump', etc.

If anything a real ECOFF toolchain would be needed.  Teaching ECOFF about
all the ELF magic like complex handling of certain magic symbols etc. is
a waste of time ...

  Ralf
