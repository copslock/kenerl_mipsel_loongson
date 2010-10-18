Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 21:19:41 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44760 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491866Ab0JRTTi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Oct 2010 21:19:38 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9IJJbRv014177;
        Mon, 18 Oct 2010 20:19:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9IJJap1014175;
        Mon, 18 Oct 2010 20:19:36 +0100
Date:   Mon, 18 Oct 2010 20:19:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
Message-ID: <20101018191936.GH27377@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
 <4CBC4F4E.5010305@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CBC4F4E.5010305@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 10:44:46PM +0900, Shinya Kuribayashi wrote:

> I suspect that SYNC insn alone is still not enough, insn't it?  In
> such systems with that 'deep' write buffer and data incoherency is
> visibly observed, there sill may be data write transactions floating
> in the internal bus system.

A SYNC in theory should ensure global visibilty of preceding writes and
completion of earlier reads.  That usually works between CPUs but not
all I/O systems fully participate in that "consistency domain" so more
or less arbitary shaking of the I/O system may still be required to to
achieve consistency.

> To make sure that all data (data inside processor's write buffer and
> data floating in the internal bus system), we need the following
> three steps:
> 
> 1. Flush data cache
> 2. Uncached, dummy load operation from _DRAM_ (not somewhere else)
> 3. then SYNC instruction
> 
> With these steps, data in write buffer will be pushed out of the
> processor's write buffer, wait for uncached load operation to be
> completed, and then finally the pipeline gets cleared.  Thoughts?

I'm trying to get a statement from the MIPS architecture guys if the
necessity to do anything beyond a cache flush is an architecture violation.

Don't worry, I'm not going to refuse patches for something just because
it's not complying to a piece of paper as long as the silicon is in the
wild.

  Ralf
