Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 13:44:21 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:9345 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225377AbUCSNoU>; Fri, 19 Mar 2004 13:44:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 574764B48D; Fri, 19 Mar 2004 14:44:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id F0B004B05E; Fri, 19 Mar 2004 14:44:13 +0100 (CET)
Date: Fri, 19 Mar 2004 14:44:13 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <16473.44507.935886.271157@arsenal.mips.com>
Message-ID: <Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
 <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com>
 <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
 <16473.44507.935886.271157@arsenal.mips.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Mar 2004, Dominic Sweetman wrote:

> >  As a side note, it makes me wonder where the borderline of the RISC
> > actually is.  Even Intel abandoned support for bit insert/extract
> > instructions after an initial attempt for the i386.  They figured out the
> > implementation was too complicated. ;-)
> 
> It probably was... but MIPS uses register-to-register ALU operations
> and no condition codes.  The interface to the ALU is typically rather
> simple.  So adding some peculiar new 2- or 3-operand computation is
> relatively easy.

 Well, I suppose that's not much different for a processor like the i386,
which is already capable to load a source operand or store (or RMW) a
destination one for whatever operation is to be executed by the ALU or
microcoded.  Intel could have taken the baroque (or rococo?) approach as
usual, though, and thus run out of die space. ;-)

> Remember: the point of RISC was never to have less instructions
> (that's just a cute acronym) - the point was and is to define an
> instruction set which is easy to implement as an efficient pipeline.

 Well, the meaning of RISC indeed depends on what you express by "reduced"  
there (i.e. whether it's "small" or "simple").  Historically, the
instruction set used to include about the smallest reasonable set of 
operations needed for efficient programming, with any redundancy offloaded 
to short sequences of simple instructions.  This could have changed, as 
technology evolved, though.

> Of course, instructions still have to be *useful* to be added.

 Well, I suppose so, as long as you set a reasonable threshold on 
usefulness.

> Insert/extract make a reasonable case for themselves, but actually
> arrived in MIPS32 release 2 as part of a bunch of other bit-shuffle
> instructions (also includes rotates and various byte-swaps) which -
> together - help quite a bit to manipulate sub-word data in registers.

 I see.  Actually all of them are a bit redundant, often replaceable with
short sequences of other instructions, but I guess code compacting may
matter more for the embedded environment than for general-purpose
computing.

 And while we are at instruction usefulness -- why are there the "di" and
"ei" instructions, but there is no a complement instruction, say "si" (for
"set interrupts"), that would copy bit #0 from a GPR to cp0.status.ie
compactly and atomically?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
