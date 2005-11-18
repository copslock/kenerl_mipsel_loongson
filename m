Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2005 01:19:50 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:1159 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8134181AbVKRBTc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2005 01:19:32 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Thu, 17 Nov 2005 17:21:44 -0800
  id 002B8E03.437D2CA8.000036F7
Message-ID: <437D2C97.8070804@jg555.com>
Date:	Thu, 17 Nov 2005 17:21:27 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	ralf@linux-mips.org, Peter Horton <pdh@colonel-panic.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com> <4379FBF4.1040505@jg555.com> <437D0AE2.9040706@jg555.com>
In-Reply-To: <437D0AE2.9040706@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Got a fix for 2.6.14, http://ftp.jg555.com/cobalt/fix-2.6.14.

Ralf, I know this is probably not the fix you would like to see, any 
suggestions.

diff -Naur linux-mips-2.6.14.orig/arch/mips/kernel/cpu-probe.c 
linux-mips-2.6.14/arch/mips/kernel/cpu-probe.c
--- linux-mips-2.6.14.orig/arch/mips/kernel/cpu-probe.c    2005-11-17 
11:42:19.000000000 -0800
+++ linux-mips-2.6.14/arch/mips/kernel/cpu-probe.c    2005-11-17 
15:00:11.000000000 -0800
@@ -121,7 +105,6 @@
     case CPU_24K:
     case CPU_25KF:
     case CPU_34K:
-     case CPU_PR4450:
         cpu_wait = r4k_wait;
         printk(" available.\n");
         break;
@@ -147,6 +130,58 @@
     check_wait();
 }
 
+#ifdef CONFIG_64BIT
+
+/*
+ * On RM5230/5231 all accesses to XKPHYS by LL(D) are forced
+ * to be uncached, bits 61-59 of the address are ignored.
+ *
+ * Apparently fixed on RM5230A/5231A.
+ */
+static inline int check_lld(void)
+{
+    unsigned long flags, value, match, phys, *addr;
+
+    printk("Checking for lld bug... ");
+
+    /* hope the stack is in the low 512MB */
+    phys = CPHYSADDR((unsigned long) &value);
+
+    /* write value to memory */
+    value = 0xfedcba9876543210;
+    addr = (unsigned long *) PHYS_TO_XKPHYS(K_CALG_UNCACHED, phys);
+    *addr = value;
+
+    /* stop spurious flushes */
+    local_irq_save(flags);
+
+    /* flip cached value */
+    value = ~value;
+
+    /* read value, supposedly from cache */
+    addr = (unsigned long *) PHYS_TO_XKPHYS(K_CALG_NONCOHERENT, phys);
+    asm volatile("lld %0, %1" : "=r" (match) : "m" (*addr));
+
+    local_irq_restore(flags);
+
+    match ^= value;
+
+    switch ((long) match) {
+    case 0:
+        printk("no.\n");
+        break;
+    case -1:
+        printk("yes.\n");
+        break;
+    default:
+        printk("yikes yes! (%lx/%lx@%p)\nPlease report to 
<linux-mips@linux-mips.org>.", value, match, &value);
+    }
+
+    return !match;
+}
+
+#endif
+
 /*
  * Probe whether cpu has config register by trying to play with
  * alternate cache bit and see whether it matters.
@@ -285,8 +320,7 @@
     case PRID_IMP_R4600:
         c->cputype = CPU_R4600;
         c->isa_level = MIPS_CPU_ISA_III;
-        c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-                 MIPS_CPU_LLSC;
+        c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
         c->tlbsize = 48;
         break;
     #if 0
@@ -366,7 +400,11 @@
         c->cputype = CPU_NEVADA;
         c->isa_level = MIPS_CPU_ISA_IV;
         c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-                     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
+                     MIPS_CPU_DIVEC;
+#ifdef CONFIG_64BIT
+        if (check_lld())
+#endif
+            c->options |= MIPS_CPU_LLSC;
         c->tlbsize = 48;
         break;
     case PRID_IMP_R6000:

-- 



-- 
----
Jim Gifford
maillist@jg555.com
