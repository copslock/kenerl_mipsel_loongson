Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 13:02:27 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:64971 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224924AbUGNMCW>; Wed, 14 Jul 2004 13:02:22 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 990AE36DB2; Wed, 14 Jul 2004 14:02:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B8A3235196; Wed, 14 Jul 2004 14:02:15 +0200 (CEST)
Date: Wed, 14 Jul 2004 14:02:15 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Kevin D. Kissell" <KevinK@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
In-Reply-To: <003301c468ee$80c5fa60$0deca8c0@Ulysses>
Message-ID: <Pine.LNX.4.55.0407141235120.4513@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <003301c468ee$80c5fa60$0deca8c0@Ulysses>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 13 Jul 2004, Kevin D. Kissell wrote:

> > That's a new restriction in MIPS32 v2.0 and you're right, we're not trying
> > to deal with it yet except for the TX49xx.
> 
> I'm pretty sure that restriction is not new to MIPS32 v2.0.  In any

 The restriction was apparently added in revision 1.00 of the MIPS32
architecture vol.II document.  I don't have that revision -- I have
versions 0.95 and 2.00 only -- without looking at the revision history in
2.00 I'd expect the original MIPS32 spec not to enforce such a
restriction, either.

> case, there are pre-MIPS32/MIPS64 chips in current mass production
> and use, under Linux among other OSes, which specify in their user
> manuals that one should not invalidate the Icache line from which one
> is currently executing.  The clause about unpredictable behavior in
> that case went into the MIPS32 spec because it was known that such
> parts existed, and we wanted to make it as easy as possible for such 
> designs to be made compliant

 Ugh, although I can imagine valid arguments for such a decision.

> Invalidating the entire Icache with a routine executing out of the Icache
> is a Bad Idea, and will almost certainly cause problems some of the time
> on some MIPS processors.  Reasonable people could disagree on whether
> we want to handle that in the generic code, or create a variant icache flush 
> routine which gets plugged in only for those parts that really need it.

 As executing code from an uncached space is terribly slow, there are at
least two points of optimization:

1. The Icache invalidation handler should run cached on processors known
to handle it gracefully.

2. For others, as you suggest, it should attempt to figure out whether its
code may invalidate itself and run uncached then, perhaps for the
problematic lines only.

  Maciej
