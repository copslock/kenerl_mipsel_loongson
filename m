Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 10:25:22 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:37903 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225257AbUK3KZP>;
	Tue, 30 Nov 2004 10:25:15 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CZ5JW-0004zT-00; Tue, 30 Nov 2004 10:32:54 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CZ5Bh-0002Da-00; Tue, 30 Nov 2004 10:24:49 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16812.19039.764510.640663@gargle.gargle.HOWL>
Date: Tue, 30 Nov 2004 10:24:31 +0000
To: "Gilad Rom" <gilad@romat.com>
Cc: <linux-mips@linux-mips.org>
Subject: Re: CP0 EntryLo
In-Reply-To: <20041130095640.499DFEB2EF@mail.romat.com>
References: <20041130095640.499DFEB2EF@mail.romat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.827, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Gilad Rom (gilad@romat.com) writes:

> I am attempting to access a peripheral device over the Au1500 static bus.
> 
> According to the Au1500 Databook, Whenever I set the Chip Select config
> Register DTY bits to 1 (for "I/O Device").

> I must also set Bits 29:26 of CoProcessor 0 to 0xD, to represent
> bits 35:32 of the Physical address.

"CoProcessor 0" is a kind of fiction represented by a whole bunch of
registers, so you've wandered a long way into the weeds here.

> My question is, if anyone can answer it, is how do I setup
> The CoProcessor0 registers 29:26 in my driver?

I think you are referring to the "EntryLo0-1" register pair.  These
are used as staging registers when reading or writing entries in the
TLB, which is the address translation table.  

The manual is implying is that you need to set up a TLB entry to
access these high physical addresses.  

In Linux most of the TLB is maintained by the kernel as a cache of the
translations used by user programs.  That's probably why you see
"random values" from the staging registers; the kernel is busy taking
exceptions when required translations aren't in the TLB and fixing
them up.

However, the Au1500 hardware permits a small number of TLB entries to
be "wired", for fixed functions like your I/O accesses.

I'm not enough of an expert on the Linux kernel to tell you how to set
up a wired entry: but grep through the sources and you'll turn
something up!

> I have noticed a set of functions called write/read_c0_entrylo[0,1],
> But I keep getting random values when invoking these from my driver.

I think those are way too low-level for your purposes.

--
Dominic Sweetman
MIPS Technologies
