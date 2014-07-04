Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 10:52:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44481 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818481AbaGDIwvU-7b0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 10:52:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s648qmrY005656;
        Fri, 4 Jul 2014 10:52:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s648qkfe005648;
        Fri, 4 Jul 2014 10:52:46 +0200
Date:   Fri, 4 Jul 2014 10:52:46 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ed Swierk <eswierk@skyportsystems.com>, linux-mips@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704085246.GH13532@linux-mips.org>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140704080641.GY804@pburton-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Jul 04, 2014 at 09:06:41AM +0100, Paul Burton wrote:

> Yes, I think it would. The reason I went with the per-mm approach though
> was to try to avoid so much overhead. I suppose we could possibly
> allocate the page on demand so that threads which don't use FP don't pay
> for it, and maybe use the shrinker interface to free the page if we run
> low on memory and aren't currently executing from it. Though it would
> mean that the FP branch delay "emulation" could fail if memory is tight,
> but I suppose that's no worse than now where it could blow the (user)
> stack.
> 
> I'll try to get a v3 out at some point soon.

The actual piece of code that needs to be installed is tiny.  So the page
could be shared between many threads.  In fact a single page would
suffice for most processes and only threads would require more slots
than provided by a single page so more pags could be allocated or the
process could sleep until a slot becomes available.

Assuming the smallest supported page size of 4k and slots of 128 bytes
(that is the largest S-cache line size in common use) that's 32 slots.

I'm also wondering how insane emulation would be.  We already have the
capability to emulate a fair fraction of the instruction set.

  Ralf
