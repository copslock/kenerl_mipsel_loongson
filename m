Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 11:31:59 +0100 (BST)
Received: from p508B696D.dip.t-dialin.net ([IPv6:::ffff:80.139.105.109]:26936
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225229AbUIBKbz>; Thu, 2 Sep 2004 11:31:55 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i82AVqXI020478;
	Thu, 2 Sep 2004 12:31:52 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i82AVbpx020477;
	Thu, 2 Sep 2004 12:31:37 +0200
Date: Thu, 2 Sep 2004 12:31:37 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Johannes Stezenbach <js@convergence.de>,
	Dominic Sweetman <dom@mips.com>,
	Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
Message-ID: <20040902103137.GB19884@linux-mips.org>
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com> <16693.52862.859233.198626@doms-laptop.algor.co.uk> <20040902101957.GA7728@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902101957.GA7728@convergence.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 02, 2004 at 12:19:57PM +0200, Johannes Stezenbach wrote:

> Hm, the MIPS32 4K Processor Core Family Software User's Manual says:
> 
> "...the 4Kc core contains a 3-entry instruction TLB (ITLB), a 3-entry
> data TLB(DTLB), and a 16 dual-entry joint TLB (JTLB) with variable page
> sizes."
> 
> What exactly does that mean, and how does it rate performancewise?
> I'm just curious ;-)

The idea behind ITLB and DTLB is to enable parallel TLB lookups for
instruction and data translations in ITLB and DTLB yet not having to make
dual or even more ported JTLB.  ITLB and DTLB are entirely managed in
hardware and therefore not visible [1] to the OS software and as such
not part of the architecture; only the JTLB is and it's what's usually
meant when documentation or we on this list are speaking of the TLB.
Probably most MIPS implementations since at least the R4600 had ITLB and
DTLB.

  Ralf

[1] Except possibly during hazards but your supposed to avoid them :-)
