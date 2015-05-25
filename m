From: Jonas Gorski <jogo@openwrt.org>
Date: Mon, 25 May 2015 19:53:54 +0200
Subject: MIPS: ralink: Fix clearing the illegal access interrupt
Message-ID: <20150525175354.2VztS0o9VJG7ZmEe3cCJS9JXQAy8Es0XIEzriwwfZus@z>

commit 9dd6f1c166bc6e7b582f6203f2dc023ec65e3ed5 upstream.

Due to a typo the illegal access interrupt is never cleared in by
the interupt handler, causing an effective deadlock on the first
illegal access.

This was broken since the code was introduced in 5433acd81e87 ("MIPS:
ralink: add illegal access driver"), but only exposed when the Kconfig
symbol was added, thus enabling the code.

Fixes: a7b7aad383c ("MIPS: ralink: add missing symbol for RALINK_ILL_ACC")
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: John Crispin <blogic@openwrt.org>
Patchwork: https://patchwork.linux-mips.org/patch/10172/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ralink/ill_acc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index e20b02e..e10d10b 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -41,7 +41,7 @@ static irqreturn_t ill_acc_irq_handler(int irq, void *_priv)
 		addr, (type >> ILL_ACC_OFF_S) & ILL_ACC_OFF_M,
 		type & ILL_ACC_LEN_M);

-	rt_memc_w32(REG_ILL_ACC_TYPE, REG_ILL_ACC_TYPE);
+	rt_memc_w32(ILL_INT_STATUS, REG_ILL_ACC_TYPE);

 	return IRQ_HANDLED;
 }
--
1.9.1
