Received:  by oss.sgi.com id <S42275AbQG2Cqj>;
	Fri, 28 Jul 2000 19:46:39 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39759 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42267AbQG2CqV>; Fri, 28 Jul 2000 19:46:21 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA04939
	for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 19:52:10 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA47245 for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 19:45:47 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA23370
	for <linux@engr.sgi.com>;
	Fri, 28 Jul 2000 19:44:10 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA01641
	for <linux@engr.sgi.com>; Fri, 28 Jul 2000 19:44:09 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id TAA17349;
	Fri, 28 Jul 2000 19:43:34 -0700
Message-ID: <398244D5.F86DE02C@mvista.com>
Date:   Fri, 28 Jul 2000 19:43:33 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
CC:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Turning off cache ...
References: <3980D95A.5949E980@mvista.com> <20000728030836.A1906@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------07B833AB41C1174A1529D62C"
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------07B833AB41C1174A1529D62C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> 
> On Thu, Jul 27, 2000 at 05:52:42PM -0700, Jun Sun wrote:
> 
> > Is there is easy way to turn off caching entirely?  I understand I need
> > to set k0 bits in config register.  What about those C bits in TLB
> > entries?  My CPU only has primary cache.
> 
> The C bits are per page, the k0 bits are for KSEG0.  If you want to
> turn of caching, then you need to:
> 
>   - change the k0 bits to uncached on startup, then flush the caches or a
>     writeback might corrupt your data.
>   - change the caching mode of the usermode pages by modifying the
>     definitions for PAGE_NONE etc. in pgtable.h.
>   - comment out the cache Create_Dirty_Exclusive instructions in r4xx0.c,
>     using them on uncached pages would corrupt data.
> 
> Which will make the kernel crawl awfully ...
> 
>   Ralf

I have successfully turned of cache.  And of course my cache code is not
the source for the problem :-) - which means I need to probe further.
:-(

For those who are interested, here is the patch that gives how I did
it.  Specifically, ld_mmu_r4k() has a line of code to turn on cache,
which needs to be commented out.  I explicitly turned off cache in
ld_mmu_r4k(), right after a flush_all_cache() call, instead of at the
beginnig of kernel_entry.

Jun
--------------07B833AB41C1174A1529D62C
Content-Type: text/plain; charset=us-ascii;
 name="linux-mips-v2.4.0-test2-r4k-cache-off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-mips-v2.4.0-test2-r4k-cache-off.patch"

--- include/asm/pgtable.h.orig	Fri Jul 28 15:22:09 2000
+++ include/asm/pgtable.h	Fri Jul 28 15:22:54 2000
@@ -132,7 +132,7 @@
 #define _CACHE_CACHABLE_NO_WA       (0<<9)  /* R4600 only              */
 #define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
 #define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
+#define _CACHE_CACHABLE_NONCOHERENT (2<<9)  /* R4[0246]00              */
 #define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00 only           */
 #define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00 only           */
 #define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00 only           */
--- arch/mips/mm/r4xx0.c.cache-off	Fri Jul 28 14:49:23 2000
+++ arch/mips/mm/r4xx0.c	Fri Jul 28 19:38:17 2000
@@ -105,7 +105,7 @@
 		:"=r" (page)
 		:"0" (page),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D)
+		 "i" (Hit_Writeback_Inv_D)
 		:"$1","memory");
 }
 
@@ -134,7 +134,7 @@
 		:"=r" (page)
 		:"0" (page),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D)
+		 "i" (Hit_Writeback_Inv_D)
 		:"$1","memory");
 }
 
@@ -143,8 +143,8 @@
  * This flavour of r4k_clear_page is for the R4600 V1.x.  Cite from the
  * IDT R4600 V1.7 errata:
  *
- *  18. The CACHE instructions Hit_Writeback_Invalidate_D, Hit_Writeback_D,
- *      Hit_Invalidate_D and Create_Dirty_Excl_D should only be
+ *  18. The CACHE instructions Hit_Writeback_Inv_D, Hit_Writeback_D,
+ *      Hit_Invalidate_D and Hit_Writeback_Inv_D should only be
  *      executed if there is no other dcache activity. If the dcache is
  *      accessed for another instruction immeidately preceding when these
  *      cache instructions are executing, it is possible that the dcache 
@@ -157,14 +157,14 @@
  *                              nop
  *                              nop
  *                              nop
- *                              cache       Hit_Writeback_Invalidate_D
+ *                              cache       Hit_Writeback_Inv_D
  *
  *      This is allowed:        lw
  *                              nop
  *                              nop
  *                              nop
  *                              nop
- *                              cache       Hit_Writeback_Invalidate_D
+ *                              cache       Hit_Writeback_Inv_D
  */
 static void r4k_clear_page_r4600_v1(void * page)
 {
@@ -198,7 +198,7 @@
 		:"=r" (page)
 		:"0" (page),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D)
+		 "i" (Hit_Writeback_Inv_D)
 		:"$1","memory");
 }
 
@@ -234,7 +234,7 @@
 		:"=r" (page)
 		:"0" (page),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D)
+		 "i" (Hit_Writeback_Inv_D)
 		:"$1","memory");
 	restore_flags(flags);
 }
@@ -434,7 +434,7 @@
 		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D));
+		 "i" (Hit_Writeback_Inv_D));
 }
 
 static void r4k_copy_page_d32(void * to, void * from)
@@ -491,7 +491,7 @@
 		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D));
+		 "i" (Hit_Writeback_Inv_D));
 }
 
 /*
@@ -559,7 +559,7 @@
 		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D));
+		 "i" (Hit_Writeback_Inv_D));
 }
 
 static void r4k_copy_page_r4600_v2(void * to, void * from)
@@ -626,7 +626,7 @@
 		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from),
 		 "I" (PAGE_SIZE),
-		 "i" (Create_Dirty_Excl_D));
+		 "i" (Hit_Writeback_Inv_D));
 	restore_flags(flags);
 }
 
@@ -2783,7 +2783,9 @@
 
 	printk("CPU revision is: %08x\n", read_32bit_cp0_register(CP0_PRID));
 
+	/* [jsun]
 	set_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
+	*/
 
 	probe_icache(config);
 	probe_dcache(config);
@@ -2803,6 +2805,7 @@
 	}
 
 	flush_cache_all();
+	set_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
 	write_32bit_cp0_register(CP0_WIRED, 0);
 
 	/*

--------------07B833AB41C1174A1529D62C--
