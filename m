Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 18:33:06 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21173 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTBUSdF>; Fri, 21 Feb 2003 18:33:05 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA17985;
	Fri, 21 Feb 2003 19:33:26 +0100 (MET)
Date: Fri, 21 Feb 2003 19:33:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Andrew Clausen <clausen@melbourne.sgi.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] sys32_sysinfo broken on mips64 and ia64
In-Reply-To: <20030221034629.A18782@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030221192741.17698A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 21 Feb 2003, Ralf Baechle wrote:

> Sigh...  Each time I curse some certain person for copying code from the
> ia64 compat code, it was of abysimal quality back in at that time -
> unlike the Sparc code.

 Hmm, I think it's well-known the sparc64 port is mature unlike the ia64
one.  So why anyone uses the latter for any real work except the ia64
itself looks like a mystery to me... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
