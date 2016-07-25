Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 22:44:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59748 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991940AbcGYUoaMxtuo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 22:44:30 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sjhill@bethel-hill.org>)
        id 1bRmaf-0003Le-1k; Mon, 25 Jul 2016 15:35:05 -0500
Subject: [PATCH] MIPS: Octeon: Remove forced mappings of USB interrupts.
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <sjhill@bethel-hill.org>
Message-ID: <57967A25.4080502@bethel-hill.org>
Date:   Mon, 25 Jul 2016 15:44:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <sjhill@bethel-hill.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@bethel-hill.org
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

Get rid of unnecessary forced interrupt mappings for
the USB host controller on OCTEON II.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c           | 12 ------------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 368eb49..6ab014c 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1542,10 +1542,6 @@ static int __init octeon_irq_init_ciu(
 			goto err;
 	}
 
-	r = octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB0, 0, 56);
-	if (r)
-		goto err;
-
 	r = octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_TWSI2, 0, 59);
 	if (r)
 		goto err;
@@ -1559,10 +1555,6 @@ static int __init octeon_irq_init_ciu(
 			goto err;
 	}
 
-	r = octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB1, 1, 17);
-	if (r)
-		goto err;
-
 	/* Enable the CIU lines */
 	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
 	if (octeon_irq_use_ip4)
@@ -2077,10 +2069,6 @@ static int __init octeon_irq_init_ciu2(
 			goto err;
 	}
 
-	r = octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB0, 3, 44);
-	if (r)
-		goto err;
-
 	for (i = 0; i < 4; i++) {
 		r = octeon_irq_force_ciu_mapping(
 			ciu_domain, i + OCTEON_IRQ_PCI_INT0, 4, i);
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index cceae32..64b86b9 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -42,8 +42,6 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER1,
 	OCTEON_IRQ_TIMER2,
 	OCTEON_IRQ_TIMER3,
-	OCTEON_IRQ_USB0,
-	OCTEON_IRQ_USB1,
 #ifndef CONFIG_PCI_MSI
 	OCTEON_IRQ_LAST = 127
 #endif
-- 
1.9.1
