Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 20:31:49 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40399 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492160Ab0D1Sbq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Apr 2010 20:31:46 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3SIVjkw006340;
        Wed, 28 Apr 2010 19:31:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3SIViYS006335;
        Wed, 28 Apr 2010 19:31:44 +0100
Date:   Wed, 28 Apr 2010 19:31:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yury Polyanskiy <ypolyans@princeton.edu>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] die() does not call die notifier chain
Message-ID: <20100428183143.GA5623@linux-mips.org>
References: <20100426005310.0786273f@penta.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100426005310.0786273f@penta.localdomain>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 26, 2010 at 12:53:10AM -0400, Yury Polyanskiy wrote:

Yuri,

> I think that the arch/mips implementation of die() forgets to call the
> notify_die() and thus notifiers registered via register_die_notifier()
> are not called.
> 
> For example this results in kgdb not being activated on exceptions.
> 
> The patch is very simple and attached: the only subtlety is that main
> notify_die declares regs argument w/o const, so I needed to remove const 
> from mips die() as well.

I'd have prefered to make all users of the reg pointer const in the hope
gcc can use that for optimization and to avoid stupid assignments via that
pointer but that turns out a significant problem on its own so I'm applying
your patch as is.

Please include a Signed-off-by: line (see Documentation/SubmittingPatches)
in future patches.  If your patch was any more complex than this I'd not
have considered it without one.

Thanks!

  Ralf
