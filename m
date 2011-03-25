Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 20:39:36 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19560 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab1CYTjI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 20:39:08 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d8cef910000>; Fri, 25 Mar 2011 12:40:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Mar 2011 12:39:04 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Mar 2011 12:39:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2PJcwcF011282;
        Fri, 25 Mar 2011 12:38:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2PJcvPW011281;
        Fri, 25 Mar 2011 12:38:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     tglx@linutronix.de, linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v3 1/4] genirq: Reserve the irq when calling irq_set_chip()
Date:   Fri, 25 Mar 2011 12:38:48 -0700
Message-Id: <1301081931-11240-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1301081931-11240-1-git-send-email-ddaney@caviumnetworks.com>
References: <1301081931-11240-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 25 Mar 2011 19:39:04.0204 (UTC) FILETIME=[4C52DCC0:01CBEB24]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The helper macros and functions like for_each_active_irq() don't work
unless the irq is in the allocated_irqs set.

In the case of !CONFIG_SPARSE_IRQ, instead of forcing all users of the
irq infrastructure to explicitly call irq_reserve_irq(), do it for
them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 kernel/irq/chip.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c9c0601..54d9aab 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -37,6 +37,12 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 	irq_chip_set_defaults(chip);
 	desc->irq_data.chip = chip;
 	irq_put_desc_unlock(desc, flags);
+	/*
+	 * For !CONFIG_SPARSE_IRQ make the irq show up in
+	 * allocated_irqs.  For the CONFIG_SPARSE_IRQ case, it may
+	 * already be there, and this call is harmless.
+	 */
+	irq_reserve_irq(irq);
 	return 0;
 }
 EXPORT_SYMBOL(irq_set_chip);
-- 
1.7.2.3
