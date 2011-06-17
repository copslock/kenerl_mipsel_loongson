Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2011 17:20:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54425 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491118Ab1FQPUb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2011 17:20:31 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5HFKScf014747;
        Fri, 17 Jun 2011 16:20:29 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5HFKS4k014744;
        Fri, 17 Jun 2011 16:20:28 +0100
Date:   Fri, 17 Jun 2011 16:20:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
Message-ID: <20110617152028.GA14107@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
 <20110325172709.GC8483@linux-mips.org>
 <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
 <20110616180250.GA13025@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110616180250.GA13025@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14670

On Thu, Jun 16, 2011 at 08:02:50PM +0200, Christoph Hellwig wrote:

> Ralf,
> 
> I'll second that request.  We'll really need this, right now embedded XFS
> users are hacking around it in horrible ways.

Here's my shot at the problem.  I don't have the time to setup a XFS
filesystem and tools for testing before the weekend so all I claim is this
patch builds for R4000-class CPUs but it should be pretty close to the
real thing.

Naveen, can you give this patch a spin?  Thanks!

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/cacheflush.h |   24 ++++++++++++++++++++++++
 arch/mips/mm/c-octeon.c            |    6 ++++++
 arch/mips/mm/c-r3k.c               |    7 +++++++
 arch/mips/mm/c-r4k.c               |   35 +++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-tx39.c              |    7 +++++++
 arch/mips/mm/cache.c               |    5 +++++
 6 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 40bb9fd..69468de 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -114,4 +114,28 @@ unsigned long run_uncached(void *func);
 extern void *kmap_coherent(struct page *page, unsigned long addr);
 extern void kunmap_coherent(void);
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+	BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
+}
+
+/*
+ * For now flush_kernel_vmap_range and invalidate_kernel_vmap_range both do a
+ * cache writeback and invalidate operation.
+ */
+extern void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
+
+static inline void flush_kernel_vmap_range(void *vaddr, int size)
+{
+	if (cpu_has_dc_aliases)
+		__flush_kernel_vmap_range((unsigned long) vaddr, size);
+}
+
+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
+{
+	if (cpu_has_dc_aliases)
+		__flush_kernel_vmap_range((unsigned long) vaddr, size);
+}
+
 #endif /* _ASM_CACHEFLUSH_H */
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 16c4d25..daa81f7 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -169,6 +169,10 @@ static void octeon_flush_cache_page(struct vm_area_struct *vma,
 		octeon_flush_icache_all_cores(vma);
 }
 
+static void octeon_flush_kernel_vmap_range(unsigned long vaddr, int size)
+{
+	BUG();
+}
 
 /**
  * Probe Octeon's caches
@@ -273,6 +277,8 @@ void __cpuinit octeon_cache_init(void)
 	flush_icache_range		= octeon_flush_icache_range;
 	local_flush_icache_range	= local_octeon_flush_icache_range;
 
+	__flush_kernel_vmap_range	= octeon_flush_kernel_vmap_range;
+
 	build_clear_page();
 	build_copy_page();
 }
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index e6b0efd..0765583 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -299,6 +299,11 @@ static void r3k_flush_cache_sigtramp(unsigned long addr)
 	write_c0_status(flags);
 }
 
+static void r3k_flush_kernel_vmap_range(unsigned long vaddr, int size)
+{
+	BUG();
+}
+
 static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
 {
 	/* Catch bad driver code */
@@ -323,6 +328,8 @@ void __cpuinit r3k_cache_init(void)
 	flush_icache_range = r3k_flush_icache_range;
 	local_flush_icache_range = r3k_flush_icache_range;
 
+	__flush_kernel_vmap_range = r3k_flush_kernel_vmap_range;
+
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
 	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
 	flush_data_cache_page = r3k_flush_data_cache_page;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index eeb642e..38a593e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -718,6 +718,39 @@ static void r4k_flush_icache_all(void)
 		r4k_blast_icache();
 }
 
+struct flush_kernel_vmap_range_args {
+	unsigned long	vaddr;
+	int		size;
+};
+
+static inline void local_r4k_flush_kernel_vmap_range(void *args)
+{
+	struct flush_kernel_vmap_range_args *vmra = args;
+	unsigned long vaddr = vmra->vaddr;
+	int size = vmra->size;
+
+	/*
+	 * Aliases only affect the primary caches so don't bother with
+	 * S-caches or T-caches.
+	 */
+	if (cpu_has_safe_index_cacheops && size >= dcache_size)
+		r4k_blast_dcache();
+	else {
+		R4600_HIT_CACHEOP_WAR_IMPL;
+		blast_dcache_range(vaddr, vaddr + size);
+	}
+}
+
+static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
+{
+	struct flush_kernel_vmap_range_args args;
+
+	args.vaddr = (unsigned long) vaddr;
+	args.size = size;
+
+	r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args);
+}
+
 static inline void rm7k_erratum31(void)
 {
 	const unsigned long ic_lsize = 32;
@@ -1399,6 +1432,8 @@ void __cpuinit r4k_cache_init(void)
 	flush_cache_page	= r4k_flush_cache_page;
 	flush_cache_range	= r4k_flush_cache_range;
 
+	__flush_kernel_vmap_range = r4k_flush_kernel_vmap_range;
+
 	flush_cache_sigtramp	= r4k_flush_cache_sigtramp;
 	flush_icache_all	= r4k_flush_icache_all;
 	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index d352fad..a43c197c 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -253,6 +253,11 @@ static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 	}
 }
 
+static void tx39_flush_kernel_vmap_range(unsigned long vaddr, int size)
+{
+	BUG();
+}
+
 static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	unsigned long end;
@@ -394,6 +399,8 @@ void __cpuinit tx39_cache_init(void)
 		flush_icache_range = tx39_flush_icache_range;
 		local_flush_icache_range = tx39_flush_icache_range;
 
+		__flush_kernel_vmap_range = tx39_flush_kernel_vmap_range;
+
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
 		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
 		flush_data_cache_page = tx39_flush_data_cache_page;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 12af739..829320c 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -35,6 +35,11 @@ void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 void (*__flush_cache_vmap)(void);
 void (*__flush_cache_vunmap)(void);
 
+void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
+void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
+
+EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
+
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
 void (*local_flush_data_cache_page)(void * addr);
