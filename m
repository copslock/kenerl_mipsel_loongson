Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2002 00:33:54 +0100 (CET)
Received: from jeeves.momenco.com ([64.169.228.99]:15628 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122165AbSKKXdx>; Tue, 12 Nov 2002 00:33:53 +0100
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id gABNXiN30566;
	Mon, 11 Nov 2002 15:33:44 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
Subject: PATCH: The other half of the Ocelot-C, plus support for the SandCraft SR71000
Date: Mon, 11 Nov 2002 15:33:44 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIKEEHCKAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C28997.B8471B50"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C28997.B8471B50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This patch is the other half of support for the Ocelot-C board from
Momentum Computer.  I've already added most of the board-specific code
to it's own directory under arch/mips/momentum/

This patch is against 2.4, but should also be applied to 2.5

This patch updates the various Makefiles, configure files,
initialization files, etc. to call the functions for the new target.

Also included in this is the code to support the SandCraft SR71000
processor, which is one of two processors supported on this board.
Not much needed in this department -- the most contraversal stuff is
an errata workaround for the 'wait' instruction, which is all done
with #ifdef's to make sure other targets aren't affected.

Also included in this is the new files for include/asm-mips/ to
support the Marvell MV-64340 chip (done much the same way as the 64240
and 64120 were done).  And the couple of changes to bootinfo.h and
serial.h to support these targets.

Ralf, please apply (or give your blessing and I'll check this all in).

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0007_01C28997.B8471B50
Content-Type: application/octet-stream;
	name="patch20021111"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20021111"

--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ arch/mips/mm/c-sr71000.c	Fri Aug 30 15:17:52 2002=0A=
@@ -0,0 +1,839 @@=0A=
+/*=0A=
+  Jason Gunthorpe <jgg@yottayotta.com>=0A=
+  Copyright (C) 2002 YottaYotta. Inc.=0A=
+   =0A=
+  Based on c-mips32:=0A=
+  Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, =
carstenl@mips.com=0A=
+  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.=0A=
+=0A=
+  This file is subject to the terms and conditions of the GNU General =
Public=0A=
+  License.  See the file "COPYING" in the main directory of this archive=0A=
+  for more details.=0A=
+   =0A=
+  Sandcraft SR71000 cache routines. =0A=
+  The SR71000 is a MIPS64 compatible CPU with 4 caches:=0A=
+   * 4 way 32K primary ICache - virtually indexed/physically tagged=0A=
+   * 4 way 32K primary DCache - virtually indexed/physically tagged=0A=
+   * 8 way 512K secondary cache - physically indexed/taged=0A=
+   * 8 way up to 16M tertiary cache - physically indexed/taged (and off =
chip)=0A=
+   =0A=
+  ICache and DCache do not have any sort of snooping. Unlike the RM7k,=0A=
+  the virtual index is 13 bits, and we use a 4k page size. This means =
you =0A=
+  can have cache aliasing effects, so they have to be treated as =
virtually=0A=
+  tagged. (unless that can be solved elsewhere, should investigate)=0A=
+=0A=
+  Note that on this chip all the _SD type cache ops (ie =
Hit_Writeback_Inv_SD)=0A=
+  are really just _S. This is in line with what the MIPS64 spec permits.=0A=
+  Also, the line size of the tertiary cache is really the block size. =
The=0A=
+  line size is always 32 bytes. The chip can tag partial blocks and the =
cache=0A=
+  op instructions work on those partial blocks too. =0A=
+  =0A=
+  See ./Documentation/cachetlb.txt=0A=
+ */=0A=
+#include <linux/init.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/mm.h>=0A=
+=0A=
+#include <asm/bootinfo.h>=0A=
+#include <asm/cpu.h>=0A=
+#include <asm/bcache.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/page.h>=0A=
+#include <asm/pgtable.h>=0A=
+#include <asm/system.h>=0A=
+#include <asm/mmu_context.h>=0A=
+=0A=
+// Should move to mipsregs.h =0A=
+#define read_32bit_cp0_registerx(reg,sel)                    \=0A=
+({ int __res;                                                   \=0A=
+        __asm__ __volatile__(                                   \=0A=
+	".set\tpush\n\t"					\=0A=
+	".set\treorder\n\t"					\=0A=
+	".set\tmips64\n\t"					\=0A=
+        "mfc0\t%0,"STR(reg)","STR(sel)"\n\t"                 \=0A=
+	".set\tmips0\n\t"					\=0A=
+	".set\tpop"						\=0A=
+        : "=3Dr" (__res));                                        \=0A=
+        __res;})=0A=
+#define write_32bit_cp0_registerx(reg,sel,value)           \=0A=
+        __asm__ __volatile__(                                   \=0A=
+	".set\tmips64\n\t"					\=0A=
+        "mtc0\t%0,"STR(reg)","STR(sel)"\n\t"		\=0A=
+	".set\tmips0\n\t"					\=0A=
+	"nop"							\=0A=
+        : : "r" (value));=0A=
+=0A=
+#undef DEBUG_CACHE=0A=
+=0A=
+/* Primary cache parameters. */=0A=
+int icache_size, dcache_size; 			/* Size in bytes */=0A=
+int ic_lsize, dc_lsize;				/* LineSize in bytes */=0A=
+=0A=
+/* Secondary cache parameters. */=0A=
+unsigned int scache_size, sc_lsize;		/* Again, in bytes */=0A=
+=0A=
+/* tertiary cache (if present) parameters. */=0A=
+unsigned int tcache_size, tc_lsize;		/* Again, in bytes */=0A=
+=0A=
+#include <asm/cacheops.h>=0A=
+#include <asm/mips32_cache.h>=0A=
+=0A=
+// Unique the SR71000=0A=
+#define Index_Invalidate_T 0x2=0A=
+#define Hit_Invalidate_T 0x16=0A=
+static inline void blast_tcache(void)=0A=
+{=0A=
+	unsigned long start =3D KSEG0;=0A=
+	unsigned long end =3D KSEG0 + tcache_size;=0A=
+	=0A=
+	// Could use flash invalidate perhaps..=0A=
+	while(start < end)=0A=
+	{=0A=
+		cache_unroll(start,Index_Invalidate_T);=0A=
+		start +=3D tc_lsize;=0A=
+	}	=0A=
+}=0A=
+=0A=
+static inline void flush_tcache_line(unsigned long addr)=0A=
+{=0A=
+	__asm__ __volatile__=0A=
+		(=0A=
+		 ".set noreorder\n\t"=0A=
+		 ".set mips3\n\t"=0A=
+		 "cache %1, (%0)\n\t"=0A=
+		 ".set mips0\n\t"=0A=
+		 ".set reorder"=0A=
+		 :=0A=
+		 : "r" (addr),=0A=
+		 "i" (Hit_Invalidate_T));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Dummy cache handling routines for machines without boardcaches=0A=
+ */=0A=
+static void no_sc_noop(void) {}=0A=
+=0A=
+static struct bcache_ops no_sc_ops =3D {=0A=
+	(void *)no_sc_noop, (void *)no_sc_noop,=0A=
+	(void *)no_sc_noop, (void *)no_sc_noop=0A=
+};=0A=
+struct bcache_ops *bcops =3D &no_sc_ops;=0A=
+=0A=
+// Clean all virtually indexed caches=0A=
+static inline void sr71000_flush_cache_all_pc(void)=0A=
+{=0A=
+	unsigned long flags;=0A=
+=0A=
+	__save_and_cli(flags);=0A=
+	blast_dcache(); blast_icache();=0A=
+	__restore_flags(flags);=0A=
+}=0A=
+=0A=
+// This clears all caches. It is only used from a syscall..=0A=
+static inline void sr71000_nuke_caches(void)=0A=
+{=0A=
+	unsigned long flags;=0A=
+=0A=
+	__save_and_cli(flags);=0A=
+	blast_dcache(); blast_icache(); blast_scache();=0A=
+	if (tcache_size !=3D 0)=0A=
+		blast_tcache();=0A=
+	__restore_flags(flags);=0A=
+}=0A=
+=0A=
+/* This is called to clean out a virtual mapping. We only need to flush =
the=0A=
+   I and D caches since the other two are physically tagged */=0A=
+static void sr71000_flush_cache_range_pc(struct mm_struct *mm,=0A=
+				     unsigned long start,=0A=
+				     unsigned long end)=0A=
+{=0A=
+	if(mm->context !=3D 0) {=0A=
+		unsigned long flags;=0A=
+=0A=
+#ifdef DEBUG_CACHE=0A=
+		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);=0A=
+#endif=0A=
+		__save_and_cli(flags);=0A=
+		blast_dcache(); blast_icache();=0A=
+		__restore_flags(flags);=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * On architectures like the Sparc, we could get rid of lines in=0A=
+ * the cache created only by a certain context, but on the MIPS=0A=
+ * (and actually certain Sparc's) we cannot.=0A=
+ * Again, only clean the virtually tagged cache.=0A=
+ */=0A=
+static void sr71000_flush_cache_mm_pc(struct mm_struct *mm)=0A=
+{=0A=
+	if(mm->context !=3D 0) {=0A=
+#ifdef DEBUG_CACHE=0A=
+		printk("cmm[%d]", (int)mm->context);=0A=
+#endif=0A=
+		sr71000_flush_cache_all_pc();=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sr71000_flush_cache_page_pc(struct vm_area_struct *vma,=0A=
+				    unsigned long page)=0A=
+{=0A=
+	struct mm_struct *mm =3D vma->vm_mm;=0A=
+	unsigned long flags;=0A=
+	pgd_t *pgdp;=0A=
+	pmd_t *pmdp;=0A=
+	pte_t *ptep;=0A=
+=0A=
+	/*=0A=
+	 * If ownes no valid ASID yet, cannot possibly have gotten=0A=
+	 * this page into the cache.=0A=
+	 */=0A=
+	if (mm->context =3D=3D 0)=0A=
+		return;=0A=
+=0A=
+#ifdef DEBUG_CACHE=0A=
+	printk("cpage[%d,%08lx]", (int)mm->context, page);=0A=
+#endif=0A=
+	__save_and_cli(flags);=0A=
+	page &=3D PAGE_MASK;=0A=
+	pgdp =3D pgd_offset(mm, page);=0A=
+	pmdp =3D pmd_offset(pgdp, page);=0A=
+	ptep =3D pte_offset(pmdp, page);=0A=
+=0A=
+	/*=0A=
+	 * If the page isn't marked valid, the page cannot possibly be=0A=
+	 * in the cache.=0A=
+	 */=0A=
+	if (!(pte_val(*ptep) & _PAGE_VALID))=0A=
+		goto out;=0A=
+=0A=
+	/*=0A=
+	 * Doing flushes for another ASID than the current one is=0A=
+	 * too difficult since Mips32 caches do a TLB translation=0A=
+	 * for every cache flush operation.  So we do indexed flushes=0A=
+	 * in that case, which doesn't overly flush the cache too much.=0A=
+	 */=0A=
+	if (mm =3D=3D current->active_mm) {=0A=
+		blast_dcache_page(page);=0A=
+	} else {=0A=
+		/* Do indexed flush, too much work to get the (possible)=0A=
+		 * tlb refills to work correctly.=0A=
+		 */=0A=
+		page =3D (KSEG0 + (page & (dcache_size - 1)));=0A=
+		blast_dcache_page_indexed(page);=0A=
+	}=0A=
+out:=0A=
+	__restore_flags(flags);=0A=
+}=0A=
+=0A=
+/* If the addresses passed to these routines are valid, they are=0A=
+ * either:=0A=
+ *=0A=
+ * 1) In KSEG0, so we can do a direct flush of the page.=0A=
+ * 2) In KSEG2, and since every process can translate those=0A=
+ *    addresses all the time in kernel mode we can do a direct=0A=
+ *    flush.=0A=
+ * 3) In KSEG1, no flush necessary.=0A=
+ */=0A=
+static void sr71000_flush_page_to_ram_pc(struct page *page)=0A=
+{=0A=
+	blast_dcache_page((unsigned long)page_address(page));=0A=
+}=0A=
+=0A=
+/* I-Cache and D-Cache are seperate and virtually tagged, these need to=0A=
+   flush them */=0A=
+static void sr71000_flush_icache_range(unsigned long start, unsigned =
long end)=0A=
+{=0A=
+	flush_cache_all();  // only does i and d, probably excessive=0A=
+}=0A=
+=0A=
+static void sr71000_flush_icache_page(struct vm_area_struct *vma,=0A=
+				     struct page *page)=0A=
+{=0A=
+	int address;=0A=
+=0A=
+	if (!(vma->vm_flags & VM_EXEC))=0A=
+		return;=0A=
+=0A=
+	address =3D KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & =
(dcache_size - 1));=0A=
+	blast_icache_page_indexed(address);=0A=
+}=0A=
+=0A=
+/* Writeback and invalidate the primary cache dcache before DMA.=0A=
+   See asm-mips/io.h =0A=
+ */=0A=
+static void sr71000_dma_cache_wback_inv_sc(unsigned long addr,=0A=
+					  unsigned long size)=0A=
+{=0A=
+	unsigned long end, a;=0A=
+=0A=
+	if (size >=3D scache_size) {=0A=
+		sr71000_nuke_caches();=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	a =3D addr & ~(sc_lsize - 1);=0A=
+	end =3D (addr + size) & ~(sc_lsize - 1);=0A=
+	while (1) {=0A=
+		flush_dcache_line(a);=0A=
+		flush_scache_line(a); // Hit_Writeback_Inv_SD=0A=
+		if (a =3D=3D end) break;=0A=
+		a +=3D sc_lsize;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sr71000_dma_cache_wback_inv_tc(unsigned long addr,=0A=
+					  unsigned long size)=0A=
+{=0A=
+	unsigned long end, a;=0A=
+=0A=
+	a =3D addr & ~(sc_lsize - 1);=0A=
+	end =3D (addr + size) & ~(sc_lsize - 1);=0A=
+	while (1) {=0A=
+		flush_dcache_line(a);=0A=
+		flush_scache_line(a); // Hit_Writeback_Inv_SD=0A=
+		flush_tcache_line(a); // Hit_Invalidate_T=0A=
+		if (a =3D=3D end) break;=0A=
+		a +=3D sc_lsize;=0A=
+	}=0A=
+}=0A=
+=0A=
+/* It is kind of silly to writeback for the inv case.. Oh well */=0A=
+static void sr71000_dma_cache_inv_sc(unsigned long addr, unsigned long =
size)=0A=
+{=0A=
+	unsigned long end, a;=0A=
+=0A=
+	if (size >=3D scache_size) {=0A=
+		sr71000_nuke_caches();=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	a =3D addr & ~(sc_lsize - 1);=0A=
+	end =3D (addr + size) & ~(sc_lsize - 1);=0A=
+	while (1) {=0A=
+		flush_dcache_line(a);=0A=
+		flush_scache_line(a); // Hit_Writeback_Inv_SD =0A=
+		if (a =3D=3D end) break;=0A=
+		a +=3D sc_lsize;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sr71000_dma_cache_inv_tc(unsigned long addr, unsigned long =
size)=0A=
+{=0A=
+	unsigned long end, a;=0A=
+=0A=
+	a =3D addr & ~(sc_lsize - 1);=0A=
+	end =3D (addr + size) & ~(sc_lsize - 1);=0A=
+	while (1) {=0A=
+		flush_dcache_line(a);=0A=
+		flush_scache_line(a); // Hit_Writeback_Inv_SD=0A=
+		flush_tcache_line(a); // Hit_Invalidate_T=0A=
+		if (a =3D=3D end) break;=0A=
+		a +=3D sc_lsize;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void sr71000_dma_cache_wback(unsigned long addr, unsigned long =
size)=0A=
+{=0A=
+	panic("sr71000_dma_cache_wback called - should not happen.");=0A=
+}=0A=
+=0A=
+/*=0A=
+ * While we're protected against bad userland addresses we don't care=0A=
+ * very much about what happens in that case.  Usually a segmentation=0A=
+ * fault will dump the process later on anyway ...=0A=
+ */=0A=
+static void sr71000_flush_cache_sigtramp(unsigned long addr)=0A=
+{=0A=
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));=0A=
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));=0A=
+}=0A=
+=0A=
+/* Detect and size the various caches. */=0A=
+static void __init probe_icache(unsigned long config,unsigned long =
config1)=0A=
+{=0A=
+	unsigned int lsize;=0A=
+=0A=
+	config1 =3D read_mips32_cp0_config1(); =0A=
+	=0A=
+	if ((lsize =3D ((config1 >> 19) & 7)))=0A=
+		mips_cpu.icache.linesz =3D 2 << lsize;=0A=
+	else =0A=
+		mips_cpu.icache.linesz =3D lsize;=0A=
+	mips_cpu.icache.sets =3D 64 << ((config1 >> 22) & 7);=0A=
+	mips_cpu.icache.ways =3D 1 + ((config1 >> 16) & 7);=0A=
+	=0A=
+	ic_lsize =3D mips_cpu.icache.linesz;=0A=
+	icache_size =3D mips_cpu.icache.sets * mips_cpu.icache.ways * =0A=
+		ic_lsize;=0A=
+	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",=0A=
+	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);=0A=
+}=0A=
+=0A=
+static void __init probe_dcache(unsigned long config,unsigned long =
config1)=0A=
+{=0A=
+	unsigned int lsize;=0A=
+=0A=
+	if ((lsize =3D ((config1 >> 10) & 7)))=0A=
+		mips_cpu.dcache.linesz =3D 2 << lsize;=0A=
+	else =0A=
+		mips_cpu.dcache.linesz =3D lsize;=0A=
+	mips_cpu.dcache.sets =3D 64 << ((config1 >> 13) & 7);=0A=
+	mips_cpu.dcache.ways =3D 1 + ((config1 >> 7) & 7);=0A=
+	=0A=
+	dc_lsize =3D mips_cpu.dcache.linesz;=0A=
+	dcache_size =3D =0A=
+		mips_cpu.dcache.sets * mips_cpu.dcache.ways=0A=
+		* dc_lsize;=0A=
+	printk("Primary data cache %dkb, linesize %d bytes (%d ways)\n",=0A=
+	       dcache_size >> 10, dc_lsize, mips_cpu.dcache.ways);=0A=
+}=0A=
+=0A=
+static void __init probe_scache(unsigned long config,unsigned long =
config2)=0A=
+{=0A=
+	unsigned int lsize;=0A=
+=0A=
+	if ((lsize =3D ((config2 >> 4) & 7)))=0A=
+		mips_cpu.scache.linesz =3D 2 << lsize;=0A=
+	else =0A=
+		mips_cpu.scache.linesz =3D lsize;=0A=
+	=0A=
+	mips_cpu.scache.sets =3D 64 << ((config2 >> 8) & 7);=0A=
+	mips_cpu.scache.ways =3D 1 + ((config2 >> 0) & 7);=0A=
+=0A=
+	sc_lsize =3D mips_cpu.scache.linesz;=0A=
+	scache_size =3D mips_cpu.scache.sets * mips_cpu.scache.ways * sc_lsize;=0A=
+	=0A=
+	printk("Secondary cache %dK, linesize %d bytes (%d ways)\n",=0A=
+	       scache_size >> 10, sc_lsize, mips_cpu.scache.ways);=0A=
+}=0A=
+=0A=
+static void __init probe_tcache(unsigned long config,unsigned long =
config2)=0A=
+{=0A=
+	unsigned int lsize;=0A=
+=0A=
+	/* Firmware or prom_init is required to configure the size of the =0A=
+	   tertiary cache in config2 and set the TE bit in config2 to signal =0A=
+	   the external SRAM chips are present. */=0A=
+	if ((config2 & (1<<28)) =3D=3D 0)=0A=
+		return;=0A=
+	=0A=
+	if ((lsize =3D ((config2 >> 20) & 7)))=0A=
+		mips_cpu.tcache.linesz =3D 2 << lsize;=0A=
+	else =0A=
+		mips_cpu.tcache.linesz =3D lsize;=0A=
+	=0A=
+	mips_cpu.tcache.sets =3D 64 << ((config2 >> 24) & 7);=0A=
+	mips_cpu.tcache.ways =3D 1 + ((config2 >> 16) & 7);=0A=
+=0A=
+	tc_lsize =3D mips_cpu.tcache.linesz;=0A=
+	tcache_size =3D mips_cpu.tcache.sets * mips_cpu.tcache.ways * tc_lsize;=0A=
+	=0A=
+	printk("Tertiary cache %dK, linesize %d bytes, blocksize %d "=0A=
+	       "bytes (%d ways)\n",=0A=
+	       tcache_size >> 10, sc_lsize, tc_lsize, mips_cpu.tcache.ways);=0A=
+}=0A=
+=0A=
+static void __init setup_scache_funcs(void)=0A=
+{=0A=
+        _flush_cache_all =3D sr71000_flush_cache_all_pc;=0A=
+        ___flush_cache_all =3D sr71000_nuke_caches;=0A=
+	_flush_cache_mm =3D sr71000_flush_cache_mm_pc;=0A=
+	_flush_cache_range =3D sr71000_flush_cache_range_pc;=0A=
+	_flush_cache_page =3D sr71000_flush_cache_page_pc;=0A=
+	_flush_page_to_ram =3D sr71000_flush_page_to_ram_pc;=0A=
+=0A=
+        // These can only be done on the primary cache.=0A=
+	_clear_page =3D (void *)mips32_clear_page_dc;=0A=
+	_copy_page =3D (void *)mips32_copy_page_dc;=0A=
+=0A=
+	_flush_icache_page =3D sr71000_flush_icache_page;=0A=
+=0A=
+	if (tcache_size =3D=3D 0)=0A=
+	{=0A=
+		_dma_cache_wback_inv =3D sr71000_dma_cache_wback_inv_sc;=0A=
+		_dma_cache_inv =3D sr71000_dma_cache_inv_sc;=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		_dma_cache_wback_inv =3D sr71000_dma_cache_wback_inv_tc;=0A=
+		_dma_cache_inv =3D sr71000_dma_cache_inv_tc;=0A=
+	}=0A=
+		=0A=
+	_dma_cache_wback =3D sr71000_dma_cache_wback;=0A=
+}=0A=
+=0A=
+/* This implements the cache intialization stuff from the SR71000 =
guide. After=0A=
+   this all the caches will be empty and ready to run. It must be run =
from=0A=
+   uncached space. */=0A=
+static void __init clear_enable_caches(unsigned long config)=0A=
+{=0A=
+	config =3D (config & (~CONF_CM_CMASK)) | CONF_CM_CACHABLE_NONCOHERENT;=0A=
+	printk("clear_enable_caches: config: 0x%08lx\n", config);=0A=
+	=0A=
+	/* Primary cache init (7.1.1)=0A=
+	   SR71000 Primary Cache initialization of 4-way, 32 Kbyte line I/D =0A=
+	   caches. */=0A=
+	__asm__ __volatile__ =0A=
+		(=0A=
+		 ".set push\n"=0A=
+		 ".set noreorder\n"=0A=
+		 ".set noat\n"=0A=
+		 ".set mips64\n"=0A=
+#if 0=0A=
+		 // Enable KSEG0 caching=0A=
+		 " mtc0 %0, $16\n"=0A=
+#endif=0A=
+		 =0A=
+		 /* It is recommended that parity be disabled during cache =0A=
+		    initialization. */=0A=
+		 " mfc0 $1, $12\n"      // Read CP0 Status Register.=0A=
+		 " li $2, 0x00010000\n" // DE Bit.=0A=
+		 " or $2, $1, $2\n"=0A=
+		 " mtc0 $2, $12\n"     // Disable Parity.=0A=
+		 =0A=
+		 " ori $3, %1, 0x1FE0\n" // 256 sets.=0A=
+		 " mtc0 $0, $28\n" // Set CP0 Tag_Lo Register=0A=
+		 "1:\n"=0A=
+		 " cache 8, 0x0000($3)\n" // Index_Store_Tag_I=0A=
+		 " cache 8, 0x2000($3)\n" // Index_Store_Tag_I=0A=
+		 " cache 8, 0x4000($3)\n" // Index_Store_Tag_I=0A=
+		 " cache 8, 0x6000($3)\n" // Index_Store_Tag_I=0A=
+		 " cache 9, 0x0000($3)\n" // Index_Store_Tag_D=0A=
+		 " cache 9, 0x2000($3)\n" // Index_Store_Tag_D=0A=
+		 " cache 9, 0x4000($3)\n" // Index_Store_Tag_D=0A=
+		 " cache 9, 0x6000($3)\n" // Index_Store_Tag_D=0A=
+		 " bne $3, %1, 1b\n"=0A=
+		 " addiu $3, $3, -0x0020\n" // 32 byte cache line=0A=
+		 " mtc0 $1, $12\n" // Put original back in Status Register.=0A=
+		 ".set pop\n"=0A=
+		 :=0A=
+		 : "r"(config), "r"(KSEG0) // arbitary unmapped address=0A=
+		 : "$1","$2","$3");=0A=
+=0A=
+	/* Secondary and tertiary flash invalidate (7.5.18)	   =0A=
+	    This code fragment, invalidates (also disables), and=0A=
+	    restores (re-enables) the secondary and tertiary caches.=0A=
+	    Ensure system is operating in uncached space. */=0A=
+	__asm__ __volatile__ =0A=
+		 (=0A=
+		 ".set push\n"=0A=
+		 ".set noreorder\n"=0A=
+		 ".set noat\n"=0A=
+		 ".set mips64\n"=0A=
+		 "  sync\n"			// flush core pipeline=0A=
+		 "  lw $2, 0(%0)\n"		// flush pending accesses=0A=
+		 "  bne $2, $2, 1f\n"		// prevent I-fetches=0A=
+		 "  nop\n"=0A=
+		 "1: mfc0 $1, $16, 2\n"		// save current Config2=0A=
+		 "  li $2, 0x20002000\n"	// set flash invalidation bits=0A=
+		 "  or $2, $1, $2\n"=0A=
+		 "  mtc0 $2, $16, 2\n"		// invalidate & disable caches=0A=
+		 "  li $2, 0x10001000\n"        // enable L2 and L3=0A=
+		 "  or $1, $1, $2\n"=0A=
+		 "  mtc0 $1, $16, 2\n"=0A=
+		 ".set pop\n"=0A=
+		 :=0A=
+		 : "r"(KSEG1)=0A=
+		 : "$1","$2");		 =0A=
+}=0A=
+=0A=
+void __init ld_mmu_sr71000(void)=0A=
+{=0A=
+	unsigned long config =3D read_32bit_cp0_registerx(CP0_CONFIG,0);=0A=
+	unsigned long config1 =3D read_32bit_cp0_registerx(CP0_CONFIG,1);=0A=
+	unsigned long config2 =3D read_32bit_cp0_registerx(CP0_CONFIG,2);=0A=
+	void (*kseg1_cec)(unsigned long config) =3D (void =
*)KSEG1ADDR(&clear_enable_caches);=0A=
+=0A=
+	// Should never happen=0A=
+        if (!(config & (1 << 31)) || !(config1 & (1 << 31)))=0A=
+		panic("sr71000 does not have necessary config registers");=0A=
+	=0A=
+	probe_icache(config,config1);=0A=
+	probe_dcache(config,config1);=0A=
+	probe_scache(config,config2);=0A=
+	probe_tcache(config,config2);=0A=
+	setup_scache_funcs();=0A=
+=0A=
+	// Make sure the the secondary cache is turned on (always present)=0A=
+	write_32bit_cp0_registerx(CP0_CONFIG,2,config2 | (1<<12));=0A=
+	=0A=
+#ifndef CONFIG_MIPS_UNCACHED=0A=
+	if ((config & CONF_CM_CMASK) !=3D CONF_CM_UNCACHED)=0A=
+                printk("Caches already enabled, leaving alone..\n");=0A=
+        else=0A=
+                kseg1_cec(config);=0A=
+#endif=0A=
+						  =0A=
+	_flush_cache_sigtramp =3D sr71000_flush_cache_sigtramp;=0A=
+	_flush_icache_range =3D sr71000_flush_icache_range;=0A=
+}=0A=
+=0A=
+/* Jack Veenstra: added access routines for CP0 registers.=0A=
+ * The ability to write certain CP0 registers is a huge security hole,=0A=
+ * so we limit it to processes with root privilege.=0A=
+ */=0A=
+=0A=
+#include <asm/uaccess.h>=0A=
+=0A=
+asmlinkage long sys_get_cp0_reg(int reg, int select, unsigned long =
*pval)=0A=
+{=0A=
+    unsigned long	val =3D 0;=0A=
+=0A=
+    switch (reg) {=0A=
+	case 0: val =3D read_32bit_cp0_register($0); break;=0A=
+	case 1: val =3D read_32bit_cp0_register($1); break;=0A=
+	case 2: val =3D read_32bit_cp0_register($2); break;=0A=
+	case 3: val =3D read_32bit_cp0_register($3); break;=0A=
+	case 4: val =3D read_32bit_cp0_register($4); break;=0A=
+	case 5: val =3D read_32bit_cp0_register($5); break;=0A=
+	case 6: val =3D read_32bit_cp0_register($6); break;=0A=
+	case 7: val =3D read_32bit_cp0_register($7); break;=0A=
+	case 8: val =3D read_32bit_cp0_register($8); break;=0A=
+	case 9: val =3D read_32bit_cp0_register($9); break;=0A=
+	case 10: val =3D read_32bit_cp0_register($10); break;=0A=
+	case 11: val =3D read_32bit_cp0_register($11); break;=0A=
+	case 12: val =3D read_32bit_cp0_register($12); break;=0A=
+	case 13: val =3D read_32bit_cp0_register($13); break;=0A=
+	case 14: val =3D read_32bit_cp0_register($14); break;=0A=
+	case 15: val =3D read_32bit_cp0_register($15); break;=0A=
+	case 20: val =3D read_32bit_cp0_register($20); break;=0A=
+	case 26: val =3D read_32bit_cp0_register($26); break;=0A=
+	case 27: val =3D read_32bit_cp0_register($27); break;=0A=
+	case 28: val =3D read_32bit_cp0_register($28); break;=0A=
+	case 29: val =3D read_32bit_cp0_register($29); break;=0A=
+	case 30: val =3D read_32bit_cp0_register($30); break;=0A=
+=0A=
+	case 16:=0A=
+	    switch (select) {=0A=
+		case 0: val =3D read_32bit_cp0_registerx($16,0); break;=0A=
+		case 1: val =3D read_32bit_cp0_registerx($16,1); break;=0A=
+		case 2: val =3D read_32bit_cp0_registerx($16,2); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 18:=0A=
+	    switch (select) {=0A=
+		case 0: val =3D read_32bit_cp0_registerx($18,0); break;=0A=
+		case 1: val =3D read_32bit_cp0_registerx($18,1); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 19:=0A=
+	    switch (select) {=0A=
+		case 0: val =3D read_32bit_cp0_registerx($19,0); break;=0A=
+		case 1: val =3D read_32bit_cp0_registerx($19,1); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 25:=0A=
+	    switch (select) {=0A=
+		case 0: val =3D read_32bit_cp0_registerx($25,0); break;=0A=
+		case 1: val =3D read_32bit_cp0_registerx($25,1); break;=0A=
+		case 2: val =3D read_32bit_cp0_registerx($25,2); break;=0A=
+		case 3: val =3D read_32bit_cp0_registerx($25,3); break;=0A=
+	    }=0A=
+	    break;=0A=
+    }=0A=
+    if (copy_to_user(pval, &val, sizeof(*pval)))=0A=
+	return -EFAULT;=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+asmlinkage long sys_set_cp0_reg(int reg, int select, unsigned long val)=0A=
+{=0A=
+    if (!capable(CAP_SYS_ADMIN))=0A=
+	return -EPERM;=0A=
+=0A=
+    switch (reg) {=0A=
+	case 2: write_32bit_cp0_register($2, val); break;=0A=
+	case 3: write_32bit_cp0_register($3, val); break;=0A=
+	case 4: write_32bit_cp0_register($4, val); break;=0A=
+	case 5: write_32bit_cp0_register($5, val); break;=0A=
+	case 6: write_32bit_cp0_register($6, val); break;=0A=
+	case 7: write_32bit_cp0_register($7, val); break;=0A=
+	case 9: write_32bit_cp0_register($9, val); break;=0A=
+	case 10: write_32bit_cp0_register($10, val); break;=0A=
+	case 11: write_32bit_cp0_register($11, val); break;=0A=
+	case 12: write_32bit_cp0_register($12, val); break;=0A=
+	case 13: write_32bit_cp0_register($13, val); break;=0A=
+	case 14: write_32bit_cp0_register($14, val); break;=0A=
+	case 20: write_32bit_cp0_register($20, val); break;=0A=
+	case 26: write_32bit_cp0_register($26, val); break;=0A=
+	case 28: write_32bit_cp0_register($28, val); break;=0A=
+	case 29: write_32bit_cp0_register($29, val); break;=0A=
+	case 30: write_32bit_cp0_register($30, val); break;=0A=
+=0A=
+	case 16:=0A=
+	    switch (select) {=0A=
+		case 0: write_32bit_cp0_registerx($16,0, val); break;=0A=
+		case 2: write_32bit_cp0_registerx($16,2, val); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 18:=0A=
+	    switch (select) {=0A=
+		case 0: write_32bit_cp0_registerx($18,0, val); break;=0A=
+		case 1: write_32bit_cp0_registerx($18,1, val); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 19:=0A=
+	    switch (select) {=0A=
+		case 0: write_32bit_cp0_registerx($19,0, val); break;=0A=
+		case 1: write_32bit_cp0_registerx($19,1, val); break;=0A=
+	    }=0A=
+	    break;=0A=
+	case 25:=0A=
+	    switch (select) {=0A=
+		case 0: write_32bit_cp0_registerx($25,0, val); break;=0A=
+		case 1: write_32bit_cp0_registerx($25,1, val); break;=0A=
+		case 2: write_32bit_cp0_registerx($25,2, val); break;=0A=
+		case 3: write_32bit_cp0_registerx($25,3, val); break;=0A=
+	    }=0A=
+	    break;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static unsigned long long Perf_counter0;=0A=
+static unsigned long long Perf_counter1;=0A=
+=0A=
+/* This routine is called from the context of an interrupt handler=0A=
+ * when a timer or performance counter interrupt occurs.=0A=
+ */=0A=
+asmlinkage void perf_counter_handler(void)=0A=
+{=0A=
+    unsigned int	val;=0A=
+#if 0=0A=
+    static int	calls =3D 0;=0A=
+=0A=
+    if (calls >=3D 1)=0A=
+	debug_led0_on();=0A=
+    if (calls >=3D 10)=0A=
+	debug_led1_on();=0A=
+    if (calls >=3D 100)=0A=
+	debug_led2_on();=0A=
+    calls +=3D 1;=0A=
+=0A=
+    val =3D read_32bit_cp0_register($9);=0A=
+    printk(KERN_CRIT "perf_counter_handler: cycle count: 0x%lx\n", val);=0A=
+#endif=0A=
+    =0A=
+    /* Write to the CP0 compare register to clear a possible=0A=
+     * timer interrupt.=0A=
+     */=0A=
+    write_32bit_cp0_register($11, 0);=0A=
+=0A=
+    val =3D read_32bit_cp0_registerx($25, 1);=0A=
+#if 0=0A=
+    printk(KERN_ERR "perf_counter_handler: perf_counter 0: 0x%lx\n", =
val);=0A=
+#endif=0A=
+    if (val & 0x80000000) {=0A=
+	Perf_counter0 +=3D val;=0A=
+	write_32bit_cp0_registerx($25, 1, 0);=0A=
+    }=0A=
+=0A=
+    val =3D read_32bit_cp0_registerx($25, 3);=0A=
+#if 0=0A=
+    printk("perf_counter_handler: perf_counter 1: 0x%lx\n", val);=0A=
+#endif=0A=
+    if (val & 0x80000000) {=0A=
+	Perf_counter1 +=3D val;=0A=
+	write_32bit_cp0_registerx($25, 3, 0);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Start the given performance counter to count the events specified=0A=
+ * by "event".  The "mode" argument limits the counting to certain modes=0A=
+ * (such as kernel mode, supervisor mode, or user mode).=0A=
+ */=0A=
+asmlinkage long sys_start_perf_counter(int cnum, int event, int mode)=0A=
+{=0A=
+    unsigned int	val;=0A=
+=0A=
+    /* Enable timer and performance counter interrupts */=0A=
+    set_cp0_status(IE_IRQ5);=0A=
+=0A=
+    val =3D (event << 5) | mode | 0x10;=0A=
+    if (cnum =3D=3D 0) {=0A=
+	/* Clear the current event counter */=0A=
+	write_32bit_cp0_registerx($25, 0, 0);=0A=
+	write_32bit_cp0_registerx($25, 1, 0);=0A=
+	Perf_counter0 =3D 0;=0A=
+=0A=
+	/* Start counting the new events */=0A=
+	write_32bit_cp0_registerx($25, 0, val);=0A=
+    } else {=0A=
+	/* Clear the current event counter */=0A=
+	write_32bit_cp0_registerx($25, 2, 0);=0A=
+	write_32bit_cp0_registerx($25, 3, 0);=0A=
+	Perf_counter1 =3D 0;=0A=
+=0A=
+	/* Start counting the new events */=0A=
+	write_32bit_cp0_registerx($25, 2, val);=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+/* Read the current value of the specified performance counter.=0A=
+ * The value is returned in the location pointed to by pval.=0A=
+ */=0A=
+asmlinkage long sys_read_perf_counter(int cnum, long long *pval)=0A=
+{=0A=
+    unsigned long long	val;=0A=
+    unsigned long	flags;=0A=
+=0A=
+    if (cnum =3D=3D 0) {=0A=
+	/* Disable interrupts */=0A=
+	save_and_cli(flags);=0A=
+	val =3D read_32bit_cp0_registerx($25, 1);=0A=
+	val +=3D Perf_counter0;=0A=
+	restore_flags(flags);=0A=
+    } else {=0A=
+	/* Disable interrupts */=0A=
+	save_and_cli(flags);=0A=
+	val =3D read_32bit_cp0_registerx($25, 3);=0A=
+	val +=3D Perf_counter1;=0A=
+	restore_flags(flags);=0A=
+    }=0A=
+=0A=
+    if (copy_to_user(pval, &val, sizeof(*pval)))=0A=
+	return -EFAULT;=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+/* Stop the given performance counter and clear it.=0A=
+ * If pval is non-NULL, return the current value of the counter=0A=
+ * in the location pointed to by pval.=0A=
+ */=0A=
+asmlinkage long sys_stop_perf_counter(int cnum, long long *pval)=0A=
+{=0A=
+    unsigned long long	val;=0A=
+    unsigned long	flags;=0A=
+=0A=
+    if (cnum =3D=3D 0) {=0A=
+	/* Disable interrupts */=0A=
+	save_and_cli(flags);=0A=
+	val =3D read_32bit_cp0_registerx($25, 1);=0A=
+	val +=3D Perf_counter0;=0A=
+	restore_flags(flags);=0A=
+=0A=
+	/* Stop counting and clear the count values */=0A=
+	write_32bit_cp0_registerx($25, 0, 0);=0A=
+	write_32bit_cp0_registerx($25, 1, 0);=0A=
+	Perf_counter0 =3D 0;=0A=
+    } else {=0A=
+	/* Disable interrupts */=0A=
+	save_and_cli(flags);=0A=
+	val =3D read_32bit_cp0_registerx($25, 3);=0A=
+	val +=3D Perf_counter1;=0A=
+	restore_flags(flags);=0A=
+=0A=
+	/* Stop counting and clear the count values */=0A=
+	write_32bit_cp0_registerx($25, 2, 0);=0A=
+	write_32bit_cp0_registerx($25, 3, 0);=0A=
+	Perf_counter1 =3D 0;=0A=
+    }=0A=
+=0A=
+    if (pval && copy_to_user(pval, &val, sizeof(*pval)))=0A=
+	return -EFAULT;=0A=
+    return 0;=0A=
+}=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ include/asm-mips/mv64340.h	Fri Nov  8 14:56:51 2002=0A=
@@ -0,0 +1,1037 @@=0A=
+/***********************************************************************=
********=0A=
+* mv64340.h - MV-64340 Internal registers definition file.=0A=
+*=0A=
+* Copyright 2002 Momentum Computer, Inc.=0A=
+* Copyright 2002 GALILEO TECHNOLOGY, LTD. =0A=
+*=0A=
+* This program is free software; you can redistribute  it and/or modify =
it=0A=
+* under  the terms of  the GNU General  Public License as published by =
the=0A=
+* Free Software Foundation;  either version 2 of the  License, or (at =
your=0A=
+* option) any later version.=0A=
+*=0A=
+************************************************************************=
*******/=0A=
+=0A=
+#ifndef __MV64340_H__=0A=
+#define __MV64340_H__=0A=
+=0A=
+#include <asm/mv64340_dep.h>=0A=
+=0A=
+/****************************************/=0A=
+/* Processor Address Space              */=0A=
+/****************************************/=0A=
+=0A=
+/* DDR SDRAM BAR and size registers */=0A=
+=0A=
+#define MV64340_CS_0_BASE_ADDR                                      =
0x008=0A=
+#define MV64340_CS_0_SIZE                                           =
0x010=0A=
+#define MV64340_CS_1_BASE_ADDR                                      =
0x208=0A=
+#define MV64340_CS_1_SIZE                                           =
0x210=0A=
+#define MV64340_CS_2_BASE_ADDR                                      =
0x018=0A=
+#define MV64340_CS_2_SIZE                                           =
0x020=0A=
+#define MV64340_CS_3_BASE_ADDR                                      =
0x218=0A=
+#define MV64340_CS_3_SIZE                                           =
0x220=0A=
+=0A=
+/* Devices BAR and size registers */=0A=
+=0A=
+#define MV64340_DEV_CS0_BASE_ADDR                                   =
0x028=0A=
+#define MV64340_DEV_CS0_SIZE                                        =
0x030=0A=
+#define MV64340_DEV_CS1_BASE_ADDR                                   =
0x228=0A=
+#define MV64340_DEV_CS1_SIZE                                        =
0x230=0A=
+#define MV64340_DEV_CS2_BASE_ADDR                                   =
0x248=0A=
+#define MV64340_DEV_CS2_SIZE                                        =
0x250=0A=
+#define MV64340_DEV_CS3_BASE_ADDR                                   =
0x038=0A=
+#define MV64340_DEV_CS3_SIZE                                        =
0x040=0A=
+#define MV64340_BOOTCS_BASE_ADDR                                    =
0x238=0A=
+#define MV64340_BOOTCS_SIZE                                         =
0x240=0A=
+=0A=
+/* PCI 0 BAR and size registers */=0A=
+=0A=
+#define MV64340_PCI_0_IO_BASE_ADDR                                  =
0x048=0A=
+#define MV64340_PCI_0_IO_SIZE                                       =
0x050=0A=
+#define MV64340_PCI_0_MEMORY0_BASE_ADDR                             =
0x058=0A=
+#define MV64340_PCI_0_MEMORY0_SIZE                                  =
0x060=0A=
+#define MV64340_PCI_0_MEMORY1_BASE_ADDR                             =
0x080=0A=
+#define MV64340_PCI_0_MEMORY1_SIZE                                  =
0x088=0A=
+#define MV64340_PCI_0_MEMORY2_BASE_ADDR                             =
0x258=0A=
+#define MV64340_PCI_0_MEMORY2_SIZE                                  =
0x260=0A=
+#define MV64340_PCI_0_MEMORY3_BASE_ADDR                             =
0x280=0A=
+#define MV64340_PCI_0_MEMORY3_SIZE                                  =
0x288=0A=
+=0A=
+/* PCI 1 BAR and size registers */=0A=
+#define MV64340_PCI_1_IO_BASE_ADDR                                  =
0x090=0A=
+#define MV64340_PCI_1_IO_SIZE                                       =
0x098=0A=
+#define MV64340_PCI_1_MEMORY0_BASE_ADDR                             =
0x0a0=0A=
+#define MV64340_PCI_1_MEMORY0_SIZE                                  =
0x0a8=0A=
+#define MV64340_PCI_1_MEMORY1_BASE_ADDR                             =
0x0b0=0A=
+#define MV64340_PCI_1_MEMORY1_SIZE                                  =
0x0b8=0A=
+#define MV64340_PCI_1_MEMORY2_BASE_ADDR                             =
0x2a0=0A=
+#define MV64340_PCI_1_MEMORY2_SIZE                                  =
0x2a8=0A=
+#define MV64340_PCI_1_MEMORY3_BASE_ADDR                             =
0x2b0=0A=
+#define MV64340_PCI_1_MEMORY3_SIZE                                  =
0x2b8=0A=
+=0A=
+/* SRAM base address */=0A=
+#define MV64340_INTEGRATED_SRAM_BASE_ADDR                           =
0x268=0A=
+=0A=
+/* internal registers space base address */=0A=
+#define MV64340_INTERNAL_SPACE_BASE_ADDR                            =
0x068=0A=
+=0A=
+/* Enables the CS , DEV_CS , PCI 0 and PCI 1 =0A=
+   windows above */=0A=
+#define MV64340_BASE_ADDR_ENABLE                                    =
0x278=0A=
+=0A=
+/****************************************/=0A=
+/* PCI remap registers                  */=0A=
+/****************************************/=0A=
+      /* PCI 0 */=0A=
+#define MV64340_PCI_0_IO_ADDR_REMAP                                 =
0x0f0=0A=
+#define MV64340_PCI_0_MEMORY0_LOW_ADDR_REMAP                        =
0x0f8=0A=
+#define MV64340_PCI_0_MEMORY0_HIGH_ADDR_REMAP                       =
0x320=0A=
+#define MV64340_PCI_0_MEMORY1_LOW_ADDR_REMAP                        =
0x100=0A=
+#define MV64340_PCI_0_MEMORY1_HIGH_ADDR_REMAP                       =
0x328=0A=
+#define MV64340_PCI_0_MEMORY2_LOW_ADDR_REMAP                        =
0x2f8=0A=
+#define MV64340_PCI_0_MEMORY2_HIGH_ADDR_REMAP                       =
0x330=0A=
+#define MV64340_PCI_0_MEMORY3_LOW_ADDR_REMAP                        =
0x300=0A=
+#define MV64340_PCI_0_MEMORY3_HIGH_ADDR_REMAP                       =
0x338=0A=
+      /* PCI 1 */=0A=
+#define MV64340_PCI_1_IO_ADDR_REMAP                                 =
0x108=0A=
+#define MV64340_PCI_1_MEMORY0_LOW_ADDR_REMAP                        =
0x110=0A=
+#define MV64340_PCI_1_MEMORY0_HIGH_ADDR_REMAP                       =
0x340=0A=
+#define MV64340_PCI_1_MEMORY1_LOW_ADDR_REMAP                        =
0x118=0A=
+#define MV64340_PCI_1_MEMORY1_HIGH_ADDR_REMAP                       =
0x348=0A=
+#define MV64340_PCI_1_MEMORY2_LOW_ADDR_REMAP                        =
0x310=0A=
+#define MV64340_PCI_1_MEMORY2_HIGH_ADDR_REMAP                       =
0x350=0A=
+#define MV64340_PCI_1_MEMORY3_LOW_ADDR_REMAP                        =
0x318=0A=
+#define MV64340_PCI_1_MEMORY3_HIGH_ADDR_REMAP                       =
0x358=0A=
+ =0A=
+#define MV64340_CPU_PCI_0_HEADERS_RETARGET_CONTROL                  =
0x3b0=0A=
+#define MV64340_CPU_PCI_0_HEADERS_RETARGET_BASE                     =
0x3b8=0A=
+#define MV64340_CPU_PCI_1_HEADERS_RETARGET_CONTROL                  =
0x3c0=0A=
+#define MV64340_CPU_PCI_1_HEADERS_RETARGET_BASE                     =
0x3c8=0A=
+#define MV64340_CPU_GE_HEADERS_RETARGET_CONTROL                     =
0x3d0=0A=
+#define MV64340_CPU_GE_HEADERS_RETARGET_BASE                        =
0x3d8=0A=
+#define MV64340_CPU_IDMA_HEADERS_RETARGET_CONTROL                   =
0x3e0=0A=
+#define MV64340_CPU_IDMA_HEADERS_RETARGET_BASE                      =
0x3e8=0A=
+=0A=
+/****************************************/=0A=
+/*         CPU Control Registers        */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_CPU_CONFIG                                          =
0x000=0A=
+#define MV64340_CPU_MODE                                            =
0x120=0A=
+#define MV64340_CPU_MASTER_CONTROL                                  =
0x160=0A=
+#define MV64340_CPU_CROSS_BAR_CONTROL_LOW                           =
0x150=0A=
+#define MV64340_CPU_CROSS_BAR_CONTROL_HIGH                          =
0x158=0A=
+#define MV64340_CPU_CROSS_BAR_TIMEOUT                               =
0x168=0A=
+=0A=
+/****************************************/=0A=
+/* SMP RegisterS                        */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_SMP_WHO_AM_I                                        =
0x200=0A=
+#define MV64340_SMP_CPU0_DOORBELL                                   =
0x214=0A=
+#define MV64340_SMP_CPU0_DOORBELL_CLEAR                             =
0x21C=0A=
+#define MV64340_SMP_CPU1_DOORBELL                                   =
0x224=0A=
+#define MV64340_SMP_CPU1_DOORBELL_CLEAR                             =
0x22C=0A=
+#define MV64340_SMP_CPU0_DOORBELL_MASK                              =
0x234=0A=
+#define MV64340_SMP_CPU1_DOORBELL_MASK                              =
0x23C=0A=
+#define MV64340_SMP_SEMAPHOR0                                       =
0x244=0A=
+#define MV64340_SMP_SEMAPHOR1                                       =
0x24c=0A=
+#define MV64340_SMP_SEMAPHOR2                                       =
0x254=0A=
+#define MV64340_SMP_SEMAPHOR3                                       =
0x25c=0A=
+#define MV64340_SMP_SEMAPHOR4                                       =
0x264=0A=
+#define MV64340_SMP_SEMAPHOR5                                       =
0x26c=0A=
+#define MV64340_SMP_SEMAPHOR6                                       =
0x274=0A=
+#define MV64340_SMP_SEMAPHOR7                                       =
0x27c=0A=
+=0A=
+/****************************************/=0A=
+/*  CPU Sync Barrier Register           */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_CPU_0_SYNC_BARRIER_TRIGGER                          =
0x0c0=0A=
+#define MV64340_CPU_0_SYNC_BARRIER_VIRTUAL                          =
0x0c8=0A=
+#define MV64340_CPU_1_SYNC_BARRIER_TRIGGER                          =
0x0d0=0A=
+#define MV64340_CPU_1_SYNC_BARRIER_VIRTUAL                          =
0x0d8=0A=
+=0A=
+/****************************************/=0A=
+/* CPU Access Protect                   */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_CPU_PROTECT_WINDOW_0_BASE_ADDR                      =
0x180=0A=
+#define MV64340_CPU_PROTECT_WINDOW_0_SIZE                           =
0x188=0A=
+#define MV64340_CPU_PROTECT_WINDOW_1_BASE_ADDR                      =
0x190=0A=
+#define MV64340_CPU_PROTECT_WINDOW_1_SIZE                           =
0x198=0A=
+#define MV64340_CPU_PROTECT_WINDOW_2_BASE_ADDR                      =
0x1a0=0A=
+#define MV64340_CPU_PROTECT_WINDOW_2_SIZE                           =
0x1a8=0A=
+#define MV64340_CPU_PROTECT_WINDOW_3_BASE_ADDR                      =
0x1b0=0A=
+#define MV64340_CPU_PROTECT_WINDOW_3_SIZE                           =
0x1b8=0A=
+=0A=
+=0A=
+/****************************************/=0A=
+/*          CPU Error Report            */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_CPU_ERROR_ADDR_LOW                                  =
0x070=0A=
+#define MV64340_CPU_ERROR_ADDR_HIGH                                 =
0x078=0A=
+#define MV64340_CPU_ERROR_DATA_LOW                                  =
0x128=0A=
+#define MV64340_CPU_ERROR_DATA_HIGH                                 =
0x130=0A=
+#define MV64340_CPU_ERROR_PARITY                                    =
0x138=0A=
+#define MV64340_CPU_ERROR_CAUSE                                     =
0x140=0A=
+#define MV64340_CPU_ERROR_MASK                                      =
0x148=0A=
+=0A=
+/****************************************/=0A=
+/*      CPU Interface Debug Registers 	*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_PUNIT_SLAVE_DEBUG_LOW                               =
0x360=0A=
+#define MV64340_PUNIT_SLAVE_DEBUG_HIGH                              =
0x368=0A=
+#define MV64340_PUNIT_MASTER_DEBUG_LOW                              =
0x370=0A=
+#define MV64340_PUNIT_MASTER_DEBUG_HIGH                             =
0x378=0A=
+#define MV64340_PUNIT_MMASK                                         =
0x3e4=0A=
+=0A=
+/****************************************/=0A=
+/*  Integrated SRAM Registers           */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_SRAM_CONFIG                                         =
0x380=0A=
+#define MV64340_SRAM_TEST_MODE                                      =
0X3F4=0A=
+#define MV64340_SRAM_ERROR_CAUSE                                    =
0x388=0A=
+#define MV64340_SRAM_ERROR_ADDR                                     =
0x390=0A=
+#define MV64340_SRAM_ERROR_ADDR_HIGH                                =
0X3F8=0A=
+#define MV64340_SRAM_ERROR_DATA_LOW                                 =
0x398=0A=
+#define MV64340_SRAM_ERROR_DATA_HIGH                                =
0x3a0=0A=
+#define MV64340_SRAM_ERROR_DATA_PARITY                              =
0x3a8=0A=
+=0A=
+/****************************************/=0A=
+/* SDRAM Configuration                  */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_SDRAM_CONFIG                                        =
0x1400=0A=
+#define MV64340_D_UNIT_CONTROL_LOW                                  =
0x1404=0A=
+#define MV64340_D_UNIT_CONTROL_HIGH                                 =
0x1424=0A=
+#define MV64340_SDRAM_TIMING_CONTROL_LOW                            =
0x1408=0A=
+#define MV64340_SDRAM_TIMING_CONTROL_HIGH                           =
0x140c=0A=
+#define MV64340_SDRAM_ADDR_CONTROL                                  =
0x1410=0A=
+#define MV64340_SDRAM_OPEN_PAGES_CONTROL                            =
0x1414=0A=
+#define MV64340_SDRAM_OPERATION                                     =
0x1418=0A=
+#define MV64340_SDRAM_MODE                                          =
0x141c=0A=
+#define MV64340_EXTENDED_DRAM_MODE                                  =
0x1420=0A=
+#define MV64340_SDRAM_CROSS_BAR_CONTROL_LOW                         =
0x1430=0A=
+#define MV64340_SDRAM_CROSS_BAR_CONTROL_HIGH                        =
0x1434=0A=
+#define MV64340_SDRAM_CROSS_BAR_TIMEOUT                             =
0x1438=0A=
+#define MV64340_SDRAM_ADDR_CTRL_PADS_CALIBRATION                    =
0x14c0=0A=
+#define MV64340_SDRAM_DATA_PADS_CALIBRATION                         =
0x14c4=0A=
+=0A=
+/****************************************/=0A=
+/* SDRAM Error Report                   */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_SDRAM_ERROR_DATA_LOW                                =
0x1444=0A=
+#define MV64340_SDRAM_ERROR_DATA_HIGH                               =
0x1440=0A=
+#define MV64340_SDRAM_ERROR_ADDR                                    =
0x1450=0A=
+#define MV64340_SDRAM_RECEIVED_ECC                                  =
0x1448=0A=
+#define MV64340_SDRAM_CALCULATED_ECC                                =
0x144c=0A=
+#define MV64340_SDRAM_ECC_CONTROL                                   =
0x1454=0A=
+#define MV64340_SDRAM_ECC_ERROR_COUNTER                             =
0x1458=0A=
+=0A=
+/******************************************/=0A=
+/*  Controlled Delay Line (CDL) Registers */=0A=
+/******************************************/=0A=
+=0A=
+#define MV64340_DFCDL_CONFIG0                                       =
0x1480=0A=
+#define MV64340_DFCDL_CONFIG1                                       =
0x1484=0A=
+#define MV64340_DLL_WRITE                                           =
0x1488=0A=
+#define MV64340_DLL_READ                                            =
0x148c=0A=
+#define MV64340_SRAM_ADDR                                           =
0x1490=0A=
+#define MV64340_SRAM_DATA0                                          =
0x1494=0A=
+#define MV64340_SRAM_DATA1                                          =
0x1498=0A=
+#define MV64340_SRAM_DATA2                                          =
0x149c=0A=
+#define MV64340_DFCL_PROBE                                          =
0x14a0=0A=
+=0A=
+/******************************************/=0A=
+/*   Debug Registers                      */=0A=
+/******************************************/=0A=
+=0A=
+#define MV64340_DUNIT_DEBUG_LOW                                     =
0x1460=0A=
+#define MV64340_DUNIT_DEBUG_HIGH                                    =
0x1464=0A=
+#define MV64340_DUNIT_MMASK                                         =
0X1b40=0A=
+=0A=
+/****************************************/=0A=
+/* Device Parameters			*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_DEVICE_BANK0_PARAMETERS				    0x45c=0A=
+#define MV64340_DEVICE_BANK1_PARAMETERS				    0x460=0A=
+#define MV64340_DEVICE_BANK2_PARAMETERS				    0x464=0A=
+#define MV64340_DEVICE_BANK3_PARAMETERS				    0x468=0A=
+#define MV64340_DEVICE_BOOT_BANK_PARAMETERS			    0x46c=0A=
+#define MV64340_DEVICE_INTERFACE_CONTROL                            =
0x4c0=0A=
+#define MV64340_DEVICE_INTERFACE_CROSS_BAR_CONTROL_LOW              =
0x4c8=0A=
+#define MV64340_DEVICE_INTERFACE_CROSS_BAR_CONTROL_HIGH             =
0x4cc=0A=
+#define MV64340_DEVICE_INTERFACE_CROSS_BAR_TIMEOUT                  =
0x4c4=0A=
+=0A=
+/****************************************/=0A=
+/* Device interrupt registers		*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_DEVICE_INTERRUPT_CAUSE				    0x4d0=0A=
+#define MV64340_DEVICE_INTERRUPT_MASK				    0x4d4=0A=
+#define MV64340_DEVICE_ERROR_ADDR				    0x4d8=0A=
+#define MV64340_DEVICE_ERROR_DATA   				    0x4dc=0A=
+#define MV64340_DEVICE_ERROR_PARITY     			    0x4e0=0A=
+=0A=
+/****************************************/=0A=
+/* Device debug registers   		*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_DEVICE_DEBUG_LOW     				    0x4e4=0A=
+#define MV64340_DEVICE_DEBUG_HIGH     				    0x4e8=0A=
+#define MV64340_RUNIT_MMASK                                         =
0x4f0=0A=
+=0A=
+/****************************************/=0A=
+/* PCI Slave Address Decoding registers */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_PCI_0_CS_0_BANK_SIZE                                =
0xc08=0A=
+#define MV64340_PCI_1_CS_0_BANK_SIZE                                =
0xc88=0A=
+#define MV64340_PCI_0_CS_1_BANK_SIZE                                =
0xd08=0A=
+#define MV64340_PCI_1_CS_1_BANK_SIZE                                =
0xd88=0A=
+#define MV64340_PCI_0_CS_2_BANK_SIZE                                =
0xc0c=0A=
+#define MV64340_PCI_1_CS_2_BANK_SIZE                                =
0xc8c=0A=
+#define MV64340_PCI_0_CS_3_BANK_SIZE                                =
0xd0c=0A=
+#define MV64340_PCI_1_CS_3_BANK_SIZE                                =
0xd8c=0A=
+#define MV64340_PCI_0_DEVCS_0_BANK_SIZE                             =
0xc10=0A=
+#define MV64340_PCI_1_DEVCS_0_BANK_SIZE                             =
0xc90=0A=
+#define MV64340_PCI_0_DEVCS_1_BANK_SIZE                             =
0xd10=0A=
+#define MV64340_PCI_1_DEVCS_1_BANK_SIZE                             =
0xd90=0A=
+#define MV64340_PCI_0_DEVCS_2_BANK_SIZE                             =
0xd18=0A=
+#define MV64340_PCI_1_DEVCS_2_BANK_SIZE                             =
0xd98=0A=
+#define MV64340_PCI_0_DEVCS_3_BANK_SIZE                             =
0xc14=0A=
+#define MV64340_PCI_1_DEVCS_3_BANK_SIZE                             =
0xc94=0A=
+#define MV64340_PCI_0_DEVCS_BOOT_BANK_SIZE                          =
0xd14=0A=
+#define MV64340_PCI_1_DEVCS_BOOT_BANK_SIZE                          =
0xd94=0A=
+#define MV64340_PCI_0_P2P_MEM0_BAR_SIZE                             =
0xd1c=0A=
+#define MV64340_PCI_1_P2P_MEM0_BAR_SIZE                             =
0xd9c=0A=
+#define MV64340_PCI_0_P2P_MEM1_BAR_SIZE                             =
0xd20=0A=
+#define MV64340_PCI_1_P2P_MEM1_BAR_SIZE                             =
0xda0=0A=
+#define MV64340_PCI_0_P2P_I_O_BAR_SIZE                              =
0xd24=0A=
+#define MV64340_PCI_1_P2P_I_O_BAR_SIZE                              =
0xda4=0A=
+#define MV64340_PCI_0_CPU_BAR_SIZE                                  =
0xd28=0A=
+#define MV64340_PCI_1_CPU_BAR_SIZE                                  =
0xda8=0A=
+#define MV64340_PCI_0_INTERNAL_SRAM_BAR_SIZE                        =
0xe00=0A=
+#define MV64340_PCI_1_INTERNAL_SRAM_BAR_SIZE                        =
0xe80=0A=
+#define MV64340_PCI_0_EXPANSION_ROM_BAR_SIZE                        =
0xd2c=0A=
+#define MV64340_PCI_1_EXPANSION_ROM_BAR_SIZE                        =
0xd9c=0A=
+#define MV64340_PCI_0_BASE_ADDR_REG_ENABLE                          =
0xc3c=0A=
+#define MV64340_PCI_1_BASE_ADDR_REG_ENABLE                          =
0xcbc=0A=
+#define MV64340_PCI_0_CS_0_BASE_ADDR_REMAP			    0xc48=0A=
+#define MV64340_PCI_1_CS_0_BASE_ADDR_REMAP			    0xcc8=0A=
+#define MV64340_PCI_0_CS_1_BASE_ADDR_REMAP			    0xd48=0A=
+#define MV64340_PCI_1_CS_1_BASE_ADDR_REMAP			    0xdc8=0A=
+#define MV64340_PCI_0_CS_2_BASE_ADDR_REMAP			    0xc4c=0A=
+#define MV64340_PCI_1_CS_2_BASE_ADDR_REMAP			    0xccc=0A=
+#define MV64340_PCI_0_CS_3_BASE_ADDR_REMAP			    0xd4c=0A=
+#define MV64340_PCI_1_CS_3_BASE_ADDR_REMAP			    0xdcc=0A=
+#define MV64340_PCI_0_CS_0_BASE_HIGH_ADDR_REMAP			    0xF04=0A=
+#define MV64340_PCI_1_CS_0_BASE_HIGH_ADDR_REMAP			    0xF84=0A=
+#define MV64340_PCI_0_CS_1_BASE_HIGH_ADDR_REMAP			    0xF08=0A=
+#define MV64340_PCI_1_CS_1_BASE_HIGH_ADDR_REMAP			    0xF88=0A=
+#define MV64340_PCI_0_CS_2_BASE_HIGH_ADDR_REMAP			    0xF0C=0A=
+#define MV64340_PCI_1_CS_2_BASE_HIGH_ADDR_REMAP			    0xF8C=0A=
+#define MV64340_PCI_0_CS_3_BASE_HIGH_ADDR_REMAP			    0xF10=0A=
+#define MV64340_PCI_1_CS_3_BASE_HIGH_ADDR_REMAP			    0xF90=0A=
+#define MV64340_PCI_0_DEVCS_0_BASE_ADDR_REMAP			    0xc50=0A=
+#define MV64340_PCI_1_DEVCS_0_BASE_ADDR_REMAP			    0xcd0=0A=
+#define MV64340_PCI_0_DEVCS_1_BASE_ADDR_REMAP			    0xd50=0A=
+#define MV64340_PCI_1_DEVCS_1_BASE_ADDR_REMAP			    0xdd0=0A=
+#define MV64340_PCI_0_DEVCS_2_BASE_ADDR_REMAP			    0xd58=0A=
+#define MV64340_PCI_1_DEVCS_2_BASE_ADDR_REMAP			    0xdd8=0A=
+#define MV64340_PCI_0_DEVCS_3_BASE_ADDR_REMAP           	    0xc54=0A=
+#define MV64340_PCI_1_DEVCS_3_BASE_ADDR_REMAP           	    0xcd4=0A=
+#define MV64340_PCI_0_DEVCS_BOOTCS_BASE_ADDR_REMAP      	    0xd54=0A=
+#define MV64340_PCI_1_DEVCS_BOOTCS_BASE_ADDR_REMAP      	    0xdd4=0A=
+#define MV64340_PCI_0_P2P_MEM0_BASE_ADDR_REMAP_LOW                  =
0xd5c=0A=
+#define MV64340_PCI_1_P2P_MEM0_BASE_ADDR_REMAP_LOW                  =
0xddc=0A=
+#define MV64340_PCI_0_P2P_MEM0_BASE_ADDR_REMAP_HIGH                 =
0xd60=0A=
+#define MV64340_PCI_1_P2P_MEM0_BASE_ADDR_REMAP_HIGH                 =
0xde0=0A=
+#define MV64340_PCI_0_P2P_MEM1_BASE_ADDR_REMAP_LOW                  =
0xd64=0A=
+#define MV64340_PCI_1_P2P_MEM1_BASE_ADDR_REMAP_LOW                  =
0xde4=0A=
+#define MV64340_PCI_0_P2P_MEM1_BASE_ADDR_REMAP_HIGH                 =
0xd68=0A=
+#define MV64340_PCI_1_P2P_MEM1_BASE_ADDR_REMAP_HIGH                 =
0xde8=0A=
+#define MV64340_PCI_0_P2P_I_O_BASE_ADDR_REMAP                       =
0xd6c=0A=
+#define MV64340_PCI_1_P2P_I_O_BASE_ADDR_REMAP                       =
0xdec =0A=
+#define MV64340_PCI_0_CPU_BASE_ADDR_REMAP_LOW                       =
0xd70=0A=
+#define MV64340_PCI_1_CPU_BASE_ADDR_REMAP_LOW                       =
0xdf0=0A=
+#define MV64340_PCI_0_CPU_BASE_ADDR_REMAP_HIGH                      =
0xd74=0A=
+#define MV64340_PCI_1_CPU_BASE_ADDR_REMAP_HIGH                      =
0xdf4=0A=
+#define MV64340_PCI_0_INTEGRATED_SRAM_BASE_ADDR_REMAP               =
0xf00=0A=
+#define MV64340_PCI_1_INTEGRATED_SRAM_BASE_ADDR_REMAP               =
0xf80=0A=
+#define MV64340_PCI_0_EXPANSION_ROM_BASE_ADDR_REMAP                 =
0xf38=0A=
+#define MV64340_PCI_1_EXPANSION_ROM_BASE_ADDR_REMAP                 =
0xfb8=0A=
+#define MV64340_PCI_0_ADDR_DECODE_CONTROL                           =
0xd3c=0A=
+#define MV64340_PCI_1_ADDR_DECODE_CONTROL                           =
0xdbc=0A=
+#define MV64340_PCI_0_HEADERS_RETARGET_CONTROL                      =
0xF40=0A=
+#define MV64340_PCI_1_HEADERS_RETARGET_CONTROL                      =
0xFc0=0A=
+#define MV64340_PCI_0_HEADERS_RETARGET_BASE                         =
0xF44=0A=
+#define MV64340_PCI_1_HEADERS_RETARGET_BASE                         =
0xFc4=0A=
+#define MV64340_PCI_0_HEADERS_RETARGET_HIGH                         =
0xF48=0A=
+#define MV64340_PCI_1_HEADERS_RETARGET_HIGH                         =
0xFc8=0A=
+=0A=
+/***********************************/=0A=
+/*   PCI Control Register Map      */=0A=
+/***********************************/=0A=
+=0A=
+#define MV64340_PCI_0_DLL_STATUS_AND_COMMAND                        =
0x1d20=0A=
+#define MV64340_PCI_1_DLL_STATUS_AND_COMMAND                        =
0x1da0=0A=
+#define MV64340_PCI_0_MPP_PADS_DRIVE_CONTROL                        =
0x1d1C=0A=
+#define MV64340_PCI_1_MPP_PADS_DRIVE_CONTROL                        =
0x1d9C=0A=
+#define MV64340_PCI_0_COMMAND			         	    0xc00=0A=
+#define MV64340_PCI_1_COMMAND					    0xc80=0A=
+#define MV64340_PCI_0_MODE                                          =
0xd00=0A=
+#define MV64340_PCI_1_MODE                                          =
0xd80=0A=
+#define MV64340_PCI_0_RETRY	        	 		    0xc04=0A=
+#define MV64340_PCI_1_RETRY				            0xc84=0A=
+#define MV64340_PCI_0_READ_BUFFER_DISCARD_TIMER                     =
0xd04=0A=
+#define MV64340_PCI_1_READ_BUFFER_DISCARD_TIMER                     =
0xd84=0A=
+#define MV64340_PCI_0_MSI_TRIGGER_TIMER                             =
0xc38=0A=
+#define MV64340_PCI_1_MSI_TRIGGER_TIMER                             =
0xcb8=0A=
+#define MV64340_PCI_0_ARBITER_CONTROL                               =
0x1d00=0A=
+#define MV64340_PCI_1_ARBITER_CONTROL                               =
0x1d80=0A=
+#define MV64340_PCI_0_CROSS_BAR_CONTROL_LOW                         =
0x1d08=0A=
+#define MV64340_PCI_1_CROSS_BAR_CONTROL_LOW                         =
0x1d88=0A=
+#define MV64340_PCI_0_CROSS_BAR_CONTROL_HIGH                        =
0x1d0c=0A=
+#define MV64340_PCI_1_CROSS_BAR_CONTROL_HIGH                        =
0x1d8c=0A=
+#define MV64340_PCI_0_CROSS_BAR_TIMEOUT                             =
0x1d04=0A=
+#define MV64340_PCI_1_CROSS_BAR_TIMEOUT                             =
0x1d84=0A=
+#define MV64340_PCI_0_SYNC_BARRIER_TRIGGER_REG                      =
0x1D18=0A=
+#define MV64340_PCI_1_SYNC_BARRIER_TRIGGER_REG                      =
0x1D98=0A=
+#define MV64340_PCI_0_SYNC_BARRIER_VIRTUAL_REG                      =
0x1d10=0A=
+#define MV64340_PCI_1_SYNC_BARRIER_VIRTUAL_REG                      =
0x1d90=0A=
+#define MV64340_PCI_0_P2P_CONFIG                                    =
0x1d14=0A=
+#define MV64340_PCI_1_P2P_CONFIG                                    =
0x1d94=0A=
+=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_0_LOW                     =
0x1e00=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_0_HIGH                    =
0x1e04=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_0                         =
0x1e08=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_1_LOW                     =
0x1e10=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_1_HIGH                    =
0x1e14=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_1                         =
0x1e18=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_2_LOW                     =
0x1e20=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_2_HIGH                    =
0x1e24=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_2                         =
0x1e28=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_3_LOW                     =
0x1e30=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_3_HIGH                    =
0x1e34=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_3                         =
0x1e38=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_4_LOW                     =
0x1e40=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_4_HIGH                    =
0x1e44=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_4                         =
0x1e48=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_5_LOW                     =
0x1e50=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_BASE_5_HIGH                    =
0x1e54=0A=
+#define MV64340_PCI_0_ACCESS_CONTROL_SIZE_5                         =
0x1e58=0A=
+=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_0_LOW                     =
0x1e80=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_0_HIGH                    =
0x1e84=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_0                         =
0x1e88=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_1_LOW                     =
0x1e90=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_1_HIGH                    =
0x1e94=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_1                         =
0x1e98=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_2_LOW                     =
0x1ea0=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_2_HIGH                    =
0x1ea4=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_2                         =
0x1ea8=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_3_LOW                     =
0x1eb0=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_3_HIGH                    =
0x1eb4=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_3                         =
0x1eb8=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_4_LOW                     =
0x1ec0=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_4_HIGH                    =
0x1ec4=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_4                         =
0x1ec8=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_5_LOW                     =
0x1ed0=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_BASE_5_HIGH                    =
0x1ed4=0A=
+#define MV64340_PCI_1_ACCESS_CONTROL_SIZE_5                         =
0x1ed8=0A=
+=0A=
+/****************************************/=0A=
+/*   PCI Configuration Access Registers */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_PCI_0_CONFIG_ADDR 				    0xcf8=0A=
+#define MV64340_PCI_0_CONFIG_DATA_VIRTUAL_REG                       =
0xcfc=0A=
+#define MV64340_PCI_1_CONFIG_ADDR 				    0xc78=0A=
+#define MV64340_PCI_1_CONFIG_DATA_VIRTUAL_REG                       =
0xc7c=0A=
+#define MV64340_PCI_0_INTERRUPT_ACKNOWLEDGE_VIRTUAL_REG	            =
0xc34=0A=
+#define MV64340_PCI_1_INTERRUPT_ACKNOWLEDGE_VIRTUAL_REG	            =
0xcb4=0A=
+=0A=
+/****************************************/=0A=
+/*   PCI Error Report Registers         */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_PCI_0_SERR_MASK					    0xc28=0A=
+#define MV64340_PCI_1_SERR_MASK					    0xca8=0A=
+#define MV64340_PCI_0_ERROR_ADDR_LOW                                =
0x1d40=0A=
+#define MV64340_PCI_1_ERROR_ADDR_LOW                                =
0x1dc0=0A=
+#define MV64340_PCI_0_ERROR_ADDR_HIGH                               =
0x1d44=0A=
+#define MV64340_PCI_1_ERROR_ADDR_HIGH                               =
0x1dc4=0A=
+#define MV64340_PCI_0_ERROR_ATTRIBUTE                               =
0x1d48=0A=
+#define MV64340_PCI_1_ERROR_ATTRIBUTE                               =
0x1dc8=0A=
+#define MV64340_PCI_0_ERROR_COMMAND                                 =
0x1d50=0A=
+#define MV64340_PCI_1_ERROR_COMMAND                                 =
0x1dd0=0A=
+#define MV64340_PCI_0_ERROR_CAUSE                                   =
0x1d58=0A=
+#define MV64340_PCI_1_ERROR_CAUSE                                   =
0x1dd8=0A=
+#define MV64340_PCI_0_ERROR_MASK                                    =
0x1d5c=0A=
+#define MV64340_PCI_1_ERROR_MASK                                    =
0x1ddc=0A=
+=0A=
+/****************************************/=0A=
+/*   PCI Debug Registers                */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_PCI_0_MMASK                                         =
0X1D24=0A=
+#define MV64340_PCI_1_MMASK                                         =
0X1DA4=0A=
+=0A=
+/*********************************************/=0A=
+/* PCI Configuration, Function 0, Registers  */=0A=
+/*********************************************/=0A=
+=0A=
+#define MV64340_PCI_DEVICE_AND_VENDOR_ID 			    0x000=0A=
+#define MV64340_PCI_STATUS_AND_COMMAND				    0x004=0A=
+#define MV64340_PCI_CLASS_CODE_AND_REVISION_ID			    0x008=0A=
+#define MV64340_PCI_BIST_HEADER_TYPE_LATENCY_TIMER_CACHE_LINE 	    0x00C=0A=
+=0A=
+#define MV64340_PCI_SCS_0_BASE_ADDR_LOW   	      		    0x010=0A=
+#define MV64340_PCI_SCS_0_BASE_ADDR_HIGH   		            0x014=0A=
+#define MV64340_PCI_SCS_1_BASE_ADDR_LOW  	     	            0x018=0A=
+#define MV64340_PCI_SCS_1_BASE_ADDR_HIGH 		            0x01C=0A=
+#define MV64340_PCI_INTERNAL_REG_MEM_MAPPED_BASE_ADDR_LOW      	    =
0x020=0A=
+#define MV64340_PCI_INTERNAL_REG_MEM_MAPPED_BASE_ADDR_HIGH     	    =
0x024=0A=
+#define MV64340_PCI_SUBSYSTEM_ID_AND_SUBSYSTEM_VENDOR_ID	    0x02c=0A=
+#define MV64340_PCI_EXPANSION_ROM_BASE_ADDR_REG	                    =
0x030=0A=
+#define MV64340_PCI_CAPABILTY_LIST_POINTER                          =
0x034=0A=
+#define MV64340_PCI_INTERRUPT_PIN_AND_LINE 			    0x03C=0A=
+       /* capability list */=0A=
+#define MV64340_PCI_POWER_MANAGEMENT_CAPABILITY                     =
0x040=0A=
+#define MV64340_PCI_POWER_MANAGEMENT_STATUS_AND_CONTROL             =
0x044=0A=
+#define MV64340_PCI_VPD_ADDR                                        =
0x048=0A=
+#define MV64340_PCI_VPD_DATA                                        =
0x04c=0A=
+#define MV64340_PCI_MSI_MESSAGE_CONTROL                             =
0x050=0A=
+#define MV64340_PCI_MSI_MESSAGE_ADDR                                =
0x054=0A=
+#define MV64340_PCI_MSI_MESSAGE_UPPER_ADDR                          =
0x058=0A=
+#define MV64340_PCI_MSI_MESSAGE_DATA                                =
0x05c=0A=
+#define MV64340_PCI_X_COMMAND                                       =
0x060=0A=
+#define MV64340_PCI_X_STATUS                                        =
0x064=0A=
+#define MV64340_PCI_COMPACT_PCI_HOT_SWAP                            =
0x068=0A=
+=0A=
+/***********************************************/=0A=
+/*   PCI Configuration, Function 1, Registers  */=0A=
+/***********************************************/=0A=
+=0A=
+#define MV64340_PCI_SCS_2_BASE_ADDR_LOW   			    0x110=0A=
+#define MV64340_PCI_SCS_2_BASE_ADDR_HIGH			    0x114=0A=
+#define MV64340_PCI_SCS_3_BASE_ADDR_LOW 			    0x118=0A=
+#define MV64340_PCI_SCS_3_BASE_ADDR_HIGH			    0x11c=0A=
+#define MV64340_PCI_INTERNAL_SRAM_BASE_ADDR_LOW          	    0x120=0A=
+#define MV64340_PCI_INTERNAL_SRAM_BASE_ADDR_HIGH         	    0x124=0A=
+=0A=
+/***********************************************/=0A=
+/*  PCI Configuration, Function 2, Registers   */=0A=
+/***********************************************/=0A=
+=0A=
+#define MV64340_PCI_DEVCS_0_BASE_ADDR_LOW	    		    0x210=0A=
+#define MV64340_PCI_DEVCS_0_BASE_ADDR_HIGH 			    0x214=0A=
+#define MV64340_PCI_DEVCS_1_BASE_ADDR_LOW 			    0x218=0A=
+#define MV64340_PCI_DEVCS_1_BASE_ADDR_HIGH      		    0x21c=0A=
+#define MV64340_PCI_DEVCS_2_BASE_ADDR_LOW 			    0x220=0A=
+#define MV64340_PCI_DEVCS_2_BASE_ADDR_HIGH      		    0x224=0A=
+=0A=
+/***********************************************/=0A=
+/*  PCI Configuration, Function 3, Registers   */=0A=
+/***********************************************/=0A=
+=0A=
+#define MV64340_PCI_DEVCS_3_BASE_ADDR_LOW	    		    0x310=0A=
+#define MV64340_PCI_DEVCS_3_BASE_ADDR_HIGH 			    0x314=0A=
+#define MV64340_PCI_BOOT_CS_BASE_ADDR_LOW			    0x318=0A=
+#define MV64340_PCI_BOOT_CS_BASE_ADDR_HIGH      		    0x31c=0A=
+#define MV64340_PCI_CPU_BASE_ADDR_LOW 				    0x220=0A=
+#define MV64340_PCI_CPU_BASE_ADDR_HIGH      			    0x224=0A=
+=0A=
+/***********************************************/=0A=
+/*  PCI Configuration, Function 4, Registers   */=0A=
+/***********************************************/=0A=
+=0A=
+#define MV64340_PCI_P2P_MEM0_BASE_ADDR_LOW  			    0x410=0A=
+#define MV64340_PCI_P2P_MEM0_BASE_ADDR_HIGH 			    0x414=0A=
+#define MV64340_PCI_P2P_MEM1_BASE_ADDR_LOW   			    0x418=0A=
+#define MV64340_PCI_P2P_MEM1_BASE_ADDR_HIGH 			    0x41c=0A=
+#define MV64340_PCI_P2P_I_O_BASE_ADDR                 	            0x420=0A=
+#define MV64340_PCI_INTERNAL_REGS_I_O_MAPPED_BASE_ADDR              =
0x424=0A=
+=0A=
+/****************************************/=0A=
+/* Messaging Unit Registers (I20)   	*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG0_PCI_0_SIDE		    0x010=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG1_PCI_0_SIDE  		    0x014=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG0_PCI_0_SIDE 		    0x018=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG1_PCI_0_SIDE  		    0x01C=0A=
+#define MV64340_I2O_INBOUND_DOORBELL_REG_PCI_0_SIDE  		    0x020=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_CAUSE_REG_PCI_0_SIDE          =
0x024=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_MASK_REG_PCI_0_SIDE	    0x028=0A=
+#define MV64340_I2O_OUTBOUND_DOORBELL_REG_PCI_0_SIDE 		    0x02C=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_CAUSE_REG_PCI_0_SIDE         =
0x030=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_MASK_REG_PCI_0_SIDE          =
0x034=0A=
+#define MV64340_I2O_INBOUND_QUEUE_PORT_VIRTUAL_REG_PCI_0_SIDE       =
0x040=0A=
+#define MV64340_I2O_OUTBOUND_QUEUE_PORT_VIRTUAL_REG_PCI_0_SIDE      =
0x044=0A=
+#define MV64340_I2O_QUEUE_CONTROL_REG_PCI_0_SIDE 		    0x050=0A=
+#define MV64340_I2O_QUEUE_BASE_ADDR_REG_PCI_0_SIDE 		    0x054=0A=
+#define MV64340_I2O_INBOUND_FREE_HEAD_POINTER_REG_PCI_0_SIDE        =
0x060=0A=
+#define MV64340_I2O_INBOUND_FREE_TAIL_POINTER_REG_PCI_0_SIDE        =
0x064=0A=
+#define MV64340_I2O_INBOUND_POST_HEAD_POINTER_REG_PCI_0_SIDE        =
0x068=0A=
+#define MV64340_I2O_INBOUND_POST_TAIL_POINTER_REG_PCI_0_SIDE        =
0x06C=0A=
+#define MV64340_I2O_OUTBOUND_FREE_HEAD_POINTER_REG_PCI_0_SIDE       =
0x070=0A=
+#define MV64340_I2O_OUTBOUND_FREE_TAIL_POINTER_REG_PCI_0_SIDE       =
0x074=0A=
+#define MV64340_I2O_OUTBOUND_POST_HEAD_POINTER_REG_PCI_0_SIDE       =
0x0F8=0A=
+#define MV64340_I2O_OUTBOUND_POST_TAIL_POINTER_REG_PCI_0_SIDE       =
0x0FC=0A=
+=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG0_PCI_1_SIDE		    0x090=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG1_PCI_1_SIDE  		    0x094=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG0_PCI_1_SIDE 		    0x098=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG1_PCI_1_SIDE  		    0x09C=0A=
+#define MV64340_I2O_INBOUND_DOORBELL_REG_PCI_1_SIDE  		    0x0A0=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_CAUSE_REG_PCI_1_SIDE          =
0x0A4=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_MASK_REG_PCI_1_SIDE	    0x0A8=0A=
+#define MV64340_I2O_OUTBOUND_DOORBELL_REG_PCI_1_SIDE 		    0x0AC=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_CAUSE_REG_PCI_1_SIDE         =
0x0B0=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_MASK_REG_PCI_1_SIDE          =
0x0B4=0A=
+#define MV64340_I2O_INBOUND_QUEUE_PORT_VIRTUAL_REG_PCI_1_SIDE       =
0x0C0=0A=
+#define MV64340_I2O_OUTBOUND_QUEUE_PORT_VIRTUAL_REG_PCI_1_SIDE      =
0x0C4=0A=
+#define MV64340_I2O_QUEUE_CONTROL_REG_PCI_1_SIDE 		    0x0D0=0A=
+#define MV64340_I2O_QUEUE_BASE_ADDR_REG_PCI_1_SIDE 		    0x0D4=0A=
+#define MV64340_I2O_INBOUND_FREE_HEAD_POINTER_REG_PCI_1_SIDE        =
0x0E0=0A=
+#define MV64340_I2O_INBOUND_FREE_TAIL_POINTER_REG_PCI_1_SIDE        =
0x0E4=0A=
+#define MV64340_I2O_INBOUND_POST_HEAD_POINTER_REG_PCI_1_SIDE        =
0x0E8=0A=
+#define MV64340_I2O_INBOUND_POST_TAIL_POINTER_REG_PCI_1_SIDE        =
0x0EC=0A=
+#define MV64340_I2O_OUTBOUND_FREE_HEAD_POINTER_REG_PCI_1_SIDE       =
0x0F0=0A=
+#define MV64340_I2O_OUTBOUND_FREE_TAIL_POINTER_REG_PCI_1_SIDE       =
0x0F4=0A=
+#define MV64340_I2O_OUTBOUND_POST_HEAD_POINTER_REG_PCI_1_SIDE       =
0x078=0A=
+#define MV64340_I2O_OUTBOUND_POST_TAIL_POINTER_REG_PCI_1_SIDE       =
0x07C=0A=
+=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG0_CPU0_SIDE		    0x1C10=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG1_CPU0_SIDE  		    0x1C14=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG0_CPU0_SIDE 		    0x1C18=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG1_CPU0_SIDE  		    0x1C1C=0A=
+#define MV64340_I2O_INBOUND_DOORBELL_REG_CPU0_SIDE  		    0x1C20=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_CAUSE_REG_CPU0_SIDE  	    0x1C24=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_MASK_REG_CPU0_SIDE	    0x1C28=0A=
+#define MV64340_I2O_OUTBOUND_DOORBELL_REG_CPU0_SIDE 		    0x1C2C=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_CAUSE_REG_CPU0_SIDE          =
0x1C30=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_MASK_REG_CPU0_SIDE           =
0x1C34=0A=
+#define MV64340_I2O_INBOUND_QUEUE_PORT_VIRTUAL_REG_CPU0_SIDE        =
0x1C40=0A=
+#define MV64340_I2O_OUTBOUND_QUEUE_PORT_VIRTUAL_REG_CPU0_SIDE       =
0x1C44=0A=
+#define MV64340_I2O_QUEUE_CONTROL_REG_CPU0_SIDE 		    0x1C50=0A=
+#define MV64340_I2O_QUEUE_BASE_ADDR_REG_CPU0_SIDE 		    0x1C54=0A=
+#define MV64340_I2O_INBOUND_FREE_HEAD_POINTER_REG_CPU0_SIDE         =
0x1C60=0A=
+#define MV64340_I2O_INBOUND_FREE_TAIL_POINTER_REG_CPU0_SIDE         =
0x1C64=0A=
+#define MV64340_I2O_INBOUND_POST_HEAD_POINTER_REG_CPU0_SIDE         =
0x1C68=0A=
+#define MV64340_I2O_INBOUND_POST_TAIL_POINTER_REG_CPU0_SIDE         =
0x1C6C=0A=
+#define MV64340_I2O_OUTBOUND_FREE_HEAD_POINTER_REG_CPU0_SIDE        =
0x1C70=0A=
+#define MV64340_I2O_OUTBOUND_FREE_TAIL_POINTER_REG_CPU0_SIDE        =
0x1C74=0A=
+#define MV64340_I2O_OUTBOUND_POST_HEAD_POINTER_REG_CPU0_SIDE        =
0x1CF8=0A=
+#define MV64340_I2O_OUTBOUND_POST_TAIL_POINTER_REG_CPU0_SIDE        =
0x1CFC=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG0_CPU1_SIDE		    0x1C90=0A=
+#define MV64340_I2O_INBOUND_MESSAGE_REG1_CPU1_SIDE  		    0x1C94=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG0_CPU1_SIDE 		    0x1C98=0A=
+#define MV64340_I2O_OUTBOUND_MESSAGE_REG1_CPU1_SIDE  		    0x1C9C=0A=
+#define MV64340_I2O_INBOUND_DOORBELL_REG_CPU1_SIDE  		    0x1CA0=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_CAUSE_REG_CPU1_SIDE  	    0x1CA4=0A=
+#define MV64340_I2O_INBOUND_INTERRUPT_MASK_REG_CPU1_SIDE	    0x1CA8=0A=
+#define MV64340_I2O_OUTBOUND_DOORBELL_REG_CPU1_SIDE 		    0x1CAC=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_CAUSE_REG_CPU1_SIDE          =
0x1CB0=0A=
+#define MV64340_I2O_OUTBOUND_INTERRUPT_MASK_REG_CPU1_SIDE           =
0x1CB4=0A=
+#define MV64340_I2O_INBOUND_QUEUE_PORT_VIRTUAL_REG_CPU1_SIDE        =
0x1CC0=0A=
+#define MV64340_I2O_OUTBOUND_QUEUE_PORT_VIRTUAL_REG_CPU1_SIDE       =
0x1CC4=0A=
+#define MV64340_I2O_QUEUE_CONTROL_REG_CPU1_SIDE 		    0x1CD0=0A=
+#define MV64340_I2O_QUEUE_BASE_ADDR_REG_CPU1_SIDE 		    0x1CD4=0A=
+#define MV64340_I2O_INBOUND_FREE_HEAD_POINTER_REG_CPU1_SIDE         =
0x1CE0=0A=
+#define MV64340_I2O_INBOUND_FREE_TAIL_POINTER_REG_CPU1_SIDE         =
0x1CE4=0A=
+#define MV64340_I2O_INBOUND_POST_HEAD_POINTER_REG_CPU1_SIDE         =
0x1CE8=0A=
+#define MV64340_I2O_INBOUND_POST_TAIL_POINTER_REG_CPU1_SIDE         =
0x1CEC=0A=
+#define MV64340_I2O_OUTBOUND_FREE_HEAD_POINTER_REG_CPU1_SIDE        =
0x1CF0=0A=
+#define MV64340_I2O_OUTBOUND_FREE_TAIL_POINTER_REG_CPU1_SIDE        =
0x1CF4=0A=
+#define MV64340_I2O_OUTBOUND_POST_HEAD_POINTER_REG_CPU1_SIDE        =
0x1C78=0A=
+#define MV64340_I2O_OUTBOUND_POST_TAIL_POINTER_REG_CPU1_SIDE        =
0x1C7C=0A=
+=0A=
+/****************************************/=0A=
+/*        Ethernet Unit Registers  		*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_ETH_PHY_ADDR_REG                                    =
0x2000=0A=
+#define MV64340_ETH_SMI_REG                                         =
0x2004=0A=
+#define MV64340_ETH_UNIT_DEFAULT_ADDR_REG                           =
0x2008=0A=
+#define MV64340_ETH_UNIT_DEFAULTID_REG                              =
0x200c=0A=
+#define MV64340_ETH_UNIT_INTERRUPT_CAUSE_REG                        =
0x2080=0A=
+#define MV64340_ETH_UNIT_INTERRUPT_MASK_REG                         =
0x2084=0A=
+#define MV64340_ETH_UNIT_INTERNAL_USE_REG                           =
0x24fc=0A=
+#define MV64340_ETH_UNIT_ERROR_ADDR_REG                             =
0x2094=0A=
+#define MV64340_ETH_BAR_0                                           =
0x2200=0A=
+#define MV64340_ETH_BAR_1                                           =
0x2208=0A=
+#define MV64340_ETH_BAR_2                                           =
0x2210=0A=
+#define MV64340_ETH_BAR_3                                           =
0x2218=0A=
+#define MV64340_ETH_BAR_4                                           =
0x2220=0A=
+#define MV64340_ETH_BAR_5                                           =
0x2228=0A=
+#define MV64340_ETH_SIZE_REG_0                                      =
0x2204=0A=
+#define MV64340_ETH_SIZE_REG_1                                      =
0x220c=0A=
+#define MV64340_ETH_SIZE_REG_2                                      =
0x2214=0A=
+#define MV64340_ETH_SIZE_REG_3                                      =
0x221c=0A=
+#define MV64340_ETH_SIZE_REG_4                                      =
0x2224=0A=
+#define MV64340_ETH_SIZE_REG_5                                      =
0x222c=0A=
+#define MV64340_ETH_HEADERS_RETARGET_BASE_REG                       =
0x2230=0A=
+#define MV64340_ETH_HEADERS_RETARGET_CONTROL_REG                    =
0x2234=0A=
+#define MV64340_ETH_HIGH_ADDR_REMAP_REG_0                           =
0x2280=0A=
+#define MV64340_ETH_HIGH_ADDR_REMAP_REG_1                           =
0x2284=0A=
+#define MV64340_ETH_HIGH_ADDR_REMAP_REG_2                           =
0x2288=0A=
+#define MV64340_ETH_HIGH_ADDR_REMAP_REG_3                           =
0x228c=0A=
+#define MV64340_ETH_BASE_ADDR_ENABLE_REG                            =
0x2290=0A=
+#define MV64340_ETH_ACCESS_PROTECTION_REG(port)                    =
(0x2294 + (port<<2))=0A=
+#define MV64340_ETH_MIB_COUNTERS_BASE(port)                        =
(0x3000 + (port<<7))=0A=
+#define MV64340_ETH_PORT_CONFIG_REG(port)                          =
(0x2400 + (port<<10))=0A=
+#define MV64340_ETH_PORT_CONFIG_EXTEND_REG(port)                   =
(0x2404 + (port<<10))=0A=
+#define MV64340_ETH_MII_SERIAL_PARAMETRS_REG(port)                 =
(0x2408 + (port<<10))=0A=
+#define MV64340_ETH_GMII_SERIAL_PARAMETRS_REG(port)                =
(0x240c + (port<<10))=0A=
+#define MV64340_ETH_VLAN_ETHERTYPE_REG(port)                       =
(0x2410 + (port<<10))=0A=
+#define MV64340_ETH_MAC_ADDR_LOW(port)                             =
(0x2414 + (port<<10))=0A=
+#define MV64340_ETH_MAC_ADDR_HIGH(port)                            =
(0x2418 + (port<<10))=0A=
+#define MV64340_ETH_SDMA_CONFIG_REG(port)                          =
(0x241c + (port<<10))=0A=
+#define MV64340_ETH_DSCP_0(port)                                   =
(0x2420 + (port<<10))=0A=
+#define MV64340_ETH_DSCP_1(port)                                   =
(0x2424 + (port<<10))=0A=
+#define MV64340_ETH_DSCP_2(port)                                   =
(0x2428 + (port<<10))=0A=
+#define MV64340_ETH_DSCP_3(port)                                   =
(0x242c + (port<<10))=0A=
+#define MV64340_ETH_DSCP_4(port)                                   =
(0x2430 + (port<<10))=0A=
+#define MV64340_ETH_DSCP_5(port)                                   =
(0x2434 + (port<<10))=0A=
+#define MV64340_ETH_DSCP_6(port)                                   =
(0x2438 + (port<<10))=0A=
+#define MV64340_ETH_PORT_SERIAL_CONTROL_REG(port)                  =
(0x243c + (port<<10))=0A=
+#define MV64340_ETH_VLAN_PRIORITY_TAG_TO_PRIORITY(port)            =
(0x2440 + (port<<10))=0A=
+#define MV64340_ETH_PORT_STATUS_REG(port)                          =
(0x2444 + (port<<10))=0A=
+#define MV64340_ETH_TRANSMIT_QUEUE_COMMAND_REG(port)               =
(0x2448 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_FIXED_PRIORITY(port)                  =
(0x244c + (port<<10))=0A=
+#define MV64340_ETH_PORT_TX_TOKEN_BUCKET_RATE_CONFIG(port)         =
(0x2450 + (port<<10))=0A=
+#define MV64340_ETH_MAXIMUM_TRANSMIT_UNIT(port)                    =
(0x2458 + (port<<10))=0A=
+#define MV64340_ETH_PORT_MAXIMUM_TOKEN_BUCKET_SIZE(port)           =
(0x245c + (port<<10))=0A=
+#define MV64340_ETH_INTERRUPT_CAUSE_REG(port)                      =
(0x2460 + (port<<10))=0A=
+#define MV64340_ETH_INTERRUPT_CAUSE_EXTEND_REG(port)               =
(0x2464 + (port<<10))=0A=
+#define MV64340_ETH_INTERRUPT_MASK_REG(port)                       =
(0x2468 + (port<<10))=0A=
+#define MV64340_ETH_INTERRUPT_EXTEND_MASK_REG(port)                =
(0x246c + (port<<10))=0A=
+#define MV64340_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             =
(0x2470 + (port<<10))=0A=
+#define MV64340_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             =
(0x2474 + (port<<10))=0A=
+#define MV64340_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                =
(0x247c + (port<<10))=0A=
+#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              =
(0x2484 + (port<<10)=0A=
+#define MV64340_ETH_PORT_DEBUG_0_REG(port)                         =
(0x248c + (port<<10))=0A=
+#define MV64340_ETH_PORT_DEBUG_1_REG(port)                         =
(0x2490 + (port<<10))=0A=
+#define MV64340_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             =
(0x2494 + (port<<10))=0A=
+#define MV64340_ETH_INTERNAL_USE_REG(port)                         =
(0x24fc + (port<<10))=0A=
+#define MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port)                =
(0x2680 + (port<<10))=0A=
+#define MV64340_ETH_CURRENT_SERVED_TX_DESC_PTR(port)               =
(0x2684 + (port<<10))      =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_0(port)              =
(0x260c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_1(port)              =
(0x261c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_2(port)              =
(0x262c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_3(port)              =
(0x263c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_4(port)              =
(0x264c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_5(port)              =
(0x265c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_6(port)              =
(0x266c + (port<<10))     =0A=
+#define MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_7(port)              =
(0x267c + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_0(port)              =
(0x26c0 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_1(port)              =
(0x26c4 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_2(port)              =
(0x26c8 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_3(port)              =
(0x26cc + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_4(port)              =
(0x26d0 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_5(port)              =
(0x26d4 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_6(port)              =
(0x26d8 + (port<<10))     =0A=
+#define MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_7(port)              =
(0x26dc + (port<<10))     =0A=
+#define MV64340_ETH_TX_QUEUE_0_TOKEN_BUCKET_COUNT(port)            =
(0x2700 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_1_TOKEN_BUCKET_COUNT(port)            =
(0x2710 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_2_TOKEN_BUCKET_COUNT(port)            =
(0x2720 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_3_TOKEN_BUCKET_COUNT(port)            =
(0x2730 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_4_TOKEN_BUCKET_COUNT(port)            =
(0x2740 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_5_TOKEN_BUCKET_COUNT(port)            =
(0x2750 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_6_TOKEN_BUCKET_COUNT(port)            =
(0x2760 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_7_TOKEN_BUCKET_COUNT(port)            =
(0x2770 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_0_TOKEN_BUCKET_CONFIG(port)           =
(0x2704 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_1_TOKEN_BUCKET_CONFIG(port)           =
(0x2714 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_2_TOKEN_BUCKET_CONFIG(port)           =
(0x2724 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_3_TOKEN_BUCKET_CONFIG(port)           =
(0x2734 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_4_TOKEN_BUCKET_CONFIG(port)           =
(0x2744 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_5_TOKEN_BUCKET_CONFIG(port)           =
(0x2754 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_6_TOKEN_BUCKET_CONFIG(port)           =
(0x2764 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_7_TOKEN_BUCKET_CONFIG(port)           =
(0x2774 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_0_ARBITER_CONFIG(port)                =
(0x2708 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_1_ARBITER_CONFIG(port)                =
(0x2718 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_2_ARBITER_CONFIG(port)                =
(0x2728 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_3_ARBITER_CONFIG(port)                =
(0x2738 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_4_ARBITER_CONFIG(port)                =
(0x2748 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_5_ARBITER_CONFIG(port)                =
(0x2758 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_6_ARBITER_CONFIG(port)                =
(0x2768 + (port<<10))=0A=
+#define MV64340_ETH_TX_QUEUE_7_ARBITER_CONFIG(port)                =
(0x2778 + (port<<10))=0A=
+#define MV64340_ETH_PORT_TX_TOKEN_BUCKET_COUNT(port)               =
(0x2780 + (port<<10))=0A=
+#define MV64340_ETH_DA_FILTER_SPECIAL_MULTICAST_TABLE_BASE(port)   =
(0x3400 + (port<<10))=0A=
+#define MV64340_ETH_DA_FILTER_OTHER_MULTICAST_TABLE_BASE(port)     =
(0x3500 + (port<<10))=0A=
+#define MV64340_ETH_DA_FILTER_UNICAST_TABLE_BASE(port)             =
(0x3600 + (port<<10))=0A=
+=0A=
+/*******************************************/=0A=
+/*          CUNIT  Registers               */=0A=
+/*******************************************/=0A=
+=0A=
+         /* Address Decoding Register Map */=0A=
+           =0A=
+#define MV64340_CUNIT_BASE_ADDR_REG0                                =
0xf200=0A=
+#define MV64340_CUNIT_BASE_ADDR_REG1                                =
0xf208=0A=
+#define MV64340_CUNIT_BASE_ADDR_REG2                                =
0xf210=0A=
+#define MV64340_CUNIT_BASE_ADDR_REG3                                =
0xf218=0A=
+#define MV64340_CUNIT_SIZE0                                         =
0xf204=0A=
+#define MV64340_CUNIT_SIZE1                                         =
0xf20c=0A=
+#define MV64340_CUNIT_SIZE2                                         =
0xf214=0A=
+#define MV64340_CUNIT_SIZE3                                         =
0xf21c=0A=
+#define MV64340_CUNIT_HIGH_ADDR_REMAP_REG0                          =
0xf240=0A=
+#define MV64340_CUNIT_HIGH_ADDR_REMAP_REG1                          =
0xf244=0A=
+#define MV64340_CUNIT_BASE_ADDR_ENABLE_REG                          =
0xf250=0A=
+#define MV64340_MPSC0_ACCESS_PROTECTION_REG                         =
0xf254=0A=
+#define MV64340_MPSC1_ACCESS_PROTECTION_REG                         =
0xf258=0A=
+#define MV64340_CUNIT_INTERNAL_SPACE_BASE_ADDR_REG                  =
0xf25C=0A=
+=0A=
+        /*  Error Report Registers  */=0A=
+=0A=
+#define MV64340_CUNIT_INTERRUPT_CAUSE_REG                           =
0xf310=0A=
+#define MV64340_CUNIT_INTERRUPT_MASK_REG                            =
0xf314=0A=
+#define MV64340_CUNIT_ERROR_ADDR                                    =
0xf318=0A=
+=0A=
+        /*  Cunit Control Registers */=0A=
+=0A=
+#define MV64340_CUNIT_ARBITER_CONTROL_REG                           =
0xf300=0A=
+#define MV64340_CUNIT_CONFIG_REG                                    =
0xb40c=0A=
+#define MV64340_CUNIT_CRROSBAR_TIMEOUT_REG                          =
0xf304=0A=
+=0A=
+        /*  Cunit Debug Registers   */=0A=
+=0A=
+#define MV64340_CUNIT_DEBUG_LOW                                     =
0xf340=0A=
+#define MV64340_CUNIT_DEBUG_HIGH                                    =
0xf344=0A=
+#define MV64340_CUNIT_MMASK                                         =
0xf380=0A=
+=0A=
+        /*  MPSCs Clocks Routing Registers  */=0A=
+=0A=
+#define MV64340_MPSC_ROUTING_REG                                    =
0xb400=0A=
+#define MV64340_MPSC_RX_CLOCK_ROUTING_REG                           =
0xb404=0A=
+#define MV64340_MPSC_TX_CLOCK_ROUTING_REG                           =
0xb408=0A=
+=0A=
+        /*  MPSCs Interrupts Registers    */=0A=
+=0A=
+#define MV64340_MPSC_CAUSE_REG(port)                               =
(0xb804 + (port<<3))=0A=
+#define MV64340_MPSC_MASK_REG(port)                                =
(0xb884 + (port<<3))=0A=
+ =0A=
+#define MV64340_MPSC_MAIN_CONFIG_LOW(port)                         =
(0x8000 + (port<<12))=0A=
+#define MV64340_MPSC_MAIN_CONFIG_HIGH(port)                        =
(0x8004 + (port<<12))    =0A=
+#define MV64340_MPSC_PROTOCOL_CONFIG(port)                         =
(0x8008 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG1(port)                            =
(0x800c + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG2(port)                            =
(0x8010 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG3(port)                            =
(0x8014 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG4(port)                            =
(0x8018 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG5(port)                            =
(0x801c + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG6(port)                            =
(0x8020 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG7(port)                            =
(0x8024 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG8(port)                            =
(0x8028 + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG9(port)                            =
(0x802c + (port<<12))    =0A=
+#define MV64340_MPSC_CHANNEL_REG10(port)                           =
(0x8030 + (port<<12))    =0A=
+        =0A=
+        /*  MPSC0 Registers      */=0A=
+=0A=
+=0A=
+/***************************************/=0A=
+/*          SDMA Registers             */=0A=
+/***************************************/=0A=
+=0A=
+#define MV64340_SDMA_CONFIG_REG(channel)                        (0x4000 =
+ (channel<<13))        =0A=
+#define MV64340_SDMA_COMMAND_REG(channel)                       (0x4008 =
+ (channel<<13))        =0A=
+#define MV64340_SDMA_CURRENT_RX_DESCRIPTOR_POINTER(channel)     (0x4810 =
+ (channel<<13))        =0A=
+#define MV64340_SDMA_CURRENT_TX_DESCRIPTOR_POINTER(channel)     (0x4c10 =
+ (channel<<13))        =0A=
+#define MV64340_SDMA_FIRST_TX_DESCRIPTOR_POINTER(channel)       (0x4c14 =
+ (channel<<13)) =0A=
+=0A=
+#define MV64340_SDMA_CAUSE_REG                                      =
0xb800=0A=
+#define MV64340_SDMA_MASK_REG                                       =
0xb880=0A=
+         =0A=
+/* BRG Interrupts */=0A=
+=0A=
+#define MV64340_BRG_CONFIG_REG(brg)                              =
(0xb200 + (brg<<3))=0A=
+#define MV64340_BRG_BAUDE_TUNING_REG(brg)                        =
(0xb208 + (brg<<3))=0A=
+#define MV64340_BRG_CAUSE_REG                                       =
0xb834=0A=
+#define MV64340_BRG_MASK_REG                                        =
0xb8b4=0A=
+=0A=
+/****************************************/=0A=
+/* DMA Channel Control			*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_DMA_CHANNEL0_CONTROL 				    0x840=0A=
+#define MV64340_DMA_CHANNEL0_CONTROL_HIGH			    0x880=0A=
+#define MV64340_DMA_CHANNEL1_CONTROL 				    0x844=0A=
+#define MV64340_DMA_CHANNEL1_CONTROL_HIGH			    0x884=0A=
+#define MV64340_DMA_CHANNEL2_CONTROL 				    0x848=0A=
+#define MV64340_DMA_CHANNEL2_CONTROL_HIGH			    0x888=0A=
+#define MV64340_DMA_CHANNEL3_CONTROL 				    0x84C=0A=
+#define MV64340_DMA_CHANNEL3_CONTROL_HIGH			    0x88C=0A=
+=0A=
+=0A=
+/****************************************/=0A=
+/*           IDMA Registers             */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_DMA_CHANNEL0_BYTE_COUNT                             =
0x800=0A=
+#define MV64340_DMA_CHANNEL1_BYTE_COUNT                             =
0x804=0A=
+#define MV64340_DMA_CHANNEL2_BYTE_COUNT                             =
0x808=0A=
+#define MV64340_DMA_CHANNEL3_BYTE_COUNT                             =
0x80C=0A=
+#define MV64340_DMA_CHANNEL0_SOURCE_ADDR                            =
0x810=0A=
+#define MV64340_DMA_CHANNEL1_SOURCE_ADDR                            =
0x814=0A=
+#define MV64340_DMA_CHANNEL2_SOURCE_ADDR                            =
0x818=0A=
+#define MV64340_DMA_CHANNEL3_SOURCE_ADDR                            =
0x81c=0A=
+#define MV64340_DMA_CHANNEL0_DESTINATION_ADDR                       =
0x820=0A=
+#define MV64340_DMA_CHANNEL1_DESTINATION_ADDR                       =
0x824=0A=
+#define MV64340_DMA_CHANNEL2_DESTINATION_ADDR                       =
0x828=0A=
+#define MV64340_DMA_CHANNEL3_DESTINATION_ADDR                       =
0x82C=0A=
+#define MV64340_DMA_CHANNEL0_NEXT_DESCRIPTOR_POINTER                =
0x830=0A=
+#define MV64340_DMA_CHANNEL1_NEXT_DESCRIPTOR_POINTER                =
0x834=0A=
+#define MV64340_DMA_CHANNEL2_NEXT_DESCRIPTOR_POINTER                =
0x838=0A=
+#define MV64340_DMA_CHANNEL3_NEXT_DESCRIPTOR_POINTER                =
0x83C=0A=
+#define MV64340_DMA_CHANNEL0_CURRENT_DESCRIPTOR_POINTER             =
0x870=0A=
+#define MV64340_DMA_CHANNEL1_CURRENT_DESCRIPTOR_POINTER             =
0x874=0A=
+#define MV64340_DMA_CHANNEL2_CURRENT_DESCRIPTOR_POINTER             =
0x878=0A=
+#define MV64340_DMA_CHANNEL3_CURRENT_DESCRIPTOR_POINTER             =
0x87C=0A=
+=0A=
+ /*  IDMA Address Decoding Base Address Registers  */=0A=
+ =0A=
+#define MV64340_DMA_BASE_ADDR_REG0                                  =
0xa00=0A=
+#define MV64340_DMA_BASE_ADDR_REG1                                  =
0xa08=0A=
+#define MV64340_DMA_BASE_ADDR_REG2                                  =
0xa10=0A=
+#define MV64340_DMA_BASE_ADDR_REG3                                  =
0xa18=0A=
+#define MV64340_DMA_BASE_ADDR_REG4                                  =
0xa20=0A=
+#define MV64340_DMA_BASE_ADDR_REG5                                  =
0xa28=0A=
+#define MV64340_DMA_BASE_ADDR_REG6                                  =
0xa30=0A=
+#define MV64340_DMA_BASE_ADDR_REG7                                  =
0xa38=0A=
+ =0A=
+ /*  IDMA Address Decoding Size Address Register   */=0A=
+ =0A=
+#define MV64340_DMA_SIZE_REG0                                       =
0xa04=0A=
+#define MV64340_DMA_SIZE_REG1                                       =
0xa0c=0A=
+#define MV64340_DMA_SIZE_REG2                                       =
0xa14=0A=
+#define MV64340_DMA_SIZE_REG3                                       =
0xa1c=0A=
+#define MV64340_DMA_SIZE_REG4                                       =
0xa24=0A=
+#define MV64340_DMA_SIZE_REG5                                       =
0xa2c=0A=
+#define MV64340_DMA_SIZE_REG6                                       =
0xa34=0A=
+#define MV64340_DMA_SIZE_REG7                                       =
0xa3C=0A=
+=0A=
+ /* IDMA Address Decoding High Address Remap and Access =0A=
+                  Protection Registers                    */=0A=
+                  =0A=
+#define MV64340_DMA_HIGH_ADDR_REMAP_REG0                            =
0xa60=0A=
+#define MV64340_DMA_HIGH_ADDR_REMAP_REG1                            =
0xa64=0A=
+#define MV64340_DMA_HIGH_ADDR_REMAP_REG2                            =
0xa68=0A=
+#define MV64340_DMA_HIGH_ADDR_REMAP_REG3                            =
0xa6C=0A=
+#define MV64340_DMA_BASE_ADDR_ENABLE_REG                            =
0xa80=0A=
+#define MV64340_DMA_CHANNEL0_ACCESS_PROTECTION_REG                  =
0xa70=0A=
+#define MV64340_DMA_CHANNEL1_ACCESS_PROTECTION_REG                  =
0xa74=0A=
+#define MV64340_DMA_CHANNEL2_ACCESS_PROTECTION_REG                  =
0xa78=0A=
+#define MV64340_DMA_CHANNEL3_ACCESS_PROTECTION_REG                  =
0xa7c=0A=
+#define MV64340_DMA_ARBITER_CONTROL                                 =
0x860=0A=
+#define MV64340_DMA_CROSS_BAR_TIMEOUT                               =
0x8d0=0A=
+=0A=
+ /*  IDMA Headers Retarget Registers   */=0A=
+=0A=
+#define MV64340_DMA_HEADERS_RETARGET_CONTROL                        =
0xa84=0A=
+#define MV64340_DMA_HEADERS_RETARGET_BASE                           =
0xa88=0A=
+=0A=
+ /*  IDMA Interrupt Register  */=0A=
+=0A=
+#define MV64340_DMA_INTERRUPT_CAUSE_REG                             =
0x8c0=0A=
+#define MV64340_DMA_INTERRUPT_CAUSE_MASK                            =
0x8c4=0A=
+#define MV64340_DMA_ERROR_ADDR                                      =
0x8c8=0A=
+#define MV64340_DMA_ERROR_SELECT                                    =
0x8cc=0A=
+=0A=
+ /*  IDMA Debug Register ( for internal use )    */=0A=
+=0A=
+#define MV64340_DMA_DEBUG_LOW                                       =
0x8e0=0A=
+#define MV64340_DMA_DEBUG_HIGH                                      =
0x8e4=0A=
+#define MV64340_DMA_SPARE                                           =
0xA8C=0A=
+=0A=
+/****************************************/=0A=
+/* Timer_Counter 			*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_TIMER_COUNTER0					    0x850=0A=
+#define MV64340_TIMER_COUNTER1					    0x854=0A=
+#define MV64340_TIMER_COUNTER2					    0x858=0A=
+#define MV64340_TIMER_COUNTER3					    0x85C=0A=
+#define MV64340_TIMER_COUNTER_0_3_CONTROL			    0x864=0A=
+#define MV64340_TIMER_COUNTER_0_3_INTERRUPT_CAUSE		    0x868=0A=
+#define MV64340_TIMER_COUNTER_0_3_INTERRUPT_MASK      		    0x86c=0A=
+=0A=
+/****************************************/=0A=
+/*         Watchdog registers  	        */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_WATCHDOG_CONFIG_REG                                 =
0xb410=0A=
+#define MV64340_WATCHDOG_VALUE_REG                                  =
0xb414=0A=
+=0A=
+/****************************************/=0A=
+/* I2C Registers                        */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_I2C_SLAVE_ADDR                                      =
0xc000=0A=
+#define MV64340_I2C_EXTENDED_SLAVE_ADDR                             =
0xc010=0A=
+#define MV64340_I2C_DATA                                            =
0xc004=0A=
+#define MV64340_I2C_CONTROL                                         =
0xc008=0A=
+#define MV64340_I2C_STATUS_BAUDE_RATE                               =
0xc00C=0A=
+#define MV64340_I2C_SOFT_RESET                                      =
0xc01c=0A=
+=0A=
+/****************************************/=0A=
+/* GPP Interface Registers              */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_GPP_IO_CONTROL                                      =
0xf100=0A=
+#define MV64340_GPP_LEVEL_CONTROL                                   =
0xf110=0A=
+#define MV64340_GPP_VALUE                                           =
0xf104=0A=
+#define MV64340_GPP_INTERRUPT_CAUSE                                 =
0xf108=0A=
+#define MV64340_GPP_INTERRUPT_MASK0                                 =
0xf10c=0A=
+#define MV64340_GPP_INTERRUPT_MASK1                                 =
0xf114=0A=
+#define MV64340_GPP_VALUE_SET                                       =
0xf118=0A=
+#define MV64340_GPP_VALUE_CLEAR                                     =
0xf11c=0A=
+=0A=
+/****************************************/=0A=
+/* Interrupt Controller Registers       */=0A=
+/****************************************/=0A=
+=0A=
+/****************************************/=0A=
+/* Interrupts	  			*/=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_MAIN_INTERRUPT_CAUSE_LOW                            =
0x004=0A=
+#define MV64340_MAIN_INTERRUPT_CAUSE_HIGH                           =
0x00c=0A=
+#define MV64340_CPU_INTERRUPT0_MASK_LOW                             =
0x014=0A=
+#define MV64340_CPU_INTERRUPT0_MASK_HIGH                            =
0x01c=0A=
+#define MV64340_CPU_INTERRUPT0_SELECT_CAUSE                         =
0x024=0A=
+#define MV64340_CPU_INTERRUPT1_MASK_LOW                             =
0x034=0A=
+#define MV64340_CPU_INTERRUPT1_MASK_HIGH                            =
0x03c=0A=
+#define MV64340_CPU_INTERRUPT1_SELECT_CAUSE                         =
0x044=0A=
+#define MV64340_INTERRUPT0_MASK_0_LOW                               =
0x054=0A=
+#define MV64340_INTERRUPT0_MASK_0_HIGH                              =
0x05c=0A=
+#define MV64340_INTERRUPT0_SELECT_CAUSE                             =
0x064=0A=
+#define MV64340_INTERRUPT1_MASK_0_LOW                               =
0x074=0A=
+#define MV64340_INTERRUPT1_MASK_0_HIGH                              =
0x07c=0A=
+#define MV64340_INTERRUPT1_SELECT_CAUSE                             =
0x084=0A=
+=0A=
+/****************************************/=0A=
+/*      MPP Interface Registers         */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_MPP_CONTROL0                                        =
0xf000=0A=
+#define MV64340_MPP_CONTROL1                                        =
0xf004=0A=
+#define MV64340_MPP_CONTROL2                                        =
0xf008=0A=
+#define MV64340_MPP_CONTROL3                                        =
0xf00c=0A=
+=0A=
+/****************************************/=0A=
+/*    Serial Initialization registers   */=0A=
+/****************************************/=0A=
+=0A=
+#define MV64340_SERIAL_INIT_LAST_DATA                               =
0xf324=0A=
+#define MV64340_SERIAL_INIT_CONTROL                                 =
0xf328=0A=
+#define MV64340_SERIAL_INIT_STATUS                                  =
0xf32c=0A=
+=0A=
+#endif=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ include/asm-mips/mv64340_dep.h	Fri Nov  8 14:56:08 2002=0A=
@@ -0,0 +1,51 @@=0A=
+/*=0A=
+ * Copyright 2002 Momentum Computer Inc.=0A=
+ * Author: Matthew Dharm <mdharm@momenco.com>=0A=
+ *=0A=
+ * include/asm-mips/mv64340-dep.h=0A=
+ *     Board-dependent definitions for MV-64340 chip.=0A=
+ *=0A=
+ * This program is free software; you can redistribute  it and/or =
modify it=0A=
+ * under  the terms of  the GNU General  Public License as published by =
the=0A=
+ * Free Software Foundation;  either version 2 of the  License, or (at =
your=0A=
+ * option) any later version.=0A=
+ */=0A=
+=0A=
+#ifndef __MV64340_DEP_H__=0A=
+#define __MV64340_DEP_H__=0A=
+=0A=
+#include <asm/addrspace.h>		/* for KSEG1ADDR() */=0A=
+#include <asm/byteorder.h>		/* for cpu_to_le32() */=0A=
+=0A=
+extern unsigned long mv64340_base;=0A=
+=0A=
+#define MV64340_BASE       (mv64340_base)=0A=
+=0A=
+/*=0A=
+ * Because of an error/peculiarity in the Galileo chip, we need to swap =
the=0A=
+ * bytes when running bigendian.=0A=
+ */=0A=
+=0A=
+#define MV_WRITE(ofs, data)  \=0A=
+        *(volatile u32 *)(MV64340_BASE+(ofs)) =3D cpu_to_le32(data)=0A=
+#define MV_READ(ofs, data)   \=0A=
+        *(data) =3D le32_to_cpu(*(volatile u32 *)(MV64340_BASE+(ofs)))=0A=
+#define MV_READ_DATA(ofs)    \=0A=
+        le32_to_cpu(*(volatile u32 *)(MV64340_BASE+(ofs)))=0A=
+=0A=
+#define MV_WRITE_16(ofs, data)  \=0A=
+        *(volatile u16 *)(MV64340_BASE+(ofs)) =3D cpu_to_le16(data)=0A=
+#define MV_READ_16(ofs, data)   \=0A=
+        *(data) =3D le16_to_cpu(*(volatile u16 *)(MV64340_BASE+(ofs)))=0A=
+=0A=
+#define MV_WRITE_8(ofs, data)  \=0A=
+        *(volatile u8 *)(MV64340_BASE+(ofs)) =3D data=0A=
+#define MV_READ_8(ofs, data)   \=0A=
+        *(data) =3D *(volatile u8 *)(MV64340_BASE+(ofs))=0A=
+=0A=
+#define MV_SET_REG_BITS(ofs,bits) \=0A=
+	(*((volatile u32 *)(MV64340_BASE+(ofs)))) |=3D ((u32)cpu_to_le32(bits))=0A=
+#define MV_RESET_REG_BITS(ofs,bits) \=0A=
+	(*((volatile u32 *)(MV64340_BASE+(ofs)))) &=3D =
~((u32)cpu_to_le32(bits))=0A=
+=0A=
+#endif=0A=
Index: arch/mips/Makefile=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/Makefile,v=0A=
retrieving revision 1.78.2.16=0A=
diff -u -u -r1.78.2.16 Makefile=0A=
--- arch/mips/Makefile	8 Nov 2002 18:45:08 -0000	1.78.2.16=0A=
+++ arch/mips/Makefile	11 Nov 2002 23:25:55 -0000=0A=
@@ -88,6 +88,9 @@=0A=
 ifdef CONFIG_CPU_RM7000=0A=
 GCCFLAGS	+=3D -mcpu=3Dr5000 -mips2 -Wa,--trap=0A=
 endif=0A=
+ifdef CONFIG_CPU_SR71000=0A=
+GCCFLAGS	+=3D -mcpu=3Dr5000 -mips2 -Wa,--trap=0A=
+endif=0A=
 ifdef CONFIG_CPU_SB1=0A=
 #GCCFLAGS	+=3D -mcpu=3Dsb1 -mips2 -Wa,--trap=0A=
 GCCFLAGS	+=3D -mcpu=3Dr5000 -mips2 -Wa,--trap=0A=
@@ -297,6 +300,17 @@=0A=
 # mips_io_port_base.=0A=
 CORE_FILES	+=3D arch/mips/momentum/ocelot_g/ocelot_g.o=0A=
 SUBDIRS		+=3D arch/mips/momentum/ocelot_g=0A=
+LOADADDR	:=3D 0x80100000=0A=
+endif=0A=
+=0A=
+#=0A=
+# Momentum Ocelot-C and -CS boards=0A=
+#=0A=
+ifdef CONFIG_MOMENCO_OCELOT_C=0A=
+# The Ocelot-C[S] setup.o must be linked early - it does the ioremap() =
for the=0A=
+# mips_io_port_base.=0A=
+CORE_FILES	+=3D arch/mips/momentum/ocelot_c/ocelot_c.o=0A=
+SUBDIRS		+=3D arch/mips/momentum/ocelot_c=0A=
 LOADADDR	:=3D 0x80100000=0A=
 endif=0A=
 =0A=
Index: arch/mips/config-shared.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v=0A=
retrieving revision 1.1.2.29=0A=
diff -u -u -r1.1.2.29 config-shared.in=0A=
--- arch/mips/config-shared.in	8 Nov 2002 01:39:44 -0000	1.1.2.29=0A=
+++ arch/mips/config-shared.in	11 Nov 2002 23:25:55 -0000=0A=
@@ -58,6 +58,7 @@=0A=
 dep_bool 'Support for MIPS SEAD board (EXPERIMENTAL)' CONFIG_MIPS_SEAD =
$CONFIG_EXPERIMENTAL=0A=
 bool 'Support for Momentum Ocelot board' CONFIG_MOMENCO_OCELOT=0A=
 bool 'Support for Momentum Ocelot-G board' CONFIG_MOMENCO_OCELOT_G=0A=
+bool 'Support for Momentum Ocelot-C and -CS boards' =
CONFIG_MOMENCO_OCELOT_C=0A=
 dep_bool 'Support for NEC DDB Vrc-5074 (EXPERIMENTAL)' CONFIG_DDB5074 =
$CONFIG_EXPERIMENTAL=0A=
 bool 'Support for NEC DDB Vrc-5476' CONFIG_DDB5476=0A=
 bool 'Support for NEC DDB Vrc-5477' CONFIG_DDB5477=0A=
@@ -293,6 +294,13 @@=0A=
    define_bool CONFIG_NONCOHERENT_IO y=0A=
    define_bool CONFIG_OLD_TIME_C y=0A=
 fi=0A=
+if [ "$CONFIG_MOMENCO_OCELOT_C" =3D "y" ]; then=0A=
+   define_bool CONFIG_PCI y=0A=
+   define_bool CONFIG_SWAP_IO_SPACE y=0A=
+   define_bool CONFIG_NEW_IRQ y=0A=
+   define_bool CONFIG_NONCOHERENT_IO y=0A=
+   define_bool CONFIG_NEW_TIME_C y=0A=
+fi=0A=
 if [ "$CONFIG_DDB5074" =3D "y" ]; then=0A=
    define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y=0A=
    define_bool CONFIG_I8259 y=0A=
@@ -463,7 +471,8 @@=0A=
 	 R8000	CONFIG_CPU_R8000 \=0A=
 	 R10000	CONFIG_CPU_R10000 \=0A=
 	 RM7000	CONFIG_CPU_RM7000 \=0A=
-	 SB1	CONFIG_CPU_SB1" R4x00=0A=
+	 SB1	CONFIG_CPU_SB1 \=0A=
+	 SR71k	CONFIG_CPU_SR71000" R4x00=0A=
 =0A=
 if [ "$CONFIG_SMP_CAPABLE" =3D "y" ]; then=0A=
    bool '  Multi-Processing support' CONFIG_SMP=0A=
@@ -512,6 +521,7 @@=0A=
      "$CONFIG_CPU_RM7000" =3D "y" -o \=0A=
      "$CONFIG_CPU_R10000" =3D "y" -o \=0A=
      "$CONFIG_CPU_SB1"    =3D "y" -o \=0A=
+     "$CONFIG_CPU_SR71000"=3D "y" -o \=0A=
      "$CONFIG_CPU_MIPS32" =3D "y" -o \=0A=
      "$CONFIG_CPU_MIPS64" =3D "y" ]; then=0A=
    dep_bool '  Support for 64-bit physical address space' =
CONFIG_64BIT_PHYS_ADDR $CONFIG_MIPS32=0A=
Index: arch/mips/kernel/Makefile=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/kernel/Makefile,v=0A=
retrieving revision 1.51.2.9=0A=
diff -u -u -r1.51.2.9 Makefile=0A=
--- arch/mips/kernel/Makefile	31 Oct 2002 19:54:04 -0000	1.51.2.9=0A=
+++ arch/mips/kernel/Makefile	11 Nov 2002 23:25:55 -0000=0A=
@@ -33,6 +33,7 @@=0A=
 obj-$(CONFIG_CPU_NEVADA)	+=3D r4k_fpu.o r4k_switch.o=0A=
 obj-$(CONFIG_CPU_R10000)	+=3D r4k_fpu.o r4k_switch.o=0A=
 obj-$(CONFIG_CPU_SB1)		+=3D r4k_fpu.o r4k_switch.o=0A=
+obj-$(CONFIG_CPU_SR71000)	+=3D r4k_fpu.o r4k_switch.o=0A=
 obj-$(CONFIG_CPU_MIPS32)	+=3D r4k_fpu.o r4k_switch.o=0A=
 obj-$(CONFIG_CPU_MIPS64)	+=3D r4k_fpu.o r4k_switch.o=0A=
 obj-$(CONFIG_CPU_R6000)		+=3D r6000_fpu.o r4k_switch.o=0A=
Index: arch/mips/kernel/cpu-probe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/kernel/cpu-probe.c,v=0A=
retrieving revision 1.1.2.7=0A=
diff -u -u -r1.1.2.7 cpu-probe.c=0A=
--- arch/mips/kernel/cpu-probe.c	7 Nov 2002 01:47:45 -0000	1.1.2.7=0A=
+++ arch/mips/kernel/cpu-probe.c	11 Nov 2002 23:25:55 -0000=0A=
@@ -5,6 +5,7 @@=0A=
 #include <asm/cpu.h>=0A=
 #include <asm/fpu.h>=0A=
 #include <asm/mipsregs.h>=0A=
+#include <asm/cacheops.h>=0A=
 =0A=
 /*=0A=
  * Not all of the MIPS CPUs have the "wait" instruction available. =
Moreover,=0A=
@@ -46,6 +47,44 @@=0A=
 #endif=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_CPU_SR71000=0A=
+/* Fix the sr71000 wait errata. We have a special ret_from_irq that is =
executed=0A=
+ * when a jump is converted to a nop. Before we wait we do that =
conversion.=0A=
+ * This engages the code that detects the errata. This way we don't =
loose any=0A=
+ * speed in the normal case. Though it does make the timing race with =
wait =0A=
+ * longer..=0A=
+ */=0A=
+extern asmlinkage void ret_from_irq_sr71000(void);=0A=
+=0A=
+static void sr71000_wait(void)=0A=
+{=0A=
+  u32 *jump =3D ((u32 *)&ret_from_irq_sr71000);=0A=
+   __asm__ __volatile__=0A=
+      (=0A=
+       ".set push\n\t"=0A=
+       ".set noat\n\t"=0A=
+       ".set noreorder\n\t"=0A=
+       ".set mips3\n\t"=0A=
+       "lw $1,0(%0)\n\t"=0A=
+       "sw $0,0(%0)\n\t"=0A=
+       =0A=
+       // No snoopy i/d cache..=0A=
+       "cache %1,0(%0)\n\t"=0A=
+       "cache %2,0(%0)\n\t"=0A=
+       =0A=
+       "wait\n\t"=0A=
+       "sw $1,0(%0)\n\t"=0A=
+       =0A=
+       "cache %1,0(%0)\n\t"=0A=
+       "cache %2,0(%0)\n\t"=0A=
+       =0A=
+       ".set pop\n\t"=0A=
+       :=0A=
+       : "r" (jump), "i"(Hit_Writeback_D), "i"(Hit_Invalidate_I)=0A=
+       : "$1");=0A=
+}=0A=
+#endif=0A=
+=0A=
 static inline void check_wait(void)=0A=
 {=0A=
 	printk("Checking for 'wait' instruction... ");=0A=
@@ -84,6 +123,12 @@=0A=
 		cpu_wait =3D au1k_wait;=0A=
 		printk(" available.\n");=0A=
 		break;=0A=
+#ifdef CONFIG_CPU_SR71000=0A=
+	case CPU_SR71000:=0A=
+		cpu_wait =3D sr71000_wait;=0A=
+		printk(" available, errata workaround enabled.\n");=0A=
+		break;=0A=
+#endif=0A=
 	default:=0A=
 		printk(" unavailable.\n");=0A=
 		break;=0A=
@@ -469,6 +514,23 @@=0A=
 			/* FPU in pass1 is known to have issues. */=0A=
 			mips_cpu.options |=3D MIPS_CPU_FPU;=0A=
 #endif=0A=
+			break;=0A=
+		default:=0A=
+			mips_cpu.cputype =3D CPU_UNKNOWN;=0A=
+			break;=0A=
+		}=0A=
+		break;=0A=
+=0A=
+	case PRID_COMP_SANDCRAFT:=0A=
+		switch (mips_cpu.processor_id & 0xff00) {=0A=
+		case PRID_IMP_SR71000:=0A=
+			mips_cpu.cputype =3D CPU_SR71000;=0A=
+			mips_cpu.isa_level =3D MIPS_CPU_ISA_M64;=0A=
+			mips_cpu.options =3D MIPS_CPU_TLB | MIPS_CPU_4KEX |=0A=
+                                           MIPS_CPU_4KTLB | =
MIPS_CPU_FPU |=0A=
+			                   MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;=0A=
+			mips_cpu.scache.ways =3D 8;=0A=
+			mips_cpu.tlbsize =3D 64;=0A=
 			break;=0A=
 		default:=0A=
 			mips_cpu.cputype =3D CPU_UNKNOWN;=0A=
Index: arch/mips/kernel/entry.S=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/kernel/entry.S,v=0A=
retrieving revision 1.34.2.7=0A=
diff -u -u -r1.34.2.7 entry.S=0A=
--- arch/mips/kernel/entry.S	5 Aug 2002 23:53:33 -0000	1.34.2.7=0A=
+++ arch/mips/kernel/entry.S	11 Nov 2002 23:25:55 -0000=0A=
@@ -35,7 +35,33 @@=0A=
 FEXPORT(ret_from_exception)=0A=
 		lw	t0, PT_STATUS(sp)	# returning to kernel mode?=0A=
 		andi	t0, t0, KU_USER=0A=
+#ifndef CONFIG_CPU_SR71000=0A=
 		beqz	t0, restore_all=0A=
+#else=0A=
+		bnez	t0, ret_from_sys_call=0A=
+/* SR71000 Errata #1:  The wait instruction does not advance the EPC.  =
The=0A=
+ * solution is to check if the EPC is pointing at a wait instruction =
and (if=0A=
+ * so), skip it.  This must be after ret_from_irq.  The setup code will =
nop=0A=
+ * out the jump below so we fall through.  This fixup only occurs if =
they are=0A=
+ * in the kernel.=0A=
+ */=0A=
+FEXPORT(ret_from_irq_sr71000)=0A=
+		j	restore_all=0A=
+=0A=
+		// Fetch EPC=0A=
+		lw	t0, PT_EPC(sp)=0A=
+ =0A=
+		// Is the instruction a wait?=0A=
+		li	t2, 0x42000000=0A=
+		lw	t1, 0(t0)=0A=
+		ori	t2, t2, 0x20=0A=
+		bne	t1, t2, restore_all=0A=
+=0A=
+		// Yep, go to the next instruction=0A=
+		addu	t1, t0, 4=0A=
+		sw	t1, PT_EPC(sp)=0A=
+		j	restore_all=0A=
+#endif=0A=
 =0A=
 FEXPORT(ret_from_sys_call)		# here to prevent code duplication=0A=
 ret_from_schedule:=0A=
Index: arch/mips/kernel/proc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/kernel/proc.c,v=0A=
retrieving revision 1.27.2.11=0A=
diff -u -u -r1.27.2.11 proc.c=0A=
--- arch/mips/kernel/proc.c	7 Nov 2002 01:47:45 -0000	1.27.2.11=0A=
+++ arch/mips/kernel/proc.c	11 Nov 2002 23:25:56 -0000=0A=
@@ -73,7 +73,8 @@=0A=
 	[CPU_VR4122]	"NEC VR4122",=0A=
 	[CPU_VR4131]	"NEC VR4131",=0A=
 	[CPU_VR4181]	"NEC VR4181",=0A=
-	[CPU_VR4181A]	"NEC VR4181A"=0A=
+	[CPU_VR4181A]	"NEC VR4181A",=0A=
+	[CPU_SR71000]	"Sandcraft SR71000"=0A=
 };=0A=
 =0A=
 =0A=
Index: arch/mips/kernel/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v=0A=
retrieving revision 1.96.2.32=0A=
diff -u -u -r1.96.2.32 setup.c=0A=
--- arch/mips/kernel/setup.c	6 Oct 2002 02:01:33 -0000	1.96.2.32=0A=
+++ arch/mips/kernel/setup.c	11 Nov 2002 23:25:56 -0000=0A=
@@ -483,6 +483,7 @@=0A=
 	void ikos_setup(void);=0A=
 	void momenco_ocelot_setup(void);=0A=
 	void momenco_ocelot_g_setup(void);=0A=
+	void momenco_ocelot_c_setup(void);=0A=
 	void nino_setup(void);=0A=
 	void nec_osprey_setup(void);=0A=
 	void nec_eagle_setup(void);=0A=
@@ -552,6 +553,11 @@=0A=
 #ifdef CONFIG_MOMENCO_OCELOT_G=0A=
 	case MACH_GROUP_MOMENCO:=0A=
 		momenco_ocelot_g_setup();=0A=
+		break;=0A=
+#endif=0A=
+#ifdef CONFIG_MOMENCO_OCELOT_C=0A=
+	case MACH_GROUP_MOMENCO:=0A=
+		momenco_ocelot_c_setup();=0A=
 		break;=0A=
 #endif=0A=
 #ifdef CONFIG_MIPS_SEAD=0A=
Index: arch/mips/mm/Makefile=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v=0A=
retrieving revision 1.27.2.3=0A=
diff -u -u -r1.27.2.3 Makefile=0A=
--- arch/mips/mm/Makefile	2 Oct 2002 13:08:16 -0000	1.27.2.3=0A=
+++ arch/mips/mm/Makefile	11 Nov 2002 23:25:56 -0000=0A=
@@ -30,6 +30,7 @@=0A=
 obj-$(CONFIG_CPU_MIPS32)	+=3D pg-mips32.o c-mips32.o tlb-r4k.o =
tlbex-r4k.o=0A=
 obj-$(CONFIG_CPU_MIPS64)	+=3D pg-mips32.o c-mips32.o tlb-r4k.o =
tlbex-r4k.o=0A=
 obj-$(CONFIG_CPU_SB1)		+=3D pg-sb1.o c-sb1.o tlb-sb1.o tlbex-r4k.o=0A=
+obj-$(CONFIG_CPU_SR71000)	+=3D pg-mips32.o c-sr71000.o tlb-r4k.o =
tlbex-r4k.o=0A=
 =0A=
 obj-$(CONFIG_SB1_CACHE_ERROR)	+=3D cex-sb1.o cerr-sb1.o=0A=
 =0A=
Index: arch/mips/mm/loadmmu.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/mm/loadmmu.c,v=0A=
retrieving revision 1.45.2.1=0A=
diff -u -u -r1.45.2.1 loadmmu.c=0A=
--- arch/mips/mm/loadmmu.c	6 Aug 2002 01:46:58 -0000	1.45.2.1=0A=
+++ arch/mips/mm/loadmmu.c	11 Nov 2002 23:25:56 -0000=0A=
@@ -61,6 +61,7 @@=0A=
 extern void ld_mmu_andes(void);=0A=
 extern void ld_mmu_sb1(void);=0A=
 extern void ld_mmu_mips32(void);=0A=
+extern void ld_mmu_sr71000(void);=0A=
 extern void r3k_tlb_init(void);=0A=
 extern void r4k_tlb_init(void);=0A=
 extern void sb1_tlb_init(void);=0A=
@@ -76,6 +77,10 @@=0A=
 #endif=0A=
 #if defined(CONFIG_CPU_RM7000)=0A=
 		ld_mmu_rm7k();=0A=
+		r4k_tlb_init();=0A=
+#endif=0A=
+#if defined(CONFIG_CPU_SR71000)=0A=
+		ld_mmu_sr71000();=0A=
 		r4k_tlb_init();=0A=
 #endif=0A=
 #if defined(CONFIG_CPU_R5432) || defined(CONFIG_CPU_R5500)=0A=
Index: drivers/mtd/devices/docprobe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/drivers/mtd/devices/docprobe.c,v=0A=
retrieving revision 1.3.2.1=0A=
diff -u -u -r1.3.2.1 docprobe.c=0A=
--- drivers/mtd/devices/docprobe.c	23 Sep 2002 01:04:02 -0000	1.3.2.1=0A=
+++ drivers/mtd/devices/docprobe.c	11 Nov 2002 23:25:57 -0000=0A=
@@ -89,7 +89,7 @@=0A=
 #elif defined(CONFIG_MOMENCO_OCELOT)=0A=
 	0x2f000000,=0A=
 	0xff000000,=0A=
-#elif defined(CONFIG_MOMENCO_OCELOT_G)=0A=
+#elif defined(CONFIG_MOMENCO_OCELOT_G) || defined =
(CONFIG_MOMENCO_OCELOT_C)=0A=
 	0xff000000,=0A=
 #else=0A=
 #warning Unknown architecture for DiskOnChip. No default probe =
locations defined=0A=
Index: include/asm-mips/bootinfo.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/include/asm-mips/bootinfo.h,v=0A=
retrieving revision 1.43.2.17=0A=
diff -u -u -r1.43.2.17 bootinfo.h=0A=
--- include/asm-mips/bootinfo.h	6 Oct 2002 02:01:33 -0000	1.43.2.17=0A=
+++ include/asm-mips/bootinfo.h	11 Nov 2002 23:25:58 -0000=0A=
@@ -125,6 +125,7 @@=0A=
  */=0A=
 #define MACH_MOMENCO_OCELOT		0=0A=
 #define MACH_MOMENCO_OCELOT_G		1=0A=
+#define MACH_MOMENCO_OCELOT_C		2=0A=
 =0A=
 /*=0A=
  * Valid machtype for group ITE=0A=
Index: include/asm-mips/cpu.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/include/asm-mips/cpu.h,v=0A=
retrieving revision 1.24.2.12=0A=
diff -u -u -r1.24.2.12 cpu.h=0A=
--- include/asm-mips/cpu.h	5 Aug 2002 23:53:37 -0000	1.24.2.12=0A=
+++ include/asm-mips/cpu.h	11 Nov 2002 23:25:58 -0000=0A=
@@ -29,6 +29,7 @@=0A=
 #define PRID_COMP_BROADCOM     0x020000=0A=
 #define PRID_COMP_ALCHEMY      0x030000=0A=
 #define PRID_COMP_SIBYTE       0x040000=0A=
+#define PRID_COMP_SANDCRAFT    0x050000=0A=
 =0A=
 /*=0A=
  * Assigned values for the product ID register.  In order to detect a=0A=
@@ -76,6 +77,12 @@=0A=
 #define PRID_IMP_SB1            0x0100=0A=
 =0A=
 /*=0A=
+ * These are the PRID's for when 23:16 =3D=3D PRID_COMP_SANDCRAFT=0A=
+ */=0A=
+=0A=
+#define PRID_IMP_SR71000        0x0400=0A=
+=0A=
+/*=0A=
  * Definitions for 7:0 on legacy processors=0A=
  */=0A=
 =0A=
@@ -139,7 +146,7 @@=0A=
 	CPU_TX3912, CPU_TX3922, CPU_TX3927, CPU_AU1000, CPU_4KEC, CPU_4KSC,=0A=
 	CPU_VR41XX, CPU_R5500, CPU_TX49XX, CPU_TX39XX, CPU_AU1500, CPU_20KC,=0A=
 	CPU_VR4111, CPU_VR4121, CPU_VR4122, CPU_VR4131, CPU_VR4181, =
CPU_VR4181A,=0A=
-	CPU_AU1100, CPU_LAST=0A=
+	CPU_AU1100, CPU_SR71000, CPU_LAST=0A=
 };=0A=
 =0A=
 #endif /* !__ASSEMBLY__ */=0A=
Index: include/asm-mips/serial.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/include/asm-mips/serial.h,v=0A=
retrieving revision 1.23.2.9=0A=
diff -u -u -r1.23.2.9 serial.h=0A=
--- include/asm-mips/serial.h	7 Nov 2002 01:47:46 -0000	1.23.2.9=0A=
+++ include/asm-mips/serial.h	11 Nov 2002 23:25:58 -0000=0A=
@@ -311,6 +311,27 @@=0A=
 #define MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS=0A=
 #endif=0A=
 =0A=
+#ifdef CONFIG_MOMENCO_OCELOT_C=0A=
+/* Ordinary NS16552 duart with a 20MHz crystal.  */=0A=
+#define OCELOT_C_BASE_BAUD ( 20000000 / 16 )=0A=
+=0A=
+#define OCELOT_C_SERIAL1_IRQ	80=0A=
+#define OCELOT_C_SERIAL1_BASE	0xfd000020=0A=
+=0A=
+#define OCELOT_C_SERIAL2_IRQ	81=0A=
+#define OCELOT_C_SERIAL2_BASE	0xfd000000=0A=
+=0A=
+#define _OCELOT_C_SERIAL_INIT(int, base)				 \=0A=
+	{ baud_base: OCELOT_C_BASE_BAUD, irq: int, flags: STD_COM_FLAGS,\=0A=
+	  iomem_base: (u8 *) base, iomem_reg_shift: 2,			 \=0A=
+	  io_type: SERIAL_IO_MEM }=0A=
+#define MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS				\=0A=
+	_OCELOT_C_SERIAL_INIT(OCELOT_C_SERIAL1_IRQ, OCELOT_C_SERIAL1_BASE), \=0A=
+	_OCELOT_C_SERIAL_INIT(OCELOT_C_SERIAL2_IRQ, OCELOT_C_SERIAL2_BASE)=0A=
+#else=0A=
+#define MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS=0A=
+#endif=0A=
+=0A=
 #ifdef CONFIG_DDB5477=0A=
 #include <asm/ddb5xxx/ddb5477.h>=0A=
 #define DDB5477_SERIAL_PORT_DEFNS                                       =
      \=0A=
@@ -338,6 +359,7 @@=0A=
 	HUB6_SERIAL_PORT_DFNS			\=0A=
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS	\=0A=
 	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS	\=0A=
+	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS	\=0A=
 	AU1000_SERIAL_PORT_DEFNS		\=0A=
-        TXX927_SERIAL_PORT_DEFNS        	\=0A=
+	TXX927_SERIAL_PORT_DEFNS        	\=0A=
 	DDB5477_SERIAL_PORT_DEFNS=0A=

------=_NextPart_000_0007_01C28997.B8471B50--
