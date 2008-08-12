From: Sundis <sundism@CUPLXSUNDISM01.corp.sa.net>
Date: Tue, 12 Aug 2008 12:43:31 -0700
Subject: [PATCH] support sparsemem for mips32
Message-ID: <20080812194331.nvYsP5m82iGuJqvbHhEn1d4OAAChdWMaM8_CT7Jwm9Y@z>

---
 arch/mips/kernel/setup.c     |   18 +++++++++++++++++-
 arch/mips/mm/init.c          |    3 +++
 include/asm-mips/sparsemem.h |    6 ++++++
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f8a535a..6ff0f72 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -405,7 +405,6 @@ static void __init bootmem_init(void)
 
 		/* Register lowmem ranges */
 		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
-		memory_present(0, start, end);
 	}
 
 	/*
@@ -417,6 +416,23 @@ static void __init bootmem_init(void)
 	 * Reserve initrd memory if needed.
 	 */
 	finalize_initrd();
+
+	/* call memory present for all the ram */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long start, end;
+
+		/*
+ * 		 * memory present only usable memory.
+ * 		 		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end   = PFN_DOWN(boot_mem_map.map[i].addr
+				    + boot_mem_map.map[i].size);
+
+		memory_present(0, start, end);
+	}
 }
 
 #endif	/* CONFIG_SGI_IP27 */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 480dec0..9bc6d35 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -417,6 +417,9 @@ void __init mem_init(void)
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
 		struct page *page = pfn_to_page(tmp);
 
+		if (!pfn_valid(tmp))
+			continue;
+
 		if (!page_is_ram(tmp)) {
 			SetPageReserved(page);
 			continue;
diff --git a/include/asm-mips/sparsemem.h b/include/asm-mips/sparsemem.h
index 795ac6c..9faaf59 100644
--- a/include/asm-mips/sparsemem.h
+++ b/include/asm-mips/sparsemem.h
@@ -6,8 +6,14 @@
  * SECTION_SIZE_BITS		2^N: how big each section will be
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
+
+#ifndef CONFIG_64BIT
+#define SECTION_SIZE_BITS       27	/* 128 MiB */
+#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
+#else
 #define SECTION_SIZE_BITS       28
 #define MAX_PHYSMEM_BITS        35
+#endif
 
 #endif /* CONFIG_SPARSEMEM */
 #endif /* _MIPS_SPARSEMEM_H */
-- 
1.5.4.1
