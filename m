Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:37:09 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:44403 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab2D0Sc5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:57 +0200
Received: by dakb39 with SMTP id b39so1178981dak.35
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pAJBaBRcTuhJ1OT0lnyDHLT/i5Q3uH6+WTtTK9NoS/g=;
        b=BrxTmtGQuo1lmHKZGX3sWd6eUGJccIolc4fIHpAXXTGywJQTLiW1MX3x4YbxqAf97u
         mK7fQKJf/pD+dGDBKdLgB66WkysRv/uajlkuCZHPPzwFqa075ek3SUbtL2z5+I9Gw8Ah
         LYnokxpw3RNgd7n2Kruk3I0p84bAjI5eKLfQkmXZmmBvvHXoiyk+yj4eQKpXHr6+oiBk
         Ny4e3tyg+qdLoCi+SDEw7fNIw6uoUiyeZnWDiJLFWUHS1tRXbmCxE82Sx05sCvft4GOM
         +gT8JYw3oEWTDr+XcDlbwrjb7VUaIQaw8ecUhrxA/cqdZkIL3BNDcs4Ep7jXKBuPU2lw
         z1AQ==
Received: by 10.68.211.197 with SMTP id ne5mr9499752pbc.143.1335551568309;
        Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pp8sm6489490pbb.21.2012.04.27.11.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWjc4019642;
        Fri, 27 Apr 2012 11:32:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWj0X019641;
        Fri, 27 Apr 2012 11:32:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 5/8] MIPS: OCTEON: Add OCTEON_IRQ_* definitions for cn68XX chips.
Date:   Fri, 27 Apr 2012 11:32:37 -0700
Message-Id: <1335551560-19581-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

There are 64 workqueue, 32 watchdog, and 4 mbox.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 16b7da3..38b25d4 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -21,10 +21,11 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER,
 /* sources in CIU_INTX_EN0 */
 	OCTEON_IRQ_WORKQ0,
-	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_WORKQ0 + 16,
-	OCTEON_IRQ_WDOG15 = OCTEON_IRQ_WDOG0 + 15,
-	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 16,
+	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_WORKQ0 + 64,
+	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 32,
 	OCTEON_IRQ_MBOX1,
+	OCTEON_IRQ_MBOX2,
+	OCTEON_IRQ_MBOX3,
 	OCTEON_IRQ_PCI_INT0,
 	OCTEON_IRQ_PCI_INT1,
 	OCTEON_IRQ_PCI_INT2,
-- 
1.7.2.3
