Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 09:28:38 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:35817 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990399AbeAPI2ak4Op0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jan 2018 09:28:30 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7FA8368C7B; Tue, 16 Jan 2018 09:28:27 +0100 (CET)
Date:   Tue, 16 Jan 2018 09:28:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     christian.koenig@amd.com
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: consolidate swiotlb dma_map implementations
Message-ID: <20180116082827.GA9211@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180116075338.GB12693@infradead.org> <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62159
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

On Tue, Jan 16, 2018 at 09:22:52AM +0100, Christian König wrote:
> Hi Konrad,
>
> can you send the first patch to Linus for inclusion in 4.15 if you haven't 
> already done so?

It's in the 4.16 queue with a cc to stable.  I guess we're ok with
a duplicate commit if we have to.
