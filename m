Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 16:01:02 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:18187 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225271AbVEXPAo>; Tue, 24 May 2005 16:00:44 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4OF08cH016983;
	Tue, 24 May 2005 16:00:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4OF08YG016982;
	Tue, 24 May 2005 16:00:08 +0100
Date:	Tue, 24 May 2005 16:00:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
Message-ID: <20050524150008.GC13850@linux-mips.org>
References: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl> <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl> <20050524142245.GG4383@linux-mips.org> <Pine.LNX.4.61L.0505241548330.13738@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0505241548330.13738@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 24, 2005 at 03:50:16PM +0100, Maciej W. Rozycki wrote:

> > The kernel ELF binary is too complicated for objcopy to cope with.  Fixing
> > objcopy to handle this case correctly turned out to be hopeless but with
> > a little linker script magic it's possible to keep the kernel vmlinux file
> > within what elf2ecoff can deal with.
> 
>  Well, it used to work for me the few times I tried, except from that MIPS 
> III magic number problem.  But that's not a binutils' fault.

That's because you haven't booted 2.6 on DECstations yet ;-)  I'm sure
you'll have some elf2ecoff fun ...

  Ralf
