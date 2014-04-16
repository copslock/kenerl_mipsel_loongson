Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:54:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:59078 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837072AbaDPMx4TJtJu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:53:56 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E6629904C164B
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:53:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:53:49 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:53:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/39] MIPS: c-r4k: Add CPU PM callback for coherency
Date:   Wed, 16 Apr 2014 13:52:54 +0100
Message-ID: <1397652810-4336-4-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 39810
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

Implement a CPU power management callback for the r4k cache, to set up
coherency again after leaving a powered down state.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mm/c-r4k.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1c74a6a..a2a71c5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -7,6 +7,7 @@
  * Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002 Ralf Baechle (ralf@gnu.org)
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+#include <linux/cpu_pm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
@@ -1644,3 +1645,26 @@ void r4k_cache_init(void)
 	coherency_setup();
 	board_cache_error_setup = r4k_cache_error_setup;
 }
+
+static int r4k_cache_pm_notifier(struct notifier_block *self, unsigned long cmd,
+			       void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		coherency_setup();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block r4k_cache_pm_notifier_block = {
+	.notifier_call = r4k_cache_pm_notifier,
+};
+
+int __init r4k_cache_init_pm(void)
+{
+	return cpu_pm_register_notifier(&r4k_cache_pm_notifier_block);
+}
+arch_initcall(r4k_cache_init_pm);
-- 
1.8.5.3
