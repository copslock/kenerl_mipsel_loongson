Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 14:02:06 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:37582 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226157AbTAJOCF>; Fri, 10 Jan 2003 14:02:05 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA26103;
	Fri, 10 Jan 2003 15:02:08 +0100 (MET)
Date: Fri, 10 Jan 2003 15:02:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
In-Reply-To: <m2smw15d0n.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1030110145323.23678J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 10 Jan 2003, Juan Quintela wrote:

> Maciej, in the other hand, you didn't coment in the other part, that
> we writeback & invalidate when we are asked only to invalidate?

 I did some investigation now and I think dma_cache_wback_inv(),
dma_cache_wback() and dma_cache_inv() all should do what the name implies. 
I'll make a fix.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
