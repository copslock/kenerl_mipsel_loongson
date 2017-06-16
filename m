Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 10:47:12 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:60991 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993859AbdFPIrDkpw1U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 10:47:03 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A4FF468BDB; Fri, 16 Jun 2017 10:47:01 +0200 (CEST)
Date:   Fri, 16 Jun 2017 10:47:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 28/44] sparc: remove arch specific dma_supported
        implementations
Message-ID: <20170616084701.GE10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-29-hch@lst.de> <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58512
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

On Fri, Jun 09, 2017 at 12:22:48AM +1000, Julian Calaby wrote:
> I'm guessing there's a few places that have DMA ops but DMA isn't
> actually supported. Why not have a common method for this, maybe
> "dma_not_supported"?

It's not common at all.  Except for sbus all dma API user first
call set_dma_mask which ends up in the dma_supported call.  sbus
is the weird outlier here.
