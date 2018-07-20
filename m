From: Felix Fietkau <nbd@nbd.name>
Date: Fri, 20 Jul 2018 13:58:22 +0200
Subject: MIPS: ath79: fix system restart
Message-ID: <20180720115822.MjXjp4D0-Sdva6u8qRtqzlDaXo0zcZ1kxxopJEQGTFA@z>

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit f8a7bfe1cb2c1ebfa07775c9c8ac0ad3ba8e5ff5 ]

This patch disables irq on reboot to fix hang issues that were observed
due to pending interrupts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19913/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/ath79/setup.c                  |    1 +
 arch/mips/include/asm/mach-ath79/ath79.h |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -40,6 +40,7 @@ static char ath79_sys_type[ATH79_SYS_TYP
 
 static void ath79_restart(char *command)
 {
+	local_irq_disable();
 	ath79_device_reset_set(AR71XX_RESET_FULL_CHIP);
 	for (;;)
 		if (cpu_wait)
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -134,6 +134,7 @@ static inline u32 ath79_pll_rr(unsigned
 static inline void ath79_reset_wr(unsigned reg, u32 val)
 {
 	__raw_writel(val, ath79_reset_base + reg);
+	(void) __raw_readl(ath79_reset_base + reg); /* flush */
 }
 
 static inline u32 ath79_reset_rr(unsigned reg)


Patches currently in stable-queue which might be from nbd@nbd.name are

queue-4.18/mips-ath79-fix-system-restart.patch
