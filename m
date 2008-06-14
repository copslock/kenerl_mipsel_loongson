Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2008 13:59:29 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:20705 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28574559AbYFNM71 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Jun 2008 13:59:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5ECx4bX023708;
	Sat, 14 Jun 2008 13:59:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5ECx3Bg023701;
	Sat, 14 Jun 2008 13:59:03 +0100
Date:	Sat, 14 Jun 2008 13:59:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Horsten <thomas@horsten.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
	has been there for a while?
Message-ID: <20080614125903.GA483@linux-mips.org>
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2008 at 04:06:03PM +0100, Thomas Horsten wrote:

Only compile tested - can you try this one?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c41ea22..2709675 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -446,6 +446,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	struct page *page = pfn_to_page(fcp_args->pfn);
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
+	int map_coherent = 0;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -479,7 +480,9 @@ static inline void local_r4k_flush_cache_page(void *args)
 		 * Use kmap_coherent or kmap_atomic to do flushes for
 		 * another ASID than the current one.
 		 */
-		if (cpu_has_dc_aliases)
+		map_coherent = (cpu_has_dc_aliases &&
+				page_mapped(page) && !Page_dcache_dirty(page));
+		if (map_coherent)
 			vaddr = kmap_coherent(page, addr);
 		else
 			vaddr = kmap_atomic(page, KM_USER0);
@@ -502,7 +505,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	}
 
 	if (vaddr) {
-		if (cpu_has_dc_aliases)
+		if (map_coherent)
 			kunmap_coherent();
 		else
 			kunmap_atomic(vaddr, KM_USER0);
