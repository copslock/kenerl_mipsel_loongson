Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 11:06:40 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:38288 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990482AbdJDJGeGj1EX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Oct 2017 11:06:34 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 70CC468C8A; Wed,  4 Oct 2017 11:06:31 +0200 (CEST)
Date:   Wed, 4 Oct 2017 11:06:31 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 04/11] ia64: make dma_cache_sync a no-op
Message-ID: <20171004090631.GA23669@lst.de>
References: <20171003104311.10058-1-hch@lst.de> <20171003104311.10058-5-hch@lst.de> <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60247
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

On Wed, Oct 04, 2017 at 08:59:24AM +0000, David Laight wrote:
> Are you sure about this one?

Yes.  And if you are not you haven't read either of the cover letter,
the DMA-API documentation, or the reply from Thomas to your mail
yesterday.
