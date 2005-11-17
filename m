Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2005 22:56:04 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:44673 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8134172AbVKQWzn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2005 22:55:43 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Thu, 17 Nov 2005 14:57:54 -0800
  id 002B8A5B.437D0AF2.000047F4
Message-ID: <437D0AE2.9040706@jg555.com>
Date:	Thu, 17 Nov 2005 14:57:38 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	ralf@linux-mips.org, Peter Horton <pdh@colonel-panic.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com> <4371FB46.1000805@gentoo.org> <4372304A.9080608@jg555.com> <4379FBF4.1040505@jg555.com>
In-Reply-To: <4379FBF4.1040505@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Ok,
    Isolated the problem down to one file, will see if this patch will 
fix the issue with 2.6.14, the patch is the a diff of a file from 
2.6.13-rc2 and 2.6.13-rc3 which introduced the issue. Here is a link to 
the patch http://ftp.jg555.com/cobalt/culprit

Will test 2.6.14 with this patch a report back.

diff -Naur linux-mips-2.6.13-rc3/arch/mips/kernel/cpu-probe.c 
testbed/arch/mips/kernel/cpu-probe.c
--- linux-mips-2.6.13-rc3/arch/mips/kernel/cpu-probe.c    2005-07-27 
14:48:12.000000000 -0700
+++ testbed/arch/mips/kernel/cpu-probe.c    2005-11-17 
14:18:56.000000000 -0800
@@ -71,27 +71,11 @@
         : : "r" (au1k_wait));
 }
 
-static int __initdata nowait = 0;
-
-int __init wait_disable(char *s)
-{
-    nowait = 1;
-
-    return 1;
-}
-
-__setup("nowait", wait_disable);
-
 static inline void check_wait(void)
 {
     struct cpuinfo_mips *c = &current_cpu_data;
 
     printk("Checking for 'wait' instruction... ");
-    if (nowait) {
-        printk (" disabled.\n");
-        return;
-    }
-
     switch (c->cputype) {
     case CPU_R3081:
     case CPU_R3081E:
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
@@ -283,8 +318,7 @@
     case PRID_IMP_R4600:
         c->cputype = CPU_R4600;
         c->isa_level = MIPS_CPU_ISA_III;
-        c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-                 MIPS_CPU_LLSC;
+        c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
         c->tlbsize = 48;
         break;
     #if 0
@@ -364,7 +398,11 @@
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
@@ -509,12 +547,6 @@
         c->ases |= MIPS_ASE_SMARTMIPS;
     if (config3 & MIPS_CONF3_DSP)
         c->ases |= MIPS_ASE_DSP;
-    if (config3 & MIPS_CONF3_VINT)
-        c->ases |= MIPS_CPU_VINT;
-    if (config3 & MIPS_CONF3_VEIC)
-        c->ases |= MIPS_CPU_VEIC;
-    if (config3 & MIPS_CONF3_MT)
-                c->ases |= MIPS_CPU_MIPSMT;
 
     return config3 & MIPS_CONF_M;
 }
@@ -632,21 +664,6 @@
     }
 }
 
-static inline void cpu_probe_philips(struct cpuinfo_mips *c)
-{
-    decode_configs(c);
-    switch (c->processor_id & 0xff00) {
-    case PRID_IMP_PR4450:
-        c->cputype = CPU_PR4450;
-        c->isa_level = MIPS_CPU_ISA_M32;
-        break;
-    default:
-        panic("Unknown Philips Core!"); /* REVISIT: die? */
-        break;
-    }
-}
-
-
 __init void cpu_probe(void)
 {
     struct cpuinfo_mips *c = &current_cpu_data;
@@ -672,9 +689,6 @@
     case PRID_COMP_SANDCRAFT:
         cpu_probe_sandcraft(c);
         break;
-     case PRID_COMP_PHILIPS:
-        cpu_probe_philips(c);
-         break;
     default:
         c->cputype = CPU_UNKNOWN;
     }

-- 
----
Jim Gifford
maillist@jg555.com
