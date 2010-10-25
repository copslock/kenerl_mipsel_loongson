Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 15:43:20 +0200 (CEST)
Received: from bombadil.infradead.org ([18.85.46.34]:34750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab0JYNnQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 15:43:16 +0200
Received: from hch by bombadil.infradead.org with local (Exim 4.72 #1 (Red Hat Linux))
        id 1PANKR-00015v-26; Mon, 25 Oct 2010 13:43:11 +0000
Date:   Mon, 25 Oct 2010 09:43:11 -0400
From:   Christoph Hellwig <hch@infradead.org>
To:     Ajeet Yadav <ajeet.yadav.77@gmail.com>
Cc:     xfs@oss.sgi.com, linux-mips@linux-mips.org
Subject: Re: XFS: bad clientid on recovery on MIPS (VIPT cache)
Message-ID: <20101025134310.GA3758@infradead.org>
References: <AANLkTi=wbBhb=s3z9vyw9gL9Qwy0goj+8UtueFyNq+y2@mail.gmail.com>
 <20101021125219.GA21472@infradead.org>
 <AANLkTimFuG6cVLkYt+7-Y_8PnapFvmry5RUcmpOHaPco@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimFuG6cVLkYt+7-Y_8PnapFvmry5RUcmpOHaPco@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+b75f2e5d2b612c62c23b+2619+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 21, 2010 at 06:57:15PM +0530, Ajeet Yadav wrote:
> Thanks for response,
> 
> Linux kernel I am using is 2.6.30, where as XFS I have ported until 2.6.34
> on given kernel.
> Do you think I need the mentioned API
> flush_kernel_vmap_range/invalidate_kernel_vmap_range in 2.6.30.9 as well.I
> will be grateful if you can provide me sample code for the above API.

I don't really know how to implement it - it's up to the cache
architecture.  Take a look at the existing implementations in 2.6.34+
kernels and possibly ask on the Linux-mips mainglinglist how to
implement it.
