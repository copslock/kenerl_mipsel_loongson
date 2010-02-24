Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 16:53:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56663 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492453Ab0BXPxm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 16:53:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OFrdFV024294;
        Wed, 24 Feb 2010 16:53:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OFrbfB024293;
        Wed, 24 Feb 2010 16:53:37 +0100
Date:   Wed, 24 Feb 2010 16:53:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Optimize spinlocks.
Message-ID: <20100224155336.GA5130@linux-mips.org>
References: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 04, 2010 at 11:31:49AM -0800, David Daney wrote:

> The current locking mechanism uses a ll/sc sequence to release a
> spinlock.  This is slower than a wmb() followed by a store to unlock.
> 
> The branching forward to .subsection 2 on sc failure slows down the
> contended case.  So we get rid of that part too.
> 
> Since we are now working on naturally aligned u16 values, we can get
> rid of a masking operation as the LHU already does the right thing.
> The ANDI are reversed for better scheduling on multi-issue CPUs
> 
> On a 12 CPU 750MHz Octeon cn5750 this patch improves ipv4 UDP packet
> forwarding rates from 3.58*10^6 PPS to 3.99*10^6 PPS, or about 11%.

And in your benchmarking patch you wrote:

> 		  spin_single	spin_multi
> base		  106885	247941
> spinlock_patch  75194		219465

I did some benchmarking on an IP27 (180MHz, 2 CPU, needs LL/SC workaround):

		spin_single	spin_multi
base		229341		3505690
spinlock_patch	177847		3615326

So about 22% speedup for spin_single but 3% slowdown for spin_multi.

Disabling the R10k LL/SC workaround btw. gives another 23% speedup for
spin_single and marginal 0.3% for spin_multi; the latter may well be
statistical noise.

  Ralf
