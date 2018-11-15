Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 08:58:25 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:45820
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990697AbeKOH6VON4F4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 08:58:21 +0100
Received: by mail-pf1-x443.google.com with SMTP id g62so6028424pfd.12;
        Wed, 14 Nov 2018 23:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uLFZE9ZIYhbq/RZKB79BO43XBOr7i2S2rpk1LvaDfyo=;
        b=Aqy7bnvA6IxcEoWjOO0PPKm3jv0tpEYcqEQU6/RYrqN1j+PZDEWEzv+3UIyt1X7/pd
         AHm2iOPmfkrT2xS1Vl475DqeDpaf6VdQu1UFZPYNK0JvHPA6QMgJJy3C86tswpoS09ax
         qXEQbG1cEZYJ4wnWyl2RnqMsxSLS9CyZV/PyUJsd+CF8yYjsAKmYKYFk1D4ip4m8jSpU
         6lqDjYE9171gbdA/bvnGyUnQcUZd7tnZzJLTnrTEzGx7+s1nGzff/nEXqIuql3C6mE3e
         YPmNqc7wRmG8mzS4gWUmXJiBx8IfFV3X4DFe/ers8jI03U7ZCTxFTxs0n4T/Qn/zljtI
         ej+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=uLFZE9ZIYhbq/RZKB79BO43XBOr7i2S2rpk1LvaDfyo=;
        b=KqhoF2B2NJ0rsqnLdvw5N0lb8OwvpdcpjhA6LDC2thQqvnwxe9LFDLWVSf6Tde1/j6
         r39djZwZvYCsZrO7LYIuN8rRvJmCAnzW0QipRuSafbPxBNd9DOGUlwMaygt0RK+NW32K
         zloifY0k+EMTdKSbFbtJl1ae40tKn6qkZA+HWi8edvS6mXskDm1DHO9aHhI6ob32GfS7
         /7Ba9jnvOAOvdIq1wpE424zZrWhFpOYp60yxYrsGlTTdhqD3tIC2gUdj4FEJ7rvkF3+u
         ahGX4nqkIKK2KR00tj4X61A5KJHRmwipFM46FqxSfJiHXk0iNWvZUn4geMT4v5tCdbyS
         Pthg==
X-Gm-Message-State: AGRZ1gJjnx9gshDZLz4Ru4MI4QQZiGEXB3BlkzWVBKBeY8o9GPbyuKfr
        mbrTPEPH3M+VtGi0wLlr+y3kcRPPwJU=
X-Google-Smtp-Source: AJdET5cACQmVgwgu3LkirD09MhZfF80iydreOee+bfxh4cllwibfedBOGkqlcxZOMMPpFebkz6+qFQ==
X-Received: by 2002:a62:888c:: with SMTP id l134-v6mr5402082pfd.198.1542268700275;
        Wed, 14 Nov 2018 23:58:20 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k24sm10366286pfj.13.2018.11.14.23.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 23:58:19 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 6/8] MIPS: Reserve extra memory for crash dump
Date:   Thu, 15 Nov 2018 15:53:57 +0800
Message-Id: <1542268439-4146-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67311
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

Traditionally, MIPS's contiguous low memory can be as less as 256M, so
crashkernel=X@Y may be unable to large enough in some cases. Moreover,
for the "multi numa node + sparse memory model" case, it is attempt to
allocate section_mem_maps on every node. Thus, if the total memory of a
node is more than 1GB, we reserve the top 128MB for the crash kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ea09ed6..070234b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -27,6 +27,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
 #include <linux/of_fdt.h>
+#include <linux/crash_dump.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -756,6 +757,48 @@ static void __init request_crashkernel(struct resource *res)
 #define BUILTIN_EXTEND_WITH_PROM	\
 	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
 
+/* Traditionally, MIPS's contiguous low memory is 256M, so crashkernel=X@Y is
+ * unable to be large enough in some cases. Thus, if the total memory of a node
+ * is more than 1GB, we reserve the top 128MB for the crash kernel */
+static void reserve_crashm_region(int node, unsigned long s0, unsigned long e0)
+{
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start == crashk_res.end)
+		return;
+
+	if ((e0 - s0) <= (SZ_1G >> PAGE_SHIFT))
+		return;
+
+	s0 = e0 - (SZ_128M >> PAGE_SHIFT);
+
+	memblock_reserve(PFN_PHYS(s0), (e0 - s0) << PAGE_SHIFT);
+#endif
+}
+
+static void reserve_oldmem_region(int node, unsigned long s0, unsigned long e0)
+{
+#ifdef CONFIG_CRASH_DUMP
+	unsigned long s1, e1;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if ((e0 - s0) > (SZ_1G >> PAGE_SHIFT))
+		e0 = e0 - (SZ_128M >> PAGE_SHIFT);
+
+	/* boot_mem_map.map[0] is crashk_res reserved by primary kernel */
+	s1 = PFN_UP(boot_mem_map.map[0].addr);
+	e1 = PFN_DOWN(boot_mem_map.map[0].addr + boot_mem_map.map[0].size);
+
+	if (node == 0) {
+		memblock_reserve(PFN_PHYS(s0), (s1 - s0) << PAGE_SHIFT);
+		memblock_reserve(PFN_PHYS(e1), (e0 - e1) << PAGE_SHIFT);
+	} else {
+		memblock_reserve(PFN_PHYS(s0), (e0 - s0) << PAGE_SHIFT);
+	}
+#endif
+}
+
 /*
  * arch_mem_init - initialize memory management subsystem
  *
@@ -780,6 +823,8 @@ static void __init request_crashkernel(struct resource *res)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	unsigned int node;
+	unsigned long start_pfn, end_pfn;
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
@@ -877,6 +922,12 @@ static void __init arch_mem_init(char **cmdline_p)
 		memblock_reserve(crashk_res.start,
 				 crashk_res.end - crashk_res.start + 1);
 #endif
+	for_each_online_node(node) {
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+		reserve_crashm_region(node, start_pfn, end_pfn);
+		reserve_oldmem_region(node, start_pfn, end_pfn);
+	}
+
 	device_tree_init();
 	sparse_init();
 	plat_swiotlb_setup();
-- 
2.7.0
