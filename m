Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:49:19 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52634 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491138Ab1FJVrk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:40 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id AEF594C8164;
        Fri, 10 Jun 2011 23:47:35 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id AB00918065A;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id A1CE255B08D; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 04/11] MIPS: BCM63XX: introduce bcm_readll & bcm_writell.
Date:   Fri, 10 Jun 2011 23:47:14 +0200
Message-Id: <1307742441-28284-5-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9574

Needed for upcoming 6368 CPU support.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
index 91180fa..8bf4a67 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h
@@ -49,9 +49,11 @@
 #define bcm_readb(a)	(*(volatile unsigned char *)	BCM_REGS_VA(a))
 #define bcm_readw(a)	(*(volatile unsigned short *)	BCM_REGS_VA(a))
 #define bcm_readl(a)	(*(volatile unsigned int *)	BCM_REGS_VA(a))
+#define bcm_readll(a)	(*(volatile u64 *)		BCM_REGS_VA(a))
 #define bcm_writeb(v, a) (*(volatile unsigned char *) BCM_REGS_VA((a)) = (v))
 #define bcm_writew(v, a) (*(volatile unsigned short *) BCM_REGS_VA((a)) = (v))
 #define bcm_writel(v, a) (*(volatile unsigned int *) BCM_REGS_VA((a)) = (v))
+#define bcm_writell(v, a) (*(volatile u64 *) BCM_REGS_VA((a)) = (v))
 
 /*
  * IO helpers to access register set for current CPU
-- 
1.7.1.1
