Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 21:12:22 +0200 (CEST)
Received: from 51.21-broadband.acttv.in ([106.51.21.48]:31844 "EHLO
        arvind-ThinkPad-Edge-E431" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27044063AbcFXTMVEjmV3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2016 21:12:21 +0200
Received: by arvind-ThinkPad-Edge-E431 (Postfix, from userid 1000)
        id BEDFB4E067D; Sat, 25 Jun 2016 00:42:13 +0530 (IST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] cpu_pm :Dummy cpu_pm_register_notifier should return error code.
Date:   Sat, 25 Jun 2016 00:42:09 +0530
Message-Id: <1466795529-4797-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <"arvind@arvind.yadav.cs"@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arvind.yadav.cs@gmail.com
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

The inline cpu_pm_register_notifier stub simply allows compilation
on systems with CONFIG_CPU_PM disabled. The dummy
cpu_pm_register_notifier does not register an trap_pm_init,
r4k_tlb_init_pm and r4k_cache_init_pm at all.The inline
cpu_pm_register_notifier should return to indicate lack of support
when attempting to register an cpu_pm_register_notifier on such a
system with CONFIG_CPU_PM disabled.

The return value of cpu_pm_register_notifier is in trap_pm_init,
r4k_tlb_init_pm and r4k_cache_init_pm where CONFIG_CPU_PM is disable,
all other places do not care about the return value.
So cpu_pm_register_notifier must returning -ENODEV.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 include/linux/cpu_pm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu_pm.h b/include/linux/cpu_pm.h
index 455b233..206c264 100644
--- a/include/linux/cpu_pm.h
+++ b/include/linux/cpu_pm.h
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/notifier.h>
+#include <linux/errno.h>
 
 /*
  * When a CPU goes to a low power state that turns off power to the CPU's
@@ -78,7 +79,7 @@ int cpu_cluster_pm_exit(void);
 
 static inline int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	return 0;
+	return -ENODEV;
 }
 
 static inline int cpu_pm_unregister_notifier(struct notifier_block *nb)
-- 
1.9.1
