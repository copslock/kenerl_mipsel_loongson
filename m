From: Kevin D. Kissell <kevink@mips.com>
Date: Thu, 10 Apr 2008 02:45:26 +0200
Subject: [PATCH] Propagate max_low_pfn as max_pfn for compatibility with legacy driver and aprp code.
Message-ID: <20080410004526.FrhBp47T1hFm5wRZJ13Rzm65HsfgXIj660PIAqus3MM@z>


Signed-off-by: Kevin D. Kissell <kevink@mips.com>
---
 arch/mips/kernel/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f8a535a..a6a0d62 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -336,6 +336,10 @@ static void __init bootmem_init(void)
 #endif
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
+	/*
+	 * Propagate final value of max_low_pfn to max_pfn
+	 */
+	max_pfn = max_low_pfn;
 
 	/*
 	 * Initialize the boot-time allocator with low memory only.
-- 
1.5.3.3


--------------030103020306010003010808
Content-Type: text/x-patch;
 name="0003-Functional-Fixes-and-a-little-reformatting-of-APRP-S.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-Functional-Fixes-and-a-little-reformatting-of-APRP-S.pa";
 filename*1="tch"
