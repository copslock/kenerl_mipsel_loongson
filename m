Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 15:17:50 +0000 (GMT)
Received: from p549F7826.dip.t-dialin.net ([84.159.120.38]:16757 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATPRU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 15:17:20 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id k0KFJwic001153;
	Fri, 20 Jan 2006 16:19:58 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id k0KFJwGM001152;
	Fri, 20 Jan 2006 16:19:58 +0100
Date:	Fri, 20 Jan 2006 16:19:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060120151958.GC30415@linux-mips.org>
References: <20060119192414.GA26798@deprecation.cyrius.com> <20060119210440.GE3398@linux-mips.org> <20060119214546.GB10040@deprecation.cyrius.com> <20060120150126.GB30415@linux-mips.org> <20060120151005.GH4343@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120151005.GH4343@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 03:10:05PM +0000, Martin Michlmayr wrote:

> * Ralf Baechle <ralf@linux-mips.org> [2006-01-20 16:01]:
> > > > pointer is eventually called as a function.  So I suggest this below.
> > > > Can you test it?
> > > Doesn't work.
> > Indeed - for quite obvioius reasons even.  I hope I now covered all cases
> > in the new patch below.
> 
> You attached the SERIO patch. ;-)

Just checking your attention ;-)

  Ralf

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 422b55f..614dceb 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -235,7 +235,9 @@ static inline void r4k_blast_scache_page
 {
 	unsigned long sc_lsize = cpu_scache_line_size();
 
-	if (sc_lsize == 16)
+	if (scache_size == 0)
+		r4k_blast_scache_page = no_sc_noop;
+	else if (sc_lsize == 16)
 		r4k_blast_scache_page = blast_scache16_page;
 	else if (sc_lsize == 32)
 		r4k_blast_scache_page = blast_scache32_page;
@@ -251,7 +253,9 @@ static inline void r4k_blast_scache_page
 {
 	unsigned long sc_lsize = cpu_scache_line_size();
 
-	if (sc_lsize == 16)
+	if (scache_size == 0)
+		r4k_blast_scache_page = no_sc_noop;
+	else if (sc_lsize == 16)
 		r4k_blast_scache_page_indexed = blast_scache16_page_indexed;
 	else if (sc_lsize == 32)
 		r4k_blast_scache_page_indexed = blast_scache32_page_indexed;
@@ -495,7 +499,7 @@ static inline void local_r4k_flush_icach
 			}
 		}
 
-		if (!cpu_icache_snoops_remote_store) {
+		if (!cpu_icache_snoops_remote_store && scache_size) {
 			if (end - start > scache_size) {
 				r4k_blast_scache();
 			} else {
@@ -728,7 +732,7 @@ static void local_r4k_flush_cache_sigtra
 
 	R4600_HIT_CACHEOP_WAR_IMPL;
 	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	if (!cpu_icache_snoops_remote_store)
+	if (!cpu_icache_snoops_remote_store && scache_size)
 		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 	if (MIPS4K_ICACHE_REFILL_WAR) {
