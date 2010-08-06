Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2010 12:12:18 +0200 (CEST)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:60762 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493453Ab0HFKMO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Aug 2010 12:12:14 +0200
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 1334710700E6;
        Fri,  6 Aug 2010 03:12:03 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id F20A710700EA;
        Fri,  6 Aug 2010 03:12:02 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 6 Aug 2010 03:12:03 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: file corruption with highmem kernel
Date:   Fri, 6 Aug 2010 03:12:00 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C02014052701F5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100805182547.GB1382@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: file corruption with highmem kernel
Thread-Index: Acs0y8bnYm14g7FHRaW+W2PRh1m8QQAgmpOA
References: <A7DEA48C84FD0B48AAAE33F328C020140526FCF5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <A7DEA48C84FD0B48AAAE33F328C02014052700A1@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100805182547.GB1382@linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     "linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Aug 2010 10:12:03.0058 (UTC) FILETIME=[D0B7B520:01CB354F]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

> 
> Since you're running on an RM9000 class CPU, why don't just use a
64-bit
> kernel?  Highmem is just so f*cking insane that you want to avoid it
like
> French kisses from a zombie suffering ebola.  If you have DMA
restrictions
> then you may consider reusing ZONE_DMA.
[Anoop P.A.] I understand that I am working on 64 bit kernel in
parallel, DMA issue made me concentrate on highmem support as immediate
option.
 
> small 32-bit system that didn't need highmem or went 64-bit right away
so
> the gaps in the code while well known were never fixed up ...

[Anoop P.A.] I presume with decreased value of RAM, more 32 bit machines
will come with bulk of memory pretty soon to the world of highmem

> 
> I'm a bit surprised that the patch posted actually made things work
better
> for you since it entirely avoids flushing of highmem pages.  The code
as
> it
> was originally written using page_address() will perform cacheflushes
> for highmem pages as well - but only for highmem pages are actually
are
> mapped.  That is your code will flush less pages than the existing
code.

[Anoop P.A.] I confirmed it, calling __dma_sync for highmem map address
occasionally causes memory corruption ( reports bus error , segmentation
fault etc..) .

Blowing entire scache (I understand it is pain) for highmem pages fixed
my file corruption issue

--- linux-2.6.18/arch/mips/mm/dma-noncoherent.c	2006-08-23
23:16:07.000000000 +0530
+++ linux-2.6.18/arch/mips/mm/dma-noncoherent.c	2010-08-06
20:48:36.000000000 +0530
@@ -15,6 +15,7 @@
 
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <asm/r4kcache.h>
 
 /*
  * Warning on the terminology - Linux calls an uncached area coherent;
@@ -131,13 +132,21 @@
 
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
+		if (!PageHighMem(sg->page))
+		{
+               		addr = (unsigned
long)page_address(sg->page) + sg->offset;
+               		__dma_sync(addr, sg->length, direction);
+		}
+		else
+		{ 
+		/*blasting entire cache for all	the highmem page's might
be over head 
+		  But __dma_sync is failing for mapped highmem pages, so
this is the 
+		  easiest solution for time being*/
+			blast_scache32(); /*RM9000 sc_line=32 */ 
+		}
 
-		addr = (unsigned long) page_address(sg->page);
-		if (addr) {
-			__dma_sync(addr + sg->offset, sg->length,
direction);
-			sg->dma_address =
(dma_addr_t)page_to_phys(sg->page)
+		sg->dma_address = (dma_addr_t)page_to_phys(sg->page)
 					  + sg->offset;
-		}
 	}
 
 	return nents;


Thanks
Anoop
