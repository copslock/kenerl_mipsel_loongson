Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 11:14:32 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:5592 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224991AbUCVLOb>; Mon, 22 Mar 2004 11:14:31 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 41BB04BAA4; Mon, 22 Mar 2004 12:14:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2E77E4B4FE; Mon, 22 Mar 2004 12:14:24 +0100 (CET)
Date: Mon, 22 Mar 2004 12:14:24 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <16478.46344.410904.489262@doms-laptop.algor.co.uk>
Message-ID: <Pine.LNX.4.55.0403221153280.6539@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
 <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com>
 <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
 <16473.44507.935886.271157@arsenal.mips.com> <Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
 <16478.46344.410904.489262@doms-laptop.algor.co.uk>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Dominic,

> But an important sub-class of embedded workloads are data intensive,
> where the data represents some sort of stream.  Basic data items are
> often 8- or 16-bits in size.  Existing RISC instruction sets end up
> bloating the inner loops of these programs, and it's marginal
> performance gains rather than code size which motivates us to make
> this work better.

 I see.  Though the associated code compaction reduces cache footprint
which improves performance as well.

> The 'di' is there to be atomic.  Such sequences are rare and code
> compactness is not an issue.  As you probably heard before, the use of
> a potentially-interruptible RMW sequence on the status register to
> disable interrupts is potentially troublesome (most common OS' manage
> themselves so it isn't an issue, but still...)

 Hmm, is the remaining minority of the OSes, that can't manage the
sequence, important enough to add such an instruction?  The atomicity of
this operation should only matter if interrupt handlers are expected to
leave interrupts disabled upon an exit to the same context -- such a setup
should be pretty rare.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
