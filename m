Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 17:32:12 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:18449 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225197AbTDCQcK>;
	Thu, 3 Apr 2003 17:32:10 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1917im-00077d-00; Thu, 03 Apr 2003 17:37:48 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1917cw-0004iz-00; Thu, 03 Apr 2003 17:31:46 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16012.25072.379410.787234@gladsmuir.mips.com>
Date: Thu, 3 Apr 2003 17:31:44 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <Pine.GSO.3.96.1030403181029.19058I-100000@delta.ds2.pg.gda.pl>
References: <20030403174219.A4276@linux-mips.org>
	<Pine.GSO.3.96.1030403181029.19058I-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-2, required 4.5, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	SPAM_PHRASE_00_01)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@ds2.pg.gda.pl) writes:

> Hmm, that's even more interesting -- how can instruction fetches be
> distinguished from data reads externally???

The length of the burst is encoded in the bus command sent out by the
R4000 at the beginning of a read or write cycle.  For the system to
work, the memory controller has to be able to do the right thing for
both of the lengths which might happen...

It's very hard to see how a system could fail to work by making the
I-cache line the same size as a D-cache line.

> Then again, the memory controller shouldn't be able to observe
> inter-cache data moves.

This is true: for L2-equipped chips I assume you can't see the
difference between I- and D-.

--
Dominic
MIPS Technologies UK.
