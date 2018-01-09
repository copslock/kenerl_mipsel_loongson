Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 19:31:12 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:60937 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993599AbeAISbGCQjRh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jan 2018 19:31:06 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E3E9668CFA; Tue,  9 Jan 2018 19:31:03 +0100 (CET)
Date:   Tue, 9 Jan 2018 19:31:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>,
        David Daney <ddaney@cavium.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: mb() calls in octeon / loongson swiotlb dma_map_ops
Message-ID: <20180109183103.GA13983@lst.de>
References: <20171230160928.GB3883@lst.de> <CAAhV-H4fzuocu6wx3kmTO96vY-0YkRqQboqtRVXzn7b0YZSS6Q@mail.gmail.com> <0fa48a91-6987-85e8-49fc-d39c5461be1e@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa48a91-6987-85e8-49fc-d39c5461be1e@caviumnetworks.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61963
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

On Thu, Jan 04, 2018 at 05:21:17PM -0800, David Daney wrote:
> It has been a while since I wrote that code.  It is possible that the 
> barriers are redundant.
>
> On OCTEON, we the primitive that accomplishes the DMA-Sync operation is the 
> MIPS "SYNC" instruction, which ensures that all stores are committed to the 
> coherency point (L2 Cache) before the DMA is initiated.  The mb(), is 
> implemented as SYNC, so we use that instead of open coding the 'asm 
> volatile("sync" ::: "memory);' in the SWIOTLB operations.

Ok.  And given that apparently octeon only uses swiotlb ops that's where
they were fitted in, instead of dma_cache_wback.

> Does the SWIOTLB DMA mapping code chain to the underlying systems DMA 
> mapping?  If so, the barriers there would be all that is necessary.

It doesn't.  But it also seems the underlying mips_default_dma_map_ops
ops is using entirely different interface for cache writeback before
dma.
