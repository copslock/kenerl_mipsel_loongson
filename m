Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 15:41:14 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12021 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038668AbXBVPlJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2007 15:41:09 +0000
Received: from localhost (p8012-ipad02funabasi.chiba.ocn.ne.jp [61.214.26.12])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2B2A3A7A9; Fri, 23 Feb 2007 00:39:48 +0900 (JST)
Date:	Fri, 23 Feb 2007 00:39:48 +0900 (JST)
Message-Id: <20070223.003948.41198458.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Kill redundant EXTRA_AFLAGS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Many Makefiles in arch/mips have EXTRA_AFLAGS := $(CFLAGS) line.  This
is redundant while AFLAGS contains $(cflags-y) and any options only
listed in CFLAGS (not in cflags-y) should be unnecessary for asm
sources.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 cobalt/Makefile                  |    2 --
 ddb5xxx/ddb5477/Makefile         |    2 --
 dec/Makefile                     |    2 --
 dec/prom/Makefile                |    2 --
 gt64120/ev64120/Makefile         |    2 --
 gt64120/momenco_ocelot/Makefile  |    2 --
 gt64120/wrppmc/Makefile          |    2 --
 jazz/Makefile                    |    2 --
 jmr3927/rbhma3100/Makefile       |    2 --
 kernel/Makefile                  |    2 --
 lib-32/Makefile                  |    2 --
 lib-64/Makefile                  |    2 --
 lib/Makefile                     |    2 --
 mips-boards/generic/Makefile     |    2 --
 mm/Makefile                      |    2 --
 momentum/ocelot_g/Makefile       |    2 --
 sgi-ip22/Makefile                |    2 --
 sgi-ip27/Makefile                |    2 --
 sgi-ip32/Makefile                |    2 --
 sibyte/bcm1480/Makefile          |    2 --
 sibyte/sb1250/Makefile           |    2 --
 sni/Makefile                     |    2 --
 tx4927/toshiba_rbtx4927/Makefile |    2 --
 vr41xx/common/Makefile           |    2 --
 24 files changed, 48 deletions(-)

diff --git a/arch/mips/cobalt/Makefile b/arch/mips/cobalt/Makefile
index 12589a1..b36dd8f 100644
--- a/arch/mips/cobalt/Makefile
+++ b/arch/mips/cobalt/Makefile
@@ -6,5 +6,3 @@ obj-y	 := irq.o reset.o setup.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= mtd.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/ddb5xxx/ddb5477/Makefile b/arch/mips/ddb5xxx/ddb5477/Makefile
index ea68815..23fd3b8 100644
--- a/arch/mips/ddb5xxx/ddb5477/Makefile
+++ b/arch/mips/ddb5xxx/ddb5477/Makefile
@@ -6,5 +6,3 @@ obj-y	 		+= irq.o irq_5477.o setup.o lcd
 
 obj-$(CONFIG_RUNTIME_DEBUG) 	+= debug.o
 obj-$(CONFIG_KGDB)		+= kgdb_io.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/dec/Makefile b/arch/mips/dec/Makefile
index 8b790c2..9eb2f9c 100644
--- a/arch/mips/dec/Makefile
+++ b/arch/mips/dec/Makefile
@@ -8,5 +8,3 @@ obj-y		:= ecc-berr.o int-handler.o ioasi
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
 obj-$(CONFIG_TC)		+= tc.o
 obj-$(CONFIG_CPU_HAS_WB)	+= wbflush.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/dec/prom/Makefile b/arch/mips/dec/prom/Makefile
index bcd0247..064ae7a 100644
--- a/arch/mips/dec/prom/Makefile
+++ b/arch/mips/dec/prom/Makefile
@@ -7,5 +7,3 @@ lib-y			+= init.o memory.o cmdline.o ide
 
 lib-$(CONFIG_32BIT)	+= locore.o
 lib-$(CONFIG_64BIT)	+= call_o32.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/gt64120/ev64120/Makefile b/arch/mips/gt64120/ev64120/Makefile
index b2c53a8..323b2ce 100644
--- a/arch/mips/gt64120/ev64120/Makefile
+++ b/arch/mips/gt64120/ev64120/Makefile
@@ -7,5 +7,3 @@
 #
 
 obj-y	+= irq.o promcon.o reset.o serialGT.o setup.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/gt64120/momenco_ocelot/Makefile b/arch/mips/gt64120/momenco_ocelot/Makefile
index 6f708df..9f9a33f 100644
--- a/arch/mips/gt64120/momenco_ocelot/Makefile
+++ b/arch/mips/gt64120/momenco_ocelot/Makefile
@@ -5,5 +5,3 @@
 obj-y	 		+= irq.o prom.o reset.o setup.o
 
 obj-$(CONFIG_KGDB)	+= dbg_io.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/gt64120/wrppmc/Makefile b/arch/mips/gt64120/wrppmc/Makefile
index 7cf5220..e425043 100644
--- a/arch/mips/gt64120/wrppmc/Makefile
+++ b/arch/mips/gt64120/wrppmc/Makefile
@@ -10,5 +10,3 @@
 #
 
 obj-y += irq.o reset.o setup.o time.o pci.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/jazz/Makefile b/arch/mips/jazz/Makefile
index 02bd39a..dd9d99b 100644
--- a/arch/mips/jazz/Makefile
+++ b/arch/mips/jazz/Makefile
@@ -3,5 +3,3 @@
 #
 
 obj-y	 	:= irq.o jazzdma.o reset.o setup.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/jmr3927/rbhma3100/Makefile b/arch/mips/jmr3927/rbhma3100/Makefile
index baf5077..18fe9a8 100644
--- a/arch/mips/jmr3927/rbhma3100/Makefile
+++ b/arch/mips/jmr3927/rbhma3100/Makefile
@@ -5,5 +5,3 @@
 obj-y	 			+= init.o irq.o setup.o
 obj-$(CONFIG_RUNTIME_DEBUG) 	+= debug.o
 obj-$(CONFIG_KGDB)		+= kgdb_io.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8faf1b4..a3dad39 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -67,5 +67,3 @@ obj-$(CONFIG_I8253)		+= i8253.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
index 2036cf5..8b94d4c 100644
--- a/arch/mips/lib-32/Makefile
+++ b/arch/mips/lib-32/Makefile
@@ -21,5 +21,3 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
index 2036cf5..8b94d4c 100644
--- a/arch/mips/lib-64/Makefile
+++ b/arch/mips/lib-64/Makefile
@@ -21,5 +21,3 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 2453ea2..52e0ec8 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -10,5 +10,3 @@ obj-$(CONFIG_PCI)	+= iomap-pci.o
 
 # libgcc-style stuff needed in the kernel
 lib-y += ashldi3.o ashrdi3.o lshrdi3.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/mips-boards/generic/Makefile b/arch/mips/mips-boards/generic/Makefile
index be47c1c..0a30f5d 100644
--- a/arch/mips/mips-boards/generic/Makefile
+++ b/arch/mips/mips-boards/generic/Makefile
@@ -22,5 +22,3 @@ obj-y				:= reset.o display.o init.o mem
 				   cmdline.o time.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_KGDB)		+= gdb_hook.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index de57273..293697b 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -31,5 +31,3 @@ obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/momentum/ocelot_g/Makefile b/arch/mips/momentum/ocelot_g/Makefile
index adb5665..c0a0030 100644
--- a/arch/mips/momentum/ocelot_g/Makefile
+++ b/arch/mips/momentum/ocelot_g/Makefile
@@ -4,5 +4,3 @@
 
 obj-y	 		+= irq.o gt-irq.o prom.o reset.o setup.o
 obj-$(CONFIG_KGDB)	+= dbg_io.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sgi-ip22/Makefile b/arch/mips/sgi-ip22/Makefile
index 6aa4c0c..b6d6492 100644
--- a/arch/mips/sgi-ip22/Makefile
+++ b/arch/mips/sgi-ip22/Makefile
@@ -7,5 +7,3 @@ obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o
 	   ip22-time.o ip22-nvram.o ip22-reset.o ip22-setup.o
 
 obj-$(CONFIG_EISA)	+= ip22-eisa.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sgi-ip27/Makefile b/arch/mips/sgi-ip27/Makefile
index a457263..7ce76e2 100644
--- a/arch/mips/sgi-ip27/Makefile
+++ b/arch/mips/sgi-ip27/Makefile
@@ -9,5 +9,3 @@ obj-y	:= ip27-berr.o ip27-irq.o ip27-ini
 obj-$(CONFIG_EARLY_PRINTK)	+= ip27-console.o
 obj-$(CONFIG_KGDB)		+= ip27-dbgio.o
 obj-$(CONFIG_SMP)		+= ip27-smp.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sgi-ip32/Makefile b/arch/mips/sgi-ip32/Makefile
index 530bf84..7e14167 100644
--- a/arch/mips/sgi-ip32/Makefile
+++ b/arch/mips/sgi-ip32/Makefile
@@ -5,5 +5,3 @@
 
 obj-y	+= ip32-berr.o ip32-irq.o ip32-setup.o ip32-reset.o \
 	   crime.o ip32-memory.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sibyte/bcm1480/Makefile b/arch/mips/sibyte/bcm1480/Makefile
index 7b36ff3..cdc4c56 100644
--- a/arch/mips/sibyte/bcm1480/Makefile
+++ b/arch/mips/sibyte/bcm1480/Makefile
@@ -1,5 +1,3 @@
 obj-y := setup.o irq.o time.o
 
 obj-$(CONFIG_SMP)			+= smp.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sibyte/sb1250/Makefile b/arch/mips/sibyte/sb1250/Makefile
index a2fdbd6..04c0f1a 100644
--- a/arch/mips/sibyte/sb1250/Makefile
+++ b/arch/mips/sibyte/sb1250/Makefile
@@ -4,5 +4,3 @@ obj-$(CONFIG_SMP)			+= smp.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= bcm1250_tbprof.o
 obj-$(CONFIG_SIBYTE_STANDALONE)		+= prom.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/sni/Makefile b/arch/mips/sni/Makefile
index e30809a..e5777b7 100644
--- a/arch/mips/sni/Makefile
+++ b/arch/mips/sni/Makefile
@@ -4,5 +4,3 @@
 
 obj-y += irq.o reset.o setup.o ds1216.o a20r.o rm200.o pcimt.o pcit.o time.o
 obj-$(CONFIG_CPU_BIG_ENDIAN) += sniprom.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/Makefile b/arch/mips/tx4927/toshiba_rbtx4927/Makefile
index c1a377a..8a991f3 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/Makefile
+++ b/arch/mips/tx4927/toshiba_rbtx4927/Makefile
@@ -1,5 +1,3 @@
 obj-y	+= toshiba_rbtx4927_prom.o
 obj-y	+= toshiba_rbtx4927_setup.o
 obj-y	+= toshiba_rbtx4927_irq.o
-
-EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/vr41xx/common/Makefile b/arch/mips/vr41xx/common/Makefile
index 975d5ca..f842783 100644
--- a/arch/mips/vr41xx/common/Makefile
+++ b/arch/mips/vr41xx/common/Makefile
@@ -3,5 +3,3 @@
 #
 
 obj-y	+= bcu.o cmu.o icu.o init.o irq.o pmu.o type.o
-
-EXTRA_AFLAGS := $(CFLAGS)
