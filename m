Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 11:11:52 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17802 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225208AbTDIKLw>; Wed, 9 Apr 2003 11:11:52 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA00251;
	Wed, 9 Apr 2003 12:12:28 +0200 (MET DST)
Date: Wed, 9 Apr 2003 12:12:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Aliasing in pgtable-bits.h (CONFIG_64BIT_PHYS_ADDR)
In-Reply-To: <20030408234735.A7363@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030409120414.29837A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 8 Apr 2003, Ralf Baechle wrote:

> > Is the aliasing between R4KBUG & GLOBAL intentional? This is the only CONFIG case where it
> > is done. Superficially, I can't see R4KBUG used anywhere, so maybe it doesn't matter. But
> > if R4KBUG truly isn't used, why not consider removing it entirely from all PTE layouts?
> 
> It's there for a R4000 bug workaround waiting to be finally written by
> somebody ...

 Possibly doing that in the toolchain may be a reasonable alternative. 
Actually wasting say 4 last words for nops on every page unconditionally
when building for the affected processors may be a good approximation of a
workaround for a start. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
