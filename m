Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 09:04:34 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:2052 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225349AbTLOJEe>;
	Mon, 15 Dec 2003 09:04:34 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AVoaz-0005s1-00; Mon, 15 Dec 2003 09:00:53 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AVoeA-0005x2-00; Mon, 15 Dec 2003 09:04:11 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16349.31025.637084.624143@doms-laptop.algor.co.uk>
Date: Mon, 15 Dec 2003 09:04:49 +0000
To: Peter Horton <pdh@colonel-panic.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Instability / caching problems on Qube 2 - solved ?
In-Reply-To: <20031215083236.GA1164@skeleton-jack>
References: <20031214162605.GA18357@skeleton-jack>
	<20031215022717.GA16560@linux-mips.org>
	<20031215083236.GA1164@skeleton-jack>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.079, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


My prejudices are showing but...

o Shouldn't the kernel should have a zero-tolerance policy towards cache
  aliases?  That is, no D-cache alias should ever be permitted to
  happen, not even in data you reasonably hope might be read-only?
  
  Aliases only appeared by a kind of mistake when the R4000 was
  opportunistically repackaged without the secondary cache (the L2
  cache tags used to keep track of the virtually-indexed L1s, and you
  got an exception if you created an L1-alias).

  They really aren't a feature to be tolerated in the hope you can
  clean up before disaster strikes.

o And I could never get my brains round cache maintenance if I used
  the same word ("flush") both for invalidate and write-back.

--
Dominic Sweetman
MIPS Technologies.
