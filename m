Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B9kDRw023086
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 02:46:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B9kDgG023085
	for linux-mips-outgoing; Thu, 11 Jul 2002 02:46:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B9jpRw023075;
	Thu, 11 Jul 2002 02:45:52 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6B9ptE06829;
	Thu, 11 Jul 2002 10:51:55 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6B9ohR25066;
	Thu, 11 Jul 2002 10:50:43 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BF3.003669E3 ; Thu, 11 Jul 2002 10:54:20 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com, carstenl@mips.com
Message-ID: <80256BF3.00366849.00@notesmta.eur.3com.com>
Date: Thu, 11 Jul 2002 10:49:55 +0100
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



>This sound more like a hardware bug to me.
>What CPU are you running on ?
>
>/Carsten

The CPU is a Broadcom BCM6352 which contains a 225Mhz Mips32 core with cache as
follows:
     16Kb Instruction cache, linesize 16 bytes (2 ways)
     4Kb Data cache, linesize 16 byes (2 ways)
I don't know the exact variant of the core but the chip has only been recently
released. I will try asking my Broadcom contacts to see if they can shed any
further light on this.

>Ralf Baechle wrote:
>>
>> While that could be done it's not a good idea; running code in KSEG1 is
>> very slow.
>>
>
>Unfortunately, it's required by manuals for some processors. As I know,
>IDT HW manuals clearly state cache flush routines must operate from
>uncached code and must access uncached data only. Examples are R30x1 CPU
>series.
>
>Regards,
>Gleb.

I'm fairly sure i've seen comments that say that cache manipulation code should
be run uncached. My current thought is that it is probably safe to manipulate
the d-cache with cached code, but I-cache manipulation which could invalidate
the cacheline containing the currently executing code really should be run
uncached. I think the CPU probably then skips instructions until it gets to the
next cacheline, what effect this has depends on how the instructions are aligned
relative to the cacheline. Given how hit-and-miss this is I am suspicous that
this problem could simply be lurking undiscovered.

The patch below makes the I-Cache routines run via kseg1, it is a bit ugly but
seems to work. I have not measured the performance impact of this patch.

diff -Nruw --exclude=CVS include/asm-mips-old/mips32_cache.h
include/asm-mips/mips32_cache.h
--- include/asm-mips-old/mips32_cache.h  Wed Apr 10 22:53:12 2002
+++ include/asm-mips/mips32_cache.h      Thu Jul 11 10:25:06 2002
@@ -219,37 +219,24 @@
     }
 }

+/* Call I-cache manipulation routines via uncached kseg1 */
+extern void mips32_blast_icache(void);
+extern void mips32_blast_icache_page(unsigned long page);
+extern void mips32_blast_icache_page_indexed(unsigned long page);
+
 static inline void blast_icache(void)
 {
-    unsigned long start = KSEG0;
-    unsigned long end = (start + icache_size);
-
-    while(start < end) {
-         cache_unroll(start,Index_Invalidate_I);
-         start += ic_lsize;
-    }
+    ((void (*)(void))KSEG1ADDR((unsigned long)mips32_blast_icache))();
 }

 static inline void blast_icache_page(unsigned long page)
 {
-    unsigned long start = page;
-    unsigned long end = (start + PAGE_SIZE);
-
-    while(start < end) {
-         cache_unroll(start,Hit_Invalidate_I);
-         start += ic_lsize;
-    }
+    ((void (*)(unsigned long))KSEG1ADDR((unsigned
long)mips32_blast_icache_page))(page);
 }

 static inline void blast_icache_page_indexed(unsigned long page)
 {
-    unsigned long start = page;
-    unsigned long end = (start + PAGE_SIZE);
-
-    while(start < end) {
-         cache_unroll(start,Index_Invalidate_I);
-         start += ic_lsize;
-    }
+    ((void (*)(unsigned long))KSEG1ADDR((unsigned
long)mips32_blast_icache_page_indexed))(page);
 }

 static inline void blast_scache(void)
diff -Nurw arch/mips/mm-old/c-mips32.c arch/mips/mm/c-mips32.c
--- arch/mips/mm-old/c-mips32.c    Thu May 23 15:19:36 2002
+++ arch/mips/mm/c-mips32.c   Thu Jul 11 10:21:02 2002
@@ -708,3 +708,36 @@

     __flush_cache_all();
 }
+
+void mips32_blast_icache(void)
+{
+    unsigned long start = KSEG0;
+    unsigned long end = (start + icache_size);
+
+    while(start < end) {
+         cache_unroll(start,Index_Invalidate_I);
+         start += ic_lsize;
+    }
+}
+
+void mips32_blast_icache_page(unsigned long page)
+{
+    unsigned long start = page;
+    unsigned long end = (start + PAGE_SIZE);
+
+    while(start < end) {
+         cache_unroll(start,Hit_Invalidate_I);
+         start += ic_lsize;
+    }
+}
+
+void mips32_blast_icache_page_indexed(unsigned long page)
+{
+    unsigned long start = page;
+    unsigned long end = (start + PAGE_SIZE);
+
+    while(start < end) {
+         cache_unroll(start,Index_Invalidate_I);
+         start += ic_lsize;
+    }
+}

     Jon Burgess
