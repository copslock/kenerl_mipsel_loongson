Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 13:33:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58986 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492437Ab0AMMdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jan 2010 13:33:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0DCXYh3020675;
        Wed, 13 Jan 2010 13:33:34 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0DCXYna020674;
        Wed, 13 Jan 2010 13:33:34 +0100
Date:   Wed, 13 Jan 2010 13:33:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Octeon: Use optimized memory barrier
 primitives.
Message-ID: <20100113123334.GB20354@linux-mips.org>
References: <4B47D8ED.1020006@caviumnetworks.com>
 <1262999864-2353-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1262999864-2353-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8518

On Fri, Jan 08, 2010 at 05:17:44PM -0800, David Daney wrote:

> In order to achieve correct synchronization semantics, the Octeon port
> had defined CONFIG_WEAK_REORDERING_BEYOND_LLSC.  This resulted in code
> that looks like:
> 
>    sync
>    ll ...
>    .
>    .
>    .
>    sc ...
>    .
>    .
>    sync
> 
> The second SYNC was redundant, but harmless.
> 
> Octeon has a SYNCW instruction that acts as a write-memory-barrier
> (due to an erratum in some parts two SYNCW are used).  It is much
> faster than SYNC because it imposes ordering on the writes, but
> doesn't otherwise stall the execution pipeline.  On Octeon, SYNC
> stalls execution until all preceeding writes are committed to the
> coherent memory system.
> 
> Using:
> 
>     syncw;syncw
>     ll
>     .
>     .
>     .
>     sc
>     .
>     .
> 
> Has identical semantics to the first sequence, but is much faster.
> The SYNCW orders the writes, and the SC will not complete successfully
> until the write is committed to the coherent memory system.  So at the
> end all preceeding writes have been committed.  Since Octeon does not
> do speculative reads, this functions as a full barrier.
> 
> The patch removes CONFIG_WEAK_REORDERING_BEYOND_LLSC, and substitutes
> SYNCW for SYNC in write-memory-barriers.

Queued for 2.6.34.  Thanks!

  Ralf
