Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 23:03:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15586 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNVDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 23:03:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb7702c0000>; Thu, 14 Oct 2010 14:03:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:03:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:03:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9EL30jA015643;
        Thu, 14 Oct 2010 14:03:01 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9EL2t0B015633;
        Thu, 14 Oct 2010 14:02:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] MIPS: Add some irq definitins required by OF
Date:   Thu, 14 Oct 2010 14:02:54 -0700
Message-Id: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 14 Oct 2010 21:03:20.0524 (UTC) FILETIME=[3B3490C0:01CB6BE3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Using the forthcoming open firmware (OF) on mips patches, requires
that several interrupt related definitions be added.

In the future we may want to allow some sort of override for
irq_create_mapping, but for now it is just supplies an identity
mapping.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/mips/include/asm/irq.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index dea4aed..f109e67 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -16,6 +16,39 @@
 
 #include <irq.h>
 
+#define NO_IRQ UINT_MAX
+
+/*
+ * This type is the placeholder for a hardware interrupt number. It
+ * has to be big enough to enclose whatever representation is used by
+ * a given platform.
+ */
+typedef unsigned long irq_hw_number_t;
+
+static inline void irq_dispose_mapping(unsigned int virq)
+{
+	return;
+}
+
+struct irq_host;
+
+/**
+ * irq_create_mapping - Map a hardware interrupt into linux virq space
+ * @host: host owning this hardware interrupt or NULL for default host
+ * @hwirq: hardware irq number in that host space
+ *
+ * Only one mapping per hardware interrupt is permitted. Returns a linux
+ * virq number.
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ */
+static inline unsigned int irq_create_mapping(struct irq_host *host,
+					      irq_hw_number_t hwirq)
+{
+	/* For now, an identity mapping. */
+	return (unsigned int)hwirq;
+}
+
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
-- 
1.7.2.3
