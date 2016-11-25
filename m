From: Paul Burton <paul.burton@imgtec.com>
Date: Fri, 25 Nov 2016 18:46:09 +0000
Subject: MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON
Message-ID: <20161125184609.BpLUK8wenUfAqb7HN_TJPEpngKJ4pOSNZR5Dks3-raU@z>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit d4da0e97baea8768b3d66ccef3967bebd50dfc3b ]

If a driver causes DMA cache maintenance with a zero length then we
currently BUG and kill the kernel. As this is a scenario that we may
well be able to recover from, WARN & return in the condition instead.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/14623/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/c-r4k.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -835,7 +835,8 @@ static void r4k_flush_icache_user_range(
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
-	BUG_ON(size == 0);
+	if (WARN_ON(size == 0))
+		return;
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
@@ -871,7 +872,8 @@ static void r4k_dma_cache_wback_inv(unsi
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
-	BUG_ON(size == 0);
+	if (WARN_ON(size == 0))
+		return;
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {


Patches currently in stable-queue which might be from paul.burton@imgtec.com are

queue-4.18/mips-warn_on-invalid-dma-cache-maintenance-not-bug_on.patch
