Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2005 13:41:00 +0000 (GMT)
Received: from p3EE07839.dip.t-dialin.net ([IPv6:::ffff:62.224.120.57]:2345
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224929AbVBJNko>; Thu, 10 Feb 2005 13:40:44 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1ADeh9P030919;
	Thu, 10 Feb 2005 14:40:43 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j1ADehmA030918;
	Thu, 10 Feb 2005 14:40:43 +0100
Date:	Thu, 10 Feb 2005 14:40:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050210134043.GA30792@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de> <20050209000640.GA10651@linux-mips.org> <4209C492.4050201@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4209C492.4050201@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 09, 2005 at 09:06:42AM +0100, Rojhalat Ibrahim wrote:

> Ok, thanks. If I can try anything that might help track down
> the problem, please let me know.

Try this patch which is meant to be used in combination with the previous
patch.  It moves a test which determines if we actually need to perform a
cacheflush to the right place.  That's a bug which is harmless on UP but
a severe bug on SMP.

Thanks,

  Ralf

 c-r4k.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-sgi-ip27-ua/arch/mips/mm/c-r4k.c
===================================================================
--- linux-sgi-ip27-ua.orig/arch/mips/mm/c-r4k.c	2005-02-10 14:25:54.935572026 +0100
+++ linux-sgi-ip27-ua/arch/mips/mm/c-r4k.c	2005-02-10 14:28:02.329527242 +0100
@@ -376,6 +376,13 @@
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (cpu_context(smp_processor_id(), vma->vm_mm) == 0)
+		return;
+
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pudp = pud_offset(pgdp, page);
@@ -433,13 +440,6 @@
 {
 	struct flush_cache_page_args args;
 
-	/*
-	 * If ownes no valid ASID yet, cannot possibly have gotten
-	 * this page into the cache.
-	 */
-	if (cpu_context(smp_processor_id(), vma->vm_mm) == 0)
-		return;
-
 	args.vma = vma;
 	args.page = page;
 
