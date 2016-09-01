Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:32:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43814 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992289AbcIAQbGfuEJ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:31:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E6340CE1BE28C;
        Thu,  1 Sep 2016 17:30:46 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 5/9] MIPS: c-r4k: Split user/kernel flush_icache_range()
Date:   Thu, 1 Sep 2016 17:30:11 +0100
Message-ID: <817ca1cd70b612aaa6231390e640d1e1a2f0dd5e.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

flush_icache_range() is used for both user addresses (i.e.
cacheflush(2)), and kernel addresses (as the API documentation
describes).

This isn't really suitable however for Enhanced Virtual Addressing (EVA)
where cache operations on usermode addresses must use a different
instruction, and the protected cache ops assume user addresses, making
flush_icache_range() ineffective on kernel addresses.

Split out a new __flush_icache_user_range() and
__local_flush_icache_user_range() for users which actually want to flush
usermode addresses (note that flush_icache_user_range() already exists
on various architectures but with different arguments).

The implementation of flush_icache_range() will be changed in an
upcoming commit to use unprotected normal cache ops so as to always work
on the kernel mode address space.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cacheflush.h | 5 +++++
 arch/mips/mm/c-octeon.c            | 2 ++
 arch/mips/mm/c-r3k.c               | 2 ++
 arch/mips/mm/c-r4k.c               | 2 ++
 arch/mips/mm/c-tx39.c              | 3 +++
 arch/mips/mm/cache.c               | 4 ++++
 6 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 34ed22ec6c33..4812d1fed0c2 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -28,6 +28,7 @@
  *  - flush_cache_sigtramp() flush signal trampoline
  *  - flush_icache_all() flush the entire instruction cache
  *  - flush_data_cache_page() flushes a page from the data cache
+ *  - __flush_icache_user_range(start, end) flushes range of user instructions
  */
 
  /*
@@ -80,6 +81,10 @@ static inline void flush_icache_page(struct vm_area_struct *vma,
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
 extern void (*local_flush_icache_range)(unsigned long start, unsigned long end);
+extern void (*__flush_icache_user_range)(unsigned long start,
+					 unsigned long end);
+extern void (*__local_flush_icache_user_range)(unsigned long start,
+					       unsigned long end);
 
 extern void (*__flush_cache_vmap)(void);
 
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 05b1d7cf9514..0e45b061e514 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -294,6 +294,8 @@ void octeon_cache_init(void)
 	flush_data_cache_page		= octeon_flush_data_cache_page;
 	flush_icache_range		= octeon_flush_icache_range;
 	local_flush_icache_range	= local_octeon_flush_icache_range;
+	__flush_icache_user_range	= octeon_flush_icache_range;
+	__local_flush_icache_user_range	= local_octeon_flush_icache_range;
 
 	__flush_kernel_vmap_range	= octeon_flush_kernel_vmap_range;
 
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 135ec313c1f6..21e4e662c1fa 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -325,6 +325,8 @@ void r3k_cache_init(void)
 	flush_cache_page = r3k_flush_cache_page;
 	flush_icache_range = r3k_flush_icache_range;
 	local_flush_icache_range = r3k_flush_icache_range;
+	__flush_icache_user_range = r3k_flush_icache_range;
+	__local_flush_icache_user_range = r3k_flush_icache_range;
 
 	__flush_kernel_vmap_range = r3k_flush_kernel_vmap_range;
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 0335a4be0635..36f4aa6d768f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1904,6 +1904,8 @@ void r4k_cache_init(void)
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
+	__flush_icache_user_range	= r4k_flush_icache_range;
+	__local_flush_icache_user_range	= local_r4k_flush_icache_range;
 
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 	if (coherentio) {
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 596e18458e04..5c282583edf1 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -411,6 +411,9 @@ void tx39_cache_init(void)
 		break;
 	}
 
+	__flush_icache_user_range = flush_icache_range;
+	__local_flush_icache_user_range = local_flush_icache_range;
+
 	current_cpu_data.icache.waysize = icache_size / current_cpu_data.icache.ways;
 	current_cpu_data.dcache.waysize = dcache_size / current_cpu_data.dcache.ways;
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index bf04c6c479a4..5a644c3fe155 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -33,6 +33,10 @@ void (*flush_icache_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(flush_icache_range);
 void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 EXPORT_SYMBOL_GPL(local_flush_icache_range);
+void (*__flush_icache_user_range)(unsigned long start, unsigned long end);
+EXPORT_SYMBOL_GPL(__flush_icache_user_range);
+void (*__local_flush_icache_user_range)(unsigned long start, unsigned long end);
+EXPORT_SYMBOL_GPL(__local_flush_icache_user_range);
 
 void (*__flush_cache_vmap)(void);
 void (*__flush_cache_vunmap)(void);
-- 
git-series 0.8.10
