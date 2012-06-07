Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 22:12:47 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:39925 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903731Ab2FGUMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 22:12:41 +0200
Received: by dadm1 with SMTP id m1so1454718dad.36
        for <multiple recipients>; Thu, 07 Jun 2012 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sliMkv32SFAlb7TKeak29br71gDmu4OhVvNrzJLfXuE=;
        b=xb1ZOq1+17z0zraLqmb9MCDeJOfD2OALU4w2VJK6lilJfZ+LkIM7OQQLRdX9Lbhx2E
         fCREHX5oHUdhZSlA9FgNF1OBhl7LagYbs2g82NP2nCRmjmHn9Cl05qIoL992/N5c444K
         IKIW5bfdx0szGPIMvk6mhfoM0i56OGPTmGZG8SiCA8OBmXs6AJflzeCh1Efk9avLbv14
         bJ0mdmI66Q/KWLPRMt7eCCNw1Na4mqbWBIvwhUa/DKRWuOuHSDBHz49feIZvjXeqMcRP
         Zb718r6I+aRZuNG/mEH4nQeVePJnnklG5M0WiuJ2EhL5av2aSoy/fpM/pkjBBZ21V9oF
         p4aQ==
Received: by 10.68.231.71 with SMTP id te7mr11388511pbc.161.1339099954660;
        Thu, 07 Jun 2012 13:12:34 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tj4sm5149731pbc.33.2012.06.07.13.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 13:12:34 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q57KCWb0018598;
        Thu, 7 Jun 2012 13:12:32 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q57KCWVG018596;
        Thu, 7 Jun 2012 13:12:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2] MIPS: OCTEON: Remove some unused OCTEON_IRQ_* definitions.
Date:   Thu,  7 Jun 2012 13:12:31 -0700
Message-Id: <1339099951-18565-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33603
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
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 4189920..c22a307 100644
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
 #ifndef CONFIG_PCI_MSI
 	OCTEON_IRQ_LAST = 127
-- 
1.7.2.3
