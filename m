Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:35:12 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225327AbSLWLec>; Mon, 23 Dec 2002 11:34:32 +0000
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:32394 "EHLO
	demo.mitica") by ralf.linux-mips.org with ESMTP id <S868812AbSLUUEM>;
	Sat, 21 Dec 2002 21:04:12 +0100
Received: by demo.mitica (Postfix, from userid 501)
	id 957B8D657; Sat, 21 Dec 2002 21:07:18 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
References: <Pine.GSO.3.96.1021221194520.7158B-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021221194520.7158B-100000@delta.ds2.pg.gda.pl>
Date: 21 Dec 2002 21:07:18 +0100
Message-ID: <m2lm2jdtl5.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 20 Dec 2002, Juan Quintela wrote:
ralf> Applied slightly modified.  I removed two other unused targets.
>> 
>> Please, add that back, and things will indeed compile :)

maciej> Ralf did that right -- it's annoying to have the COFF image for mips64
maciej> built in the mips tree.  Unlike the intermediate object files, this target
maciej> is visible to a non-developer.  But a few bits are missing, indeed.  How
maciej> about the following patch?  It's a trivial modification of what I use for
maciej> about half a year now.

BTW, are you using mips64 in a r4k? If so, do you need any additional
patches?

I am having some memory corruption :(


maciej> -- 
maciej> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
maciej> +--------------------------------------------------------------+
maciej> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

maciej> patch-mips-2.4.20-pre6-20021220-mips64-ecoff-0
maciej> diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021220.macro/arch/mips64/boot/Makefile linux-mips-2.4.20-pre6-20021220/arch/mips64/boot/Makefile
maciej> --- linux-mips-2.4.20-pre6-20021220.macro/arch/mips64/boot/Makefile	2002-06-26 03:04:47.000000000 +0000
maciej> +++ linux-mips-2.4.20-pre6-20021220/arch/mips64/boot/Makefile	2002-12-21 14:23:32.000000000 +0000
maciej> @@ -22,11 +22,11 @@ all: vmlinux.ecoff addinitrd
maciej> vmlinux.ecoff:	$(CONFIGURE) elf2ecoff $(TOPDIR)/vmlinux
maciej> ./elf2ecoff $(TOPDIR)/vmlinux vmlinux.ecoff $(E2EFLAGS)
 
maciej> -elf2ecoff: elf2ecoff.c
maciej> -	$(HOSTCC) -o $@ $^
maciej> +elf2ecoff: $(TOPDIR)/arch/mips/boot/elf2ecoff.c
maciej> +	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
maciej> -addinitrd: addinitrd.c
maciej> -	$(HOSTCC) -o $@ $^
maciej> +addinitrd: $(TOPDIR)/arch/mips/boot/addinitrd.c
maciej> +	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
maciej> # Don't build dependencies, this may die if $(CC) isn't gcc
maciej> dep:

It is better than mine.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
