Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 17:27:30 +0100 (BST)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:10380 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S28583000AbYHTQ1X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 17:27:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 58B2D80B4;
	Wed, 20 Aug 2008 11:27:15 -0500 (CDT)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0Qj0wI0ELeR; Wed, 20 Aug 2008 11:27:14 -0500 (CDT)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 188668081;
	Wed, 20 Aug 2008 11:27:14 -0500 (CDT)
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
In-Reply-To: <s5hk5eezcfe.wl%tiwai@suse.de>
References: <s5hk5eezcfe.wl%tiwai@suse.de>
Content-Type: text/plain
Date:	Wed, 20 Aug 2008 11:27:12 -0500
Message-Id: <1219249633.3258.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Mon, 2008-08-18 at 15:21 +0200, Takashi Iwai wrote:
> I've been trying to fix a long-standing bug in ALSA, the mmap of
> pages via dma_mmap_coherent().  Since the sound drivers need to expose
> the whole buffer via mmap and the buffers are allocated via
> dma_alloc_coherent(), it causes Oops on some architectures like MIPS.
> One of the fix patches is this one, the addition of
> dma_mmap_coherent() to MIPS architecture.
> 
> This implementation is pretty lazy (and untested) as you see below.
> 
> The whole patches are found on topic/dma-fix branch on sound-2.6 git
> tree
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> The gitweb URL of the branch is:
>   http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;h=topic/dma-fix
> 
> Any review and comments would be appreciated.

I've inlined the parisc piece ... although it would be helpful if you
had posted it to the parisc list rather than letting the mips people
forward it.

I'm afraid there are several problems.  The first is that it doesn't do
what you want.  You can't map a coherent page to userspace (which is at
a non congruent address on parisc) and still expect it to be
coherent ... there's going to have to be fiddling with the page table
caches to make sure coherency isn't destroyed by aliasing effects

Secondly, it's incomplete ... there are two other instances of
hppa_dma_ops in drivers/parisc ccio-dma.c and sba_iommu.c that would
also need to have this added

Finally, there's the meta observation that this is exactly the type of
thing that the framebuffer code already does, so why reinvent a new way
of doing it rather than coming up with the correct infrastructure and
making them both use it?

James

---

From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 17 Jun 2008 14:39:05 +0000 (+0200)
Subject: parisc: implement dma_mmap_coherent()
X-Git-Url: http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftiwai%2Fsound-2.6.git;a=commitdiff_plain;h=7a9dbc6e9d4798fd00005faebeff720c87f098df;hp=fb959151b618360fc74b8978d918182c82f67a4a

parisc: implement dma_mmap_coherent()

A lazy version of dma_mmap_coherent() implementation for PA-RISC.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ccd61b9..ddeecc2 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -545,6 +545,19 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
 		flush_kernel_dcache_range(sg_virt_addr(sglist), sglist->length);
 }
 
+static int pa11_dma_mmap_coherent(struct device *dev,
+				  struct vm_area_struct *vma,
+				  void *cpu_addr, dma_addr_t handle,
+				  size_t size)
+{
+	struct page *pg;
+	cpu_addr = __va(handle);
+	pg = virt_to_page(cpu_addr);
+	return remap_pfn_range(vma, vma->vm_start,
+			       page_to_pfn(pg) + vma->vm_pgoff,
+			       size, vma->vm_page_prot);
+}
+
 struct hppa_dma_ops pcxl_dma_ops = {
 	.dma_supported =	pa11_dma_supported,
 	.alloc_consistent =	pa11_dma_alloc_consistent,
@@ -558,6 +571,7 @@ struct hppa_dma_ops pcxl_dma_ops = {
 	.dma_sync_single_for_device = pa11_dma_sync_single_for_device,
 	.dma_sync_sg_for_cpu = pa11_dma_sync_sg_for_cpu,
 	.dma_sync_sg_for_device = pa11_dma_sync_sg_for_device,
+	.mmap_coherent =	pa11_dma_mmap_coherent,
 };
 
 static void *fail_alloc_consistent(struct device *dev, size_t size,
@@ -598,4 +612,5 @@ struct hppa_dma_ops pcx_dma_ops = {
 	.dma_sync_single_for_device =	pa11_dma_sync_single_for_device,
 	.dma_sync_sg_for_cpu =		pa11_dma_sync_sg_for_cpu,
 	.dma_sync_sg_for_device =	pa11_dma_sync_sg_for_device,
+	.mmap_coherent =	pa11_dma_mmap_coherent,
 };
diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-mapping.h
index 53af696..a66235b 100644
--- a/include/asm-parisc/dma-mapping.h
+++ b/include/asm-parisc/dma-mapping.h
@@ -19,6 +19,9 @@ struct hppa_dma_ops {
 	void (*dma_sync_single_for_device)(struct device *dev, dma_addr_t iova, unsigned long offset, size_t size, enum dma_data_direction direction);
 	void (*dma_sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
 	void (*dma_sync_sg_for_device)(struct device *dev, struct scatterlist *sg, int nelems, enum dma_data_direction direction);
+	int (*mmap_coherent)(struct device *dev, struct vm_area_struct *vma,
+			     void *cpu_addr, dma_addr_t handle, size_t size);
+
 };
 
 /*
@@ -204,6 +207,13 @@ dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		flush_kernel_dcache_range((unsigned long)vaddr, size);
 }
 
+static inline int
+dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		  void *cpu_addr, dma_addr_t handle, size_t size)
+{
+	return hppa_dma_ops->mmap_coherent(dev, vma, cpu_addr, handle, size);
+}
+
 static inline void *
 parisc_walk_tree(struct device *dev)
 {
