Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 12:44:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56254 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493323AbZKRLo0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 12:44:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAIBiX9D005971;
	Wed, 18 Nov 2009 12:44:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAIBiWrD005969;
	Wed, 18 Nov 2009 12:44:32 +0100
Date:	Wed, 18 Nov 2009 12:44:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	figo zhang <figo1802@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: how i can know the linux-mips implememt cache strategy?
Message-ID: <20091118114432.GA17418@linux-mips.org>
References: <c6ed1ac50911171859k24685b32m237afd68f63c626f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ed1ac50911171859k24685b32m237afd68f63c626f@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 18, 2009 at 10:59:43AM +0800, figo zhang wrote:

> I am porting 24KEC soc to linux new, i have see the mips-kernel impement
> cache strategy: invalid and write-back,
> is it right?  is it implement the write-through strategy? see in
> include/asm-mips/r4kcache.h
> 
> how i can know the kernel using which cache strategy in user space, such
> as how can see the /proc system to know it?

The kernel will always use cache stategy 3 for non-coherent systems and
caching strategy 5 for cache coherent systems.  These two select the most
aggressive caching strategy on all processors and that's what gives the
best performance.

I think write through is just not worth thinking about it.  Early 4K
cores did only implement write through; later models added write-back and
as the result have significantly improved performance.

Minor optimizations of the cacheflush operations for write-through caches
would be possible but I expect only small gains.  R4kcache.h implements a
bunch of helper functions that iterate over memory areas; optimizations
for write-through caches should be done by the callers of these helper
functions.

Again, if you have write-back caches don't even think about write-though.
It almost certainly less effective.

  Ralf
