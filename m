Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 12:53:27 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:39733 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029920AbcERKwoJUWt1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 12:52:44 +0200
X-QQ-mid: bizesmtp3t1463568749t120t096
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 18 May 2016 18:52:28 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF60000A0000000
X-QQ-FEAT: YltLETjrkC1lpfQT2Wb+gV8MkT56lsSf9ySPZ7gHg7fS+Ahv9AJYbT/ZMPPcP
        FMA6V9xnrhlldzwJdlR3FqZGdlrcQ7/+NEl7Z23M2ZZruQyxFO3nbk2GOn3KhJPitgzOXmd
        JtsVh449NGSBngB4ykXwVe/+piaSsBHB7lPLzQ8IcrQ5CNiChrjuBC4sp3+M4L20Kn+K1D+
        WQQWsvCFpqbcurPhTcqjQltBFxwX/wkQvE1hGrjP40Pw6SCEKFuEt9pDMWko1xNJrv1mnjl
        StjhJXkMvzu66Wy7KkCoJodtOOwYWVhB+wQA==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 7/9] MIPS: Loongson-1A: Enable SPARSEMEN and HIGHMEM
Date:   Wed, 18 May 2016 18:49:59 +0800
Message-Id: <1463568601-25042-6-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
References: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53502
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

Signed-off-by: Chunbo Cui <cuichboo@163.com>
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
index 35effa8..0b5a125 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -7,6 +7,7 @@ config LOONGSON1_LS1A
 	bool "Loongson LS1A board"
 	select CEVT_R4K
 	select CSRC_R4K
+	select ARCH_SPARSEMEM_ENABLE
 	select SYS_HAS_CPU_LOONGSON1A
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 95b0155..af9ccee 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -54,7 +54,8 @@ void __init plat_mem_setup(void)
 		.orig_video_points	= 16,
 	};
 #endif
-	add_memory_region(0x20000000, 0x30000000, BOOT_MEM_RESERVED);
+	if (highmemsize > 0)
+		add_memory_region(0x50000000, highmemsize << 20, BOOT_MEM_RAM);
 #endif
 }
 
-- 
1.9.1
