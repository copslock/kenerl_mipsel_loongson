Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 11:19:22 +0100 (BST)
Received: from pD9E729B1.dip.t-dialin.net ([IPv6:::ffff:217.231.41.177]:9869
	"EHLO abc.local") by linux-mips.org with ESMTP id <S8225229AbUIBKTS>;
	Thu, 2 Sep 2004 11:19:18 +0100
Received: from js by abc.local with local (Exim 3.35 #1 (Debian))
	id 1C2ohB-00021J-00; Thu, 02 Sep 2004 12:19:57 +0200
Date: Thu, 2 Sep 2004 12:19:57 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Dominic Sweetman <dom@mips.com>
Cc: Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
Message-ID: <20040902101957.GA7728@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Dominic Sweetman <dom@mips.com>, Emmanuel Michon <em@realmagic.fr>,
	linux-mips@linux-mips.org
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com> <16693.52862.859233.198626@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16693.52862.859233.198626@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.5.6+20040818i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:
> 
> Emmanuel,
> 
> > regarding the hardware implementation of a 4KE (r4k style mmu
> > if I remember) I'm wondering about the performance difference
> > when the TLB has 16 pairs of entries (covering 128KBytes of
> > data) or 32 pairs (covering 256KBytes).
> > 
> > Does someone have a useful advise regarding the `nice spot'
> > for TLB size?
...
> However, the measurements we've done at MIPS suggest that for
> moderate-size workloads where the user-space programs are working
> hard, a 16-entry TLB can thrash quite badly, making a significant dent
> in performance.
> 
> So the advice I'd give is that if:
> 
> 1. Your application has a non-trivial user space of any size;
> 
> 2. The performance of userland code is significant;
> 
> then you should pick a 32-entry TLB, until and unless you have
> measurements of your own application to show you don't need it.

Hm, the MIPS32 4K Processor Core Family Software User's Manual says:

"...the 4Kc core contains a 3-entry instruction TLB (ITLB), a 3-entry
data TLB(DTLB), and a 16 dual-entry joint TLB (JTLB) with variable page
sizes."

What exactly does that mean, and how does it rate performancewise?
I'm just curious ;-)

Johannes
