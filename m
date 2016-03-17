From: Huacai Chen <chenhc@lemote.com>
Date: Thu, 17 Mar 2016 20:41:05 +0800
Subject: MIPS: Loongson-3: Reserve 32MB for RS780E integrated GPU
Message-ID: <20160317124105.59ITbKEJGq5u-qodxTZ-qI4tNpajscZsRy101c6hzhA@z>

commit 3484de7bcbed20ecbf2b8d80671619e7059e2dd7 upstream.

Due to datasheet, reserving 0xff800000~0xffffffff (8MB below 4GB) is
not enough for RS780E integrated GPU's TOM (top of memory) registers
and MSI/MSI-x memory region, so we reserve 0xfe000000~0xffffffff (32MB
below 4GB).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J . Hill <sjhill@realitydiluted.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12889/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/loongson64/loongson-3/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 6f9e010..282c5a8 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -213,10 +213,10 @@ static void __init node_mem_init(unsigned int node)
 		BOOTMEM_DEFAULT);

 	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
-		/* Reserve 0xff800000~0xffffffff for RS780E integrated GPU */
+		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
 		reserve_bootmem_node(NODE_DATA(node),
-				(node_addrspace_offset | 0xff800000),
-				8 << 20, BOOTMEM_DEFAULT);
+				(node_addrspace_offset | 0xfe000000),
+				32 << 20, BOOTMEM_DEFAULT);
 	}

 	sparse_memory_present_with_active_regions(node);
--
2.7.4
