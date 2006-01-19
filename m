Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 21:03:29 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:59923 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134468AbWASVDI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 21:03:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0JL4epp001055;
	Thu, 19 Jan 2006 21:04:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0JL4e5x001051;
	Thu, 19 Jan 2006 21:04:40 GMT
Date:	Thu, 19 Jan 2006 21:04:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060119210440.GE3398@linux-mips.org>
References: <20060119192414.GA26798@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119192414.GA26798@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 19, 2006 at 07:24:14PM +0000, Martin Michlmayr wrote:

> If cpu_icache_snoops_remote_store is not set, Cobalt will crash
> immediately when starting the kernel.

That's papering over the actual bug.  The CPU has no scache, so the
scache flushing functions aren't getting initialized and the NULL
pointer is eventually called as a function.  So I suggest this below.
Can you test it?

  Ralf

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 422b55f..24a59a9 100644
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
