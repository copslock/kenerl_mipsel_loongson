Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 23:54:03 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:27385 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224847AbSLDWyB>;
	Wed, 4 Dec 2002 23:54:01 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB4MrtN31764;
	Wed, 4 Dec 2002 14:53:55 -0800
Date: Wed, 4 Dec 2002 14:53:55 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: possible Malta 4Kc cache problem ...
Message-ID: <20021204145355.W4363@mvista.com>
References: <20021203224504.B13437@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021203224504.B13437@mvista.com>; from jsun@mvista.com on Tue, Dec 03, 2002 at 10:45:04PM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


OK, I am fully convinced that this is some kind of hardware
problem.  Basically, it appears CPU is running from a stale 
icache line even though it has invalid flags!

In order to see how I draw this conclusion, you will need to 
be a little patient.

Here is the relavent user code segment:

  400f3c:       45010009        bc1t    400f64 <C_x_co_DIDI_J+0x84>
  400f40:       8c510008        lw      $s1,8($v0)
  ....
  400f94:       4501000a        bc1t    400fc0 <C_x_co_DIDI_J+0xe0>
  400f98:       8fa20050        lw      $v0,80($sp)

In both cases, branch are taken.  The faulting symptom is that
"lw" in the second delay slot does not load correct value to $v0.

I wrote some sizable instrumentation code to capture what has happened
before and after "lw" emulation.  A rough patch of my change is included for 
the diehard hackers.

Here is the output from my captured data for the faulting "lw" case:

----------
dsemul_insns = 7fff78f0, epc=00400f98, cpc=00400fc0, ir=8fa20050
v0 = 10000028, s1=00000004
ret_epc = 7fff78f4, ret_ir=8fa20050, ret_sp=7fff7900, ret_sp_80val=00000004
ret_v0 = 10000028, ret_s1=00000004, bad_addr=00000000
cache tags before: 0018a8f2, 03b878f0, 000308f2, 03b888f2
cache tags after : 0018a8f2, 03b87800, 000308f2, 03b888f2
mem @ a3b878f0 : 8fa20050, 8c000001, 0000bd36, 00400fc0
----------

Several notes and observations:

. 7fff78f0 is in fact 83b878f0 (or a3b878f0) in kernel space

. ret_v0 is the v0 value after we return from trampoline execution.  Wowla,
  it has the same value as before, meaning "lw $v0,80($sp)" did not happen.  
  To further confirm that, I actually printed out the value at 80($sp) which is
  "ret_sp_80val=00000004" (That is the right value $v0 should have, BTW).

. apparently the trampoline is executed, because we did come back from it
  through unaligned access exception.

. In order to figure out what the first instruction is, I modified $s1 value
  to 0x55 right before we start to execute trampoline code.  Guess what, after 
  it comes back, $s1 is changed to "ret_s1=00000004", which suggests an stale instruction
  "lw $s1,8($v0)" was executed.  This instruction was put into icache during the previous
  bc1t emulation.

. "cache tags before/after" dumps cache tags of all four ways in the same set as the
   trampoline.  It is clear that after flush_cache_sigtramp() the valid bits are correctly
   cleared.

. The last line shows memory indeed has the right values.  It is the icache
  to blame.

. No page fault has happened during flush_cache_sigtramp() because bad_addr would
  otherwise contains the faulting address.

It seems safe to conclude CPU executed from a stale icache line.  I have no clue why 
icache exhibits such a problem.

I modified flush_cache_sigtramp() to flush the whole icache, and things appear
to be working.  However, not knowing the root cause I am not 100% sure
if this is a valid workaround.

Here are some info related to the CPU:

CPU revision is: 00018001
Primary instruction cache 16kb, linesize 16 bytes (4 ways)
Primary data cache 16kb, linesize 16 bytes (4 ways)

Jun


On Tue, Dec 03, 2002 at 10:45:04PM -0800, Jun Sun wrote:
> 
> I attached the test case.  Untar it.  Type 'make' and run 'a.out'.
> 
> If the test fails you will see a print-out.  Otherwise you see nothing.
> 
> It does not always fail.  But if it fails, it is usually pretty consistent.
> Try a few times.  Moving source tree to a different directory may cause
> the symptom appear or disappear.
> 
> I spent quite some time to trace this problem, and came to suspect
> there might be a hardware problem.
> 
> The problem involves emulating a "lw" instruction in cp1 branch delay
> slot, which needs to  set up trampoline in user stack.  The net effect
> looks as if the icache line or dcache line is not flushed properly.
> 
> Using gdb/kgdb, printf or printk in any useful places would hide the bug.
> 
> I did find a smaller part of the problem.  flush_cache_sigtramp for
> MIPS32 (4Kc) calls protected_writeback_dcache_line in mips32_cache.h.
> It uses Hit_Writeback_D, and the 4Kc mannual says it is not implemented
> and executed as no-op (*ick*).
> 
> Even after fixing this, I still see the problem happening.
> 
> If you replace flush_cache_sigtramp() with flush_cache_all(), symptom
> would disppear.
> 
> Several of my tests seem to suggest it is the icache that did not
> get flushed (or updated) properly.
> 
> Not re-producible on other MIPS boards.  At least so far.
> 
> Does anybody with more knowledge about 4Kc have any clues here?
> 
> Thanks.
> 
> Jun



--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.patch"

diff -Nru ./arch/mips/math-emu/cp1emu.c.orig ./arch/mips/math-emu/cp1emu.c
--- ./arch/mips/math-emu/cp1emu.c.orig	Tue Oct 22 18:36:50 2002
+++ ./arch/mips/math-emu/cp1emu.c	Wed Dec  4 13:44:55 2002
@@ -772,6 +772,47 @@
 /* Instruction inserted following the AdELOAD to further tag the sequence */
 #define BD_COOKIE 0x0000bd36 /* tne $0,$0 with baggage */
 
+int jsun_flag=0;
+unsigned long jsun_addr;
+struct {
+	unsigned dsemul_insns, epc, cpc, ir;
+	unsigned v0, s1;
+	unsigned ret_epc, ret_ir, ret_sp, ret_sp_80val;
+	unsigned ret_v0, ret_s1;
+	unsigned long bad_addr;
+	unsigned cache_tag[4], ret_cache_tag[4];
+	unsigned long kaddr;
+	unsigned kaddr_data[4];
+} jsun_array[200];
+int jsun_index;
+
+extern unsigned long user_to_kernel(unsigned long addr);
+extern int dcache_way_offset, icache_way_offset;
+
+#include <asm/cacheops.h>
+static inline unsigned load_icache_line_indexed(unsigned long addr)
+{
+        __asm__ __volatile__(
+                ".set noreorder\n\t"
+                ".set mips3\n\t"
+                "cache %1, (%0)\n\t"
+                ".set mips0\n\t"
+                ".set reorder"
+                :
+                : "r" (addr),
+                  "i" (Index_Load_Tag_I));
+
+	return read_32bit_cp0_register(CP0_TAGLO);
+}
+
+void read_cache_tag(unsigned long addr, unsigned *tag)
+{
+	tag[0] = load_icache_line_indexed(addr);
+	tag[1] = load_icache_line_indexed(addr+icache_way_offset);
+	tag[2] = load_icache_line_indexed(addr+icache_way_offset*2);
+	tag[3] = load_icache_line_indexed(addr+icache_way_offset*3);
+}
+
 int do_dsemulret(struct pt_regs *xcp)
 {
 	unsigned long *pinst;
@@ -786,7 +827,7 @@
 	 * If we can't even access the area, something is very wrong, but we'll
 	 * leave that to the default handling
 	 */
-	if (verify_area(VERIFY_READ, pinst, sizeof(unsigned long) * 3))
+	if (verify_area(VERIFY_READ, pinst-1, sizeof(unsigned long) * 4))
 		return 0;
 
 	/* Is the instruction pointed to by the EPC an AdELOAD? */
@@ -826,16 +867,77 @@
 	/* Set EPC to return to post-branch instruction */
 	xcp->cp0_epc = stackitem;
 
+	jsun_array[jsun_index].ret_epc = (unsigned long)pinst;
+	jsun_array[jsun_index].ret_ir = mips_get_word(xcp, pinst-1, &err);
+	jsun_array[jsun_index].ret_sp = xcp->regs[29];
+	jsun_array[jsun_index].ret_v0 = xcp->regs[2];
+	jsun_array[jsun_index].ret_s1 = xcp->regs[17];
+	jsun_array[jsun_index].ret_sp_80val = mips_get_word(xcp, xcp->regs[29]+80, &err);
+	if (jsun_array[jsun_index].ret_ir == 0x8fa20050) {
+		xcp->regs[17] = jsun_array[jsun_index].s1;
+	}
+
+	jsun_index ++;
+
 	return 1;
 }
 
 
 #define AdELOAD 0x8c000001	/* lw $0,1($0) */
 
+void jsun_dump_struct(void)
+{
+	int i;
+	printk("dump jsun_struct:\n");
+	for (i=0; i< jsun_index; i++) {
+		printk("------\n");
+		printk("dsemul_insns = %08x, epc=%08x, cpc=%08x, ir=%08x\n", 
+				jsun_array[i].dsemul_insns, 
+				jsun_array[i].epc,
+				jsun_array[i].cpc,
+				jsun_array[i].ir);
+		printk("v0 = %08x, s1=%08x\n",
+				jsun_array[i].v0,
+				jsun_array[i].s1);
+		printk("ret_epc = %08x, ret_ir=%08x, ret_sp=%08x, ret_sp_80val=%08x\n", 
+				jsun_array[i].ret_epc,
+				jsun_array[i].ret_ir,
+				jsun_array[i].ret_sp,
+				jsun_array[i].ret_sp_80val);
+		printk("ret_v0 = %08x, ret_s1=%08x, bad_addr=%08lx\n",
+				jsun_array[i].ret_v0,
+				jsun_array[i].ret_s1,
+				jsun_array[i].bad_addr
+				);
+		printk("cache tags before: %08x, %08x, %08x, %08x\n",
+				jsun_array[i].cache_tag[0],
+				jsun_array[i].cache_tag[1],
+				jsun_array[i].cache_tag[2],
+				jsun_array[i].cache_tag[3]
+		      );
+		printk("cache tags after : %08x, %08x, %08x, %08x\n",
+				jsun_array[i].ret_cache_tag[0],
+				jsun_array[i].ret_cache_tag[1],
+				jsun_array[i].ret_cache_tag[2],
+				jsun_array[i].ret_cache_tag[3]
+		      );
+		printk("mem @ %08x : %08x, %08x, %08x, %08x\n",
+				jsun_array[i].kaddr + 0x20000000,
+				jsun_array[i].kaddr_data[0],
+				jsun_array[i].kaddr_data[1],
+				jsun_array[i].kaddr_data[2],
+				jsun_array[i].kaddr_data[3]);
+				
+	}
+	jsun_index = 0;
+}
+
 static int mips_dsemul(struct pt_regs *regs, mips_instruction ir, vaddr_t cpc)
 {
 	mips_instruction *dsemul_insns;
 	extern asmlinkage void handle_dsemulret(void);
+	mips_instruction new_ir;
+	unsigned long temp;
 
 	if (ir == 0) {		/* a nop is easy */
 		regs->cp0_epc = VA_TO_REG(cpc);
@@ -864,11 +966,17 @@
 	dsemul_insns = (mips_instruction *) (regs->regs[29] & ~0xf);
 	dsemul_insns -= 4;	/* Retain 16-byte alignment */
 
+	temp=user_to_kernel((unsigned long)dsemul_insns);
+
 	/* Verify that the stack pointer is not competely insane */
 	if (verify_area
 	    (VERIFY_WRITE, dsemul_insns, sizeof(mips_instruction) * 4))
 		return SIGBUS;
 
+	if (ir == 0x8fa20050) {
+		// ir = 0x24020004;	// li v0, 9
+		// regs->regs[2]=0;
+	}
 	if (mips_put_word(regs, &dsemul_insns[0], ir)) {
 		fpuemuprivate.stats.errors++;
 		return (SIGBUS);
@@ -890,9 +998,50 @@
 		return (SIGBUS);
 	}
 
+
+	jsun_array[jsun_index].dsemul_insns = (unsigned long)dsemul_insns;
+	jsun_array[jsun_index].epc = (unsigned long)regs->cp0_epc;
+	jsun_array[jsun_index].cpc = cpc;
+	jsun_array[jsun_index].v0 = regs->regs[2];
+	jsun_array[jsun_index].s1 = regs->regs[17];
+	jsun_array[jsun_index].ir = *(unsigned long *)&ir;
+	jsun_array[jsun_index].kaddr = temp;
+
+	// jsun_index ++;
+
+	if (ir == 0x8fa20050) {
+		regs->regs[17] = 0x55;
+	}
+
 	regs->cp0_epc = VA_TO_REG & dsemul_insns[0];
 
+	read_cache_tag(temp, jsun_array[jsun_index].cache_tag);
+	jsun_addr=0;
 	flush_cache_sigtramp((unsigned long)dsemul_insns);
+	jsun_array[jsun_index].bad_addr = jsun_addr;
+	read_cache_tag(temp, jsun_array[jsun_index].ret_cache_tag);
+
+	jsun_array[jsun_index].kaddr_data[0] = *(unsigned*)(temp + 0x20000000);
+	jsun_array[jsun_index].kaddr_data[1] = *(unsigned*)(temp + 0x20000004);
+	jsun_array[jsun_index].kaddr_data[2] = *(unsigned*)(temp + 0x20000008);
+	jsun_array[jsun_index].kaddr_data[3] = *(unsigned*)(temp + 0x2000000c);
+
+	// my_flush_cache_sigtramp((unsigned long)dsemul_insns);
+	// flush_cache_all();
+
+#if 0
+	jsun_addr=user_to_kernel((unsigned long)dsemul_insns);
+	if (jsun_addr) 
+		printk("mem @ %08x : %08x, %08x, %08x, %08x\n",
+				jsun_addr,
+				*(unsigned long*)jsun_addr,
+				*(unsigned long*)(jsun_addr+4),
+				*(unsigned long*)(jsun_addr+8),
+				*(unsigned long*)(jsun_addr+12));
+	else 
+		printk("convertion failed\n");
+#endif
+
 	return SIGILL;		/* force out of emulation loop */
 }
 
diff -Nru ./arch/mips/mm/c-mips32.c.orig ./arch/mips/mm/c-mips32.c
--- ./arch/mips/mm/c-mips32.c.orig	Tue Dec  3 18:54:52 2002
+++ ./arch/mips/mm/c-mips32.c	Wed Dec  4 13:04:29 2002
@@ -39,6 +39,7 @@
 /* Primary cache parameters. */
 int icache_size, dcache_size; 			/* Size in bytes */
 int ic_lsize, dc_lsize;				/* LineSize in bytes */
+int icache_way_offset, dcache_way_offset;	/* offset between ways w. same set */
 
 /* Secondary cache (if present) parameters. */
 unsigned int scache_size, sc_lsize;		/* Again, in bytes */
@@ -407,6 +408,55 @@
  * very much about what happens in that case.  Usually a segmentation
  * fault will dump the process later on anyway ...
  */
+static void indexed_writeback_dcache_line(unsigned long addr)
+{
+	int i;
+	int set_size = dcache_size / mips_cpu.dcache.ways;
+	for (i=0; i<mips_cpu.dcache.ways; i++) {
+	       flush_dcache_line_indexed(addr);
+	       addr += set_size;
+	}
+}
+
+void my_flush_cache_sigtramp(unsigned long addr)
+{
+	indexed_writeback_dcache_line(addr & ~(dc_lsize - 1));
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
+}
+
+unsigned long user_to_kernel(unsigned long addr)
+{
+	unsigned offset;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	mem_map_t *pg;
+	struct mm_struct *mm;
+
+	offset = addr & ~PAGE_MASK;
+	addr &= PAGE_MASK;
+	if (!current->mm  ||
+		!current->mm->context ||
+		!current->active_mm ||
+		!current->active_mm->context ||
+		current->mm != current->active_mm) {
+		printk("user_to_kernel condition failed\n");
+		return 0;
+	}
+
+	mm= current->mm;
+	pgd = pgd_offset(mm, addr);
+	pmd = pmd_offset(pgd, addr);
+	pte = pte_offset(pmd, addr);
+	if(!(pte_val(*pte) & _PAGE_VALID)) {
+		printk("user_to_kernel : pte not valid\n");
+		return 0;
+	}
+
+	pg= pte_page(*pte);
+	return (unsigned long)pg->virtual + offset;
+}
+
 static void mips32_flush_cache_sigtramp(unsigned long addr)
 {
 	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
@@ -451,6 +501,7 @@
 	}
 	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",
 	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);
+	icache_way_offset = icache_size / mips_cpu.icache.ways;
 }
 
 static void __init probe_dcache(unsigned long config)
@@ -490,6 +541,7 @@
 	}
 	printk("Primary data cache %dkb, linesize %d bytes (%d ways)\n",
 	       dcache_size >> 10, dc_lsize, mips_cpu.dcache.ways);
+	dcache_way_offset = dcache_size / mips_cpu.dcache.ways;
 }
 
 
diff -Nru ./arch/mips/mm/fault.c.orig ./arch/mips/mm/fault.c
--- ./arch/mips/mm/fault.c.orig	Tue Oct 22 18:36:51 2002
+++ ./arch/mips/mm/fault.c	Wed Dec  4 10:35:26 2002
@@ -74,6 +74,7 @@
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
+extern unsigned long jsun_addr;
 asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			      unsigned long address)
 {
@@ -193,6 +194,7 @@
 		long new_epc;
 
 		tsk->thread.cp0_baduaddr = address;
+		jsun_addr = address;
 		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
 		if (development_version)
 			printk(KERN_DEBUG "%s: Exception at [<%lx>] (%lx)\n",
diff -Nru ./include/asm-mips/mips32_cache.h.orig ./include/asm-mips/mips32_cache.h
--- ./include/asm-mips/mips32_cache.h.orig	Tue Oct 22 18:37:03 2002
+++ ./include/asm-mips/mips32_cache.h	Tue Dec  3 18:24:25 2002
@@ -171,7 +171,7 @@
 		".previous"
 		:
 		: "r" (addr),
-		  "i" (Hit_Writeback_D));
+		  "i" (Hit_Writeback_Inv_D));
 }
 
 #define cache_unroll(base,op)	        	\
diff -Nru ./net/ipv4/icmp.c.orig ./net/ipv4/icmp.c
--- ./net/ipv4/icmp.c.orig	Mon Feb 25 11:38:14 2002
+++ ./net/ipv4/icmp.c	Tue Dec  3 12:08:01 2002
@@ -733,6 +733,7 @@
 
 static void icmp_echo(struct sk_buff *skb)
 {
+	jsun_dump_struct();
 	if (!sysctl_icmp_echo_ignore_all) {
 		struct icmp_bxm icmp_param;
 

--/04w6evG8XlLl3ft--
