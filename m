Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GJaqA21465
	for linux-mips-outgoing; Mon, 16 Jul 2001 12:36:52 -0700
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GJamV21461
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 12:36:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA21713;
	Mon, 16 Jul 2001 21:28:39 +0200 (MET DST)
Date: Mon, 16 Jul 2001 21:28:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] 2.4.5: R3k cache line sizing + minor bits
Message-ID: <Pine.GSO.3.96.1010716204626.12988G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 The following patch implements real cache line sizing for R3k processors
instead of the current hardcoded single word (4 bytes).  Having a true
cache line size available will enable the possibility to tune cache
flushing functions making them perform better if the line size is bigger
than a word. 

 The patch includes minor corrections as well (sorry -- splitting them up
would be difficult due to overlapping areas).  They should be mostly
obvious.  One that probably needs a comment is the change to the low bound
of the cache size check.  It's now 128 words, as the IDT sw development
manual states in the portability section that the minimal size of the
cache for their chips is 512 bytes each (two extraneous executions of the
loops shouldn't hurt here anyway, even if we never meet such a CPU). 

 I've successfully tested the patch on my hardware, but since DECstation
5000/240 features single-word-wide cache lines, it doesn't really bring
anything new to my system apart from being more correct. ;-)  I'd be
pleased to hear from people having a different cache layout.

 Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-cacheline-6
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/mm/r2300.c linux-mips-2.4.5-20010704/arch/mips/mm/r2300.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/mm/r2300.c	Thu Jun 28 04:27:03 2001
+++ linux-mips-2.4.5-20010704/arch/mips/mm/r2300.c	Sun Jul 15 23:24:16 2001
@@ -33,7 +33,7 @@
 /* For R3000 cores with R4000 style caches */
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
 static unsigned long icache_lsize, dcache_lsize;	/* Size in bytes */
-static unsigned long scache_size = 0;
+static unsigned long scache_size;
 
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>
@@ -134,31 +134,64 @@ unsigned long __init r3k_cache_size(unsi
 	dummy = *p;
 	status = read_32bit_cp0_register(CP0_STATUS);
 
-	if (dummy != 0xa5a55a5a || (status & (1<<19))) {
+	if (dummy != 0xa5a55a5a || (status & ST0_CM)) {
 		size = 0;
 	} else {
-		for (size = 512; size <= 0x40000; size <<= 1)
+		for (size = 128; size <= 0x40000; size <<= 1)
 			*(p + size) = 0;
 		*p = -1;
-		for (size = 512; 
+		for (size = 128; 
 		     (size <= 0x40000) && (*(p + size) == 0); 
 		     size <<= 1)
 			;
 		if (size > 0x40000)
 			size = 0;
 	}
+
 	write_32bit_cp0_register(CP0_STATUS, flags);
 
 	return size * sizeof(*p);
 }
 
+unsigned long __init r3k_cache_lsize(unsigned long ca_flags)
+{
+	unsigned long flags, status, lsize, i, j;
+	volatile unsigned long *p;
+
+	p = (volatile unsigned long *) KSEG0;
+
+	flags = read_32bit_cp0_register(CP0_STATUS);
+
+	/* isolate cache space */
+	write_32bit_cp0_register(CP0_STATUS, (ca_flags|flags)&~ST0_IEC);
+
+	for (i = 0; i < 128; i++)
+		*(p + i) = 0;
+	*(volatile unsigned char *)p = 0;
+	for (lsize = 1; lsize < 128; lsize <<= 1) {
+		*(p + lsize);
+		status = read_32bit_cp0_register(CP0_STATUS);
+		if (!(status & ST0_CM))
+			break;
+	}
+	for (i = 0; i < 128; i += lsize)
+		*(volatile unsigned char *)(p + i) = 0;
+
+	write_32bit_cp0_register(CP0_STATUS, flags);
+
+	return lsize * sizeof(*p);
+}
+
 static void __init r3k_probe_cache(void)
 {
 	dcache_size = r3k_cache_size(ST0_ISC);
-	dcache_lsize = 4;
+	if (dcache_size)
+		dcache_lsize = r3k_cache_lsize(ST0_ISC);
+	
 
 	icache_size = r3k_cache_size(ST0_ISC|ST0_SWC);
-	icache_lsize = 4;
+	if (icache_size)
+		icache_lsize = r3k_cache_lsize(ST0_ISC|ST0_SWC);
 }
 
 static void r3k_flush_icache_range(unsigned long start, unsigned long end)
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-mips/mipsregs.h linux-mips-2.4.5-20010704/include/asm-mips/mipsregs.h
--- linux-mips-2.4.5-20010704.macro/include/asm-mips/mipsregs.h	Thu Jul  5 01:19:13 2001
+++ linux-mips-2.4.5-20010704/include/asm-mips/mipsregs.h	Sun Jul 15 21:45:28 2001
@@ -331,6 +331,7 @@ __BUILD_SET_CP0(config,CP0_CONFIG)
 /* bits 6 & 7 are reserved on R[23]000 */
 #define ST0_ISC			0x00010000
 #define ST0_SWC			0x00020000
+#define ST0_CM			0x00080000
 
 /*
  * Bits specific to the R4640/R4650
