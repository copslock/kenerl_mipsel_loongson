Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 09:43:23 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:14602 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224988AbUCVJnV>;
	Mon, 22 Mar 2004 09:43:21 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B5Lqt-00085a-00; Mon, 22 Mar 2004 09:36:11 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B5LxB-0000QT-00; Mon, 22 Mar 2004 09:42:42 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16478.46344.410904.489262@doms-laptop.algor.co.uk>
Date: Mon, 22 Mar 2004 09:42:32 +0000
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com>
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
	<16473.44507.935886.271157@arsenal.mips.com>
	<Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.847, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej

> > Insert/extract make a reasonable case for themselves, but actually
> > arrived in MIPS32 release 2 as part of a bunch of other bit-shuffle
> > instructions (also includes rotates and various byte-swaps) which -
> > together - help quite a bit to manipulate sub-word data in registers.
> 
>  I see.  Actually all of them are a bit redundant, often replaceable with
> short sequences of other instructions, but I guess code compacting may
> matter more for the embedded environment than for general-purpose
> computing.

When we relied on things like Specmarks for benchmarks, those are
mostly general purpose C programs.  They tend to be intricate
programs, not dominated by repetitive handling of large-scale data
(the floating point benchmarks *are* data-intensive, which is why 
architectural strangeness is much more successful on those).

Moreover, Specmarks have a strong tendency to use 'int' data types;
sub-word data handling is essentially irrelevant to performance on
them.  RISCs are good at the fiddly stuff (at least, well-designed
RISCs are) and happy with the int data types: so the Specmarks are
relatively good and we're happy.

But an important sub-class of embedded workloads are data intensive,
where the data represents some sort of stream.  Basic data items are
often 8- or 16-bits in size.  Existing RISC instruction sets end up
bloating the inner loops of these programs, and it's marginal
performance gains rather than code size which motivates us to make
this work better.

>  And while we are at instruction usefulness -- why are there the "di" and
> "ei" instructions, but there is no a complement instruction, say "si" (for
> "set interrupts"), that would copy bit #0 from a GPR to cp0.status.ie
> compactly and atomically?

The 'di' is there to be atomic.  Such sequences are rare and code
compactness is not an issue.  As you probably heard before, the use of
a potentially-interruptible RMW sequence on the status register to
disable interrupts is potentially troublesome (most common OS' manage
themselves so it isn't an issue, but still...)

The 'ei' comes for free with it.

In encoding terms, di/ei can be seen to be individual members of a
generic instruction whose action is something like "atomically
set/clear bit in a CP0 register".  But CP0 registers are low-level
things, whose bits have real hardware functions; so implementing the
bit-set/bit-clear is not the same in all cases.  So we've defined
this instruction minimally, only or critical bits.

--
Dominic
