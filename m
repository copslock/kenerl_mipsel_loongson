Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 17:17:08 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:43948 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJOPRH>; Tue, 15 Oct 2002 17:17:07 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17372;
	Tue, 15 Oct 2002 17:17:24 +0200 (MET DST)
Date: Tue, 15 Oct 2002 17:17:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Johannes Stezenbach <js@convergence.de>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
In-Reply-To: <01fd01c26e1d$add77240$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1021015171049.16503A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 7 Oct 2002, Kevin D. Kissell wrote:

> That's probably going to be a more reliable design,
> though I would still consider leaving the TLB refill handler
> untouched and counting on the fact that k1 must contain
> a non-lethal EntryLo value on return from the exception.

 Well, there is a "nop" just before the "eret" in all R4k-style TLB
exception handlers.  I see no problem to use the slot for explicit
clobbering of k0 or k1 with a single instruction like "li" or "lui". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
