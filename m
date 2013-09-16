Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 01:09:56 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57441 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822674Ab3IPXJvX4mKQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 01:09:51 +0200
Received: by mail-ob0-f181.google.com with SMTP id gq1so4365441obb.26
        for <multiple recipients>; Mon, 16 Sep 2013 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FopL+BwdhGjle+Jth83DOJWsXFdAkldvkazcdyxuSK4=;
        b=zIy48u/aY77LyQ5vHWe0V8og2bYtuWW09IvRXK4/g8l+zU4X1NclwhdFAY2ociuri2
         NWjpy6jkX+7BZYtNMmP0c/nmJmXxeTqyJSy583J9znJVu7LWdLdDS67ClQFSba2jXxXw
         3gFchn2LMlq/nebX4VDRJwQwGGIZeG8x8g+0jEUJ+4xy+qmaA/CqYOOGD/bxLR5RVjMi
         hS/9q5/QUJZQK841p5WtwiAgLNUNdxRJEqcUs5qdYG51MXhwNAF46WPj1/ZfvjF4y71A
         QJx/FXH8s9YsCIMzfJPozdGKLujWhpf72fAreObb6xGC2orXjtBm9Mfc6fR5O0XC3uaA
         lbJg==
X-Received: by 10.60.60.71 with SMTP id f7mr1012687oer.82.1379372985161;
        Mon, 16 Sep 2013 16:09:45 -0700 (PDT)
Received: from rob-laptop.calxeda.com ([173.226.190.126])
        by mx.google.com with ESMTPSA id s14sm34574615oeo.1.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Sep 2013 16:09:44 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 15/28] mips: use early_init_dt_scan
Date:   Mon, 16 Sep 2013 18:09:11 -0500
Message-Id: <1379372965-22359-16-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <rob.herring@calxeda.com>

Convert mips to use new early_init_dt_scan function.

Remove early_init_dt_scan_memory_arch

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/prom.h |  3 ---
 arch/mips/kernel/prom.c      | 39 +++------------------------------------
 2 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 1e7e096..e3dbd0e 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -17,9 +17,6 @@
 #include <linux/types.h>
 #include <asm/bootinfo.h>
 
-extern int early_init_dt_scan_memory_arch(unsigned long node,
-	const char *uname, int depth, void *data);
-
 extern void device_tree_init(void);
 
 static inline unsigned long pci_address_to_pio(phys_addr_t address)
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 0fa0b69..67a4c53 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -17,8 +17,6 @@
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -40,13 +38,6 @@ char *mips_get_machine_name(void)
 }
 
 #ifdef CONFIG_OF
-int __init early_init_dt_scan_memory_arch(unsigned long node,
-					  const char *uname, int depth,
-					  void *data)
-{
-	return early_init_dt_scan_memory(node, uname, depth, data);
-}
-
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	return add_memory_region(base, size, BOOT_MEM_RAM);
@@ -78,36 +69,12 @@ int __init early_init_dt_scan_model(unsigned long node,	const char *uname,
 	return 0;
 }
 
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
-
-	/* try to load the mips machine name */
-	of_scan_flat_dt(early_init_dt_scan_model, NULL);
-}
-
 void __init __dt_setup_arch(struct boot_param_header *bph)
 {
-	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
-		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
-
+	if (!early_init_dt_scan(bph))
 		return;
-	}
-
-	initial_boot_params = bph;
 
-	early_init_devtree(initial_boot_params);
+	/* try to load the mips machine name */
+	of_scan_flat_dt(early_init_dt_scan_model, NULL);
 }
 #endif
-- 
1.8.1.2
