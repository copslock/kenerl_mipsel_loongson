Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:25:51 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:27623 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8226137AbTAJNZv>;
	Fri, 10 Jan 2003 13:25:51 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 519BDD657; Fri, 10 Jan 2003 14:33:51 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
References: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>
Date: 10 Jan 2003 14:33:51 +0100
Message-ID: <m24r8h6se8.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


I agree with the cleanup.

The only thing that could be controversial is the _l1() thing, and as
current thing is broken, I vote for insclusion.

maciej> diff -up --recursive --new-file linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c
maciej> --- linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c	2002-12-20 03:56:52.000000000 +0000
maciej> +++ linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c	2003-01-09 23:21:39.000000000 +0000
@@ -979,7 +980,7 @@ static void r4k_dma_cache_wback_inv_sc(u
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}

This one is fixing a bug, we are talking about a chip with Secondary
cache and don't touch the secondary cache at all :(

Later, Juan. 

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
