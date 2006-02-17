Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 19:07:49 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:47881 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133379AbWBQTHi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 19:07:38 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2593864D59; Fri, 17 Feb 2006 19:14:16 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4A4638F77; Fri, 17 Feb 2006 19:14:06 +0000 (GMT)
Date:	Fri, 17 Feb 2006 19:14:06 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060217191406.GA19158@deprecation.cyrius.com>
References: <20060119192414.GA26798@deprecation.cyrius.com> <20060119210440.GE3398@linux-mips.org> <20060119214546.GB10040@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119214546.GB10040@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-01-19 21:45]:
> > scache flushing functions aren't getting initialized and the NULL
> > pointer is eventually called as a function.  So I suggest this below.
> > Can you test it?
> Doesn't work.

OK, I found the bug in your patch, fixed this and also added proper
type casting.  Tested patch below; please commit to git and push to
Linus since Cobalt support is completely broken without this patch.


From: Martin Michlmayr <tbm@cyrius.com>

[PATCH] Initialize scache flushing functions when CPU has no scache

When a CPU has no scache, the scache flushing functions currently
aren't getting initialized and the NULL pointer is eventually called
as a function.  Initialize the scache flushing functions as a noop
when there's no scache.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 c-r4k.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1b71d91..0668e9b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -235,7 +235,9 @@ static inline void r4k_blast_scache_page
 {
 	unsigned long sc_lsize = cpu_scache_line_size();
 
-	if (sc_lsize == 16)
+	if (scache_size == 0)
+		r4k_blast_scache_page = (void *)no_sc_noop;
+	else if (sc_lsize == 16)
 		r4k_blast_scache_page = blast_scache16_page;
 	else if (sc_lsize == 32)
 		r4k_blast_scache_page = blast_scache32_page;
@@ -251,7 +253,9 @@ static inline void r4k_blast_scache_page
 {
 	unsigned long sc_lsize = cpu_scache_line_size();
 
-	if (sc_lsize == 16)
+	if (scache_size == 0)
+		r4k_blast_scache_page_indexed = (void *)no_sc_noop;
+	else if (sc_lsize == 16)
 		r4k_blast_scache_page_indexed = blast_scache16_page_indexed;
 	else if (sc_lsize == 32)
 		r4k_blast_scache_page_indexed = blast_scache32_page_indexed;
@@ -267,7 +271,9 @@ static inline void r4k_blast_scache_setu
 {
 	unsigned long sc_lsize = cpu_scache_line_size();
 
-	if (sc_lsize == 16)
+	if (scache_size == 0)
+		r4k_blast_scache = (void *)no_sc_noop;
+	else if (sc_lsize == 16)
 		r4k_blast_scache = blast_scache16;
 	else if (sc_lsize == 32)
 		r4k_blast_scache = blast_scache32;
@@ -482,7 +488,7 @@ static inline void local_r4k_flush_icach
 			protected_blast_dcache_range(start, end);
 		}
 
-		if (!cpu_icache_snoops_remote_store) {
+		if (!cpu_icache_snoops_remote_store && scache_size) {
 			if (end - start > scache_size)
 				r4k_blast_scache();
 			else
@@ -651,7 +657,7 @@ static void local_r4k_flush_cache_sigtra
 
 	R4600_HIT_CACHEOP_WAR_IMPL;
 	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	if (!cpu_icache_snoops_remote_store)
+	if (!cpu_icache_snoops_remote_store && scache_size)
 		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 	if (MIPS4K_ICACHE_REFILL_WAR) {



-- 
Martin Michlmayr
http://www.cyrius.com/
