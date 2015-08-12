Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 19:00:18 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57348 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012472AbbHLRARIMaas (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 19:00:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2F0A38EE10E;
        Wed, 12 Aug 2015 10:00:09 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZBsUnD_Eqlbo; Wed, 12 Aug 2015 10:00:09 -0700 (PDT)
Received: from [153.66.254.242] (unknown [184.11.141.41])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A46EC8EE0A2;
        Wed, 12 Aug 2015 10:00:07 -0700 (PDT)
Message-ID: <1439398807.2825.51.camel@HansenPartnership.com>
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, vgupta@synopsys.com,
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
Date:   Wed, 12 Aug 2015 10:00:07 -0700
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
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

On Wed, 2015-08-12 at 09:05 +0200, Christoph Hellwig wrote:
> Dan Williams started to look into addressing I/O to and from
> Persistent Memory in his series from June:
> 
> 	http://thread.gmane.org/gmane.linux.kernel.cross-arch/27944
> 
> I've started looking into DMA mapping of these SGLs specifically instead
> of the map_pfn method in there.  In addition to supporting NVDIMM backed
> I/O I also suspect this would be highly useful for media drivers that
> go through nasty hoops to be able to DMA from/to their ioremapped regions,
> with vb2_dc_get_userptr in drivers/media/v4l2-core/videobuf2-dma-contig.c
> being a prime example for the unsafe hacks currently used.
> 
> It turns out most DMA mapping implementation can handle SGLs without
> page structures with some fairly simple mechanical work.  Most of it
> is just about consistently using sg_phys.  For implementations that
> need to flush caches we need a new helper that skips these cache
> flushes if a entry doesn't have a kernel virtual address.
> 
> However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
> to be operate mostly on virtual addresses.  It's a fairly odd concept
> that I don't fully grasp, so I'll need some help with those if we want
> to bring this forward.

I can explain that.  I think this doesn't apply to ia64 because it's
cache is PIPT, but on parisc, we have a VIPT cache.

On normal physically indexed architectures, when the iommu sees a DMA
transfer to/from physical memory, it also notifies the CPU to flush the
internal CPU caches of those lines.  This is usually an interlocking
step of the transfer to make sure the page is coherent before transfer
to/from the device (it's why the ia32 for instance is a coherent
architecture).  Because the system is physically indexed, there's no
need to worry about aliases.

On Virtually Indexed systems, like parisc, there is an aliasing problem.
The CCIO iommu unit (and all other iommu systems on parisc) have what's
called a local coherence index (LCI).  You program it as part of the
IOMMU page table and it tells the system which Virtual line in the cache
to flush as part of the IO transaction, thus still ensuring cache
coherence.  That's why we have to know the virtual as well as physical
addresses for the page.  The problem we have in Linux is that we have
two virtual addresses, which are often incoherent aliases: the user
virtual address and a kernel virtual address but we can only make the
page coherent with a single alias (only one LCI).  The way I/O on Linux
currently works is that get_user_pages actually flushes the user virtual
address, so that's expected to be coherent, so the address we program
into the VCI is the kernel virtual address.  Usually nothing in the
kernel has ever touched the page, so there's nothing to flush, but we do
it just in case.

In theory, for these non kernel page backed SG entries, we can make the
process more efficient by not flushing in gup and instead programming
the user virtual address into the local coherence index.  However,
simply zeroing the LCI will also work (except that poor VI zero line
will get flushed repeatedly, so it's probably best to pick a known
untouched line in the kernel).

James
