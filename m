Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 15:59:31 +0100 (BST)
Received: from p508B5469.dip.t-dialin.net ([IPv6:::ffff:80.139.84.105]:35756
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225302AbTDPO7X>; Wed, 16 Apr 2003 15:59:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3GExJK17650;
	Wed, 16 Apr 2003 16:59:19 +0200
Date: Wed, 16 Apr 2003 16:59:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: MIPS32 cache functions now using c-r4k?
Message-ID: <20030416165919.A15111@linux-mips.org>
References: <3E9D0C34.38FE2749@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9D0C34.38FE2749@ekner.info>; from hartvig@ekner.info on Wed, Apr 16, 2003 at 09:54:28AM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 09:54:28AM +0200, Hartvig Ekner wrote:

> It seems much of the r4k cache code assumes the presence of SD - which
> breaks on all MIPS32 CPU's?

Nothing a soldering iron and some patience couldn't fix ;)

Try below patch,

  Ralf

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.43
diff -u -r1.3.2.43 c-r4k.c
--- arch/mips/mm/c-r4k.c	16 Apr 2003 12:41:18 -0000	1.3.2.43
+++ arch/mips/mm/c-r4k.c	16 Apr 2003 14:56:03 -0000
@@ -34,6 +34,8 @@
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>
 
+extern void r4k_clear_page32_d16(void * page);
+extern void r4k_clear_page32_d32(void * page);
 extern void r4k_clear_page_d16(void * page);
 extern void r4k_clear_page_d32(void * page);
 extern void r4k_clear_page_r4600_v1(void * page);
@@ -877,7 +879,10 @@
 
 	switch (current_cpu_data.dcache.linesz) {
 	case 16:
-		_clear_page = r4k_clear_page_d16;
+		if (cpu_has_64bits)
+			_clear_page = r4k_clear_page_d16;
+		else
+			_clear_page = r4k_clear_page32_d16;
 		_copy_page = r4k_copy_page_d16;
 
 		break;
@@ -890,7 +895,10 @@
 			_clear_page = r4k_clear_page_r4600_v2;
 			_copy_page = r4k_copy_page_r4600_v2;
 		} else {
-			_clear_page = r4k_clear_page_d32;
+			if (cpu_has_64bits)
+				_clear_page = r4k_clear_page_d32;
+			else
+				_clear_page = r4k_clear_page32_d32;
 			_copy_page = r4k_copy_page_d32;
 		}
 		break;
Index: arch/mips/mm/pg-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/pg-r4k.S,v
retrieving revision 1.2.2.3
diff -u -r1.2.2.3 pg-r4k.S
--- arch/mips/mm/pg-r4k.S	5 Aug 2002 23:53:35 -0000	1.2.2.3
+++ arch/mips/mm/pg-r4k.S	16 Apr 2003 14:56:07 -0000
@@ -39,6 +39,39 @@
  *   versions of R4000 and R4400.
  */
 
+LEAF(r4k_clear_page32_d16)
+	addiu	AT, a0, _PAGE_SIZE
+1:	cache	Create_Dirty_Excl_D, (a0)
+	sw	zero, (a0)
+	sw	zero, 4(a0)
+	sw	zero, 8(a0)
+	sw	zero, 12(a0)
+	addiu	a0, 32
+	cache	Create_Dirty_Excl_D, -16(a0)
+	sw	zero, -16(a0)
+	sw	zero, -12(a0)
+	sw	zero, -8(a0)
+	sw	zero, -4(a0)
+	bne	AT, a0, 1b
+	jr	ra
+	END(r4k_clear_page32_d16)
+
+LEAF(r4k_clear_page32_d32)
+	addiu	AT, a0, _PAGE_SIZE
+1:	cache	Create_Dirty_Excl_D, (a0)
+	sw	zero, (a0)
+	sw	zero, 4(a0)
+	sw	zero, 8(a0)
+	sw	zero, 12(a0)
+	addiu	a0, 64
+	sw	zero, -16(a0)
+	sw	zero, -12(a0)
+	sw	zero, -8(a0)
+	sw	zero, -4(a0)
+	bne	AT, a0, 1b
+	jr	ra
+	END(r4k_clear_page32_d32)
+
 LEAF(r4k_clear_page_d16)
 	addiu	AT, a0, _PAGE_SIZE
 1:	cache	Create_Dirty_Excl_D, (a0)
Index: include/asm-mips/cpu.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/cpu.h,v
retrieving revision 1.24.2.18
diff -u -r1.24.2.18 cpu.h
--- include/asm-mips/cpu.h	15 Apr 2003 14:19:14 -0000	1.24.2.18
+++ include/asm-mips/cpu.h	16 Apr 2003 14:56:33 -0000
@@ -162,14 +162,20 @@
 
 /*
  * ISA Level encodings
+ *
  */
 #define MIPS_CPU_ISA_I		0x00000001
 #define MIPS_CPU_ISA_II		0x00000002
-#define MIPS_CPU_ISA_III	0x00000003
-#define MIPS_CPU_ISA_IV		0x00000004
-#define MIPS_CPU_ISA_V		0x00000005
+#define MIPS_CPU_ISA_III	0x00008003
+#define MIPS_CPU_ISA_IV		0x00008004
+#define MIPS_CPU_ISA_V		0x00008005
 #define MIPS_CPU_ISA_M32	0x00000020
-#define MIPS_CPU_ISA_M64	0x00000040
+#define MIPS_CPU_ISA_M64	0x00008040
+
+/*
+ * Bit 15 encodes if an ISA level supports 64-bit operations.
+ */
+#define MIPS_CPU_ISA_64BIT	0x00008000
 
 /*
  * CPU Option encodings
Index: include/asm-mips/processor.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/processor.h,v
retrieving revision 1.43.2.18
diff -u -r1.43.2.18 processor.h
--- include/asm-mips/processor.h	15 Apr 2003 14:19:14 -0000	1.43.2.18
+++ include/asm-mips/processor.h	16 Apr 2003 14:56:46 -0000
@@ -93,6 +93,7 @@
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #define cpu_has_dc_aliases	(cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
 #define cpu_has_ic_fills_f_dc	(cpu_data[0].dcache.flags & MIPS_CACHE_IC_F_DC)
+#define cpu_has_64bits		(cpu_data[0].isa_level & MIPS_CPU_ISA_64BIT)
 
 extern struct cpuinfo_mips cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
