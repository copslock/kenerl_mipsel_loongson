Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:48:56 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:60203 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904133Ab1KDSst (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:48:49 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 8E4654C82A6;
        Fri,  4 Nov 2011 19:48:44 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id B1FDD557C0C; Fri,  4 Nov 2011 19:11:58 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 04/11] MIPS: BCM63XX: introduce bcm_readll & bcm_writell.
Date:   Fri,  4 Nov 2011 19:09:28 +0100
Message-Id: <1320430175-13725-5-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3907

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
