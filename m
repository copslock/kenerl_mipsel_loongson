Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 20:39:57 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17405 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224821AbTGVTjy>; Tue, 22 Jul 2003 20:39:54 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA09221;
	Tue, 22 Jul 2003 21:39:40 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 21:39:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030721182002.GA28587@foobazco.org>
Message-ID: <Pine.GSO.3.96.1030722212122.607D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 21 Jul 2003, Keith M Wesolowski wrote:

> sparc32 and sparc64 processors and systems are significantly
> different.  For example, the SRMMU present in v8 CPUs is 100% replaced
> with a totally different MMU (indeed, totally different instructions,
> access methods, etc) in v9.  Accordingly there is very little code in
> common between the two ports, and most of that is in device handling;
> code that is in drivers/sbus and thus shared anyway.

 Well, the MMU of (original) 32-bit MIPS processors (i.e. R2k/R3k) is
completely different from the one in later ones, too.  I suspect this is
true for the R6k as well.  The exception handlers differ a bit as well,
especially considering the XTLB refill one.  That probably counts as
nitpicking, though... 

> Something that made sense for sparc might not make sense for mips.

 Certainly it needs to be analysed on a case by case basis, avoiding
blanket assumptions.  Anyway, I still see two reasons for having at least
a separate top-level directory:

1. A better separation of the more straightforward 32-bit Makefile and the
more complicated 64-bit one.

2. A better visual existence of the 64-bit port; not really a technical
advantage, but more a psychological one.  It stops any newcomer wondering
whether we support 64-bit systems natively or not. 

 There is also no point in having headers in asm-mips consisting of a
single #ifdef CONFIG_MIPS32/#else/#endif conditional, where two distinct
versions should be present in asm-mips and asm-mips64, respectively.  It's
easier to make a diff between such separate implementations to verify
everything's OK. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
