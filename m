Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24KJll24843
	for linux-mips-outgoing; Mon, 4 Mar 2002 12:19:47 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g24KJa924838
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 12:19:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA02475;
	Mon, 4 Mar 2002 20:19:28 +0100 (MET)
Date: Mon, 4 Mar 2002 20:19:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: [patch] Critical swapping problems
In-Reply-To: <Pine.GSO.3.96.1020225173650.12500L-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020304194911.21038N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 After studying dependencies I concluded the Flo's patch for R3k swapping
is OK -- it correctly zeroes the valid and global bits of swapped-out
PTEs.  Additionally the R4k+ version didn't zero the global bit. 

 Here is a patch I successfully tested using an NVRAM and a RAM-disk as
swap devices on my R3k system.  I took quite some time, but weird Oopses
and init crashes were distracting me.  It turned out these were signal
delivery bugs (or at least that's what I suspect) that were not directly
related to the patch but to the test environment I created (the bugs are
still a mystery and are under investigation) -- without the patch they
happen as well, usually under conditions near OOM.  The patch consists
mostly of the Flo's changes with R4k+ bits as well as comment updates
added by me. 

 Given enough virtual memory the patch works very well -- I've run `tar
-jxf glibc-2.2.5.tar.bz2; rm -rf glibc-2.2.5' for a few hours in a loop
which with RAM clipped to 16MB and 32MB of swap gives a considerable swap
activity, with no problems noticed. 

 Ralf, the patch is *CRITICAL* for R3k -- please apply it as soon as
possible.  The R4k+ update is not so important as MAX_SWAPFILES protects
us, but it should go in anyway for correctness.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020129-swap-2
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/include/asm-mips/pgtable.h linux-mips-2.4.17-20020129/include/asm-mips/pgtable.h
--- linux-mips-2.4.17-20020129.macro/include/asm-mips/pgtable.h	Fri Jan 25 05:27:42 2002
+++ linux-mips-2.4.17-20020129/include/asm-mips/pgtable.h	Wed Feb 27 00:55:35 2002
@@ -165,7 +165,7 @@ extern int add_temporary_entry(unsigned 
 #define _PAGE_SILENT_READ           (1<<9)  /* synonym                 */
 #define _PAGE_DIRTY                 (1<<10) /* The MIPS dirty bit      */
 #define _PAGE_SILENT_WRITE          (1<<10)
-#define _CACHE_UNCACHED             (1<<11) /* R4[0246]00              */
+#define _CACHE_UNCACHED             (1<<11)
 #define _CACHE_MASK                 (1<<11)
 #define _CACHE_CACHABLE_NONCOHERENT 0
 
@@ -518,9 +518,19 @@ extern void paging_init(void);
 extern void update_mmu_cache(struct vm_area_struct *vma,
 				unsigned long address, pte_t pte);
 
-#define SWP_TYPE(x)		(((x).val >> 1) & 0x3f)
+/* Swap entries must have VALID and GLOBAL bits cleared. */
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+
+#define SWP_TYPE(x)		(((x).val >> 1) & 0x7f)
+#define SWP_OFFSET(x)		((x).val >> 10)
+#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
+#else
+
+#define SWP_TYPE(x)		(((x).val >> 1) & 0x1f)
 #define SWP_OFFSET(x)		((x).val >> 8)
 #define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#endif
+
 #define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)	((pte_t) { (x).val })
 
