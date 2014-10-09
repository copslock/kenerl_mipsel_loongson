Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:00:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1386 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011002AbaJIUAUThXlH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:00:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E81B5D759522B;
        Thu,  9 Oct 2014 21:00:08 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 21:00:12 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 21:00:12 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 21:00:12 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 9 Oct 2014
 13:00:10 -0700
Subject: [PATCH v2 1/3] MIPS: mips_flush_cache_range is added
To:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <davidlohr@hp.com>, <macro@linux-mips.org>, <chenhc@lemote.com>,
        <richard@nod.at>, <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <alex@alex-smith.me.uk>,
        <tglx@linutronix.de>, <blogic@openwrt.org>,
        <jchandra@broadcom.com>, <paul.burton@imgtec.com>,
        <qais.yousef@imgtec.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <dengcheng.zhu@imgtec.com>, <manuel.lauss@gmail.com>,
        <akpm@linux-foundation.org>, <lars.persson@axis.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 9 Oct 2014 13:00:10 -0700
Message-ID: <20141009200009.31230.75919.stgit@linux-yegoshin>
In-Reply-To: <20141009195030.31230.58695.stgit@linux-yegoshin>
References: <20141009195030.31230.58695.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

New function mips_flush_cache_range() is added.
It flushes D-cache on kernel VA and I-cache on user VA.
It is significant in case of cache aliasing systems.
It can be used to flush a short sequence of newly written code
to user space and especially usefull in ptrace() and dsemul().
Today a full page is flushed by flush_cache_page in ptrace().

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/cacheflush.h |    3 +++
 arch/mips/mm/c-octeon.c            |    8 +++++++
 arch/mips/mm/c-r3k.c               |    8 +++++++
 arch/mips/mm/c-r4k.c               |   43 ++++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-tx39.c              |    9 ++++++++
 arch/mips/mm/cache.c               |    4 +++
 6 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index e08381a..8305241 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -94,6 +94,9 @@ extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
+extern void (*mips_flush_data_cache_range)(struct vm_area_struct *vma,
+	unsigned long vaddr, struct page *page, unsigned long addr,
+	unsigned long size);
 
 /*
  * This flag is used to indicate that the page pointed to by a pte
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 05b1d7c..38349d1 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -178,6 +178,13 @@ static void octeon_flush_kernel_vmap_range(unsigned long vaddr, int size)
 	BUG();
 }
 
+static void octeon_flush_data_cache_range(struct vm_area_struct *vma,
+       unsigned long vaddr, struct page *page, unsigned long addr,
+       unsigned long size)
+{
+	octeon_flush_cache_page(vma, addr, page_to_pfn(page));
+}
+
 /**
  * Probe Octeon's caches
  *
@@ -292,6 +299,7 @@ void octeon_cache_init(void)
 	flush_cache_sigtramp		= octeon_flush_cache_sigtramp;
 	flush_icache_all		= octeon_flush_icache_all;
 	flush_data_cache_page		= octeon_flush_data_cache_page;
+	mips_flush_data_cache_range     = octeon_flush_data_cache_range;
 	flush_icache_range		= octeon_flush_icache_range;
 	local_flush_icache_range	= local_octeon_flush_icache_range;
 
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 135ec31..93b4810 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -273,6 +273,13 @@ static void r3k_flush_data_cache_page(unsigned long addr)
 {
 }
 
+static void r3k_mips_flush_data_cache_range(struct vm_area_struct *vma,
+	unsigned long vaddr, struct page *page, unsigned long addr,
+	unsigned long size)
+{
+	r3k_flush_cache_page(vma, addr, page_to_pfn(page));
+}
+
 static void r3k_flush_cache_sigtramp(unsigned long addr)
 {
 	unsigned long flags;
@@ -322,6 +329,7 @@ void r3k_cache_init(void)
 	__flush_cache_all = r3k___flush_cache_all;
 	flush_cache_mm = r3k_flush_cache_mm;
 	flush_cache_range = r3k_flush_cache_range;
+	mips_flush_data_cache_range = r3k_mips_flush_data_cache_range;
 	flush_cache_page = r3k_flush_cache_page;
 	flush_icache_range = r3k_flush_icache_range;
 	local_flush_icache_range = r3k_flush_icache_range;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ad6ff7b..ee014e4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -636,6 +636,48 @@ static void r4k_flush_data_cache_page(unsigned long addr)
 		r4k_on_each_cpu(local_r4k_flush_data_cache_page, (void *) addr);
 }
 
+struct mips_flush_data_cache_range_args {
+	struct vm_area_struct *vma;
+	unsigned long vaddr;
+	unsigned long start;
+	unsigned long len;
+};
+
+static inline void local_r4k_mips_flush_data_cache_range(void *args)
+{
+	struct mips_flush_data_cache_range_args *f_args = args;
+	unsigned long vaddr = f_args->vaddr;
+	unsigned long start = f_args->start;
+	unsigned long len = f_args->len;
+	struct vm_area_struct * vma = f_args->vma;
+
+	blast_dcache_range(start, start + len);
+
+	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) {
+			wmb();
+
+		/* vma is given for exec check only, mmap is current,
+		   so - no non-current vma page flush, just user or kernel */
+		protected_blast_icache_range(vaddr, vaddr + len);
+	}
+}
+
+/* flush dirty kernel data and a corresponding user instructions (if needed).
+   used in copy_to_user_page() */
+static void r4k_mips_flush_data_cache_range(struct vm_area_struct *vma,
+	unsigned long vaddr, struct page *page, unsigned long start,
+	unsigned long len)
+{
+	struct mips_flush_data_cache_range_args args;
+
+	args.vma = vma;
+	args.vaddr = vaddr;
+	args.start = start;
+	args.len = len;
+
+	r4k_on_each_cpu(local_r4k_mips_flush_data_cache_range, (void *)&args);
+}
+
 struct flush_icache_range_args {
 	unsigned long start;
 	unsigned long end;
@@ -1656,6 +1698,7 @@ void r4k_cache_init(void)
 	flush_icache_all	= r4k_flush_icache_all;
 	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
+	mips_flush_data_cache_range = r4k_mips_flush_data_cache_range;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
 
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 8d909db..9316e92 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -230,6 +230,13 @@ static void tx39_flush_data_cache_page(unsigned long addr)
 	tx39_blast_dcache_page(addr);
 }
 
+static void local_flush_data_cache_range(struct vm_area_struct *vma,
+       unsigned long vaddr, struct page *page, unsigned long addr,
+       unsigned long size)
+{
+	flush_cache_page(vma, addr, page_to_pfn(page));
+}
+
 static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 {
 	if (end - start > dcache_size)
@@ -371,6 +378,7 @@ void tx39_cache_init(void)
 
 		flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
 		local_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
+		mips_flush_data_cache_range     = (void *) local_flush_data_cache_range;
 		flush_data_cache_page	= (void *) tx39h_flush_icache_all;
 
 		_dma_cache_wback_inv	= tx39h_dma_cache_wback_inv;
@@ -402,6 +410,7 @@ void tx39_cache_init(void)
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
 		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
+		mips_flush_data_cache_range     = (void *) local_flush_data_cache_range;
 		flush_data_cache_page = tx39_flush_data_cache_page;
 
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 7e3ea77..b7bdd01 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -44,10 +44,14 @@ void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
 void (*flush_cache_sigtramp)(unsigned long addr);
 void (*local_flush_data_cache_page)(void * addr);
 void (*flush_data_cache_page)(unsigned long addr);
+void (*mips_flush_data_cache_range)(struct vm_area_struct *vma,
+      unsigned long vaddr, struct page *page, unsigned long addr,
+      unsigned long size);
 void (*flush_icache_all)(void);
 
 EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
+EXPORT_SYMBOL(mips_flush_data_cache_range);
 EXPORT_SYMBOL(flush_icache_all);
 
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
