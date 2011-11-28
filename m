Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2011 20:33:06 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:34213 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1905239Ab1K1TdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2011 20:33:02 +0100
Received: by mail-iy0-f177.google.com with SMTP id p10so10745357iap.36
        for <multiple recipients>; Mon, 28 Nov 2011 11:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dyLXBZqQbUo7iTmw+7W/ltD3lW0i8eN23jutj1HSbaE=;
        b=QSl6X5Zp+LsYDrKEEpyMutoyLwYyY9ffReB+/UxIE8/ztqouIB/1pR49PkbNE5Jxy4
         20KUqrZJivmtgZEkuO12J7Te8xHSzq1jmT9QN3/27TpLSAvkfZYThQhfr1X4Ib5ppPjp
         KmsnCDP6ZAnE5GrsdoJPmib7bJF4rMtK5MGKo=
Received: by 10.231.63.143 with SMTP id b15mr243028ibi.1.1322508781408;
        Mon, 28 Nov 2011 11:33:01 -0800 (PST)
Received: from localhost.localdomain (wtj.mtv.corp.google.com [172.18.96.96])
        by mx.google.com with ESMTPS id el2sm49214545ibb.10.2011.11.28.11.32.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 11:32:59 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com,
        liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 19/23] mips: Use HAVE_MEMBLOCK_NODE_MAP
Date:   Mon, 28 Nov 2011 11:31:21 -0800
Message-Id: <1322508685-32532-20-git-send-email-tj@kernel.org>
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1322508685-32532-1-git-send-email-tj@kernel.org>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
X-archive-position: 32009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23231

mips used early_node_map[] just to prime free_area_init_nodes().  Now
memblock can be used for the same purpose and early_node_map[] is
scheduled to be dropped.  Use memblock instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                |    3 +++
 arch/mips/kernel/setup.c         |    3 ++-
 arch/mips/sgi-ip27/ip27-memory.c |    5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d46f1da..b789847 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,9 @@ config MIPS
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select ARCH_DISCARD_MEMBLOCK
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 84af26a..b1cb8f8 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/screen_info.h>
+#include <linux/memblock.h>
 #include <linux/bootmem.h>
 #include <linux/initrd.h>
 #include <linux/root_dev.h>
@@ -352,7 +353,7 @@ static void __init bootmem_init(void)
 			continue;
 #endif
 
-		add_active_range(0, start, end);
+		memblock_add_node(PFN_PHYS(start), PFN_PHYS(end - start), 0);
 	}
 
 	/*
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index bc12971..b105eca 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -12,6 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
@@ -381,8 +382,8 @@ static void __init szmem(void)
 				continue;
 			}
 			num_physpages += slot_psize;
-			add_active_range(node, slot_getbasepfn(node, slot),
-					 slot_getbasepfn(node, slot) + slot_psize);
+			memblock_add_node(PFN_PHYS(slot_getbasepfn(node, slot)),
+					  PFN_PHYS(slot_psize), node);
 		}
 	}
 }
-- 
1.7.3.1
