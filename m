Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 15:20:21 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:4624 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225234AbVBDPUG>;
	Fri, 4 Feb 2005 15:20:06 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Cx5Kp-0001D8-00; Fri, 04 Feb 2005 15:25:27 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Cx5FN-0005qe-00; Fri, 04 Feb 2005 15:19:49 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.37525.412441.558873@gargle.gargle.HOWL>
Date:	Fri, 4 Feb 2005 15:19:49 +0000
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
In-Reply-To: <20050204145803.GA5618@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
	<4203890B.5030305@mips.com>
	<20050204145803.GA5618@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.845,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Only some CPUs suffer from aliases.  A 4Kbyte direct-mapped cache must
be alias free, because all the virtual index bits are the same (being
in-page) as the physical address bits.  That's true but irrelvant,
since there aren't any 4Kbyte caches: but what's slightly less obvious
is that a 16Kbyte 4-way set-associative cache is also alias free.

24K's "AR" bit trick applies *only* to the D-cache, and only to a
32Kbyte cache.  (But then most alias problems are D-cache aliases, and
32Kbyte happens to be the most popular size for a 24K cache - so this
is a trick worth doing).

Note that I-cache aliases are not completely harmless; sometimes you
want to invalidate any I-cache copies of some data, and if it's
aliased you may miss some of them.  Shared libraries are generally
aligned to some large page-size multiple - so multiple text images are
usually the same colour, and don't matter.  You can get problems with
trampolines and stuff.

--
Dominic Sweetman
MIPS Technologies
