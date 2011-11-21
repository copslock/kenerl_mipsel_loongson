Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 10:16:41 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51155 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903702Ab1KUJOy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 10:14:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 309123B1C5A;
        Mon, 21 Nov 2011 10:14:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zv58rdebyRJV; Mon, 21 Nov 2011 10:14:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id CAA9D3B1C75;
        Mon, 21 Nov 2011 10:14:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/9] MIPS: BCM63XX: define RSET_SPI_SIZE
Date:   Mon, 21 Nov 2011 10:14:16 +0100
Message-Id: <1321866861-14340-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321866861-14340-1-git-send-email-florian@openwrt.org>
References: <1321866861-14340-1-git-send-email-florian@openwrt.org>
X-archive-position: 31844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17037

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 016dc9e..073aaca 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -135,6 +135,7 @@ enum bcm63xx_regs_set {
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
 #define RSET_DSL_SIZE			4096
 #define RSET_WDT_SIZE			12
+#define RSET_SPI_SIZE			256
 #define RSET_ENET_SIZE			2048
 #define RSET_ENETDMA_SIZE		2048
 #define RSET_ENETSW_SIZE		65536
-- 
1.7.5.4
