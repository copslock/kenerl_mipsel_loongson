From: Huacai Chen <chenhc@lemote.com>
Date: Thu, 12 Mar 2015 11:51:06 +0800
Subject: MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
Message-ID: <20150312035106.5Nc2xK1njbkuiObLlOpAKUEw8k1p3f4DGQpnR9RFFDs@z>

commit 0add9c2f1cff9f3f1f2eb7e9babefa872a9d14b9 upstream.

HPET irq is routed to i8259 and then to MIPS CPU irq (cascade). After
commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq on CPU IRQs), if without
IRQF_NO_SUSPEND in cascade_irqaction, HPET interrupts will lost during
suspend. The result is machine cannot be waken up.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/9528/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/loongson/loongson-3/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index f240828181ff..f2077f201a2a 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -42,6 +42,7 @@ void mach_irq_dispatch(unsigned int pending)

 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
+	.flags = IRQF_NO_SUSPEND,
 	.name = "cascade",
 };
