Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 12:55:18 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:27401 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225237AbUIBLzN>;
	Thu, 2 Sep 2004 12:55:13 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1C2qLg-00012j-00; Thu, 02 Sep 2004 13:05:52 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C2qAg-0000xL-00; Thu, 02 Sep 2004 12:54:31 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.2505.44705.24637@mips.com>
Date: Thu, 2 Sep 2004 12:53:45 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Johannes Stezenbach <js@convergence.de>,
	Dominic Sweetman <dom@mips.com>,
	Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
In-Reply-To: <20040902103137.GB19884@linux-mips.org>
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com>
	<16693.52862.859233.198626@doms-laptop.algor.co.uk>
	<20040902101957.GA7728@convergence.de>
	<20040902103137.GB19884@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.849, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Johannes asked

> > "...the 4Kc core contains a 3-entry instruction TLB (ITLB), a 3-entry
> > data TLB(DTLB), and a 16 dual-entry joint TLB (JTLB) with variable page
> > sizes."
> > 
> > What exactly does that mean, and how does it rate performancewise?
> > I'm just curious ;-)

I'd like to believe that if the manual mentions the ITLB and DTLB it
also says, somewhere, what they do...

But as Ralf says they're tiny caches of translation entries,
automatically refilled from the main TLB when required.  They work
faster than the main TLB (being smaller) and prevent translations for
loads/stores getting in the way of translations for instruction
fetches.  Usually there's a mysterious 1-clock extra delay when the
translation you need isn't in the ITLB/DTLB, but it's only one clock
and doesn't happen very often, so the performance effect is usually
somewhere between unmeasurable and tiny.

> Probably most MIPS implementations since at least the R4600 had ITLB
> and DTLB.

Even the very first MIPS architecture chip (R2000) had an I-side
"uTLB".  It had just one entry, but then instructions tend to be
sequential...

--
Dominic Sweetman
MIPS Technologies
