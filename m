Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 17:35:47 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:62220 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225732AbUGNQfi>;
	Wed, 14 Jul 2004 17:35:38 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BkmvQ-0007Vc-00; Wed, 14 Jul 2004 17:48:08 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Bkmj2-0007aP-00; Wed, 14 Jul 2004 17:35:20 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1Bkmj2-0006WL-00; Wed, 14 Jul 2004 17:35:20 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16629.24775.778491.754688@arsenal.mips.com>
Date: Wed, 14 Jul 2004 17:35:19 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Kevin D. Kissell" <KevinK@mips.com>,
	S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
In-Reply-To: <20040713003317.GA26715@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
	<20040710100412.GA23624@linux-mips.org>
	<00ba01c46823$3729b200$0deca8c0@Ulysses>
	<20040713003317.GA26715@linux-mips.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.848, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> > A truly safe and general I-cache flush routine should itself run
> > uncached... 

It depends what you mean by general, and uncached is not the only
option.  The spec says:

 "The operation of the instruction is UNPREDICTABLE if the cache line
  that contains the CACHE instruction is the target of an
  invalidate..." 

If you use hit-type cache operations in a kernel routine, then you're
safe.  I can't envisage any circumstance in which Linux would try to
invalidate kernel mainline code locations from the I-cache (well, you
might be doing something fabulous with debugging the kernel, but
that's not normal and you'd hardly expect to be able to support such
an activity with standard cache management calls).

So this problem can only arise on index-type I-cache invalidation.  I
claim that a running kernel on a MIPS CPU should only use index-type
invalidation when it is necessary to invalidate the entire I-cache.
(If you use index-type operations for a range which doesn't resolve to
"the whole cache" then that should be fixed).

That implies that a MIPS32-paranoid "invalidate-whole-I-cache" routine
should:

1. Identify which indexes might alias to cache lines 
   containing the routines's own 'cache invalidate' instruction(s),
   and thus hit the problem.  There won't be that many of them.

2. Arrange to skip those indexes when zapping the cache, then do
   something weird to invalidate that handful of lines.  You could 
   do that by running uncached, but you could also do it just by using
   some auxiliary routine which is known to be more than a cache line
   but much less than a whole I-cache span distant, so can't possibly
   alias to the same thing...

This is fiddly, but not terribly difficult and should have a
negligible performance impact.

Does that make sense?  Am I now, having named the solution,
responsible for figuring out a patch (yeuch, I never wanted to be a
kernel programmer again...).

--
Dominic Sweetman
MIPS Technologies
