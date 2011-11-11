Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 03:22:52 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:64257 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904255Ab1KKCWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 03:22:23 +0100
Received: by ywp31 with SMTP id 31so2040739ywp.36
        for <multiple recipients>; Thu, 10 Nov 2011 18:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XctRrEtYnVIEueifpPJNDRAV2iX2OxZntrA8MxC0zKE=;
        b=CfLms2EJeRWARWdNzmRnprWBic7xVH/7aRUWj+MyNPYszNRB+Zgw72fHLq5w/3zjZ5
         0V3SkBGRUURLWBlUfynZG7n6YI+4Rv1EaD2g7prYyGrD6ubJ8EJ0d6jATmICNud162Yk
         5ByU7eT9vhU8vhbF6K+sMLQWm0/sWP+LJEERY=
Received: by 10.101.107.9 with SMTP id j9mr4463662anm.100.1320978137302;
        Thu, 10 Nov 2011 18:22:17 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 8sm29449680anv.16.2011.11.10.18.22.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 18:22:14 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB2MCIu013090;
        Thu, 10 Nov 2011 18:22:12 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB2MC26013089;
        Thu, 10 Nov 2011 18:22:12 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/8] MIPS: Prune some target specific code out of prom.c
Date:   Thu, 10 Nov 2011 18:21:58 -0800
Message-Id: <1320978124-13042-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9963

From: David Daney <david.daney@cavium.com>

This code is not common enough to be in a shared file.  It is also not
used by any existing boards, so just remove it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/prom.c |   50 -----------------------------------------------
 1 files changed, 0 insertions(+), 50 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 6b8b420..04bf462 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -59,53 +59,3 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
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
-	of_scan_flat_dt(early_init_dt_scan_chosen, arcs_cmdline);
-
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
