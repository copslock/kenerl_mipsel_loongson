Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 11:03:59 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55477 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEJD6>; Thu, 5 Sep 2002 11:03:58 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02559;
	Thu, 5 Sep 2002 11:04:15 +0200 (MET DST)
Date: Thu, 5 Sep 2002 11:04:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthew Dharm <mdharm@momenco.com>
cc: Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: RE: Interrupt handling....
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEMFCIAA.mdharm@momenco.com>
Message-ID: <Pine.GSO.3.96.1020905105934.2423B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 98
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Matthew Dharm wrote:

> Okay... What type of information do you need?

 Well, first check if a PTE is indeed installed by ioremap() in the table. 
If so, the what happens at the access time -- what exceptions, what are
the contents of the related registers, what does exist in the TLB, etc.
You don't need to go to the IRQ handler at first -- it might be easier to
get such things if you deliberately access the location from elsewhere,
e.g. from the setup code right after ioremap().

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
