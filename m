Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2004 14:22:52 +0000 (GMT)
Received: from p508B7C9B.dip.t-dialin.net ([IPv6:::ffff:80.139.124.155]:54300
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225467AbUBFOWv>; Fri, 6 Feb 2004 14:22:51 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i16EMcex004348
	for <linux-mips@linux-mips.org>; Fri, 6 Feb 2004 15:22:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i16EM1gr004344;
	Fri, 6 Feb 2004 15:22:01 +0100
Date: Fri, 6 Feb 2004 15:22:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: R4[04]00SC
Message-ID: <20040206142201.GA4275@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

We still have this stuff in flush_cache_mm():

       /*
         * Kludge alert.  For obscure reasons R4000SC and R4400SC go nuts if we
         * only flush the primary caches but R10000 and R12000 behave sane ...
         */
        if (current_cpu_data.cputype == CPU_R4000SC ||
            current_cpu_data.cputype == CPU_R4000MC ||
            current_cpu_data.cputype == CPU_R4400SC ||
            current_cpu_data.cputype == CPU_R4400MC)
                r4k_blast_scache();

You have any idea what might make this necessary?  This slows down
SC systems quite badly but makes the compiler from eleminating the
call to r4k_blast_scache() on systems that don't have one of these
processors.

Could be kludged a bit by also testing cpu_has_subset_pcaches() but
that'd be a hack.

  Ralf
