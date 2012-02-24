Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 17:30:12 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:55359 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903755Ab2BXQaF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 17:30:05 +0100
Received: by pbcun1 with SMTP id un1so3260036pbc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 08:29:58 -0800 (PST)
Received-SPF: pass (google.com: domain of glikely@secretlab.ca designates 10.68.136.100 as permitted sender) client-ip=10.68.136.100;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of glikely@secretlab.ca designates 10.68.136.100 as permitted sender) smtp.mail=glikely@secretlab.ca
Received: from mr.google.com ([10.68.136.100])
        by 10.68.136.100 with SMTP id pz4mr9725400pbb.26.1330100998617 (num_hops = 1);
        Fri, 24 Feb 2012 08:29:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.136.100 with SMTP id pz4mr8036162pbb.26.1330100998472;
        Fri, 24 Feb 2012 08:29:58 -0800 (PST)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id e6sm4710609pbr.74.2012.02.24.08.29.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 08:29:57 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 9CC5A3E0647; Fri, 24 Feb 2012 09:29:56 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: [PATCH] irq_domain/mips: Allow irq_domain on MIPS
Date:   Fri, 24 Feb 2012 09:29:55 -0700
Message-Id: <1330100995-19823-1-git-send-email-grant.likely@secretlab.ca>
X-Mailer: git-send-email 1.7.9
X-Gm-Message-State: ALoCoQnsGSN3cPtx7+vgIY7pbC8rZ4rx4U8EQcmTWBhe/MTuUfPheXvcbC7BFBDVS5gY5V9o0ONH
X-archive-position: 32549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch makes IRQ_DOMAIN usable on MIPS.  It uses an ugly workaround
to preserve current behaviour so that MIPS has time to add irq_domain
registration to the irq controller drivers.  The workaround will be
removed in Linux v3.6

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

This applies on top of linux-next or my irqdomain/next branch.  Ralf, with
your ack I should merge it via that tree.

git://git.secretlab.ca/git/linux-2.6 irqdomain/next

 arch/mips/Kconfig           |    1 +
 arch/mips/include/asm/irq.h |    5 +----
 arch/mips/kernel/prom.c     |   14 --------------
 kernel/irq/irqdomain.c      |   12 ++++++++++++
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5ab6e89..edbbae1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2327,6 +2327,7 @@ config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
 	select OF_EARLY_FLATTREE
+	select IRQ_DOMAIN
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 2354c87..fb698dc 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -11,15 +11,12 @@
 
 #include <linux/linkage.h>
 #include <linux/smp.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mipsmtregs.h>
 
 #include <irq.h>
 
-static inline void irq_dispose_mapping(unsigned int virq)
-{
-}
-
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 6b8b420..558b539 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -60,20 +60,6 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
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
 void __init early_init_devtree(void *params)
 {
 	/* Setup flat device-tree pointer */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 25a498e..af48e59 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -411,6 +411,18 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 
 	domain = controller ? irq_find_host(controller) : irq_default_domain;
 	if (!domain) {
+#ifdef CONFIG_MIPS
+		/*
+		 * Workaround to avoid breaking interrupt controller drivers
+		 * that don't yet register an irq_domain.  This is temporary
+		 * code. ~~~gcl, Feb 24, 2012
+		 *
+		 * Scheduled for removal in Linux v3.6.  That should be enough
+		 * time.
+		 */
+		if (intsize > 0)
+			return intspec[0];
+#endif
 		printk(KERN_WARNING "irq: no irq domain found for %s !\n",
 		       controller->full_name);
 		return 0;
-- 
1.7.9
