Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2015 12:15:58 +0200 (CEST)
Received: from smtpbg303.qq.com ([184.105.206.26]:47124 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008488AbbFQKOTAxaDp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jun 2015 12:14:19 +0200
X-QQ-mid: bizesmtp4t1434536045t992t132
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 17 Jun 2015 18:14:05 +0800 (CST)
X-QQ-SSF: 01100000002000F0F962000A0000000
X-QQ-FEAT: 0ESs8nxzjD+CbcdBieGvVxtzU3x805KkXnEThj+m8zWLSULT62OkT+g6u4p3f
        nDsFezCmNKMLagAsEZmQF6XyUD/DkB5kY65GRfO+kfR9f/bYY8T/5JUkn8yCuPGMjYHvs6O
        c8ibQgs6DK1B8W4MqtCbwX3mmoUuGzifJLgVgh4Aal9lXYBWIcqwk1nuc5b+IBh0IrYtKew
        WY64TGhhHaJSNciMerE7tTvYFjSS0azpZ48KFEDyL244CpCx2fbTvtnkk5kJJBfQ=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v2 7/8] MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
Date:   Wed, 17 Jun 2015 18:32:45 +0800
Message-Id: <1434537166-5385-8-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
References: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: E3ED4B17E50E4C6EB4F6319A0724F603
X-QQ-LocalIP: 112.95.241.173
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/sparsemem.h   | 6 +++++-
 arch/mips/loongson32/Kconfig        | 1 +
 arch/mips/loongson32/common/setup.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
index b1071c1..f73e671 100644
--- a/arch/mips/include/asm/sparsemem.h
+++ b/arch/mips/include/asm/sparsemem.h
@@ -11,7 +11,11 @@
 #else
 # define SECTION_SIZE_BITS	28
 #endif
-#define MAX_PHYSMEM_BITS	48
+#ifdef CONFIG_64BIT
+# define MAX_PHYSMEM_BITS	48
+#else
+# define MAX_PHYSMEM_BITS	36
+#endif
 
 #endif /* CONFIG_SPARSEMEM */
 #endif /* _MIPS_SPARSEMEM_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 741867c..5a96672 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -11,6 +11,7 @@ config LOONGSON1_LS1A
 	bool "Loongson LS1A board"
 	select CEVT_R4K
 	select CSRC_R4K
+	select ARCH_SPARSEMEM_ENABLE
 	select SYS_HAS_CPU_LOONGSON1A
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 87d21c9..d764fae 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -48,7 +48,8 @@ void __init plat_mem_setup(void)
 		.orig_video_points	= 16,
 	};
 #endif
-	add_memory_region(0x20000000, 0x30000000, BOOT_MEM_RESERVED);
+	if (highmemsize > 0)
+		add_memory_region(0x50000000, highmemsize << 20, BOOT_MEM_RAM);
 #endif
 }
 
-- 
1.9.0
