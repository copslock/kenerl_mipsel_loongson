Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 19:02:29 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:29197 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226057AbTAHTC3>;
	Wed, 8 Jan 2003 19:02:29 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.algor.co.uk)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 18WLbe-0004iw-00; Wed, 08 Jan 2003 19:11:14 +0000
Received: from arsenal.algor.co.uk ([192.168.192.197] ident=mail)
	by olympia.algor.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 18WLSq-0006V1-00; Wed, 08 Jan 2003 19:02:08 +0000
Received: from dom by arsenal.algor.co.uk with local (Exim 3.35 #1 (Debian))
	id 18WLSp-0003Zb-00; Wed, 08 Jan 2003 19:02:07 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15900.30127.646847.937900@arsenal.algor.co.uk>
Date: Wed, 8 Jan 2003 19:02:07 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
In-Reply-To: <20030108145953.B8396@linux-mips.org>
References: <Pine.GSO.3.96.1030108141332.1580F-100000@delta.ds2.pg.gda.pl>
	<20030108145953.B8396@linux-mips.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1.2, required 5, AWL,
	IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES, SPAM_PHRASE_00_01)
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> On Wed, Jan 08, 2003 at 02:27:05PM +0100, Maciej W. Rozycki wrote:
> 
> >  32-bit R4k TLB flush functions use KSEG0 as an impossible (unmapped) VPN2
> > value for invalidated TLB entries.  64-bit ones use KSEG0 as well, but
> > here KSEG0 is a valid XKSEG (mapped) value as it gets interpreted as
> > 0xc00000ff80000000 when written into cp0.EntryHi.  The correct impossible
> > (unmapped) VPN2 value for the 64-bit mode is XKPHYS. 
> 
> That's a funny one.  Historically the idea was to use KSEG0 because the
> for KSEG0 the TLB is not used for translation.  That already failed for
> the Sibyte SB1 which is why we have to use different KSEG0 addresses for
> each entry there.

Amplification: some MIPS CPUs really hate having the same "virtual
address" in more than one TLB entry.  Some of MIPS Technologies' own
cores are the same.

It's probably better to use legal kuseg virtual addresses (but with
the invalid bit set) for initialising TLBs.  And to make them all
different...

--
Dominic Sweetman
mailto:dom@mips.com
