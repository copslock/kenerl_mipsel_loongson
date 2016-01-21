Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 14:05:22 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:53446 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009956AbcAUNFJEecau (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 14:05:09 +0100
X-QQ-mid: bizesmtp15t1453381485t597t10
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jan 2016 21:04:41 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 3jlOKZxptE7JHAvCvFnf3Rtj6JJtb4OSlT1MYD0hGZIwCNyJQFvIr91pEOpZv
        KxD5o9x7FcXIPIcm2a2ufKOyO/Vg9rj5FIIO5R3sXtDE9jSBLbIO0wOEDxESZa3tCn35Q3D
        wbXAlHeJ+5T0qQy25pVbFmrXPEXm1mvp6Qhki4sF3i0V/1Qvg6RmzMynogdScKAZ5BI2P7n
        ewkZo+TD6wasc5IQAzsQqHfVDoI09aB3i5lJtX4XIOVwSC7DeUts8rbZajAn1AjICToRjDg
        J/Mhpr5fIB0nyIoyqhqqBcnok=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 1/6] MIPS: Cleanup the unused __arch_local_irq_restore() function
Date:   Thu, 21 Jan 2016 21:09:47 +0800
Message-Id: <1453381793-8357-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
References: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51276
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
