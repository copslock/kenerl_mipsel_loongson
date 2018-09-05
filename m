Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:35:54 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:36751
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEJfsmgAVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:35:48 +0200
Received: by mail-pg1-x541.google.com with SMTP id d1-v6so3164528pgo.3;
        Wed, 05 Sep 2018 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yf/O9kRdR/UhOpR1wyI8Mld9CgtCeV/UjtptlXKqEAY=;
        b=Wl/5lANwPpnHefmGKD8OHZnyf9hNtLNg6cjoOa3fKzoQ4PGFiDhg2GrOCW2QIQy3dk
         cq9yYZtdyTZPFnp/Br8VyvXuCzoVYMZqUcAO1pdQ2C2dIBsmi84cCoYwI/19X7c6Kjrz
         8g2xysb/aUcRz6tPMPCKIfGiPRSwSaOC9kzunAwQ2fjeuny1OjhZQld8v/uUD7VgjTEw
         OHl0qSV9u5OrNw++TzmuTEeGTqrslo/ed1EyJlLWky2v1bJPK31X3osqEwowhirC2iyZ
         Gr3lURB/wpvwrqt/LXbHr059BJgCBsujJabZsSlSmPndWngcOUUSonP/BeO2RciaVTOE
         MA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=yf/O9kRdR/UhOpR1wyI8Mld9CgtCeV/UjtptlXKqEAY=;
        b=gR+TCWXULdETdbNpNUbv7mDLOiZjrO17cge19DFIB1rBDOtaCm1/4n4lPDlAsHdTdM
         g3pgWWGufdw6a+p2ZLiNcqu6Ug82LFgsUUyZqNwHIdBSgni6FtNMS3GCmMT8YtAB298v
         5Y6m5wqladqzZQsexNXpFQJW4IkH3auVH8tetzzaSX5650XkYJ8Okmm/8e6l+6dnFTCV
         O/lm9sjUyDOPYvAxLduCZN5VhXw3Y5Z2Q7G5sQU81Vbszndm3HaK4gc3GFZQgRs85X5o
         Bp8Lgf8rEb7lbku+kim2+Iy/OZhkxiEYr1A2ZdFn5+DfL9rbkuO7g6kZeuf0yuAuTGmk
         /3Ig==
X-Gm-Message-State: APzg51BibwE+RBVOiStLwwmDjkYUyGYHEmkSjUttdYNJlHVlyhupWnuw
        Xq1MjN0YJVmSpO4U8+CfD04oNQfHQh8=
X-Google-Smtp-Source: ANB0VdZ5rbHr3kRapxngUpLClOyr9PN9ytfu1F2sbyMvsyqCSclc/8QAkilwt380ru9llbt3zE1YSw==
X-Received: by 2002:a63:f849:: with SMTP id v9-v6mr35474809pgj.71.1536140142409;
        Wed, 05 Sep 2018 02:35:42 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:35:41 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 06/10] MIPS: Reserve extra memory for crash dump
Date:   Wed,  5 Sep 2018 17:33:06 +0800
Message-Id: <1536139990-11665-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65944
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
 arch/mips/kernel/setup.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb..9f2d5d9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -28,6 +28,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
 #include <linux/of_fdt.h>
+#include <linux/crash_dump.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -830,6 +831,52 @@ static void __init request_crashkernel(struct resource *res)
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
+	reserve_bootmem_node(NODE_DATA(node), PFN_PHYS(s0),
+			(e0 - s0) << PAGE_SHIFT, BOOTMEM_DEFAULT);
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
+		reserve_bootmem_node(NODE_DATA(node), PFN_PHYS(s0),
+				(s1 - s0) << PAGE_SHIFT, BOOTMEM_DEFAULT);
+		reserve_bootmem_node(NODE_DATA(node), PFN_PHYS(e1),
+				(e0 - e1) << PAGE_SHIFT, BOOTMEM_DEFAULT);
+	} else {
+		reserve_bootmem_node(NODE_DATA(node), PFN_PHYS(s0),
+				(e0 - s0) << PAGE_SHIFT, BOOTMEM_DEFAULT);
+	}
+#endif
+}
+
 /*
  * arch_mem_init - initialize memory management subsystem
  *
@@ -842,6 +843,8 @@ static void __init request_crashkernel(struct resource *res)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	unsigned int node;
+	unsigned long start_pfn, end_pfn;
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
@@ -923,6 +972,12 @@ static void __init arch_mem_init(char **cmdline_p)
 				crashk_res.end - crashk_res.start + 1,
 				BOOTMEM_DEFAULT);
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
