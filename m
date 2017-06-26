Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:34:47 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:34711
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993962AbdFZWeA5coft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:34:00 +0200
Received: by mail-qt0-x243.google.com with SMTP id w6so1877124qtg.1;
        Mon, 26 Jun 2017 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5bWnOsVH0upiLjUQMbws8ELARtsuDFAS7j8H/h9kZgs=;
        b=k5CGlU3sA1tpvoVcMC7gGmDDBT/zfinV8wHWziB+ZILSsIFCyhOhEJlz7EywkNLTXP
         NDT1qH2m42yBzFHc2EtA5zZIA3AZhmI6kWnWiyXu7mRNPqnG4mb/mVMilW36qA0qOuVN
         AIikFuHPhz1avBNwPxcjNjCrsmuxYj4Fedcih09ecbFuCMK5UIj2taElXew2bKQ/6tCY
         o/P8MeOCZhluNi4vtmQKSv5SSt78JFzVz87aVoCDcMRQXGrieohmtcTLGzfLg/fy0sa+
         gCq66VOq24JCXORB238GrkFoozkst6Hzw2FmgHWU+cJCpk1xoMyndQNTVr1eE+I/plKi
         rP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5bWnOsVH0upiLjUQMbws8ELARtsuDFAS7j8H/h9kZgs=;
        b=RpmtcqX96xArJajyNUfHjQ9v/1v7Gs6Te0ZefhpP7fv0bci2FNC3+U/uhZnkWcZ2Rm
         dKdsWmBWcklChqlh8GqBOQhf7H08dpVz1zER8nFeRAyFyrqhYB7z/I+r4BTgSM0JCU0S
         uYlBMO5BXycMGZJ1W9bWwbdnZb7IwSOH2REiv1pNoxxyEsdpfM5FT/CY8X2QLudvMCtU
         c0ww1TDHPafd1jnZU2DnlEtx+gAf1VVf8MQOwRQBumqAcR1/zxLgdARsW7sc4ikk/uxh
         iDdeTbgVnp/aE2mAULZV05xeTSUKur4XPfLC8JicNlft+lupEilyKlJumwcYzYrFq7sf
         u+7Q==
X-Gm-Message-State: AKS2vOzjFnsD3u+oweeolZ0Y9Q74a/LCNma4mjJ6jEbP6jet3LCzOD9Z
        DbjFPMA/g5pg4w==
X-Received: by 10.200.40.207 with SMTP id j15mr2984517qtj.186.1498516435311;
        Mon, 26 Jun 2017 15:33:55 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:33:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] misc: sram-exec: Use aligned fncpy instead of memcpy
Date:   Mon, 26 Jun 2017 15:32:43 -0700
Message-Id: <20170626223248.14199-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Dave Gerlach <d-gerlach@ti.com>

Currently the sram-exec functionality, which allows allocation of
executable memory and provides an API to move code to it, is only
selected in configs for the ARM architecture. Based on commit
5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
function body copying") simply copying a C function pointer address
using memcpy without consideration of alignment and Thumb is unsafe on
ARM platforms.

The aforementioned patch introduces the fncpy macro which is a safe way
to copy executable code on ARM platforms, so let's make use of that here
rather than the unsafe plain memcpy that was previously used by
sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
return an address that is guaranteed to be safely callable.

In the future, architectures hoping to make use of the sram-exec
functionality must define an fncpy macro just as ARM has done to
guarantee or check for safe copying to executable memory before allowing
the arch to select CONFIG_SRAM_EXEC.

Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/misc/sram-exec.c | 27 ++++++++++++++++++++-------
 include/linux/sram.h     |  8 ++++----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index 3d528a13b8fc..426ad912b441 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/sram.h>
 
+#include <asm/fncpy.h>
 #include <asm/set_memory.h>
 
 #include "sram.h"
@@ -58,20 +59,32 @@ int sram_add_protect_exec(struct sram_partition *part)
  * @src: Source address for the data to copy
  * @size: Size of copy to perform, which starting from dst, must reside in pool
  *
+ * Return: Address for copied data that can safely be called through function
+ *	   pointer, or NULL if problem.
+ *
  * This helper function allows sram driver to act as central control location
  * of 'protect-exec' pools which are normal sram pools but are always set
  * read-only and executable except when copying data to them, at which point
  * they are set to read-write non-executable, to make sure no memory is
  * writeable and executable at the same time. This region must be page-aligned
  * and is checked during probe, otherwise page attribute manipulation would
- * not be possible.
+ * not be possible. Care must be taken to only call the returned address as
+ * dst address is not guaranteed to be safely callable.
+ *
+ * NOTE: This function uses the fncpy macro to move code to the executable
+ * region. Some architectures have strict requirements for relocating
+ * executable code, so fncpy is a macro that must be defined by any arch
+ * making use of this functionality that guarantees a safe copy of exec
+ * data and returns a safe address that can be called as a C function
+ * pointer.
  */
-int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
-		   size_t size)
+void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+		     size_t size)
 {
 	struct sram_partition *part = NULL, *p;
 	unsigned long base;
 	int pages;
+	void *dst_cpy;
 
 	mutex_lock(&exec_pool_list_mutex);
 	list_for_each_entry(p, &exec_pool_list, list) {
@@ -81,10 +94,10 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	mutex_unlock(&exec_pool_list_mutex);
 
 	if (!part)
-		return -EINVAL;
+		return NULL;
 
 	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
-		return -EINVAL;
+		return NULL;
 
 	base = (unsigned long)part->base;
 	pages = PAGE_ALIGN(size) / PAGE_SIZE;
@@ -94,13 +107,13 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	set_memory_nx((unsigned long)base, pages);
 	set_memory_rw((unsigned long)base, pages);
 
-	memcpy(dst, src, size);
+	dst_cpy = fncpy(dst, src, size);
 
 	set_memory_ro((unsigned long)base, pages);
 	set_memory_x((unsigned long)base, pages);
 
 	mutex_unlock(&part->lock);
 
-	return 0;
+	return dst_cpy;
 }
 EXPORT_SYMBOL_GPL(sram_exec_copy);
diff --git a/include/linux/sram.h b/include/linux/sram.h
index c97dcbe8ce25..4fb405fb0480 100644
--- a/include/linux/sram.h
+++ b/include/linux/sram.h
@@ -16,12 +16,12 @@
 struct gen_pool;
 
 #ifdef CONFIG_SRAM_EXEC
-int sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
+void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
 #else
-static inline int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
-				 size_t size)
+static inline void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+				   size_t size)
 {
-	return -ENODEV;
+	return NULL;
 }
 #endif /* CONFIG_SRAM_EXEC */
 #endif /* __LINUX_SRAM_H__ */
-- 
2.9.3
