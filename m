Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 17:51:29 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:28086 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224827AbTC1Rv3>; Fri, 28 Mar 2003 17:51:29 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA27053;
	Fri, 28 Mar 2003 18:51:57 +0100 (MET)
Date: Fri, 28 Mar 2003 18:51:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c 4/7 flush_cache_mm cleanup
In-Reply-To: <m2smt89ut8.fsf@neno.mitica>
Message-ID: <Pine.GSO.3.96.1030328175039.26178B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 28 Mar 2003, Juan Quintela wrote:

> 	flush_cache_mm can use __flush_cache_all.

 Wrong, it should use r4k_flush_pcache_all() unconditionally, but I'm told
such a setup triggers a bug somewhere, that needs to be tracked down
before committing that change to the CVS.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
