Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:43:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:34535 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8226150AbTAJNnR>;
	Fri, 10 Jan 2003 13:43:17 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 06EA5D657; Fri, 10 Jan 2003 14:51:20 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
References: <Pine.GSO.3.96.1030110143030.23678F-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1030110143030.23678F-100000@delta.ds2.pg.gda.pl>
Date: 10 Jan 2003 14:51:20 +0100
Message-ID: <m2smw15d0n.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 10 Jan 2003, Juan Quintela wrote:
>> The only thing that could be controversial is the _l1() thing, and as
>> current thing is broken, I vote for insclusion.
>> 
maciej> diff -up --recursive --new-file linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c
maciej> --- linux-mips-2.4.20-pre6-20030107.macro/arch/mips64/mm/c-r4k.c	2002-12-20 03:56:52.000000000 +0000
maciej> +++ linux-mips-2.4.20-pre6-20030107/arch/mips64/mm/c-r4k.c	2003-01-09 23:21:39.000000000 +0000
>> @@ -979,7 +980,7 @@ static void r4k_dma_cache_wback_inv_sc(u
>> unsigned long end, a;
>> 
>> if (size >= scache_size) {
>> -		flush_cache_l1();
>> +		flush_cache_all();
>> return;
>> }
>> 
>> This one is fixing a bug, we are talking about a chip with Secondary
>> cache and don't touch the secondary cache at all :(

maciej> That bug is inactive -- both function pointers are defined to the same
maciej> value as surprisinly enough "l1" means "both caches" for the R4k.  Anyway,
maciej> I for removing flush_cache_l1() altogether in the next step. 

Yep, you are right, only 2 weeks since I looked at that file and
already forgot it.

Ralf, current code (as Maciej tolds), just have _l1 & _l2 variants,
but at least in that file, they are defined to be the same :(

I also vote to unify the mips & mips64 versions of that file, they are
the same :(

Maciej, in the other hand, you didn't coment in the other part, that
we writeback & invalidate when we are asked only to invalidate?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
