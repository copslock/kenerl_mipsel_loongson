Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 20:23:18 +0000 (GMT)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:41989 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365031AbZAHUXP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 20:23:15 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496660700000>; Thu, 08 Jan 2009 15:22:09 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 12:21:26 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 12:21:26 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n08KLNGw008473;
	Thu, 8 Jan 2009 12:21:23 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n08KLLLx008470;
	Thu, 8 Jan 2009 12:21:21 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	rusty@rustcorp.com.au, torvalds@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] cpumask fallout: Initialize irq_default_affinity earlier.
Date:	Thu,  8 Jan 2009 12:21:21 -0800
Message-Id: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 08 Jan 2009 20:21:26.0317 (UTC) FILETIME=[AE9805D0:01C971CE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Move the initialization of irq_default_affinity to early_irq_init as
core_initcall is too late.

irq_default_affinity can be used in init_IRQ and potentially timer and
SMP init as well.  All of these happen before core_initcall.  Moving
the initialization to early_irq_init ensures that it is initialized
before it is used.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Only tested on my mips/cavium_octeon port that (if the benevolent
spirits are willing) will be pushed up from Ralf's linux-mips.org tree
in the very near future.  Also the tested configuration is without
CONFIG_SPARSE_IRQ, so that was not tested, but it should be safe as it
is the same code.

 kernel/irq/handle.c    |    8 ++++++++
 kernel/irq/internals.h |    4 ++++
 kernel/irq/manage.c    |    4 +---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index c20db0b..54802ca 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -134,6 +134,10 @@ int __init early_irq_init(void)
 	int legacy_count;
 	int i;
 
+#ifdef CONFIG_SMP
+	init_irq_default_affinity();
+#endif
+
 	desc = irq_desc_legacy;
 	legacy_count = ARRAY_SIZE(irq_desc_legacy);
 
@@ -219,6 +223,10 @@ int __init early_irq_init(void)
 	int count;
 	int i;
 
+#ifdef CONFIG_SMP
+	init_irq_default_affinity();
+#endif
+
 	desc = irq_desc;
 	count = ARRAY_SIZE(irq_desc);
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index e6d0a43..066ff94 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -32,6 +32,10 @@ static inline void unregister_handler_proc(unsigned int irq,
 
 extern int irq_select_affinity_usr(unsigned int irq);
 
+#ifdef CONFIG_SMP
+extern void init_irq_default_affinity(void);
+#endif
+
 /*
  * Debugging printout:
  */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index cd0cd8d..2f87aae 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,13 +18,11 @@
 #ifdef CONFIG_SMP
 cpumask_var_t irq_default_affinity;
 
-static int init_irq_default_affinity(void)
+void __init init_irq_default_affinity(void)
 {
 	alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
 	cpumask_setall(irq_default_affinity);
-	return 0;
 }
-core_initcall(init_irq_default_affinity);
 
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
-- 
1.5.6.6
