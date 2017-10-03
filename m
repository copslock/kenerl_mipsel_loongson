Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 22:27:34 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:44931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993411AbdJCU11ksiUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 22:27:27 +0200
Received: from p4fea5b32.dip0.t-ipconnect.de ([79.234.91.50] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dzTmV-0001wO-70; Tue, 03 Oct 2017 22:27:07 +0200
Date:   Tue, 3 Oct 2017 22:27:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Christoph Hellwig' <hch@lst.de>,
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
Subject: RE: [PATCH 02/11] x86: make dma_cache_sync a no-op
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.20.1710032214370.2278@nanos>
References: <20171003104311.10058-1-hch@lst.de> <20171003104311.10058-3-hch@lst.de> <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 3 Oct 2017, David Laight wrote:

> From: Christoph Hellwig
> > Sent: 03 October 2017 11:43
> > x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> > make any sense to do any work in dma_cache_sync given that it must be a
> > no-op when dma_alloc_attrs returns coherent memory.
> 
> I believe it is just about possible to require an explicit
> write flush on x86.
> ISTR this can happen with something like write combining.

As the changelog says: x86 only implements dma_alloc_coherent() which as
the name says returns coherent memory, i.e. type WB (write back), which is
not subject to dma_cache_sync() operations.

If the driver converts that memory to WC (write combine) on its own via
PAT/MTRR, then it needs to take care of flushing the write buffer on its
own. It's not convered by this interface.

Thanks,

	tglx
