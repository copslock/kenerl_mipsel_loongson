Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 14:46:43 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:36625 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224911AbUHTNqj>;
	Fri, 20 Aug 2004 14:46:39 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1By9tj-0003MH-00; Fri, 20 Aug 2004 14:57:39 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1By9ie-0001B8-00; Fri, 20 Aug 2004 14:46:12 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1By9ie-0002nS-00; Fri, 20 Aug 2004 14:46:12 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16678.163.774841.111369@arsenal.mips.com>
Date: Fri, 20 Aug 2004 14:46:11 +0100
To: Jun Sun <jsun@mvista.com>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
In-Reply-To: <20040819221646.GC8737@mvista.com>
References: <20040804152936.D6269@mvista.com>
	<16676.46694.564448.344602@arsenal.mips.com>
	<20040819221646.GC8737@mvista.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.848, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Jun Sun (jsun@mvista.com) writes:

> > [large expanse of new ABI stuff omitted]
>
> What is the motivation of other changes?  Taking this chance to make
> things all right in one shot?

Yes, and I did kind of cover this in the large expanse of stuff:

> > As you said, this motivates a revision of the ABI.  Any
> > incompatible change to the ABI is painful, since everything has to
> > be recompiled; so our reasoning at the moment is that we might as
> > well be radical...

o32 puts only four arguments in registers, which is less than optimal,
and continually reloads the GOT pointer (which is not defined as a
saved register in o32).

n32 (despite its name) runs exclusively on 64-bit CPUs.

So yes, we have strong reasons for making a larger change to the ABI,
and knowing how difficult it is...

> However, from NPTL implementation point of view I really just care
> about the per-thread register.

I guess our main message was that we felt it would be a mistake just
to add a thread register to o32 (which produces a substantially
incompatible new ABI anyway).

Until that all works, what we had in mind is that we'd do NPTL over
o32 by defining a system call to return a per-thread ID which is or
can be converted into a per-thread data pointer.  We suspected that
NPTL's per-thread-data model allows the use of cunning macros or
library functions to make that look OK.

Ought we to go further and see exactly how that can be done?

--
Dominic
