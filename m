Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 22:05:51 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:52522 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993941AbeIYUFndd7Fk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Sep 2018 22:05:43 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1C5EA68AEF; Tue, 25 Sep 2018 22:05:43 +0200 (CEST)
Date:   Tue, 25 Sep 2018 22:05:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Paul Burton <paul.burton@mips.com>, Christoph Hellwig <hch@lst.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Message-ID: <20180925200542.GA8200@lst.de>
References: <20180911090049.10747-1-hch@lst.de> <20180921061052.GA13705@lst.de> <20180921194218.at7ejkmmiucmawzo@pburton-laptop> <62B54A6B-6E10-4A40-8E61-C1D23A853816@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62B54A6B-6E10-4A40-8E61-C1D23A853816@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66559
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

On Sat, Sep 22, 2018 at 12:24:33PM -0700, Florian Fainelli wrote:
> >My thought would be that it would be ideal to fix in 4.19 since that's
> >where the breakage is, but having said that I don't have much insight
> >into how bad the breakage is for the affected systems.
> 
> 
> AFAIR, DMA corruption is typically what you would observe, which could prove difficult if you are not exactly looking for it. In any case, I don't have a BMIPS system running 4.19 right now to exercise this on, but this looks correct:

Well, I originally intended it for 4.19, but without reviews from
the affected maintainers I'd fell bad about it.  Now that we've got
agreement I'll queue it for 4.19.
