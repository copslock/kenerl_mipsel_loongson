Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7A2PZRw029681
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 19:25:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7A2PZBd029680
	for linux-mips-outgoing; Fri, 9 Aug 2002 19:25:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7A2PNRw029671;
	Fri, 9 Aug 2002 19:25:23 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g7A2RUS28242;
	Fri, 9 Aug 2002 19:27:30 -0700
Date: Fri, 9 Aug 2002 19:27:30 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "linux-mips@oss.sgi.com"@ayrnetworks.com, ralf@oss.sgi.com
Subject: [PATCH] delay.h fix for HZ != 100 or 128
Message-ID: <20020809192730.H6317@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Spam-Status: No, hits=-4.5 required=5.0 tests=PLING,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The current include/asm-mips/delay.h uses fixed constants for either HZ
= 100 or 128, but won't work for other values, such as HZ = 1000 or
1024. This patch calculates that constant (still to infinite precision)
and does 64-bit arithmetic (not really, though - gcc does it with only
one additional 32-bit multiply) for HZ > 1000 so that udelay() will
still work for usec <= 1000 (mdelay(), etc).

Thanks,
Will

---
Index: include/asm-mips/delay.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/delay.h,v
retrieving revision 1.10.2.1
diff -u -r1.10.2.1 delay.h
--- include/asm-mips/delay.h	2002/08/09 22:17:48	1.10.2.1
+++ include/asm-mips/delay.h	2002/08/10 02:18:47
@@ -29,26 +29,35 @@
 /*
  * division by multiplication: you don't have to worry about
  * loss of precision.
- *
- * Use only for very small delays ( < 1 msec).  Should probably use a
+ *      
+ * Use only for very small delays ( <= 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
 extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)
-{
-	unsigned long lo;
-
-#if (HZ == 100)
-	usecs *= 0x00068db8;		/* 2**32 / (1000000 / HZ) */
-#elif (HZ == 128)
-	usecs *= 0x0008637b;		/* 2**32 / (1000000 / HZ) */
+{       
+        const unsigned long long mult_const =
+                (((unsigned long long)HZ << 32)/1000000);
+#if (HZ > 1000)                                                         
+        /* If HZ > 1000, udelay() did't work for usecs <= 1000.        
+         *
+         * GCC is smart enough to do this with just three
+         * 32-bit multiplies.
+         */     
+        unsigned long long xusecs;
+        xusecs = (unsigned long long)usecs * (unsigned long long)lpj *
+                mult_const;
+        __delay((unsigned long)(xusecs>>32));
+#else
+        unsigned long lo;
+        usecs *= (unsigned long long)mult_const;
+        __asm__("multu\t%2,%3"
+                :"=h" (usecs), "=l" (lo)
+                :"r" (usecs),"r" (lpj));
+        __delay(usecs);
 #endif
-	__asm__("multu\t%2,%3"
-		:"=h" (usecs), "=l" (lo)
-		:"r" (usecs),"r" (lpj));
-	__delay(usecs);
 }
 
 #ifdef CONFIG_SMP
