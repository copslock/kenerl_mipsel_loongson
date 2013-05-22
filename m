Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 23:46:37 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36142 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820514Ab3EVVqfAxkRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 23:46:35 +0200
Received: by mail-pb0-f41.google.com with SMTP id xb12so2178748pbc.28
        for <multiple recipients>; Wed, 22 May 2013 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dfdJfcMDnUgx9nL6RONDrLjrGskkPN3uNwafFGt3Rzo=;
        b=xu7kiY3OJ6DtBpo//DOR/a3rg/BPLak21oVo3d30jRJSmG34PX97Rm1qVRD4yLWmXl
         urQz8E6pEC6VYfxd1EbdEYGETcRBA6SDijjmc2JzOUqqDBCYhotRNrgOAhZhA6mURSTB
         zIzWhJhWup0/9cCS6fXC4No00BfKFufg/z86I6v7QByIiJWCa5u15F6ihl0GbJtb40MZ
         3ZgBngI00K3wqGBk0TNWD3a9IGWb0pYU2u622PIzraoYd3eNuT2gcYE7HJqwhd27SP5f
         mOsr3OKUxoXuEEXp7WPVRsiylItQwkPCIftpCML03MJwAfrSZIwPLo6Qlj9Y9o33n0Zn
         0rmQ==
X-Received: by 10.66.119.145 with SMTP id ku17mr10150061pab.204.1369259188260;
        Wed, 22 May 2013 14:46:28 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id q18sm9672408pao.4.2013.05.22.14.46.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 14:46:27 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MLkPVR029111;
        Wed, 22 May 2013 14:46:25 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MLkO8o029110;
        Wed, 22 May 2013 14:46:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: OCTEON: Remove vestiges of CONFIG_CAVIUM_DECODE_RSL
Date:   Wed, 22 May 2013 14:46:23 -0700
Message-Id: <1369259183-29076-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36539
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

From: David Daney <david.daney@cavium.com>

This config option doesn't exist any more, remove the leftover code
for it too.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0baa29..b593133 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -40,12 +40,6 @@
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 
-#ifdef CONFIG_CAVIUM_DECODE_RSL
-extern void cvmx_interrupt_rsl_decode(void);
-extern int __cvmx_interrupt_ecc_report_single_bit_errors;
-extern void cvmx_interrupt_rsl_enable(void);
-#endif
-
 extern struct plat_smp_ops octeon_smp_ops;
 
 #ifdef CONFIG_PCI
@@ -460,18 +454,6 @@ static void octeon_halt(void)
 }
 
 /**
- * Handle all the error condition interrupts that might occur.
- *
- */
-#ifdef CONFIG_CAVIUM_DECODE_RSL
-static irqreturn_t octeon_rlm_interrupt(int cpl, void *dev_id)
-{
-	cvmx_interrupt_rsl_decode();
-	return IRQ_HANDLED;
-}
-#endif
-
-/**
  * Return a string representing the system type
  *
  * Returns
@@ -1061,15 +1043,6 @@ void prom_free_prom_memory(void)
 			panic("Core-14449 WAR not in place (%04x).\n"
 			      "Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).", insn);
 	}
-#ifdef CONFIG_CAVIUM_DECODE_RSL
-	cvmx_interrupt_rsl_enable();
-
-	/* Add an interrupt handler for general failures. */
-	if (request_irq(OCTEON_IRQ_RML, octeon_rlm_interrupt, IRQF_SHARED,
-			"RML/RSL", octeon_rlm_interrupt)) {
-		panic("Unable to request_irq(OCTEON_IRQ_RML)");
-	}
-#endif
 }
 
 int octeon_prune_device_tree(void);
-- 
1.7.11.7
