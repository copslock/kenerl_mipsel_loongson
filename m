Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 17:54:18 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14325 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103029AbZA0RyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 17:54:15 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B497f4a260002>; Tue, 27 Jan 2009 12:53:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Jan 2009 09:53:29 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Jan 2009 09:53:29 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n0RHrP1p024139;
	Tue, 27 Jan 2009 09:53:25 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n0RHrPtY024138;
	Tue, 27 Jan 2009 09:53:25 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	travis@sgi.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] cpumask fallout: Initialize irq_default_affinity earlier (v3).
Date:	Tue, 27 Jan 2009 09:53:22 -0800
Message-Id: <1233078802-24111-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
In-Reply-To: <497F48F2.90309@caviumnetworks.com>
References: <497F48F2.90309@caviumnetworks.com>
X-OriginalArrivalTime: 27 Jan 2009 17:53:29.0561 (UTC) FILETIME=[297BCC90:01C980A8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21841
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
Acked-by: Mike Travis <travis@sgi.com>
---
 kernel/irq/handle.c |   16 ++++++++++++++++
 kernel/irq/manage.c |    8 --------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index c20db0b..3aba8d1 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -39,6 +39,18 @@ void handle_bad_irq(unsigned int irq, struct irq_desc *desc)
 	ack_bad_irq(irq);
 }
 
+#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
+static void __init init_irq_default_affinity(void)
+{
+	alloc_bootmem_cpumask_var(&irq_default_affinity);
+	cpumask_setall(irq_default_affinity);
+}
+#else
+static void __init init_irq_default_affinity(void)
+{
+}
+#endif
+
 /*
  * Linux has a controller-independent interrupt architecture.
  * Every controller has a 'controller-template', that is used
@@ -134,6 +146,8 @@ int __init early_irq_init(void)
 	int legacy_count;
 	int i;
 
+	init_irq_default_affinity();
+
 	desc = irq_desc_legacy;
 	legacy_count = ARRAY_SIZE(irq_desc_legacy);
 
@@ -219,6 +233,8 @@ int __init early_irq_init(void)
 	int count;
 	int i;
 
+	init_irq_default_affinity();
+
 	desc = irq_desc;
 	count = ARRAY_SIZE(irq_desc);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 618a64f..291f036 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,14 +18,6 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
 cpumask_var_t irq_default_affinity;
 
-static int init_irq_default_affinity(void)
-{
-	alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
-	cpumask_setall(irq_default_affinity);
-	return 0;
-}
-core_initcall(init_irq_default_affinity);
-
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
-- 
1.5.6.6
