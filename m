Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 04:01:22 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:49579 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993943AbdHJCBCQ925C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Aug 2017 04:01:02 +0200
X-QQ-mid: bizesmtp9t1502330431tnw4998bs
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 10 Aug 2017 10:00:20 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0B00A0000000
X-QQ-FEAT: aNIQy3Sfu62yZkD28SskSvdUKl1HxcpO47/G06/OpIKfMjBxrfHM7R+uQlIsK
        mAsq+GuUi18sr/1qgLs5014Nt68Me+owUkXjFiOp8TOaoD8ft9hpPP7GWOyLI833sIxJ6nq
        hf4qcQlOjgj8zBitTtj0rOCeqWsdvVzUnz8mpj4OBucu1CebJCx9JIWVJ3BT4tYEcOXpcA6
        EkRV9PBniewAsRhXSnzjaSgw3zcRZUL8hm0hsA+W45qAb02Lhh5PsjQrZeJCtnTjAzy0q1w
        FPUya9sCZPIHaGnbL77hpFj6VjOf9ufs9/zg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/8] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
Date:   Thu, 10 Aug 2017 10:00:26 +0800
Message-Id: <1502330433-16670-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59463
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

New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
(Store Fill Buffer) which can improve the performance of memory access.
Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
the generic kernel has no benefit from SFB (even it is running on a new
Loongson-3 machine). With this patch, we can enable SFB at runtime by
detecting the CPU type (the expense is war_io_reorder_wmb() will always
be a 'sync', which will hurt the performance of old Loongson-3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h                         |  2 +-
 .../asm/mach-loongson64/kernel-entry-init.h        | 38 +++++++++++++---------
 arch/mips/include/asm/mipsregs.h                   |  2 ++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index ecabc00..d3e38af 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -304,7 +304,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
-#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON3)
 #define war_io_reorder_wmb()		wmb()
 #else
 #define war_io_reorder_wmb()		do { } while (0)
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 8393bc54..4b7f58a 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -19,19 +19,22 @@
 	.set	push
 	.set	mips64
 	/* Set LPA on LOONGSON3 config3 */
-	mfc0	t0, $16, 3
+	mfc0	t0, CP0_CONFIG3
 	or	t0, (0x1 << 7)
-	mtc0	t0, $16, 3
+	mtc0	t0, CP0_CONFIG3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	mfc0	t0, $5, 1
+	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
-	mtc0	t0, $5, 1
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
+	mtc0	t0, CP0_PAGEGRAIN
 	/* Enable STFill Buffer */
-	mfc0	t0, $16, 6
+	mfc0	t0, CP0_PRID
+	andi	t0, 0xffff
+	slti	t0, 0x6308
+	bnez	t0, 1f
+	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
-	mtc0	t0, $16, 6
-#endif
+	mtc0	t0, CP0_CONFIG6
+1:
 	_ehb
 	.set	pop
 #endif
@@ -45,19 +48,22 @@
 	.set	push
 	.set	mips64
 	/* Set LPA on LOONGSON3 config3 */
-	mfc0	t0, $16, 3
+	mfc0	t0, CP0_CONFIG3
 	or	t0, (0x1 << 7)
-	mtc0	t0, $16, 3
+	mtc0	t0, CP0_CONFIG3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	mfc0	t0, $5, 1
+	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
-	mtc0	t0, $5, 1
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
+	mtc0	t0, CP0_PAGEGRAIN
 	/* Enable STFill Buffer */
-	mfc0	t0, $16, 6
+	mfc0	t0, CP0_PRID
+	andi	t0, 0xffff
+	slti	t0, 0x6308
+	bnez	t0, 1f
+	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
-	mtc0	t0, $16, 6
-#endif
+	mtc0	t0, CP0_CONFIG6
+1:
 	_ehb
 	.set	pop
 #endif
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index dbb0ece..cb1ebc6 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -50,6 +50,7 @@
 #define CP0_CONF $3
 #define CP0_CONTEXT $4
 #define CP0_PAGEMASK $5
+#define CP0_PAGEGRAIN $5, 1
 #define CP0_SEGCTL0 $5, 2
 #define CP0_SEGCTL1 $5, 3
 #define CP0_SEGCTL2 $5, 4
@@ -76,6 +77,7 @@
 #define CP0_CONFIG $16
 #define CP0_CONFIG3 $16, 3
 #define CP0_CONFIG5 $16, 5
+#define CP0_CONFIG6 $16, 6
 #define CP0_LLADDR $17
 #define CP0_WATCHLO $18
 #define CP0_WATCHHI $19
-- 
2.7.0
