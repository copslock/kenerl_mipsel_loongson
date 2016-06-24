Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 21:12:01 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33261 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27044047AbcFXTL66nh43 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2016 21:11:58 +0200
Received: by mail-pf0-f194.google.com with SMTP id c74so10038803pfb.0
        for <linux-mips@linux-mips.org>; Fri, 24 Jun 2016 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=e8XdFxIzBscnVQuuq6jOrU+LuozAn9/4zCxS4oM/mlo=;
        b=eEZJaWD9EKk2L8QVXv73zLv/LOYQ/4oA2aNSjbxqdsf1GIpH6MDte1DQmD0unQY9N2
         t/L15kjYmdKsnKGX8j07yqtcck72uhqeGwSWPgcYJVzdby72r9lQkM/wL55zAjxhuSQ5
         4ggRbrHQ7REg9Cg845s4CKpRovETFypUL3duXZ7qV5lAuIrmwp3nnBVrXGW5I+tLrqt2
         Ns72tqRZEDH1/nurukVwr/QYP52iGwLbqvBITqtDDvV6uBzMYV4MDtd8/h1VeaSJNk9K
         HHgU1jnCIbwtQOrQ+MkKgiYsdm2eEYBCHlnBEQvZXHx7q+EYPfI1ke9zady2Z57Ien1w
         J8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e8XdFxIzBscnVQuuq6jOrU+LuozAn9/4zCxS4oM/mlo=;
        b=IqM8KTZfGTrKHPM+d0xFc9eRrHLDwVw60YTuSIj/74VJVoDym3dMZbBfqWSqjtZRoy
         coUdW97EDDLNnh+K6rgCOGJ6cEA6Clo13tOhUgESgQqxRG4cMDQU3dn2fnTj1rJUD+Du
         Q+0JLvuw+e3eZnaz37nIy2wJijNvI7UJnjsDjXrKHKiStmUz0M9ILOQgGB/aSZAPOf1r
         crhDINeeNwHTTBsD2cIloGJ2Lt1J5I+/ELfmaob7csagMRnMDaNbCc7MSCUwLO9sSwEj
         1K79KID5iUZvygHmNpotjVKrCbP4y6eV0COvzGXDmH3pH6bPSGQsaq2j4LKNXeDyE/cX
         08ww==
X-Gm-Message-State: ALyK8tJ4XZBSNtR7GREgxgSz7PCpPLKwgJcJSVXPftrklRlTHQ5mzpf7g2nniSD7mJxQNg==
X-Received: by 10.98.201.210 with SMTP id l79mr10088319pfk.87.1466795512934;
        Fri, 24 Jun 2016 12:11:52 -0700 (PDT)
Received: from localhost.localdomain ([106.51.21.48])
        by smtp.gmail.com with ESMTPSA id o84sm1737896pfj.95.2016.06.24.12.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 12:11:51 -0700 (PDT)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] cpu_pm :Dummy cpu_pm_register_notifier should return error code.
Date:   Sat, 25 Jun 2016 00:41:37 +0530
Message-Id: <1466795497-4744-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54160
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
