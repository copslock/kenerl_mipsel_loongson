Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 16:29:11 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:52528 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbeAXP3E4B6YX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 16:29:04 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7FE4368D62; Wed, 24 Jan 2018 16:29:04 +0100 (CET)
Date:   Wed, 24 Jan 2018 16:29:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     James Hogan <jhogan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
        loongson_dma_map_ops
Message-ID: <20180124152904.GA29244@lst.de>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com> <20180124140234.GF5446@saruman> <20180124141144.GB25393@lst.de> <20180124150304.GG5446@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124150304.GG5446@saruman>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62317
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

On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
> I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
> applicable then unless Huacai adds some explanation.

In addition there also is no driver that can be used on loongsoon
that actually calls dma_cache_sync either.
