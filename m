Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 14:55:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48462 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994931AbdH2My4SDZ4l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 14:54:56 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7TCstvo024300;
        Tue, 29 Aug 2017 14:54:55 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7TCstNQ024299;
        Tue, 29 Aug 2017 14:54:55 +0200
Date:   Tue, 29 Aug 2017 14:54:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: consolidate coherent and non-coherent dma_alloc
 code
Message-ID: <20170829125455.GB15640@linux-mips.org>
References: <20170616071229.16954-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616071229.16954-1-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59862
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

On Fri, Jun 16, 2017 at 09:12:29AM +0200, Christoph Hellwig wrote:

> Besides eliminating lots of duplication this also allows allocations with
> the DMA_ATTR_NON_CONSISTENT to use the CMA allocator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

> Note: compile tested only.

Your change essentially reverts a change from Oct 2007 so it should work.

  Ralf
