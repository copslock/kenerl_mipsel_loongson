Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 16:19:47 +0100 (CET)
Received: from smtpbg299.qq.com ([184.105.67.99]:33195 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006763AbbK3PTpjhxiS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 16:19:45 +0100
X-QQ-mid: bizesmtp8t1448896729t246t296
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 30 Nov 2015 23:18:42 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK62B00A0000000
X-QQ-FEAT: oP8qruwI8aV2qtJwy9msFEos1sPsZUHFKuB3u6nbRySFkZG+H/Xdh0urbIPqE
        zWKxIZgi4W+1mytMjoxl9HXt0vCchrMQnNfc76FYvhUC+T18Yd6aob1PQ20XU7rmg4Byrv8
        rvTYafPSHbPJzwDVCKS6UhF5duE5O8RGXdeyLyOUbQhMV2iJJ77tD7hVTNd2yE6ihPqJESZ
        KKQ2+zGYLDgnHxXDzs0ozHQKAAKCQsBcwCTStEEUMFNhqKWAcfLL6GR1+MnRdjT83+OdBiE
        cvOgB5RYQjkxWspUtrQKTe+p4=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Cleanup the unused __arch_local_irq_restore() function
Date:   Mon, 30 Nov 2015 23:22:38 +0800
Message-Id: <1448896958-14551-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-FName: DAC92E87B595406B9C38F0CEB7E68615
X-QQ-LocalIP: 10.130.87.152
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

In history, __arch_local_irq_restore() is only used by SMTC. However,
SMTC support has been removed since 3.16, this patch remove the unused
function.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/irqflags.h | 30 ------------------------------
 arch/mips/lib/mips-atomic.c      | 30 +-----------------------------
 2 files changed, 1 insertion(+), 59 deletions(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index e7b138b..65c351e 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -84,41 +84,11 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	: "memory");
 }
 
-static inline void __arch_local_irq_restore(unsigned long flags)
-{
-	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-#if defined(CONFIG_IRQ_MIPS_CPU)
-	/*
-	 * Slow, but doesn't suffer from a relatively unlikely race
-	 * condition we're having since days 1.
-	 */
-	"	beqz	%[flags], 1f					\n"
-	"	di							\n"
-	"	ei							\n"
-	"1:								\n"
-#else
-	/*
-	 * Fast, dangerous.  Life is fun, life is good.
-	 */
-	"	mfc0	$1, $12						\n"
-	"	ins	$1, %[flags], 0, 1				\n"
-	"	mtc0	$1, $12						\n"
-#endif
-	"	" __stringify(__irq_disable_hazard) "			\n"
-	"	.set	pop						\n"
-	: [flags] "=r" (flags)
-	: "0" (flags)
-	: "memory");
-}
 #else
 /* Functions that require preempt_{dis,en}able() are in mips-atomic.c */
 void arch_local_irq_disable(void);
 unsigned long arch_local_irq_save(void);
 void arch_local_irq_restore(unsigned long flags);
-void __arch_local_irq_restore(unsigned long flags);
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 
 static inline void arch_local_irq_enable(void)
diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
index 272af8a..5530070 100644
--- a/arch/mips/lib/mips-atomic.c
+++ b/arch/mips/lib/mips-atomic.c
@@ -57,7 +57,6 @@ notrace void arch_local_irq_disable(void)
 }
 EXPORT_SYMBOL(arch_local_irq_disable);
 
-
 notrace unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
@@ -111,31 +110,4 @@ notrace void arch_local_irq_restore(unsigned long flags)
 }
 EXPORT_SYMBOL(arch_local_irq_restore);
 
-
-notrace void __arch_local_irq_restore(unsigned long flags)
-{
-	unsigned long __tmp1;
-
-	preempt_disable();
-
-	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-	"	mfc0	$1, $12						\n"
-	"	andi	%[flags], 1					\n"
-	"	ori	$1, 0x1f					\n"
-	"	xori	$1, 0x1f					\n"
-	"	or	%[flags], $1					\n"
-	"	mtc0	%[flags], $12					\n"
-	"	" __stringify(__irq_disable_hazard) "			\n"
-	"	.set	pop						\n"
-	: [flags] "=r" (__tmp1)
-	: "0" (flags)
-	: "memory");
-
-	preempt_enable();
-}
-EXPORT_SYMBOL(__arch_local_irq_restore);
-
-#endif /* !CONFIG_CPU_MIPSR2 */
+#endif /* !CONFIG_CPU_MIPSR2 && !CONFIG_CPU_MIPSR6 */
-- 
2.4.6
