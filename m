Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9RNYPB10919
	for linux-mips-outgoing; Sat, 27 Oct 2001 16:34:25 -0700
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9RNXw010915
	for <linux-mips@oss.sgi.com>; Sat, 27 Oct 2001 16:33:58 -0700
Received: (qmail 26326 invoked from network); 27 Oct 2001 23:33:56 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 27 Oct 2001 23:33:56 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 15xcxX-0007LK-00
	for <linux-mips@oss.sgi.com>; Sat, 27 Oct 2001 17:33:47 -0600
Date: Sat, 27 Oct 2001 17:33:47 -0600 (MDT)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] RM7k cache initialization
Message-ID: <Pine.LNX.3.96.1011027164718.27541C-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

I've been fiddling around with getting Linux from SGI CVS booting on my
RM7000 box, with lots of good luck! I did find one notable bug, the code
in c-rm7k.c to initialize the caches isn't correct. My board boots in a
manner that tends to expose cache flushing bugs so I actually hit this..

The patch below fixes it up. The notable changes are:
  - Cache sizes are #defined and verifed against the CPU registers. This
    is to help ensure that gcc doesn't start touching memory it shouldn't
  - There is a single cache init function that does the ICache, DCache,
    SCache and TCache all in one go.
  - The code to fix up the ICache was corrected to run with caches turned
    on and to load data that is definately 0 (required according to PMC)
  - TCache initialization is done if the cache is marked enabled when 
    ld_mmu_rm7k is called. I expect prom_init functions to enable any
    HW support, disable KSEG0 caching and enable the tcache bit. The size
    of the cache is assumed to be the max the chip can support.

I've only tested this on a custom RM7000A board with a wack of tertiary
cache, but I don't see any reason it shouldn't work generally..

Thanks,
Jason

Index: c-rm7k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-rm7k.c,v
retrieving revision 1.2
diff -u -r1.2 c-rm7k.c
--- c-rm7k.c	2001/10/26 22:33:14	1.2
+++ c-rm7k.c	2001/10/27 22:47:10
@@ -33,7 +33,9 @@
 				     ".set reorder\n\t")
 
 /* Primary cache parameters. */
-static int icache_size, dcache_size; /* Size in bytes */
+#define icache_size	(16*1024)	/* Fixed to 16KiB on RM7000 */
+#define dcache_size	(16*1024)	/* Fixed to 16KiB on RM7000 */
+#define tcache_size	(8*1024*1024)	/* 8 Meg max on RM7000 */
 
 #define ic_lsize	32		/* Fixed to 32 byte on RM7000  */
 #define dc_lsize	32		/* Fixed to 32 byte on RM7000  */
@@ -52,7 +54,8 @@
  * Not added to asm/r4kcache.h because it seems to be RM7000-specific.
  */
 #define Page_Invalidate_T 0x16
-
+#define Index_Store_Tag_S 0x0B
+#define Index_Store_Tag_T 0x0A
 static inline void invalidate_tcache_page(unsigned long addr)
 {
 	__asm__ __volatile__(
@@ -195,76 +198,139 @@
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 }
 
-/* Detect and size the caches. */
-static inline void probe_icache(unsigned long config)
-{
-	icache_size = 1 << (12 + ((config >> 9) & 7));
-
-	printk(KERN_INFO "Primary instruction cache %dKiB.\n", icache_size >> 10);
-}
-
-static inline void probe_dcache(unsigned long config)
-{
-	dcache_size = 1 << (12 + ((config >> 6) & 7));
-
-	printk(KERN_INFO "Primary data cache %dKiB.\n", dcache_size >> 10);
-}
-
-
 /* 
  * This function is executed in the uncached segment KSEG1.
  * It must not touch the stack, because the stack pointer still points
- * into KSEG0. 
+ * into KSEG0.
  *
- * Three options:
+ * Two options:
  *	- Write it in assembly and guarantee that we don't use the stack.
- *	- Disable caching for KSEG0 before calling it.
  *	- Pray that GCC doesn't randomly start using the stack.
  *
  * This being Linux, we obviously take the least sane of those options -
  * following DaveM's lead in r4xx0.c
  *
+ * Some MIPS proms actually do all of this work for us, so this is harmless
+ * but redundent. If Linux is booting from flash directly then this code
+ * is required. All cache initing must be done with the cache enabled or
+ * it doesn't work right.
+ *
  * It seems we get our kicks from relying on unguaranteed behaviour in GCC
+ *
  */
-static __init void setup_scache(void)
+#define CACHE_OP(op,size,lsize)                    \
+	for (i=0; i<size; i+=lsize) {              \
+		__asm__ __volatile__ (             \
+		      ".set noreorder\n\t"         \
+		      ".set mips3\n\t"             \
+		      "cache %1, (%0)\n\t"         \
+		      ".set mips0\n\t"             \
+		      ".set reorder"               \
+		      :                            \
+		      : "r" (KSEG0ADDR(i)),        \
+		        "i" (op));                 \
+	}
+
+static __init void clear_enable_caches(unsigned long config)
 {
-	int register i;
-	
-	set_cp0_config(1<<3 /* CONF_SE */);
+	register unsigned long i;
 
+	memset((void *)KSEG0,0,4096);
+	
+	/* Enable caching and turn off secondary/tertiary caches while
+	   we are working */
+	change_cp0_config(CONF_CM_CMASK |
+			  (1<<3) /* CONF_SE */ | 
+			  (1<<12) /* CONF_TE */,
+			  CONF_CM_CACHABLE_NONCOHERENT);
+	BARRIER;
+
+	/* RM7000 erratum #31. The icache is screwed at startup.
+	   This fix needs to be done while executing from uncached memory and 
+	   the addresses passed to the cache command need to be cacheable. It
+	   also needs to point to memory that has valid op codes (ie 0). */
 	set_taglo(0);
 	set_taghi(0);
-	
-	for (i=0; i<scache_size; i+=sc_lsize) {
+	for (i = KSEG0; i <= KSEG0 + 4096; i += ic_lsize) {
 		__asm__ __volatile__ (
-		      ".set noreorder\n\t"
-		      ".set mips3\n\t"
-		      "cache %1, (%0)\n\t"
-		      ".set mips0\n\t"
-		      ".set reorder"
-		      :
-		      : "r" (KSEG0ADDR(i)),
-		        "i" (Index_Store_Tag_SD));
+			".set noreorder\n\t"
+			".set mips3\n\t"
+			"cache\t%1, 0(%0)\n\t"
+			"cache\t%1, 0x1000(%0)\n\t"
+			"cache\t%1, 0x2000(%0)\n\t"
+			"cache\t%1, 0x3000(%0)\n\t"
+			"cache\t%2, 0(%0)\n\t"
+			"cache\t%2, 0x1000(%0)\n\t"
+			"cache\t%2, 0x2000(%0)\n\t"
+			"cache\t%2, 0x3000(%0)\n\t"
+			"cache\t%1, 0(%0)\n\t"
+			"cache\t%1, 0x1000(%0)\n\t"
+			"cache\t%1, 0x2000(%0)\n\t"
+			"cache\t%1, 0x3000(%0)\n\t"
+			".set\tmips0\n\t"
+			".set\treorder\n\t"
+			:
+			: "r" (i), "i" (Index_Store_Tag_I), "i" (Fill));
 	}
 
+	// Next up, primary data cache
+	CACHE_OP(Index_Store_Tag_D,dcache_size,dc_lsize);
+   
+	// Secondary cache disabled
+	if (((config >> 31) & 1) == 0)
+	{
+		// Enable and invalidate 
+		set_cp0_config(1<<3 /* CONF_SE */);
+		BARRIER;
+		CACHE_OP(Index_Store_Tag_S,scache_size,sc_lsize);
+	}
+	
+	/* Tertiary cache..
+	   If the board supports L3 cache then the prom should enable it
+	   but leave caching turned off. When we get here we detect it was
+	   turned on and then do the initialization. Speed isn't important
+	   so we don't worry about flash invalidate */
+	if (((config >> 17) & 1) == 0 &&
+	    ((config >> 12) & 1) != 0)
+	{
+		/* It doesn't actually matter how big the tcache actually is, 
+		 this code initializes the largest possible */
+		set_cp0_config(1<<12 /* CONF_TE*/);
+		BARRIER;
+		CACHE_OP(Page_Invalidate_T,tcache_size,tc_pagesize);
+	}
+	
+	BARRIER;
 }
 
-static inline void probe_scache(unsigned long config)
+
+/* Check the Caches are as we expect them to be. The RM7K has a fixed cache
+   size and we want the cache sizes to be constant for the above evil 
+   routine. These guys print some nice messages to make the user feel warm
+   and fuzzy */
+static inline void probe_icache(unsigned long config)
 {
-	void (*func)(void) = KSEG1ADDR(&setup_scache);
+	if (icache_size != 1 << (12 + ((config >> 9) & 7)))
+		panic("RM7000 ICache size mismatch!\n");
+
+	printk(KERN_INFO "Primary instruction cache %dKiB.\n", icache_size >> 10);
+}
 
+static inline void probe_dcache(unsigned long config)
+{
+	if (dcache_size != 1 << (12 + ((config >> 6) & 7)))
+		panic("RM7000 DCache size mismatch!\n");
+
+	printk(KERN_INFO "Primary data cache %dKiB.\n", dcache_size >> 10);
+}
+		 
+static inline void probe_scache(unsigned long config)
+{
 	if ((config >> 31) & 1)
 		return;
 
 	printk(KERN_INFO "Secondary cache %dKiB, linesize %d bytes.\n",
 	       (scache_size >> 10), sc_lsize);
-
-	if ((config >> 3) & 1)
-		return;
-
-	printk(KERN_INFO "Enabling secondary cache...");
-	func();
-	printk("Done\n");
 }
  
 static inline void probe_tcache(unsigned long config)
@@ -274,15 +340,15 @@
 
 	/* We can't enable the L3 cache yet. There may be board-specific
 	 * magic necessary to turn it on, and blindly asking the CPU to
-	 * start using it would may give cache errors.
+	 * start using it may give cache errors.
 	 *
 	 * Also, board-specific knowledge may allow us to use the 
 	 * CACHE Flash_Invalidate_T instruction if the tag RAM supports
 	 * it, and may specify the size of the L3 cache so we don't have
 	 * to probe it. 
 	 */
-	printk(KERN_INFO "Tertiary cache present, %s enabled\n",
-	       config&(1<<12) ? "already" : "not (yet)");
+	printk(KERN_INFO "Tertiary cache present %s\n",
+	       config&(1<<12) ? "- will be used." : " - might be enabled later..");
 
 	if ((config >> 12) & 1)
 		rm7k_tcache_enabled = 1;
@@ -291,45 +357,26 @@
 void __init ld_mmu_rm7k(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
-	unsigned long addr;
+	void (*func)(unsigned long config) = KSEG1ADDR(&clear_enable_caches);
 
 	printk("CPU revision is: %08x\n", read_32bit_cp0_register(CP0_PRID));
 
         change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
 
-	/* RM7000 erratum #31. The icache is screwed at startup. */
-	set_taglo(0);
-	set_taghi(0);
-	for (addr = KSEG0; addr <= KSEG0 + 4096; addr += ic_lsize) {
-		__asm__ __volatile__ (
-			".set noreorder\n\t"
-			".set mips3\n\t"
-			"cache\t%1, 0(%0)\n\t"
-			"cache\t%1, 0x1000(%0)\n\t"
-			"cache\t%1, 0x2000(%0)\n\t"
-			"cache\t%1, 0x3000(%0)\n\t"
-			"cache\t%2, 0(%0)\n\t"
-			"cache\t%2, 0x1000(%0)\n\t"
-			"cache\t%2, 0x2000(%0)\n\t"
-			"cache\t%2, 0x3000(%0)\n\t"
-			"cache\t%1, 0(%0)\n\t"
-			"cache\t%1, 0x1000(%0)\n\t"
-			"cache\t%1, 0x2000(%0)\n\t"
-			"cache\t%1, 0x3000(%0)\n\t"
-			".set\tmips0\n\t"
-			".set\treorder\n\t"
-			:
-			: "r" (addr), "i" (Index_Store_Tag_I), "i" (Fill));
-	}
-
-#ifndef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
-
+	// Print out all the status messages and do sanity checks
 	probe_icache(config);
 	probe_dcache(config);
 	probe_scache(config);
 	probe_tcache(config);
+
+	// Call clear_enable_caches in uncached memory
+	printk(KERN_INFO "Clearing and enabling all caches...");
+	func(config);
+	printk("Done\n");
+	
+#ifdef CONFIG_MIPS_UNCACHED
+        change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+#endif	
 
 	_clear_page = rm7k_clear_page;
 	_copy_page = rm7k_copy_page;
