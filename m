Received:  by oss.sgi.com id <S554084AbRBYDDz>;
	Sat, 24 Feb 2001 19:03:55 -0800
Received: from snowman.foobazco.org ([198.144.194.230]:43440 "HELO
        mail.foobazco.org") by oss.sgi.com with SMTP id <S554081AbRBYDDb>;
	Sat, 24 Feb 2001 19:03:31 -0800
Received: from pimp.foobazco.org (pimp.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 1E5A7109CE; Sat, 24 Feb 2001 19:03:35 -0800 (PST)
Received: by pimp.foobazco.org (Postfix, from userid 1014)
	id B2A0910003; Sat, 24 Feb 2001 19:03:24 -0800 (PST)
Date:   Sat, 24 Feb 2001 19:03:24 -0800
From:   Keith M Wesolowski <wesolows@foobazco.org>
To:     Pete Popov <ppopov@mvista.com>
Cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: loops_per_sec
Message-ID: <20010224190323.A1373@foobazco.org>
References: <3A95C0E2.5173DEA6@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A95C0E2.5173DEA6@mvista.com>; from ppopov@mvista.com on Thu, Feb 22, 2001 at 05:46:10PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2001 at 05:46:10PM -0800, Pete Popov wrote:

> The variable loops_per_sec has become loops_per_jiffy around 2.4.1,
> breaking the mips delay functions.  I edited include/asm-mips/delay.h to
> rename the variable.  There's other places in mips64 where loops_per_sec
> is being used. Furthermore, since it's loops per "jiffy", the delay must
> be further increased by a factor of HZ.  

A partial fix appears to be in place for mips already.  This patch
should complete the picture.  I need people using mips and mips64 to
confirm that it works please; I can't test it right now.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jiffy.diff"

Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.53
diff -u -r1.53 setup.c
--- arch/mips/kernel/setup.c	2001/02/22 04:12:11	1.53
+++ arch/mips/kernel/setup.c	2001/02/25 02:34:49
@@ -62,8 +62,6 @@
  */
 char cyclecounter_available;
 
-unsigned long loops_per_sec;
-
 /*
  * There are several bus types available for MIPS machines.  "RISC PC"
  * type machines have ISA, EISA, VLB or PCI available, DECstations
Index: arch/mips64/kernel/proc.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/proc.c,v
retrieving revision 1.4
diff -u -r1.4 proc.c
--- arch/mips64/kernel/proc.c	2000/10/26 23:43:28	1.4
+++ arch/mips64/kernel/proc.c	2001/02/25 02:34:49
@@ -48,8 +48,8 @@
 		       mach_group_to_name[mips_machgroup][mips_machtype]);
 */
 		len += sprintf(buffer + len, "BogoMIPS\t\t: %lu.%02lu\n",
-		       (loops_per_sec + 2500) / 500000,
-	               ((loops_per_sec + 2500) / 5000) % 100);
+		       (loops_per_jiffy + 2500) / (500000/HZ),
+	               ((loops_per_jiffy + 2500) / (5000/HZ)) % 100);
 /*		len += sprintf(buffer + len, "Number of cpus\t\t: %d\n", smp_num_cpus);*/
 #if defined (__MIPSEB__)
 		len += sprintf(buffer + len, "byteorder\t\t: big endian\n");
Index: arch/mips64/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/setup.c,v
retrieving revision 1.17
diff -u -r1.17 setup.c
--- arch/mips64/kernel/setup.c	2001/01/10 17:17:56	1.17
+++ arch/mips64/kernel/setup.c	2001/02/25 02:34:50
@@ -56,8 +56,6 @@
  */
 char cyclecounter_available;
 
-unsigned long loops_per_sec;
-
 /*
  * Set if box has EISA slots.
  */
Index: include/asm-mips/delay.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/delay.h,v
retrieving revision 1.9
diff -u -r1.9 delay.h
--- include/asm-mips/delay.h	2001/01/10 17:18:04	1.9
+++ include/asm-mips/delay.h	2001/02/25 02:34:56
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 
-extern unsigned long loops_per_sec;
+extern unsigned long loops_per_jiffy;
 
 extern __inline__ void
 __delay(unsigned long loops)
@@ -35,21 +35,21 @@
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
-extern __inline__ void __udelay(unsigned long usecs, unsigned long lps)
+extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)
 {
 	unsigned long lo;
 
-	usecs *= 0x000010c6;		/* 2**32 / 1000000 */
+	usecs *= 0x00068db8;		/* 2**32 / (1000000 / HZ) */
 	__asm__("multu\t%2,%3"
 		:"=h" (usecs), "=l" (lo)
-		:"r" (usecs),"r" (lps));
+		:"r" (usecs),"r" (lpj));
 	__delay(usecs);
 }
 
 #ifdef CONFIG_SMP
 #define __udelay_val cpu_data[smp_processor_id()].udelay_val
 #else
-#define __udelay_val loops_per_sec
+#define __udelay_val loops_per_jiffy
 #endif
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
Index: include/asm-mips64/delay.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/delay.h,v
retrieving revision 1.7
diff -u -r1.7 delay.h
--- include/asm-mips64/delay.h	2001/01/10 17:18:04	1.7
+++ include/asm-mips64/delay.h	2001/02/25 02:34:56
@@ -12,7 +12,7 @@
 
 #include <linux/config.h>
 
-extern unsigned long loops_per_sec;
+extern unsigned long loops_per_jiffy;
 
 extern __inline__ void
 __delay(unsigned long loops)
@@ -36,21 +36,21 @@
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
-extern __inline__ void __udelay(unsigned long usecs, unsigned long lps)
+extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)
 {
 	unsigned long lo;
 
-	usecs *= 0x000010c6f7a0b5edUL;		/* 2**64 / 1000000 */
+	usecs *= 0x00068db8bac710cbUL;		/* 2**64 / (1000000 / HZ) */
 	__asm__("dmultu\t%2,%3"
 		:"=h" (usecs), "=l" (lo)
-		:"r" (usecs),"r" (lps));
+		:"r" (usecs),"r" (lpj));
 	__delay(usecs);
 }
 
 #ifdef CONFIG_SMP
 #define __udelay_val cpu_data[smp_processor_id()].udelay_val
 #else
-#define __udelay_val loops_per_sec
+#define __udelay_val loops_per_jiffy
 #endif
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
Index: include/asm-mips64/smp.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/smp.h,v
retrieving revision 1.3
diff -u -r1.3 smp.h
--- include/asm-mips64/smp.h	2000/08/08 18:54:51	1.3
+++ include/asm-mips64/smp.h	2001/02/25 02:34:56
@@ -10,7 +10,7 @@
 
 #if 0
 struct cpuinfo_mips {				/* XXX  */
-	unsigned long loops_per_sec;
+	unsigned long loops_per_jiffy;
 	unsigned long last_asn;
 	unsigned long *pgd_cache;
 	unsigned long *pte_cache;

--rwEMma7ioTxnRzrJ--
