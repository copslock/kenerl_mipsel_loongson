Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 15:17:22 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53713 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992155AbdFTNRLxeaXn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 15:17:11 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9520D7FC0D; Tue, 20 Jun 2017 15:17:11 +0200 (CEST)
Date:   Tue, 20 Jun 2017 15:17:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
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
Subject: Re: clean up and modularize arch dma_mapping interface
Message-ID: <20170620131711.GC30769@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58688
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

On Tue, Jun 20, 2017 at 11:19:02AM +0200, Daniel Vetter wrote:
> Ack for the 2 drm patches, but I can also pick them up through drm-misc if
> you prefer that (but then it'll be 4.14).

Nah, I'll plan to set up a dma-mapping tree so that we'll have common
place for dma-mapping work.
