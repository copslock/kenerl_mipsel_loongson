Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BGv5Rw008756
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 09:57:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BGv5RH008755
	for linux-mips-outgoing; Thu, 11 Jul 2002 09:57:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BGuvRw008746;
	Thu, 11 Jul 2002 09:56:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA15221;
	Thu, 11 Jul 2002 19:01:58 +0200 (MET DST)
Date: Thu, 11 Jul 2002 19:01:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <20020711131247.A11700@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020711185642.7876I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Ralf Baechle wrote:

> The R3000 cache manipulation mechanism is implemented by giving magic
> meaning to store instruction while the isolate cache and swap cache bits
> are in use.  By their very implementation they're both incompatible with
> normal operation of caches and therefore can only be used from uncached
> space.

 Well, docs state only the cache that acts as the D-cache gets isolated
and the one that acts as the I-cache always functions normally (and the
real D-cache has all the logic needed to pretend it's an I-cache
successfully).  Thus running from an uncached space is not needed.  I
haven't checked it explicitly, but the flushing functions would fail
(hang) quite soon otherwise and they don't.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
