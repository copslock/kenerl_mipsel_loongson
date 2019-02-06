Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473DCC169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 11:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150692175B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 11:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7c4m/2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBFL7c (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:59:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFL7c (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 06:59:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so2946924pfe.13
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 03:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=iPOl0FP8s9ku1Bl+AhZFWSENW1DU4PLiK5zttHTCYQc=;
        b=P7c4m/2NelxT8D2VWq4Gt8IBJ/4Zlg+51OdtI3KmGhKMIUKnB7KQ41wR7LG+k7lmzH
         Tb9RPNuKlmztF1MNMCj8DVXGIsHDUDICreuV/lVMdgeCkoXj5cZPkRYyYZT+2dq0+f42
         tbQKZIJkMoa2UJIK3gBwUSmsQSysqxuLY85v5laFYY4afUtbLBJMkVABvrCXQuA+qHGa
         KCgVybrh72wfcuFYtNuSzAro487frV7xR2QXI7lu0Z4yhRJ8cGcwDI6VHwIV11ZXKhug
         kdyoOWu/GgG/re2o7znBzuZ1LteVYYQMUpJJv1mRUmmwbbgzDhCJqh7QfObaOWRtfcxf
         Koog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=iPOl0FP8s9ku1Bl+AhZFWSENW1DU4PLiK5zttHTCYQc=;
        b=l7PM4xPApyszlcfGgV8wg+yejPw7VafgvxQtvYu81sVeh43xE3Bv4oGzCATSh9KLvc
         dHWxLe9x9zm0IOMQHJkz/qOdlGDpzngK/5+x0aRABQE3M1iJKwRaTB5rdMprjo+v2bU2
         rPddC+hpy1OHpA2VA1mR27GhYVXU2loX4liKUuR0RAgHAp89x21O7BRhdqyfng5tuVpI
         lIbvltbErDGgIF1kGdjsDVdRIaQL99RxLpyaiPh8LumARMO0dFaVlnS//DmUNm9h/HFp
         DuZSx5aWiAD0ZofjI7qDW95xeIwRG5xzgiasqw1j2HEu2I/zpgc49xNQLT69Er9pzG3v
         rkwQ==
X-Gm-Message-State: AHQUAua4b8ajLrJRCkIByLdM8FYl47qnFopYLnpzeumami/UnsCTYyzP
        G8gHAvqhTdUiwT98m0NUvyg=
X-Google-Smtp-Source: AHgI3IYUt+39oq+Ck6j4SpuQZwJtCandJOw6RCaQ/gBEyhOlqAGm9X1Dj6qs3ODNy3xFvcVULHa8Gg==
X-Received: by 2002:a62:a510:: with SMTP id v16mr10134905pfm.18.1549454371817;
        Wed, 06 Feb 2019 03:59:31 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id u69sm12471710pfj.116.2019.02.06.03.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 03:59:31 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/2] MIPS: Reserve extra memory for crash dump
Date:   Wed,  6 Feb 2019 19:59:32 +0800
Message-Id: <1549454373-8910-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

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
index 44434e5..af62dc8 100644
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
 
@@ -878,6 +923,12 @@ static void __init arch_mem_init(char **cmdline_p)
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

