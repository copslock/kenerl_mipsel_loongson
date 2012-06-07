Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 21:52:46 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50595 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903731Ab2FGTwd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 21:52:33 +0200
Received: by pbbrq13 with SMTP id rq13so1614657pbb.36
        for <multiple recipients>; Thu, 07 Jun 2012 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9d0mwAOl4W3cE0PHJPZMpzJBEDBytYNDwKd0UC1S2n8=;
        b=pqp3j1BQkGGrHGFd5VuyrfGvt9n/SSnXXDDpALqS/UHi1gBDjvjofoWFEDKtb/ezcj
         v5QR7Wh6c48W139vpAhxm+xzVd9oDVqkBnt1Rbs3kDxxeSLpXGIyE6IX5CjoITNb96Dj
         GekCxsrRBCIn0waZHSxrPmOHOX3zClpcqC7r6Aw2/RIPKvhS2BgqT7bMiIL7IAV5Pewc
         Wx9D/OsxBkOpmANjxWuzfho1Pud1zYZF5u5UB+ym1Bg5IBdaKHKcg2aH7JeGi3SaPF0e
         APLwpdlX+ON9IVkrm3w0SeZDNHVnFuZ9PB38qNk5h8smcf1P8ns/T4yTmMgfigsyvhsU
         wXnA==
Received: by 10.68.136.106 with SMTP id pz10mr11657890pbb.143.1339098747261;
        Thu, 07 Jun 2012 12:52:27 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id to1sm5102352pbc.27.2012.06.07.12.52.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 12:52:26 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q57JqPBc009906;
        Thu, 7 Jun 2012 12:52:25 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q57JqPuq009905;
        Thu, 7 Jun 2012 12:52:25 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] MIPS: OCTEON: Remove some unused OCTEON_IRQ_* definitions.
Date:   Thu,  7 Jun 2012 12:52:24 -0700
Message-Id: <1339098744-9874-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33600
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

These are now unused.  Remove them.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/irq.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 4189920..0a47c9f 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -26,9 +26,6 @@ enum octeon_irq {
 	OCTEON_IRQ_WDOG15 = OCTEON_IRQ_WDOG0 + 15,
 	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 16,
 	OCTEON_IRQ_MBOX1,
-	OCTEON_IRQ_UART0,
-	OCTEON_IRQ_UART1,
-	OCTEON_IRQ_UART2,
 	OCTEON_IRQ_PCI_INT0,
 	OCTEON_IRQ_PCI_INT1,
 	OCTEON_IRQ_PCI_INT2,
@@ -38,8 +35,6 @@ enum octeon_irq {
 	OCTEON_IRQ_PCI_MSI2,
 	OCTEON_IRQ_PCI_MSI3,
 
-	OCTEON_IRQ_TWSI,
-	OCTEON_IRQ_TWSI2,
 	OCTEON_IRQ_RML,
 	OCTEON_IRQ_TIMER0,
 	OCTEON_IRQ_TIMER1,
@@ -47,8 +42,6 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER3,
 	OCTEON_IRQ_USB0,
 	OCTEON_IRQ_USB1,
-	OCTEON_IRQ_MII0,
-	OCTEON_IRQ_MII1,
 	OCTEON_IRQ_BOOTDMA,
 #ifndef CONFIG_PCI_MSI
 	OCTEON_IRQ_LAST = 127
-- 
1.7.2.3
