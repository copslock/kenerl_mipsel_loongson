Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 00:23:00 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:59098 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224935AbVBHAWo>; Tue, 8 Feb 2005 00:22:44 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j180HhQt025257;
	Tue, 8 Feb 2005 00:17:43 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j180Hgnt025256;
	Tue, 8 Feb 2005 00:17:42 GMT
Date:	Tue, 8 Feb 2005 00:17:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050208001742.GA15336@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42072264.6000001@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 09:10:12AM +0100, Rojhalat Ibrahim wrote:

> With a slightly extended patch it actually works. But afterwards
> I get a lot of Illegal instructions and Segmentation faults, where
> there shouldn't be any. Below is the patch I used.

> --- linux/arch/mips/mm/c-r4k.c  2005-01-03 10:23:27.000000000 +0100
> +++ linux-2.6.10/arch/mips/mm/c-r4k.c   2005-02-07 09:04:27.000000000 +0100
> @@ -566,9 +566,17 @@
> 
>         if (!cpu_has_ic_fills_f_dc) {
>                 unsigned long addr = (unsigned long) page_address(page);
> -               r4k_blast_dcache_page(addr);
> +               if (addr)
> +                       r4k_blast_dcache_page(addr);
> +               else
> +                       r4k_blast_dcache();
>                 if (!cpu_icache_snoops_remote_store)
> -                       r4k_blast_scache_page(addr);
> +               {
> +                       if (addr)
> +                               r4k_blast_scache_page(addr);
> +                       else
> +                               r4k_blast_scache();
> +               }
>                 ClearPageDcacheDirty(page);
>         }

Blowing away the entire S-cache is extreme overkill.  We really want to
avoid this if possible as it'll have serious performance impact.  As for
the RM9000 that means we have a struct page pointer, therefore we know
the physical address of the page and can perform a selective flush on the
second level cache.  See below for a patch which tries that.

Obviously this one only tries to optimize performance a bit further but
doesn't really solve the remaining problem.

  Ralf

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.101
diff -u -r1.101 c-r4k.c
--- arch/mips/mm/c-r4k.c	7 Feb 2005 21:53:39 -0000	1.101
+++ arch/mips/mm/c-r4k.c	8 Feb 2005 00:18:17 -0000
@@ -566,9 +566,21 @@
 
 	if (!cpu_has_ic_fills_f_dc) {
 		unsigned long addr = (unsigned long) page_address(page);
-		r4k_blast_dcache_page(addr);
-		if (!cpu_icache_snoops_remote_store)
-			r4k_blast_scache_page(addr);
+
+		if (addr)
+			r4k_blast_dcache_page(addr);
+		else
+			r4k_blast_dcache();
+
+		if (!cpu_icache_snoops_remote_store) {
+			if (addr)
+				r4k_blast_scache_page(addr);
+			else {
+				addr = page_to_pfn(page) << PAGE_SHIFT;
+				addr = CKSEG + (addr & ~((1UL << 24) - 1));
+				r4k_blast_scache_page_indexed(addr);
+			}
+		}
 		ClearPageDcacheDirty(page);
 	}
 
