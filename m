Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 14:19:37 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:51706 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225294AbTDPNTe>; Wed, 16 Apr 2003 14:19:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA01905;
	Wed, 16 Apr 2003 15:19:57 +0200 (MET DST)
Date: Wed, 16 Apr 2003 15:19:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: MIPS32 cache functions now using c-r4k?
In-Reply-To: <00c401c30418$0d9d1370$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1030416151808.1322B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Apr 2003, Kevin D. Kissell wrote:

> The whole point of creating the generic MIPS32 MMU and cache
> routines was to have something that would run on both 32-bit and
> 64-bit processors.  Who decided to throw them away and abandon 
> support for 32-bit-only CPUs other than the R3000, and why?

 It's a plain bug and then a trivial one.  I don't think anybody meant to
abandon MIPS32.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
