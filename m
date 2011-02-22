Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 21:59:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13988 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1BVU6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 21:58:20 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d64239f0000>; Tue, 22 Feb 2011 12:59:11 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1MKwDfE020911;
        Tue, 22 Feb 2011 12:58:13 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1MKwCaH020910;
        Tue, 22 Feb 2011 12:58:12 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH 03/10] MIPS: Prune some target specific code out of prom.c
Date:   Tue, 22 Feb 2011 12:57:47 -0800
Message-Id: <1298408274-20856-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 22 Feb 2011 20:58:18.0691 (UTC) FILETIME=[3B69C130:01CBD2D3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This code is not common enough to be in a shared file.  It is also not
used by any existing boards, so just remove it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/prom.c |   49 -----------------------------------------------
 1 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index a19811e9..a07b6f1 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -59,52 +59,3 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 	initrd_below_start_ok = 1;
 }
 #endif
-
-/*
- * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
- *
- * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
- * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
- * supported.
- */
-unsigned int irq_create_of_mapping(struct device_node *controller,
-				   const u32 *intspec, unsigned int intsize)
-{
-	return intspec[0];
-}
-EXPORT_SYMBOL_GPL(irq_create_of_mapping);
-
-void __init early_init_devtree(void *params)
-{
-	/* Setup flat device-tree pointer */
-	initial_boot_params = params;
-
-	/* Retrieve various informations from the /chosen node of the
-	 * device-tree, including the platform type, initrd location and
-	 * size, and more ...
-	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
-
-	/* Scan memory nodes */
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
-}
-
-void __init device_tree_init(void)
-{
-	unsigned long base, size;
-
-	if (!initial_boot_params)
-		return;
-
-	base = virt_to_phys((void *)initial_boot_params);
-	size = be32_to_cpu(initial_boot_params->totalsize);
-
-	/* Before we do anything, lets reserve the dt blob */
-	reserve_mem_mach(base, size);
-
-	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_mem_mach(base, size);
-}
-- 
1.7.2.3
