Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:33:00 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30925 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226146AbTAJNc7>; Fri, 10 Jan 2003 13:32:59 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA25532;
	Fri, 10 Jan 2003 14:33:05 +0100 (MET)
Date: Fri, 10 Jan 2003 14:33:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
In-Reply-To: <m24r8h6se8.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1030110143030.23678F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 10 Jan 2003, Juan Quintela wrote:

> The only thing that could be controversial is the _l1() thing, and as
> current thing is broken, I vote for insclusion.
> 
> maciej> diff -up --recursive --new-file linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c
> maciej> --- linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c	2002-12-20 03:56:52.000000000 +0000
> maciej> +++ linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c	2003-01-09 23:21:39.000000000 +0000
> @@ -979,7 +980,7 @@ static void r4k_dma_cache_wback_inv_sc(u
>  	unsigned long end, a;
>  
>  	if (size >= scache_size) {
> -		flush_cache_l1();
> +		flush_cache_all();
>  		return;
>  	}
> 
> This one is fixing a bug, we are talking about a chip with Secondary
> cache and don't touch the secondary cache at all :(

 That bug is inactive -- both function pointers are defined to the same
value as surprisinly enough "l1" means "both caches" for the R4k.  Anyway,
I for removing flush_cache_l1() altogether in the next step. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
