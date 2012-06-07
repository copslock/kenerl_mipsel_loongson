Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 21:52:20 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:64094 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903735Ab2FGTwR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 21:52:17 +0200
Received: by dadm1 with SMTP id m1so1427993dad.36
        for <multiple recipients>; Thu, 07 Jun 2012 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZzDm0Sk1yC/2I+TBQ93H9xUYlpr/q5jsNUw9B05mNds=;
        b=ZzOEo33YyWKb5kJItWJypWDFq+iUw1fYZRlyU7ZWNiSMYdZj8glBkfLlOO4b0PcJZb
         65jk5Su+6f2UBqYQFs65Wm93ZigF5aKL4ybCUNXE2LzdcwSTBGMHeM4qcOga/eaXSAZt
         M2aODPAeEOMEaN5jsb9xnvH924u0ohkSbAo38U2I476mM0mgDnKX0M36MOvDv2qhmxZS
         ochn36b6rPfPKvOYcf0PpOdv+LMFpOIji/d0+0065hcS/bSDQKOz8MAkHiNZ7RY5j8Uw
         OnoZjULPUhVu07ZBq9guqgIuJelVUwKzjAJCRc2RkcKWw+Sj0VvupyLmKdhaMbpr/1UL
         OO/g==
Received: by 10.68.201.195 with SMTP id kc3mr12739696pbc.33.1339098730077;
        Thu, 07 Jun 2012 12:52:10 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wn3sm5084080pbc.74.2012.06.07.12.52.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 12:52:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q57Jq7Jl009825;
        Thu, 7 Jun 2012 12:52:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q57Jq6kH009823;
        Thu, 7 Jun 2012 12:52:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/3] MIPS: OCTEON: Fix build error when configured without PCI_MSI
Date:   Thu,  7 Jun 2012 12:52:05 -0700
Message-Id: <1339098725-9792-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The build dies with complaints about missing definition of
OCTEON_IRQ_RST.  This symbol was removed, so don't use it as part of
the definition of OCTEON_IRQ_LAST.

Set OCTEON_IRQ_LAST to 127 so there is space for all the automatically
allocated (via irq_domain) irqs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index f9bfb63..4189920 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -50,6 +50,9 @@ enum octeon_irq {
 	OCTEON_IRQ_MII0,
 	OCTEON_IRQ_MII1,
 	OCTEON_IRQ_BOOTDMA,
+#ifndef CONFIG_PCI_MSI
+	OCTEON_IRQ_LAST = 127
+#endif
 };
 
 #ifdef CONFIG_PCI_MSI
@@ -58,8 +61,6 @@ enum octeon_irq {
 
 #define OCTEON_IRQ_MSI_LAST      (OCTEON_IRQ_MSI_BIT0 + 255)
 #define OCTEON_IRQ_LAST          (OCTEON_IRQ_MSI_LAST + 1)
-#else
-#define OCTEON_IRQ_LAST         (OCTEON_IRQ_RST + 1)
 #endif
 
 #endif
-- 
1.7.2.3
