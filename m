Received:  by oss.sgi.com id <S553818AbRAPQGF>;
	Tue, 16 Jan 2001 08:06:05 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:26583 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553803AbRAPQFv>;
	Tue, 16 Jan 2001 08:05:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA16883;
	Tue, 16 Jan 2001 17:01:16 +0100 (MET)
Date:   Tue, 16 Jan 2001 17:01:15 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116153618.A1347@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010116162557.5546J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Florian Lohoff wrote:

> diff -u -r1.17 memory.c
> --- arch/mips/arc/memory.c	2001/01/03 18:15:24	1.17
> +++ arch/mips/arc/memory.c	2001/01/16 13:53:45
> @@ -120,7 +120,7 @@
>  		unsigned long base, size;
>  		long type;
>  
> -		base = __pa(p->base << PAGE_SHIFT);	/* Fix up from KSEG0 */
> +		base = p->base << PAGE_SHIFT;
>  		size = p->pages << PAGE_SHIFT;
>  		type = prom_memtype_classify(p->type);

 That's about the correct fix.

> start_kernel, 541
> start_kernel, 543
> Calibrating system timer... 1250000 [250.00 MHz CPU]
> Got a bus error IRQ, shouldn't happen yet
> $0 : 00000000 1004fc00 00000001 00000000
> $4 : 88009cd8 00000000 00000008 00000000
> $8 : 1004fc01 1000001f 0000000a 00000001
> $12: 00000000 00000004 00000000 00000001
> $16: 00000000 00000002 0000000a 880083d8
> $20: 00000001 a8746f70 9fc5c2b4 00000000
> $24: 00002590 00000001
> $28: 88008000 88009cd8 00000001 88010118
> epc   : 880127b0
> Status: 1004fc03
> Cause : 10004000
> Status: 1004fc03
> Cause : 10004000
> Cause : 10004000
> Spinning...

 It looks like an unoccupied location access in mem_init().  Weird.  Here
is a preliminary patch that fixes a few memory map problems I discovered
till far.  It incorporates a fix like yours as well as a few others.  It
won't fix the above crash, I'm afraid.  It was not sufficiently tested,
either.  I'll prepare a few debugging changes to mem_init() so we can
track the fatal access down.

 Meanwhile, could you please try to boot with "mem=0x07800000@0x08800000"
command line option?  This will show if the non-contiguous memory is the
problem or not -- you have a relatively small block at the beginning.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
