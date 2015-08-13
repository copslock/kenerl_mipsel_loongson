Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 16:40:38 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:38601 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012053AbbHMOkhmGIKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 16:40:37 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B632D691EC; Thu, 13 Aug 2015 16:40:36 +0200 (CEST)
Date:   Thu, 13 Aug 2015 16:40:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        axboe@kernel.dk, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-nvdimm@ml01.01.org,
        dhowells@redhat.com, sparclinux@vger.kernel.org,
        egtvedt@samfundet.no, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org, dwmw2@infradead.org,
        hskinnemoen@gmail.com, linux-xtensa@linux-xtensa.org,
        grundler@parisc-linux.org, realmz6@gmail.com,
        alex.williamson@redhat.com, linux-metag@vger.kernel.org,
        monstr@monstr.eu, linux-parisc@vger.kernel.org,
        vgupta@synopsys.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-media@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: RFC: prepare for struct scatterlist entries without page
        backing
Message-ID: <20150813144036.GB17375@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <55CB3F47.3000902@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55CB3F47.3000902@plexistor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48863
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

On Wed, Aug 12, 2015 at 03:42:47PM +0300, Boaz Harrosh wrote:
> The support I have suggested and submitted for zone-less sections.
> (In my add_persistent_memory() patchset)
>
> Would work perfectly well and transparent for all such multimedia cases.
> (All hacks removed). In fact I have loaded pmem (with-pages) on a VRAM
> a few times and it is great easy fun. (I wanted to experiment with cached
> memory over a pcie)

And everyone agree that it was both buggy and incomplete.

Dan has done a respin of the page backed nvdimm work with most of
these comments addressed.

I have to say I hate both pfn-based I/O [1] and page backed nvdimms with
passion, so we're looking into the lesser evil with an open mind.

[1] not the SGL part posted here, which I think is quite sane.  The bio
    side is much worse, though.
