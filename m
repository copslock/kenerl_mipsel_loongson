Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 09:34:38 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58682 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822197Ab2KLIeBRaOIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2012 09:34:01 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3805949pad.36
        for <multiple recipients>; Mon, 12 Nov 2012 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=f9ga1bkJUQ1AkymSECYTMMoldYV6O7Wmp+jfDhrNWOY=;
        b=hqgXIy036BVSWj0Bc4cxH1+Cm789SxNMkYdmpYfS/XxwkOCBnpXOnx1yU0FjSlB5F3
         gTOfNC1AJ5Rwcc1wS044rMKHxWDkhzbQqUsaqdB+Uv9XeO/8k8D/2Z5VQSBeGC6/QztP
         FRf095g1i8V556afCEPD/kYjvLBkwdAZ5sCv1EihYJZ/jYLkVKer0SChNEAqj5/O8N2o
         AVGnIJkHFx+DnYuhJHo96WOB1P10VJsEBNQkS/gEgl04hk99pfTeydow9oNLkTa/RSPU
         3J/EQ3lWTiOsX3d2MzwWuj/JLiDhCFQ0dKvVUkjqT+of6ykBSNds07blx8YyABIAD22l
         Uubw==
Received: by 10.68.247.39 with SMTP id yb7mr56616827pbc.15.1352709240343;
        Mon, 12 Nov 2012 00:34:00 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id k4sm3967393pax.7.2012.11.12.00.33.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 00:33:59 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V8 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Mon, 12 Nov 2012 16:32:39 +0800
Message-Id: <1352709169-3481-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
References: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34955
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
 arch/mips/include/asm/cacheflush.h   |    6 ++++++
 arch/mips/include/asm/cpu-features.h |    6 ++++++
 arch/mips/mm/c-r4k.c                 |   21 +++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

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
index c507b93..2d13048 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -242,6 +242,12 @@
 #define cpu_has_inclusive_pcaches	(cpu_data[0].options & MIPS_CPU_INCLUSIVE_CACHES)
 #endif
 
+#ifdef CONFIG_CPU_SUPPORTS_COHERENT_CACHE
+#define cpu_has_coherent_cache	1
+#else
+#define cpu_has_coherent_cache	0
+#endif
+
 #ifndef cpu_dcache_line_size
 #define cpu_dcache_line_size()	cpu_data[0].dcache.linesz
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d52ffe4..9baf3db 100644
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
