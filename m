Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 17:53:29 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:53770 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224832AbUHTQxY>;
	Fri, 20 Aug 2004 17:53:24 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1ByCoK-0008IC-00; Fri, 20 Aug 2004 18:04:16 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ByCdB-0003v6-00; Fri, 20 Aug 2004 17:52:45 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1ByCdA-0002se-00; Fri, 20 Aug 2004 17:52:44 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16678.11356.115235.767617@arsenal.mips.com>
Date: Fri, 20 Aug 2004 17:52:44 +0100
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Dominic Sweetman <dom@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
In-Reply-To: <20040820131210.GE14937@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040804152936.D6269@mvista.com>
	<16676.46694.564448.344602@arsenal.mips.com>
	<20040820131210.GE14937@rembrandt.csv.ica.uni-stuttgart.de>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.348, required 4, AWL,
	BAYES_00, J_BACKHAIR_46)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Thiemo Seufer (ica2_ts@csv.ica.uni-stuttgart.de) writes:

> > So we're proposing:
> > 
> > o The register name<->number mapping is that of n64.
> > 
> > o Calling convention: register-, not slot-based. Each argument is
> >   represented by a register value. Arguments 0-7 travel in registers
> >   a0-7 (or fa0-7 as required for floating point types).
> 
> This suggests to have no fp temporaries left: fv0-1, fa0-7, fs0-5.
> Is this intentional?

No, there are lots really...

Long, long ago early MIPS CPUs had to use FP registers in pairs to get
FP doubles, so had only 16 effective registers.

But there are 32 real double-precision FP registers in all known
modern MIPS CPUs (well, all known pretty old ones, really) once you
turn off the backward-compatibility bit in the status register.  I
forgot to mention that... (or I could claim, weasel words, that this
is implied by the "name<->number mapping of n64").

--
Dominic
