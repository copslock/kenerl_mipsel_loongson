Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:12:23 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36749 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992735AbcLSCIHLx0XK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:07 +0100
Received: by mail-lf0-f67.google.com with SMTP id o20so6141473lfg.3;
        Sun, 18 Dec 2016 18:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OugcL8nPOc3dizu4uogf16Ajls8g0+zVsxTqvngmogY=;
        b=mEVHh+vBKQZmQmEaoCT+29k/z83L6I3glJppWljLiFNU3D03reVlsMKYO4GnPB1PDG
         PJn2VDYqaV2CUf6P7kYjpKo0wyyRNJlalcfeXZVj12Xn+xvqhWZVK7aldOGgHVU/V9Qg
         4J+Etbb73mVxRlJYJ0HkhgQwx5A5sjYWWr8Wm92phiR2obWXuZu8CvCqizWLooCIVV/U
         DeEYY0wgbvyvCiLPp/6dtPCkqNsfbGDynF45oFHDzJvc7rMbQy3WA5Rw1UgJqI3vzPIw
         BbDREtUA4XFbJfOk1Cbr6SjkAF+G/nCF0mVmgJfXOBkbgSmFOjlWcrdzo551J3l9olj9
         urDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OugcL8nPOc3dizu4uogf16Ajls8g0+zVsxTqvngmogY=;
        b=DkguNJbSAWzDbteTPkJd5Sc+Zb/FKn1bbchxPbsP5CRQTtBL7dBT1yv8JfJmPgDPKl
         JgiHC3476Hj1daOI2xNk5kMIjk/Kv9RiZtsN9kwKXO/U1uOHbKIGKvzbNJOmemFEsw2R
         xpHFeZogeazYIwt9d/8YNzSG4iSettAiH7plk1N/RTpcEKNoPNhZxQ1mdSVYfIvUvCAw
         MsMRHh4JEInZvvRsazFYgAQJUjQ1F06zftgRY9qJ29A5+43jIu1lK8a5g2deTych4agb
         vD+WSc9CPVWowHsKh4TZqjCT+/GLAB8Z3L95LhCEwj4IzREuXaukNIoOEDJxnbo8tL/0
         eoFQ==
X-Gm-Message-State: AIkVDXLniYniVhYrGNl/q4FSiNdX8OC2kLO/zXtfwWAt1F91Vi+8BTxE+hEPRNfsIXcxdA==
X-Received: by 10.46.9.5 with SMTP id 5mr5747566ljj.23.1482113279829;
        Sun, 18 Dec 2016 18:07:59 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:59 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 06/21] MIPS memblock: Alter kexec-crashkernel parameters parser
Date:   Mon, 19 Dec 2016 05:07:31 +0300
Message-Id: <1482113266-13207-7-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Memblock API can be successfully used to verify whether crashkernel
memory region belongs to low memory, then it can be reserved within
memblock allocator.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 105 ++++++++++++++---------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d2f38ac..cc6d06b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -426,6 +426,55 @@ static void __init mips_reserve_initrd_mem(void) { }
 
 #endif
 
+#ifdef CONFIG_KEXEC
+/*
+ * Parse passed crashkernel parameter and reserve corresponding memory
+ */
+static void __init mips_parse_crashkernel(void)
+{
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+	int ret;
+
+	/* Parse crachkernel parameter */
+	total_mem = memblock_phys_mem_size();
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base);
+	if (ret != 0 || crash_size <= 0)
+		return;
+
+	crashk_res.start = crash_base;
+	crashk_res.end	 = crash_base + crash_size - 1;
+
+	/* Check whether the region belogs to lowmem and valid */
+	if (!is_lowmem_and_valid("Crashkernel", crash_base, crash_size))
+		return;
+
+	/* Reserve crashkernel resource */
+	memblock_reserve(crash_base, crash_size);
+}
+
+/*
+ * Reserve crashkernel memory within passed RAM resource
+ */
+static void __init request_crashkernel(struct resource *res)
+{
+	int ret;
+
+	ret = request_resource(res, &crashk_res);
+	if (!ret)
+		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
+			(unsigned long)((crashk_res.end -
+					 crashk_res.start + 1) >> 20),
+			(unsigned long)(crashk_res.start  >> 20));
+}
+#else /* !CONFIG_KEXEC */
+
+static void __init mips_parse_crashkernel(void) { }
+static void __init request_crashkernel(struct resource *res) { }
+
+#endif /* !CONFIG_KEXEC */
+
 /*
  * Initialize the bootmem allocator. It also setup initrd related data
  * if needed.
@@ -450,6 +499,9 @@ static void __init bootmem_init(void)
 	/* Check and reserve memory occupied by initrd */
 	mips_reserve_initrd_mem();
 
+	/* Parse crashkernel parameter */
+	mips_parse_crashkernel();
+
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
 	/*
@@ -717,52 +769,6 @@ static void __init arch_mem_addpart(phys_addr_t mem, phys_addr_t end, int type)
 	add_memory_region(mem, size, type);
 }
 
-#ifdef CONFIG_KEXEC
-static inline unsigned long long get_total_mem(void)
-{
-	unsigned long long total;
-
-	total = max_pfn - min_low_pfn;
-	return total << PAGE_SHIFT;
-}
-
-static void __init mips_parse_crashkernel(void)
-{
-	unsigned long long total_mem;
-	unsigned long long crash_size, crash_base;
-	int ret;
-
-	total_mem = get_total_mem();
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0)
-		return;
-
-	crashk_res.start = crash_base;
-	crashk_res.end	 = crash_base + crash_size - 1;
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-	int ret;
-
-	ret = request_resource(res, &crashk_res);
-	if (!ret)
-		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
-			(unsigned long)((crashk_res.end -
-					 crashk_res.start + 1) >> 20),
-			(unsigned long)(crashk_res.start  >> 20));
-}
-#else /* !defined(CONFIG_KEXEC)		*/
-static void __init mips_parse_crashkernel(void)
-{
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-}
-#endif /* !defined(CONFIG_KEXEC)  */
-
 #define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
 #define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
 #define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
@@ -836,13 +842,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 #endif
 
-	mips_parse_crashkernel();
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-				crashk_res.end - crashk_res.start + 1,
-				BOOTMEM_DEFAULT);
-#endif
 	device_tree_init();
 	sparse_init();
 	plat_swiotlb_setup();
-- 
2.6.6
