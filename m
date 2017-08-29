Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 15:18:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50046 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994931AbdH2NSeVgaLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 15:18:34 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7TDIYmg026321;
        Tue, 29 Aug 2017 15:18:34 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7TDIXF7026319;
        Tue, 29 Aug 2017 15:18:33 +0200
Date:   Tue, 29 Aug 2017 15:18:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: consolidate coherent and non-coherent dma_alloc
 code
Message-ID: <20170829131833.GD22412@linux-mips.org>
References: <20170616071229.16954-1-hch@lst.de>
 <20170829125455.GB15640@linux-mips.org>
 <20170829125927.GA28540@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829125927.GA28540@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59865
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

On Tue, Aug 29, 2017 at 02:59:28PM +0200, Christoph Hellwig wrote:

> On Tue, Aug 29, 2017 at 02:54:55PM +0200, Ralf Baechle wrote:
> > On Fri, Jun 16, 2017 at 09:12:29AM +0200, Christoph Hellwig wrote:
> > 
> > > Besides eliminating lots of duplication this also allows allocations with
> > > the DMA_ATTR_NON_CONSISTENT to use the CMA allocator.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> I don't have anything that depends on it - do you just want to pick
> it up in the mips tree?

Sure, done.

> > > Note: compile tested only.
> > 
> > Your change essentially reverts a change from Oct 2007 so it should work.
> 
> Which commit is that?  I can't find anything that looks related in the
> Oct 2017 commits.

Well, it predates the git history so it indeed is hard to find:

https://git.linux-mips.org/cgit/ralf/linux.git/commit/?id=7ca16d269a1a4b96d98968b48f137977bcab1522

  Ralf
