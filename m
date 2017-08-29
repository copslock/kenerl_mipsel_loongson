Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 14:59:41 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:34154 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994929AbdH2M7aR-hrl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 14:59:30 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 85FD268C68; Tue, 29 Aug 2017 14:59:28 +0200 (CEST)
Date:   Tue, 29 Aug 2017 14:59:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: consolidate coherent and non-coherent dma_alloc
        code
Message-ID: <20170829125927.GA28540@lst.de>
References: <20170616071229.16954-1-hch@lst.de> <20170829125455.GB15640@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829125455.GB15640@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Tue, Aug 29, 2017 at 02:54:55PM +0200, Ralf Baechle wrote:
> On Fri, Jun 16, 2017 at 09:12:29AM +0200, Christoph Hellwig wrote:
> 
> > Besides eliminating lots of duplication this also allows allocations with
> > the DMA_ATTR_NON_CONSISTENT to use the CMA allocator.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

I don't have anything that depends on it - do you just want to pick
it up in the mips tree?

> > Note: compile tested only.
> 
> Your change essentially reverts a change from Oct 2007 so it should work.

Which commit is that?  I can't find anything that looks related in the
Oct 2017 commits.
