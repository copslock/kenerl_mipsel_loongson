Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 16:54:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56868 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492453Ab0BXPy0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 16:54:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OFsPlA024321;
        Wed, 24 Feb 2010 16:54:25 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OFsP4Z024320;
        Wed, 24 Feb 2010 16:54:25 +0100
Date:   Wed, 24 Feb 2010 16:54:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Optimize spinlocks.
Message-ID: <20100224155424.GA24316@linux-mips.org>
References: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com>
 <20100224155336.GA5130@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100224155336.GA5130@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 04:53:36PM +0100, Ralf Baechle wrote:

> And in your benchmarking patch you wrote:
> 
> > 		  spin_single	spin_multi
> > base		  106885	247941
> > spinlock_patch  75194		219465
> 
> I did some benchmarking on an IP27 (180MHz, 2 CPU, needs LL/SC workaround):
> 
> 		spin_single	spin_multi
> base		229341		3505690
> spinlock_patch	177847		3615326
> 
> So about 22% speedup for spin_single but 3% slowdown for spin_multi.
> 
> Disabling the R10k LL/SC workaround btw. gives another 23% speedup for
> spin_single and marginal 0.3% for spin_multi; the latter may well be
> statistical noise.

And I forgot the most important - patch queued for 2.6.34.

Thanks!

  Ralf
