Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 16:18:06 +0200 (CEST)
Received: from [216.241.235.117] ([216.241.235.117]:40623 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab0HEOR5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 16:17:57 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 097818E0080;
        Thu,  5 Aug 2010 06:43:52 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 6BD548E001B;
        Thu,  5 Aug 2010 06:43:52 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 5 Aug 2010 06:43:52 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: file corruption with highmem kernel
Date:   Thu, 5 Aug 2010 06:43:50 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C02014052700A1@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140526FCF5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: file corruption with highmem kernel
Thread-Index: AcsyRsvJtdIm2QULSF2xEZbUAQ5rPACWmtew
References: <A7DEA48C84FD0B48AAAE33F328C020140526FCF5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "linux-mips" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
X-OriginalArrivalTime: 05 Aug 2010 13:43:52.0230 (UTC) FILETIME=[3D8FB460:01CB34A4]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

List,

With a slightly modified patched (copied below) I have reached a point
where I am no more seeing errors like segmentation fault, bus error
(which was due to memory corruption I believe).
How ever I am still seeing some kind of file corruption. 

I believe this file corruption happening because cache is not getting
invalidated before a highmem dma. I am not sure which routine to call to
invalidate cache for a highmem address. 

Hope to see response from linux-mips gurus

Thank you,
Anoop   

--- arch/mips/mm/dma-noncoherent.c.orig	2010-08-02 23:53:17.000000000
+0530
+++ arch/mips/mm/dma-noncoherent.c	2010-08-06 00:17:21.000000000
+0530
@@ -131,13 +131,14 @@
 
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
-
-		addr = (unsigned long) page_address(sg->page);
-		if (addr) {
-			__dma_sync(addr + sg->offset, sg->length,
direction);
-			sg->dma_address =
(dma_addr_t)page_to_phys(sg->page)
-					  + sg->offset;
+		if (!PageHighMem(sg->page)){
+			addr = (unsigned long)page_address(sg->page) +
sg->offset;
+			__dma_sync(addr , sg->length, direction);
 		}
+
+		sg->dma_address = (dma_addr_t)page_to_phys(sg->page)
+					+ sg->offset;
+		
 	}
 
 	return nents;
@@ -187,9 +188,10 @@
 		return;
 
 	for (i = 0; i < nhwentries; i++, sg++) {
-		addr = (unsigned long) page_address(sg->page);
-		if (addr)
-			__dma_sync(addr + sg->offset, sg->length,
direction);
+		if (!PageHighMem(sg->page)){
+			addr = (unsigned long)page_address(sg->page) +
sg->offset;
+			__dma_sync(addr , sg->length, direction);
+		}
 	}
 }
