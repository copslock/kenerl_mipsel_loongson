Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 05:49:36 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:44512 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991726AbdHQDtVaj0A2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 05:49:21 +0200
X-QQ-mid: bizesmtp15t1502941720t6igrq6u
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 17 Aug 2017 11:48:30 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0000A0000000
X-QQ-FEAT: r8geFCKg7nbvcEdfP/0Oip4g09rRHXEOHbGMbTBbztSM/Xy7wTwtmsgL4NZXT
        jPjcGKLAW4lboGw7zWO6f538EjvPOrX860SSeH02QHDn9ARD1s+GuJEM9Czy8M39zs30XC0
        AjqUmkOLpEjDogln7OPb0WBAlTd5DD2Qgakllc/tiMbomj090hnigLr5W+wbIdjv6D0fa71
        hJt5E3uulhl+VxluolWNVzMDSqSyvlQ4ofjcDrqIGf1tShsPeheztQRCfp8UOaKw4NaWewj
        +CHBgHibaxhTdIZCuPYBz0Ywbodl/3RMmUbg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        YunQiang Su <yunqiang.su@imgtec.com>
Subject: [PATCH] MIPS: Loongson fix name confict - MEM_RESERVED
Date:   Thu, 17 Aug 2017 11:49:26 +0800
Message-Id: <1502941766-19524-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59604
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

MEM_RESERVED is used as a value of enum mem_type in include/linux/
edac.h. This will make failure to build for Loongson in some case:
for example with CONFIG_RAS enabled.

So here rename MEM_RESERVED to SYSTEM_RAM_RESERVED in Loongson code.

Signed-off-by: YunQiang Su <yunqiang.su@imgtec.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/boot_param.h | 2 +-
 arch/mips/loongson64/common/mem.c                  | 2 +-
 arch/mips/loongson64/loongson-3/numa.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 6faa76d..7f66760 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -3,7 +3,7 @@
 
 #define SYSTEM_RAM_LOW		1
 #define SYSTEM_RAM_HIGH		2
-#define MEM_RESERVED		3
+#define SYSTEM_RAM_RESERVED	3
 #define PCI_IO			4
 #define PCI_MEM			5
 #define LOONGSON_CFG_REG	6
diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/common/mem.c
index 4022a35..65169ee 100644
--- a/arch/mips/loongson64/common/mem.c
+++ b/arch/mips/loongson64/common/mem.c
@@ -86,7 +86,7 @@ void __init prom_init_memory(void)
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RAM);
 				break;
-			case MEM_RESERVED:
+			case SYSTEM_RAM_RESERVED:
 				add_memory_region(loongson_memmap->map[i].mem_start,
 					(u64)loongson_memmap->map[i].mem_size << 20,
 					BOOT_MEM_RESERVED);
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 2e93cd2..416a489 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -175,7 +175,7 @@ static void __init szmem(unsigned int node)
 			memblock_add_node(PFN_PHYS(start_pfn),
 				PFN_PHYS(end_pfn - start_pfn), node);
 			break;
-		case MEM_RESERVED:
+		case SYSTEM_RAM_RESERVED:
 			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
 				(u32)node_id, mem_type, mem_start, mem_size);
 			add_memory_region((node_id << 44) + mem_start,
-- 
2.7.0


C
