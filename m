Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 15:30:14 +0200 (CEST)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:48745 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492258Ab0HBNaK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Aug 2010 15:30:10 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id CC6058E00AE;
        Mon,  2 Aug 2010 06:29:58 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id B8F848E00AD;
        Mon,  2 Aug 2010 06:29:58 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 2 Aug 2010 06:29:58 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: file corruption with highmem kernel
Date:   Mon, 2 Aug 2010 06:29:56 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140526FCF5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: file corruption with highmem kernel
Thread-Index: AcsyRsvJtdIm2QULSF2xEZbUAQ5rPA==
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "linux-mips" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
X-OriginalArrivalTime: 02 Aug 2010 13:29:58.0732 (UTC) FILETIME=[CD84C0C0:01CB3246]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

List,

I am running 2.6.18 (highmem) kernel in RM9000 based SOC with 2 Gig RAM.
I have observed file corruption and system hangs (Easily reproducible on
remounting file system) when doing file copy to SATA disk / USB disk (
SATA/ USB controller over PCI) . How ever when I limit memory with
option mem=512M from command line everything seems to be working fine.

Issue is reproducible with 2.6.18-stable lmo git sources .

I have modified dma-noncoherent.c as follows and I am no more
experiencing system hang. But file's are getting corrupted (observed bus
error / segmentation fault / illegal instruction error few times)
occasionally.  One more observation I have made is file corruption is
more if I use root file system from onboard USB flash, than running a
NFS root mount.


--- arch/mips/mm/dma-noncoherent.c.orig	2010-08-02 23:53:17.000000000
+0530
+++ arch/mips/mm/dma-noncoherent.c	2010-08-02 23:56:19.000000000
+0530
@@ -132,12 +132,13 @@
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
-		addr = (unsigned long) page_address(sg->page);
-		if (addr) {
-			__dma_sync(addr + sg->offset, sg->length,
direction);
-			sg->dma_address =
(dma_addr_t)page_to_phys(sg->page)
-					  + sg->offset;
-		}
+		addr = (unsigned long) page_address(sg->page) +
sg->offset;
+		if (addr) 
+			__dma_sync(addr, sg->length, direction);
+		
+		sg->dma_address = (dma_addr_t)page_to_phys(sg->page)
+					+ sg->offset;
+		
 	}
 
 	return nents;
@@ -187,9 +188,9 @@
 		return;
 
 	for (i = 0; i < nhwentries; i++, sg++) {
-		addr = (unsigned long) page_address(sg->page);
+		addr = (unsigned long) page_address(sg->page) +
sg->offset;
 		if (addr)
-			__dma_sync(addr + sg->offset, sg->length,
direction);
+			__dma_sync(addr , sg->length, direction);
 	}
 }


It will be great if any body can give me some pointers / help to fix the
issue.

Thanks
Anoop
