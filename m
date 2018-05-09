Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:55:03 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53128 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990392AbeENFy4n9LaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 07:54:56 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8C4D668CEE; Wed,  9 May 2018 07:03:06 +0200 (CEST)
Date:   Wed, 9 May 2018 07:03:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        sstabellini@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: centralize SWIOTLB config symbol and misc other cleanups V3
Message-ID: <20180509050306.GA18336@lst.de>
References: <20180425051539.1989-1-hch@lst.de> <20180502124617.GA22001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502124617.GA22001@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63896
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

On Wed, May 02, 2018 at 05:46:17AM -0700, Christoph Hellwig wrote:
> Any more comments?  Especially from the x86, mips and powerpc arch
> maintainers?  I'd like to merge this in a few days as various other
> patches depend on it.

I've pulled it in to make forward progress.  Any additional comments
will have to be sent in the form of incremental patches.
