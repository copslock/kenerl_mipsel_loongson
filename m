Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 20:45:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11817 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491989Ab1CDTmw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 20:42:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d7140f00000>; Fri, 04 Mar 2011 11:43:44 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p24JgjR4017349;
        Fri, 4 Mar 2011 11:42:45 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p24JgiIr017348;
        Fri, 4 Mar 2011 11:42:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v2 06/12] MIPS: Octeon: Add a irq_create_of_mapping() implementation.
Date:   Fri,  4 Mar 2011 11:42:18 -0800
Message-Id: <1299267744-17278-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 04 Mar 2011 19:42:50.0388 (UTC) FILETIME=[58770D40:01CBDAA4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is needed for Octeon to use the Device Tree.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index b365710..b0a9261 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -8,7 +8,9 @@
 
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/smp.h>
 
@@ -64,6 +66,29 @@ static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
 	octeon_irq_ciu_to_irq[line][bit] = irq;
 }
 
+/*
+ * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
+ *
+ * Octeon irq maps are a pair of indexes.  The first selects either
+ * ciu0 or ciu1, the second is the bit within the ciu register.
+ */
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   const u32 *intspec, unsigned int intsize)
+{
+	int ciu, bit;
+	unsigned int irq = 0;
+
+	ciu = be32_to_cpup(intspec);
+	bit = be32_to_cpup(intspec + 1);
+
+	if (ciu < 8 && bit < 64)
+		irq = octeon_irq_ciu_to_irq[ciu][bit];
+
+	return irq;
+}
+EXPORT_SYMBOL_GPL(irq_create_of_mapping);
+
+
 static int octeon_coreid_for_cpu(int cpu)
 {
 #ifdef CONFIG_SMP
-- 
1.7.2.3
