Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 12:52:50 +0000 (GMT)
Received: from alg133.algor.co.uk ([62.254.210.133]:19183 "EHLO
	oalggw.algor.co.uk") by linux-mips.org with ESMTP
	id <S8225268AbSLLMwt>; Thu, 12 Dec 2002 12:52:49 +0000
Received: from arsenal.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gBCCqmW24310;
	Thu, 12 Dec 2002 12:52:48 GMT
Received: from dom by arsenal.algor.co.uk with local (Exim 3.35 #1 (Debian))
	id 18MSpW-0005T5-00; Thu, 12 Dec 2002 12:52:42 +0000
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15864.34458.46732.218720@arsenal.algor.co.uk>
Date: Thu, 12 Dec 2002 12:52:42 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Vivien Chappelier <vivienc@nerim.net>,
	linux-mips@linux-mips.org, Ilya Volynets <ilya@theilya.com>
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
In-Reply-To: <20021212132022.A5060@linux-mips.org>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor>
	<1039656676.18587.63.camel@irongate.swansea.linux.org.uk>
	<20021212033307.C22987@linux-mips.org>
	<1039697045.21231.13.camel@irongate.swansea.linux.org.uk>
	<20021212132022.A5060@linux-mips.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> Flushes are very expensive operations, on the order of 16 cycles per
> cacheline plus memory delay.

Hmm.  Not on most MIPS CPUs; the internal cost of running the
writeback cache-op instructions is typically around 3 clocks per
cache-line.  But this is misleading anyway... too CPU-centric.

The associated memory operations are the slowest thing about cacheops,
always.  Memory accesses (120ns is good) are much, much slower than an
instruction time on a modern CPU (1-5ns).

So for your framebuffer, it's the write which does for you.  If you
use uncached mode and write 32-bit words that's 120ns/word.  You can
get a cacheline-sized burst of 8 words in and out in roughly the same
amount of time.

In most cases this means that cacheing the framebuffer and then
pushing it out will save a whole lot of time.  

It's not absolutely certain: in most MIPS CPUs (write allocate as well
as writeback) you also pay to read in the framebuffer data.  And it
tends to displace all sorts of other useful data from the cache, and
then you have to pay to bring it back again.

But in general the memory operations associated with write-backs and
invalidates are much more costly than the cacheops themselves.

-- 
Dominic Sweetman, 
MIPS Technologies (UK)
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706205 / fax: +44 1223 706250 / swbrd: +44 1223 706200
http://www.algor.co.uk
