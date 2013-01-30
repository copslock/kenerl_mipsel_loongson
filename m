Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 14:36:15 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41826 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817037Ab3A3NgNc9RiW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 14:36:13 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa12so972478pbc.8
        for <multiple recipients>; Wed, 30 Jan 2013 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=fN5AENRwgdTC2u/WDQCCGQBGaz4mTEMUXd/rSb3pcRY=;
        b=loaTa5gr29tH8gRzuGupPv4LOdP3+21QGOozIYHGVtx4rktBh9CEDp4tdauSRq+nJ/
         loeaGpLTaLbLxxBjyh1ovVQiTF8xzuBLwl3bq5YX/61Ei6jE/ktCGjcmF8nZa9LIpg9q
         zFHy6ZluhmRWKUPPyGuRAAxwxsFp5WULVlg0GGTrOOJHy7jGQssSBGZMPV3HnEJn+db5
         FWPXw5cjJPWidIwhPqcvf8d/emAM4ONviWQc7yDYYOjet5lCaIcz4lPU6c8oh1o3Hul2
         Ta+HrFGbXk9CNBuulrGXS/kL12hi4LIJUc6gukbQmNRMjJHyJTohozR3hfnxf1lD/8SZ
         iUsg==
X-Received: by 10.68.219.67 with SMTP id pm3mr9639295pbc.150.1359527360536;
        Tue, 29 Jan 2013 22:29:20 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gj1sm612282pbc.11.2013.01.29.22.28.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 22:29:19 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V9 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Wed, 30 Jan 2013 14:24:56 +0800
Message-Id: <1359527106-22879-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
X-archive-position: 35636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
feature named cpu_has_coherent_cache and use it to modify MIPS's cache
flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/cacheflush.h                 |    6 +++++
 arch/mips/include/asm/cpu-features.h               |    3 ++
 .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +++++
 arch/mips/mm/c-r4k.c                               |   21 ++++++++++++++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 69468de..8c4fa0d 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -70,6 +70,9 @@ extern void (*__flush_cache_vmap)(void);
 
 static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (cpu_has_dc_aliases)
 		__flush_cache_vmap();
 }
@@ -78,6 +81,9 @@ extern void (*__flush_cache_vunmap)(void);
 
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (cpu_has_dc_aliases)
 		__flush_cache_vunmap();
 }
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c507b93..55213ca 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -110,6 +110,9 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
+#ifndef cpu_has_coherent_cache
+#define cpu_has_coherent_cache	0
+#endif
 
 /*
  * I-Cache snoops remote store.  This only matters on SMP.  Some multiprocessors
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 1a05d85..f72b6be 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -57,5 +57,11 @@
 #define cpu_has_vint		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_watch		1
+#ifdef CONFIG_CPU_SUPPORTS_COHERENT_CACHE
+#define cpu_has_coherent_cache	1
+#else
+#define cpu_has_coherent_cache	0
+#endif
+
 
 #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d1b9da3..5f9171d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -345,6 +345,10 @@ static inline void local_r4k___flush_cache_all(void * args)
 	r4k_blast_scache();
 	return;
 #endif
+
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_blast_dcache();
 	r4k_blast_icache();
 
@@ -406,8 +410,12 @@ static inline void local_r4k_flush_cache_range(void * args)
 static void r4k_flush_cache_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec __maybe_unused;
+
+	if (cpu_has_coherent_cache)
+		return;
 
+	exec = vma->vm_flags & VM_EXEC;
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
@@ -527,7 +535,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long pfn)
 {
-	struct flush_cache_page_args args;
+	struct flush_cache_page_args args __maybe_unused;
+
+	if (cpu_has_coherent_cache)
+		return;
 
 	args.vma = vma;
 	args.addr = addr;
@@ -543,6 +554,9 @@ static inline void local_r4k_flush_data_cache_page(void * addr)
 
 static void r4k_flush_data_cache_page(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
@@ -701,6 +715,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
-- 
1.7.7.3
