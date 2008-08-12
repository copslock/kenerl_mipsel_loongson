From: Sundis <sundism@CUPLXSUNDISM01.corp.sa.net>
Date: Tue, 12 Aug 2008 13:02:34 -0700
Subject: [PATCH] add sparsemem howto document
Message-ID: <20080812200234.UzrZONz6h2ZaV16LAm9NaK_gViH-Aa_trgKcy_g08hI@z>

---
 Documentation/sparsemem.txt |   95 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/sparsemem.txt

diff --git a/Documentation/sparsemem.txt b/Documentation/sparsemem.txt
new file mode 100644
index 0000000..a9ce4bc
--- /dev/null
+++ b/Documentation/sparsemem.txt
@@ -0,0 +1,95 @@
+Sparsemem divides up physical memory in your system into N section of M
+bytes. Page tables are created for only those sections that
+actually exist (as far as the sparsemem code is concerned). This allows
+for holes in the physical memory without having to waste space by
+creating page discriptors for those pages that do not exist.
+When page_to_pfn() or pfn_to_page() are called there is a bit of overhead to
+look up the proper memory section to get to the page_table, but this
+is small compared to the memory you are likely to save. So, it's not the
+default, but should be used if you have big holes in physical memory.
+
+Note that discontiguous memory is more closely related to NUMA machines
+and if you are a single CPU system use sparsemem and not discontig. 
+It's much simpler. 
+
+1) CALL MEMORY_PRESENT()
+Existing sections are recorded once the bootmem allocator is up and running by
+calling the sparsemem function "memory_present(node, pfn_start, pfn_end)" for each
+block of memory that exists in your physical address space. The
+memory_present() function records valid sections in a data structure called
+mem_section[].
+
+2) DETERMINE AND SET THE SIZE OF SECTIONS AND PHYSMEM
+The size of N and M above depend upon your architecture
+and your platform and are specified in the file:
+
+      include/asm-<your_arch>/sparsemem.h
+
+and you should create the following lines similar to below: 
+
+	#ifdef CONFIG_YOUR_PLATFORM
+	 #define SECTION_SIZE_BITS       27	/* 128 MiB */
+	#endif
+	#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
+
+if they don't already exist, where: 
+
+ * SECTION_SIZE_BITS            2^M: how big each section will be
+ * MAX_PHYSMEM_BITS             2^N: how much memory we can have in that
+                                     space
+
+3) INITIALIZE SPARSE MEMORY
+You should make sure that you initialize the sparse memory code by calling 
+
+	bootmem_init();
+  +	sparse_init();
+	paging_init();
+
+just before you call paging_init() and after the bootmem_allocator is
+turned on in your setup_arch() code.  
+
+4) ENABLE SPARSEMEM IN KCONFIG
+Add a line like this:
+
+	select ARCH_SPARSEMEM_ENABLE
+
+into the config for your platform in arch/<your_arch>/Kconfig. This will
+ensure that turning on sparsemem is enabled for your platform. 
+
+5) CONFIG
+Run make menuconfig or make gconfig, as you like, and turn on the sparsemem
+memory model under the "Kernel Type" --> "Memory Model" and then build your
+kernel.
+
+
+6) Gotchas
+
+One trick that I encountered when I was turning this on for MIPS was that there
+was some code in mem_init() that set the "reserved" flag for pages that were not
+valid RAM. This caused my kernel to crash when I enabled sparsemem since those
+pages (and page descriptors) didn't actually exist. I changed my code by adding
+lines like below:
+
+
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
+
+   +		if (!pfn_valid(tmp))
+   +			continue;
+   +
+		if (!page_is_ram(tmp)) {
+			SetPageReserved(page);
+			continue;
+		}
+		ClearPageReserved(page);
+		init_page_count(page);
+		__free_page(page);
+		physmem_record(PFN_PHYS(tmp), PAGE_SIZE, physmem_highmem);
+		totalhigh_pages++;
+	}
+
+
+Once I got that straight, it worked!!!! I saved 10MiB of memory.  
+
+
+
-- 
1.5.4.1


--------------010403040800010305090501--
