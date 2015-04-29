Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:46:43 +0200 (CEST)
Received: from smtpbg64.qq.com ([103.7.28.238]:60103 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011920AbbD2DqlsTFBp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:46:41 +0200
X-QQ-mid: bizesmtp2t1430278791t244t009
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:50 +0800 (CST)
X-QQ-SSF: 01100000002000F0F432B00A0000000
X-QQ-FEAT: wkBK5F5nntizLtVz9Eb7lWZViR/2su7Jh6vsPBDndo5mz9sE1VI3+WGkrwOFM
        +HGXVEWpSYpgnnIaHKLxUrk0bJ3sQ/FQ06wqoxRsvv9msVEYmaZSgDF+4iHP8VQXlr/MJDJ
        ZF0m17VzWl4VjKCBuDb0bV5EMBluLhgm3o4xwjvngLUXd6Y6ZFtL0c8Za6oTPpmve7EKy+h
        Vji4vbjOd+ZcttY7oWiKJXVbCehDhowK5Qff0Mf05ncmiEkxpyZ3Q
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 7/8] MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
Date:   Wed, 29 Apr 2015 11:57:26 +0800
Message-Id: <1430279847-25120-8-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47158
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
 arch/mips/include/asm/sparsemem.h  | 6 +++++-
 arch/mips/loongson1/Kconfig        | 1 +
 arch/mips/loongson1/common/setup.c | 3 ++-
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
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index 7899f53..94a0701 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -11,6 +11,7 @@ config LOONGSON1_LS1A
 	bool "Loongson LS1A board"
 	select CEVT_R4K
 	select CSRC_R4K
+	select ARCH_SPARSEMEM_ENABLE
 	select SYS_HAS_CPU_LOONGSON1A
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson1/common/setup.c
index 87d21c9..d764fae 100644
--- a/arch/mips/loongson1/common/setup.c
+++ b/arch/mips/loongson1/common/setup.c
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
