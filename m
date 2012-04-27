Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:34:17 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:52483 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab2D0Scy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:54 +0200
Received: by dakb39 with SMTP id b39so1178922dak.35
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0Zpg7WpKIMOrhF5b+vQcpV9NkZahu2Fkr+LRoTd6klY=;
        b=saSW3FhhWWweMqXZqFx/c/O3fRE28nhmeRa/6i2lZRrTAYyuwWMiB73uChwNxqhMKd
         kAIE3TJ0860ZKZqCi1TIOJ1ddLx8ZNHSXyiDeomyHJdziCz2HHGJvtJC5rurA0c8f8ZG
         NhAluyb66E7KEgDVz8/ZKgLw83UHFPAEjOSLoMZhjyA8CbGY87nBXXVWs2IyNgGM4h5+
         mK0c7QCR/vQ7gGFRiRldEbYjat+lpA+N75wOREy8q+Kr2EGeY4VtOJmatrHNmF8fHR9a
         35LWPm+cKMyUnDDDm1/FmxsbYUG13rfkW6GBVBhF2zkkcxaPfA3Ql+FFCwzpqUM8vNi+
         k7/w==
Received: by 10.68.136.42 with SMTP id px10mr1875501pbb.132.1335551568123;
        Fri, 27 Apr 2012 11:32:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id h10sm7152700pbh.69.2012.04.27.11.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWjRa019638;
        Fri, 27 Apr 2012 11:32:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWjWo019637;
        Fri, 27 Apr 2012 11:32:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 4/8] MIPS: OCTEON: Get rid of unused OCTEON_IRQ_* definitions.
Date:   Fri, 27 Apr 2012 11:32:36 -0700
Message-Id: <1335551560-19581-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

With the device tree and irq_domains, most of these are unneeded.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index f9bfb63..16b7da3 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -21,14 +21,10 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER,
 /* sources in CIU_INTX_EN0 */
 	OCTEON_IRQ_WORKQ0,
-	OCTEON_IRQ_GPIO0 = OCTEON_IRQ_WORKQ0 + 16,
-	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_GPIO0 + 16,
+	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_WORKQ0 + 16,
 	OCTEON_IRQ_WDOG15 = OCTEON_IRQ_WDOG0 + 15,
 	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 16,
 	OCTEON_IRQ_MBOX1,
-	OCTEON_IRQ_UART0,
-	OCTEON_IRQ_UART1,
-	OCTEON_IRQ_UART2,
 	OCTEON_IRQ_PCI_INT0,
 	OCTEON_IRQ_PCI_INT1,
 	OCTEON_IRQ_PCI_INT2,
@@ -38,8 +34,6 @@ enum octeon_irq {
 	OCTEON_IRQ_PCI_MSI2,
 	OCTEON_IRQ_PCI_MSI3,
 
-	OCTEON_IRQ_TWSI,
-	OCTEON_IRQ_TWSI2,
 	OCTEON_IRQ_RML,
 	OCTEON_IRQ_TIMER0,
 	OCTEON_IRQ_TIMER1,
@@ -47,8 +41,6 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER3,
 	OCTEON_IRQ_USB0,
 	OCTEON_IRQ_USB1,
-	OCTEON_IRQ_MII0,
-	OCTEON_IRQ_MII1,
 	OCTEON_IRQ_BOOTDMA,
 };
 
@@ -59,7 +51,7 @@ enum octeon_irq {
 #define OCTEON_IRQ_MSI_LAST      (OCTEON_IRQ_MSI_BIT0 + 255)
 #define OCTEON_IRQ_LAST          (OCTEON_IRQ_MSI_LAST + 1)
 #else
-#define OCTEON_IRQ_LAST         (OCTEON_IRQ_RST + 1)
+#define OCTEON_IRQ_LAST         256
 #endif
 
 #endif
-- 
1.7.2.3
