Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 17:42:25 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:15745 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225469AbTISQmX>; Fri, 19 Sep 2003 17:42:23 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA15739;
	Fri, 19 Sep 2003 18:42:12 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 18:42:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Eric Christopher <echristo@redhat.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
Message-ID: <Pine.GSO.3.96.1030919182314.9134K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2003, Eric Christopher wrote:

> >  I think "-mabi=64" is OK (I use it for over a year now) and for those
> > worried of every byte of precious memory, "-mabi=n32 -mlong64" might be
> > the right long-term answer (although it might require verifying if tools
> > handle it right).  Given the experimental state of the 64-bit kernel it
> > should be OK to be less forgiving on a requirement for recent tools. 
> 
> OK as in "it works for me", and OK as in "this is the correct usage" are

 Well, my "OK" is of both kinds. 8-) 

> two different things. I believe that for a 64-bit kernel either -mabi=64
> or -mabi=n32 (-mlong64) are the right long term answer, part of Daniel's
> problem was that his bootloader couldn't deal with ELF64.

 I've successfully converted ELF64 Linux images to o32 ELF32, with
`objcopy' and then to COFF even, with `elf2ecoff' (provided with the Linux
sources).  The resulting COFF image used to work with the DECstation's
firmware.  I suppose the intermediate ELF32 one would work with
ELF-capable firmware, too.  Of course I had to make sure the addresses
seen by the firmware in the file headers fit the 32-bit address space
(KSEG0, actually; KSEG1 might work, too). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
