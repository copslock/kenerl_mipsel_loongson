Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 19:33:25 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:40788 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225272AbTC1TdY>;
	Fri, 28 Mar 2003 19:33:24 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 0A6396EE; Fri, 28 Mar 2003 20:33:22 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c 4/7 flush_cache_mm cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030328195953.A17890@linux-mips.org> (Ralf Baechle's message
 of "Fri, 28 Mar 2003 19:59:53 +0100")
References: <m2smt89ut8.fsf@neno.mitica>
	<Pine.GSO.3.96.1030328175039.26178B-100000@delta.ds2.pg.gda.pl>
	<20030328195953.A17890@linux-mips.org>
Date: Fri, 28 Mar 2003 20:33:22 +0100
Message-ID: <86smt79th9.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Fri, Mar 28, 2003 at 06:51:57PM +0100, Maciej W. Rozycki wrote:
>> > 	flush_cache_mm can use __flush_cache_all.
>> 
>> Wrong, it should use r4k_flush_pcache_all() unconditionally, but I'm told
>> such a setup triggers a bug somewhere, that needs to be tracked down
>> before committing that change to the CVS.

ralf> Now that the problem is mentioned on the list lemme elaborate a bit.  The
ralf> problem mentioned only affects R4000SC and R4400SC processors.
ralf> Flush_cache_mm is only used when a mm is either copied on fork or when
ralf> it's finally destroyed.  Because the S-cache is is physically indexed
ralf> and the P-cache is refilled from the S-cache if data should be still in
ralf> there we don't need to flush the S-cache ever for any of the mm's
ralf> cacheflushing functions.  So the observation that things are only
ralf> working properly if we do flush the S-cache also suggest we're either
ralf> having a bug elsewhere in the cache code or we're hitting a hardware
ralf> problem.

Ok, will took a look at that (casually my I2 has an R4400SC), but I
still think that patch can be applied.  It has the same behaviour than
actual code.  And it is a cleanup.  When we found the bug, we can do a
s/__flush_cache_all/r4k_flush_pcache_all/

on that function.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
