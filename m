Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 09:10:17 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:34777 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011049AbbHLHI6RblNj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 09:08:58 +0200
Received: from p5de57192.dip0.t-ipconnect.de ([93.229.113.146] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZPQ9O-0001R2-4J; Wed, 12 Aug 2015 07:08:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, axboe@kernel.dk
Cc:     dan.j.williams@intel.com, vgupta@synopsys.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org,
        dwmw2@infradead.org, alex.williamson@redhat.com,
        grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
Subject: RFC: prepare for struct scatterlist entries without page backing
Date:   Wed, 12 Aug 2015 09:05:19 +0200
Message-Id: <1439363150-8661-1-git-send-email-hch@lst.de>
X-Mailer: git-send-email 1.9.1
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
        See http://www.infradead.org/rpr.html
Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48780
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

Dan Williams started to look into addressing I/O to and from
Persistent Memory in his series from June:

	http://thread.gmane.org/gmane.linux.kernel.cross-arch/27944

I've started looking into DMA mapping of these SGLs specifically instead
of the map_pfn method in there.  In addition to supporting NVDIMM backed
I/O I also suspect this would be highly useful for media drivers that
go through nasty hoops to be able to DMA from/to their ioremapped regions,
with vb2_dc_get_userptr in drivers/media/v4l2-core/videobuf2-dma-contig.c
being a prime example for the unsafe hacks currently used.

It turns out most DMA mapping implementation can handle SGLs without
page structures with some fairly simple mechanical work.  Most of it
is just about consistently using sg_phys.  For implementations that
need to flush caches we need a new helper that skips these cache
flushes if a entry doesn't have a kernel virtual address.

However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
to be operate mostly on virtual addresses.  It's a fairly odd concept
that I don't fully grasp, so I'll need some help with those if we want
to bring this forward.

Additional this series skips ARM entirely for now.  The reason is
that most arm implementations of the .map_sg operation just iterate
over all entries and call ->map_page for it, which means we'd need
to convert those to a ->map_pfn similar to Dan's previous approach.
