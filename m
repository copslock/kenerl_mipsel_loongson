Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 11:47:47 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:55457 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993420AbdFZJrkZCedK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jun 2017 11:47:40 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DCD1D68B00; Mon, 26 Jun 2017 11:47:39 +0200 (CEST)
Date:   Mon, 26 Jun 2017 11:47:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, tndave <tushar.n.dave@oracle.com>,
        linux-mips@linux-mips.org, linux-samsung-soc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
        openrisc@lists.librecores.org, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: clean up and modularize arch dma_mapping interface V2
Message-ID: <20170626094739.GB13981@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <162d7932-5766-4c29-5471-07d1b699190a@oracle.com> <20170624071855.GD14580@lst.de> <1498318616.31581.87.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498318616.31581.87.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58802
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

On Sat, Jun 24, 2017 at 10:36:56AM -0500, Benjamin Herrenschmidt wrote:
> I think we still need to do it. For example we have a bunch new "funky"
> cases.

I have no plan to do away with the selection - I just want a better
interface than the current one.
