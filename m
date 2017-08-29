Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 15:21:07 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:34299 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994931AbdH2NU5QJVYl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 15:20:57 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 052E068C5A; Tue, 29 Aug 2017 15:20:57 +0200 (CEST)
Date:   Tue, 29 Aug 2017 15:20:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: consolidate coherent and non-coherent dma_alloc
        code
Message-ID: <20170829132056.GA30271@lst.de>
References: <20170616071229.16954-1-hch@lst.de> <20170829125455.GB15640@linux-mips.org> <20170829125927.GA28540@lst.de> <20170829131833.GD22412@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829131833.GD22412@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59866
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

On Tue, Aug 29, 2017 at 03:18:33PM +0200, Ralf Baechle wrote:
> > > Your change essentially reverts a change from Oct 2007 so it should work.
> > 
> > Which commit is that?  I can't find anything that looks related in the
> > Oct 2017 commits.
> 
> Well, it predates the git history so it indeed is hard to find:
> 
> https://git.linux-mips.org/cgit/ralf/linux.git/commit/?id=7ca16d269a1a4b96d98968b48f137977bcab1522

That looks like a different commit from a different series than the
one you replied to.  But I'll happily take the ACK for that one :)
