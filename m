Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 11:56:48 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:41484 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225202AbTDOK4q>;
	Tue, 15 Apr 2003 11:56:46 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 195OC3-0007Cw-00; Tue, 15 Apr 2003 12:01:39 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 195O6T-0007BP-00; Tue, 15 Apr 2003 11:55:53 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16027.58679.576152.853200@gladsmuir.mips.com>
Date: Tue, 15 Apr 2003 11:55:51 +0100
To: Dennis Castleman <DennisCastleman@oaktech.com>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Gus Fernandez <GusFernandez@oaktech.com>
Subject: Re: Soft floating point on 5K
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E2634102F07@TLEXMAIL>
References: <56BEF0DBC8B9D611BFDB00508B5E2634102F07@TLEXMAIL>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-2, required 4.5, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	SPAM_PHRASE_00_01)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Dennis Castleman (DennisCastleman@oaktech.com) writes:

> I'm trying to run soft-floating point functions on a r5000 core with
> a FPU. Without having to take the overhead of using a trap.  Using
> the files fp-bit.c and dp-bit.c from the gcc source as a floating
> point lib.  This implementation lack in accuracy in the least
> signeficant bit multiplication in division operations.

There's an IEEE-compatible set of software floating point routines in
the Linux kernel, invoked by the trap handler.  The routines were
donated by Algorithmics (now part of MIPS Technologies).

If you wrapped them in the appropriate GCC skins, they should give you
a soft-float library which works better.

--
Dominic Sweetman
dom@mips.com
