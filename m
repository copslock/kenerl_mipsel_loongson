Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 14:11:18 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:14604 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225362AbUCROLR>;
	Thu, 18 Mar 2004 14:11:17 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B3y7u-0002ie-00; Thu, 18 Mar 2004 14:04:02 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B3yEG-0004nx-00; Thu, 18 Mar 2004 14:10:36 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1B3yEG-0000Ij-00; Thu, 18 Mar 2004 14:10:36 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.44507.935886.271157@arsenal.mips.com>
Date: Thu, 18 Mar 2004 14:10:35 +0000
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com>
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.846, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@ds2.pg.gda.pl) writes:
> 
> > We added patterns to let our (old) GCC use the new rotates and
> > bit-insert/extracts, at least in simple cases.  I'm not sure whether
> > we've put those in our 3.4 evolution tree yet, but if we have we
> > should push those out.
> 
>  As a side note, it makes me wonder where the borderline of the RISC
> actually is.  Even Intel abandoned support for bit insert/extract
> instructions after an initial attempt for the i386.  They figured out the
> implementation was too complicated. ;-)

It probably was... but MIPS uses register-to-register ALU operations
and no condition codes.  The interface to the ALU is typically rather
simple.  So adding some peculiar new 2- or 3-operand computation is
relatively easy.

If the instruction is too complicated, of course, it might eventually
become a critical path and make the whole CPU slower.  But
insert/extract - while elaborate to describe - involve only fairly
shallow logic.

Remember: the point of RISC was never to have less instructions
(that's just a cute acronym) - the point was and is to define an
instruction set which is easy to implement as an efficient pipeline.

Of course, instructions still have to be *useful* to be added.
Insert/extract make a reasonable case for themselves, but actually
arrived in MIPS32 release 2 as part of a bunch of other bit-shuffle
instructions (also includes rotates and various byte-swaps) which -
together - help quite a bit to manipulate sub-word data in registers.

--
Dominic Sweetman
MIPS Technologies
