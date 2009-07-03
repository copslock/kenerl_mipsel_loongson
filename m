From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 3 Jul 2009 07:11:15 +0100
Subject: [PATCH] MIPS: Fix pfn_valid()
Message-ID: <20090703061115.u9GV80JMKmaEklRRTHWUVYpRYgTfbhMBBWbvs7hNeCM@z>

For systems which do not define PHYS_OFFSET as 0 pfn_valid() may falsely
have returned 0 on most configurations.  Bug introduced by commit
752fbeb2e3555c0d236e992f1195fd7ce30e728d (linux-mips.org) rsp.
6f284a2ce7b8bc49cb8455b1763357897a899abb (kernel.org) titled "[MIPS]
FLATMEM: introduce PHYS_OFFSET."

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index dc0eaa7..96a14a4 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -165,7 +165,14 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #ifdef CONFIG_FLATMEM
 
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#define pfn_valid(pfn)							\
+({									\
+	unsigned long __pfn = (pfn);					\
+	/* avoid <linux/bootmem.h> include hell */			\
+	extern unsigned long min_low_pfn;				\
+									\
+	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
+})
 
 #elif defined(CONFIG_SPARSEMEM)
 
