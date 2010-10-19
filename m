Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 00:50:51 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8892 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491767Ab0JSWur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 00:50:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cbe20e80000>; Tue, 19 Oct 2010 15:51:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 19 Oct 2010 15:51:04 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 19 Oct 2010 15:51:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9JMocw6031841;
        Tue, 19 Oct 2010 15:50:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9JMoWtf031839;
        Tue, 19 Oct 2010 15:50:32 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Dezhong Diao <dediao@cisco.com>
Subject: [PATCH] of/mips: Cleanup some include directives/files.
Date:   Tue, 19 Oct 2010 15:50:31 -0700
Message-Id: <1287528631-31797-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 19 Oct 2010 22:51:04.0681 (UTC) FILETIME=[1C356590:01CB6FE0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The __init directives should go on the definitions of things, not the
declaration, also __init is meaningless for inline functions, so
remove it from prom.h.  This allows us to get rid of a useless
#include, but most of the rest of them are useless too, so kill them
as well.

If of_i2c.c needs irq definitions, it should include linux/irq.h
directly, not assume indirect inclusion via asm/prom.h.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Dezhong Diao <dediao@cisco.com>
---
 arch/mips/include/asm/prom.h |    8 ++------
 drivers/of/of_i2c.c          |    1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 23f8237..f29b862 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -12,10 +12,6 @@
 #define __ASM_MIPS_PROM_H
 
 #ifdef CONFIG_OF
-#include <linux/init.h>
-
-#include <asm/setup.h>
-#include <asm/irq.h>
 #include <asm/bootinfo.h>
 
 /* which is compatible with the flattened device tree (FDT) */
@@ -27,9 +23,9 @@ extern int early_init_dt_scan_memory_arch(unsigned long node,
 extern int reserve_mem_mach(unsigned long addr, unsigned long size);
 extern void free_mem_mach(unsigned long addr, unsigned long size);
 
-extern void __init device_tree_init(void);
+extern void device_tree_init(void);
 #else /* CONFIG_OF */
-static inline void __init device_tree_init(void) { }
+static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
 
 #endif /* _ASM_MIPS_PROM_H */
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 0a694de..c85d3c7 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_i2c.h>
 #include <linux/of_irq.h>
-- 
1.7.2.3
