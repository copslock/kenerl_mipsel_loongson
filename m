Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2006 19:51:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:25318 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133887AbWFDRvo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2006 19:51:44 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k54HpVpw008187;
	Sun, 4 Jun 2006 18:51:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k54HpT6I008186;
	Sun, 4 Jun 2006 18:51:29 +0100
Date:	Sun, 4 Jun 2006 18:51:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Prasad Boddupalli <bprasad@cs.arizona.edu>,
	linux-mips@linux-mips.org
Subject: Re: replacing synthesized tlb handlers with older ones
Message-ID: <20060604175128.GA3790@linux-mips.org>
References: <e8180c7f0606021139w6d26e03eice708d5076cccf64@mail.gmail.com> <01b401c68678$98199a10$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b401c68678$98199a10$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 02, 2006 at 09:13:11PM +0200, Kevin D. Kissell wrote:

> The TLB refill handler behavior for 1 CPU is fundamentally
> different than for SMP.  In the uniprocessor case, the page
> table origin is implicit, whereas in SMP it needs to be indexed
> by some per-CPU value, typically maintained in the Context
> register.  Pre-synthesed kernels set up up so that the Context
> value would be shifted left 23 bits, then right by 2 bits, to generate
> an offset.  The newer system eliminates the right shift by ensuring
> that the CPU index is stored in a pre-scaled form, and that bits
> 23 and 24 are zero.  So you can't just drop the old code into
> the newer kernel, unless you also change the setup of Context.
> A single CPU would work, because 0 == 0, otherwise...
> Try nuking those right shifts.

And beyond that, the old ones hardly made any reasonable attempt at
getting TLB hazard handling right, so depending on hardware they will
blow up.

  Ralf
