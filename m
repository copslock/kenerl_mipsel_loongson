Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:55:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:54373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837153AbaDPMyAhV0fN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:54:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E242ED53FE978
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:53:51 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:53:53 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:53:53 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:53:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/39] MIPS: tlb-r4k: Add CPU PM callback to reconfigure TLB
Date:   Wed, 16 Apr 2014 13:52:55 +0100
Message-ID: <1397652810-4336-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: James Hogan <james.hogan@imgtec.com>

Add a CPU power management callback for the r4k TLB which reconfigures
it after the CPU leaves a powered down state.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mm/tlb-r4k.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index eeaf50f..89e3fab 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -8,6 +8,7 @@
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
  */
+#include <linux/cpu_pm.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -421,7 +422,10 @@ static int __init set_ntlb(char *str)
 
 __setup("ntlb=", set_ntlb);
 
-void tlb_init(void)
+/*
+ * Configure TLB (for init or after a CPU has been powered off).
+ */
+static void r4k_tlb_configure(void)
 {
 	/*
 	 * You should never change this register:
@@ -453,6 +457,11 @@ void tlb_init(void)
 	local_flush_tlb_all();
 
 	/* Did I tell you that ARC SUCKS?  */
+}
+
+void tlb_init(void)
+{
+	r4k_tlb_configure();
 
 	if (ntlb) {
 		if (ntlb > 1 && ntlb <= current_cpu_data.tlbsize) {
@@ -466,3 +475,26 @@ void tlb_init(void)
 
 	build_tlb_refill_handler();
 }
+
+static int r4k_tlb_pm_notifier(struct notifier_block *self, unsigned long cmd,
+			       void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		r4k_tlb_configure();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block r4k_tlb_pm_notifier_block = {
+	.notifier_call = r4k_tlb_pm_notifier,
+};
+
+static int __init r4k_tlb_init_pm(void)
+{
+	return cpu_pm_register_notifier(&r4k_tlb_pm_notifier_block);
+}
+arch_initcall(r4k_tlb_init_pm);
-- 
1.8.5.3
