Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:28:43 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:30183 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8226140AbTAJN2m>;
	Fri, 10 Jan 2003 13:28:42 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 016BBD657; Fri, 10 Jan 2003 14:36:45 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
References: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>
	<20030110140326.B7699@linux-mips.org>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030110140326.B7699@linux-mips.org>
Date: 10 Jan 2003 14:36:45 +0100
Message-ID: <m21y3l6s9e.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Fri, Jan 10, 2003 at 01:37:12PM +0100, Maciej W. Rozycki wrote:
>> I can't see any need for flush_cache_l1() and flush_cache_l2().  I'd like
>> to remove them.  A single flush_cache_all() seems sufficient for our
>> needs.  Any objections? 

ralf> The reason for the existance of flush_cache_l1 and flush_cache_l2 is the
ralf> Origin.  An empty flush_cache_all() is sufficient on the Origin because
ralf> it's R10000 processor doesn't suffer from cache aliases.  During bootup
ralf> we have to flush all caches or the cache coherence logic will send crazy
ralf> exceptions at us.  For all other occasions just a flush of the primary
ralf> caches is sufficient which is why there is flush_cache_l1.

ralf> So I think we want to wrap things a bit nicer but basically we have to
ralf> keep those cacheops for the sake of the Origin.

Humm, I thought that there wasn't origins with R4400 processors :)

Anyways, I think that the change is the good direction, at least:
- unsigned int flags -> unsigned long flags
  && under proper #ifdefs

and the mips64 port just now should work only in R4400MC & R4400PC (to me
knowlegge the most unusual ones), and broke in the R4400SC :(


Once talking about caches, why do we _allways_ do the writeback,
indeed if they asked us to do a invalidate?

Something like that?

Later, Juan.

Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.1.2.11
diff -u -r1.1.2.11 c-r4k.c
--- arch/mips64/mm/c-r4k.c	8 Jan 2003 14:16:31 -0000	1.1.2.11
+++ arch/mips64/mm/c-r4k.c	9 Jan 2003 23:16:41 -0000
@@ -979,7 +979,7 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}
 
@@ -1010,7 +1010,7 @@
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			invalidate_dcache_line(a); /* Hit_Invalidate_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -1027,14 +1027,14 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_l1();
+		flush_cache_all();
 		return;
 	}
 
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size - 1) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
+		invalidate_scache_line(a); /* Hit_Invalidate_SD */
 		if (a == end) break;
 		a += sc_lsize;
 	}
 




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
