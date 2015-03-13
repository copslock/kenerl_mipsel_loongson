Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 03:26:14 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:56183 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013618AbbCMC0CEVECr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Mar 2015 03:26:02 +0100
X-QQ-mid: bizesmtp10t1426213538t491t16
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 13 Mar 2015 10:25:37 +0800 (CST)
X-QQ-SSF: 01100000000000F0FJ52000A0000000
X-QQ-FEAT: wto48VEmSUEbgW3zOtK3AnxKgYjg9WchwMqbtdkBIB5pfLdCCwe+hre+7HUE8
        ci2+pwWBa7yEIx5Bpp6VTIQqY6CARytzMHQ46EnKrPIQpqN5EuxlxQAPo0cFyE5zkLdMvPZ
        t+lVTJI3lbG1PKqoI2DDypwWzAXc8Fh1iwzQv/wBceqeL+JT1IQ1jnJmrWtMy8AKs4BryzF
        2NGIu8s3GFC/zoVYoPJnfHeaMPBOemkZ5R8CIXMpWzQ==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V8 1/8] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Fri, 13 Mar 2015 10:24:51 +0800
Message-Id: <1426213492-28350-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1426213492-28350-1-git-send-email-chenhc@lemote.com>
References: <1426213492-28350-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46354
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

Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
feature named cpu_has_coherent_cache and use it to modify MIPS's cache
flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/Kconfig                                  |    3 ++
 arch/mips/include/asm/cpu-features.h               |    3 ++
 .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
 arch/mips/mm/c-r4k.c                               |   21 ++++++++++++++++++++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7a1690..61e7aed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1677,6 +1677,7 @@ config CPU_BMIPS5000
 config SYS_HAS_CPU_LOONGSON3
 	bool
 	select CPU_SUPPORTS_CPUFREQ
+	select CPU_SUPPORTS_COHERENT_CACHE
 
 config SYS_HAS_CPU_LOONGSON2E
 	bool
@@ -1852,6 +1853,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	bool
 config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
+config CPU_SUPPORTS_COHERENT_CACHE
+	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
 	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 0d8208d..0678e3e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -151,6 +151,9 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
+#ifndef cpu_has_coherent_cache
+#define cpu_has_coherent_cache	0
+#endif
 #ifndef cpu_has_local_ebase
 #define cpu_has_local_ebase	1
 #endif
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 6d69332..7efb191 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -58,5 +58,6 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_SUPPORTS_COHERENT_CACHE)
 
 #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3f80596..36f553f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -420,6 +420,9 @@ static void r4k_blast_scache_setup(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
 	case CPU_LOONGSON3:
@@ -447,6 +450,9 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
 }
 
@@ -493,6 +499,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 {
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
@@ -616,6 +625,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 {
 	struct flush_cache_page_args args;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	args.vma = vma;
 	args.addr = addr;
 	args.pfn = pfn;
@@ -625,11 +637,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_blast_dcache_page((unsigned long) addr);
 }
 
 static void r4k_flush_data_cache_page(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
@@ -814,6 +832,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
-- 
1.7.7.3
