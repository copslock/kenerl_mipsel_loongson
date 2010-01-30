Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:37:18 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53014 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493002Ab0A3RfN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:13 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 729D2551082; Sat, 30 Jan 2010 18:35:13 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 5/7] MIPS: bcm63xx: fix typo in cpu-feature-overrides file.
Date:   Sat, 30 Jan 2010 18:34:56 +0100
Message-Id: <1264872898-28149-6-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19473

Fix typo: CONFIG_BCMCPU_IS_63xx does not exists,
CONFIG_BCM63XX_CPU_63xx is the valid config option.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 .../asm/mach-bcm63xx/cpu-feature-overrides.h       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
index 71742ba..f453c01 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -24,7 +24,7 @@
 #define cpu_has_smartmips		0
 #define cpu_has_vtag_icache		0
 
-#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCMCPU_IS_6348) || defined(CONFIG_CPU_IS_6338) || defined(CONFIG_CPU_IS_BCM6345))
+#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCM63XX_CPU_6348) || defined(CONFIG_BCM63XX_CPU_6345) || defined(CONFIG_BCM63XX_CPU_6338))
 #define cpu_has_dc_aliases		0
 #endif
 
-- 
1.6.3.3
