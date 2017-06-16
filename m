Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 10:45:49 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:60949 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993859AbdFPIpnWL2oU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 10:45:43 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0383768D1E; Fri, 16 Jun 2017 10:45:43 +0200 (CEST)
Date:   Fri, 16 Jun 2017 10:45:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/44] sparc: remove leon_dma_ops
Message-ID: <20170616084542.GD10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-28-hch@lst.de> <593E4B82.70306@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593E4B82.70306@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58511
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

On Mon, Jun 12, 2017 at 10:06:26AM +0200, Andreas Larsson wrote:
> Yes, it is needed. LEON systems are AMBA bus based. The common case here is 
> DMA over AMBA buses. Some LEON systems have PCI bridges, but in general 
> CONFIG_PCI is not a given.

Ok, and even for AMBA we use the pci ops, so I'll leave it in and drop
the comment from the commit.
