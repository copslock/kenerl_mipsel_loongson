Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MLNBt08596
	for linux-mips-outgoing; Sun, 22 Jul 2001 14:23:11 -0700
Received: from dea.waldorf-gmbh.de (u-133-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.133])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MLN8V08593
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 14:23:08 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6MLN1p13823;
	Sun, 22 Jul 2001 23:23:01 +0200
Date: Sun, 22 Jul 2001 23:23:01 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lars Munch Christensen <c948114@student.dtu.dk>
Cc: linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010722232301.B13551@bacchus.dhis.org>
References: <20010721112715.C2335@tuxedo.skovlyporten.dk> <20010721172309.A25467@bacchus.dhis.org> <20010721181733.A3591@tuxedo.skovlyporten.dk> <20010721210737.D25928@bacchus.dhis.org> <20010722113923.A17752@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010722113923.A17752@tuxedo.skovlyporten.dk>; from c948114@student.dtu.dk on Sun, Jul 22, 2001 at 11:39:23AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 22, 2001 at 11:39:23AM +0200, Lars Munch Christensen wrote:

> I'm working on a very small, single address space, microkernel and I have
> the MIPS Malta with a 5Kc CPU to develop it on. The 5Kc is compatible
> with mips32 but I must admit, I really like to have my kernel
> running 64bit :). Is there a working binutils for 64 bit code floating
> around somewhere or should I stick with the mips32 stuff?
> 
> I tried the binutil from ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/ but
> they where unable to compile with target mips64-linux.

Afaik the mips64-linux binutils are the only one that more (or more less ;)
work for building a 64-bit kernel.  What we have to do to get around the
bugs and missing features is building a 64-bit kernel but passing -32 to
the assembler so we never use 64-bit ELF.  In the end we convert the
resulting 32-bit ELF executable into 64-ELF using objcopy.  That's about
as much as 64-bit binutils are usable for.  For details see
arch/mips64/Makefile.

  Ralf
