Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 08:56:20 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:59763 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992827AbeAZH4NIspXj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 08:56:13 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D30D068D62; Fri, 26 Jan 2018 08:56:12 +0100 (CET)
Date:   Fri, 26 Jan 2018 08:56:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     James Hogan <jhogan@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
        loongson_dma_map_ops
Message-ID: <20180126075612.GD2356@lst.de>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com> <20180124140234.GF5446@saruman> <20180124141144.GB25393@lst.de> <20180124150304.GG5446@saruman> <20180124152904.GA29244@lst.de> <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com> <20180125075520.GA3270@saruman> <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62333
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

On Thu, Jan 25, 2018 at 04:44:36PM +0800, Huacai Chen wrote:
> Yes, kmalloc()'d memory with the appropriate GFP_DMA flags can be

You should never use GFP_DMA in kmalloc calls in new code.

> synced using the dma_map_*() and dma_unmap_*() functions. So,
> loongson_dma_map_page()/loongson_dma_unmap_page() (which is the
> backend of dma_map_*() and dma_unmap_*()) should call dma_cache_sync()
> for non-coherent devices, right?

No, it should call the internal dma sync for device/cpu calls, as already
explained by James.  Note that for 4.17 or 4.18 I plan to extent
the dma-direct work to not dma coherent systems, so we'll get an
explicit and document ABI for those across platforms.  That is if
I can pull it off as it doesn't seem entirely trivial.
