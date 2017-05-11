From: Mathias Kresin <dev@kresin.me>
Date: Thu, 11 May 2017 08:18:24 +0200
Subject: MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset
Message-ID: <20170511061824.V61W0L9iI1as0ZQcblNNw1HDZTXarXpoxC6eKbpnGtE@z>

From: Mathias Kresin <dev@kresin.me>

[ Upstream commit 05454c1bde91fb013c0431801001da82947e6b5a ]

According to the QCA u-boot source the "PCIE Phase Lock Loop
Configuration (PCIE_PLL_CONFIG)" register is for all SoCs except the
QCA955X and QCA956X at offset 0x10.

Since the PCIE PLL config register is only defined for the AR724x fix
only this value. The value is wrong since the day it was added and isn't
used by any driver yet.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16048/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -167,7 +167,7 @@
 #define AR71XX_AHB_DIV_MASK		0x7
 
 #define AR724X_PLL_REG_CPU_CONFIG	0x00
-#define AR724X_PLL_REG_PCIE_CONFIG	0x18
+#define AR724X_PLL_REG_PCIE_CONFIG	0x10
 
 #define AR724X_PLL_FB_SHIFT		0
 #define AR724X_PLL_FB_MASK		0x3ff


Patches currently in stable-queue which might be from dev@kresin.me are

queue-4.16/mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
