Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M7U9525955
	for linux-mips-outgoing; Mon, 21 Jan 2002 23:30:09 -0800
Received: from ns4.sony.co.jp (NS4.Sony.CO.JP [146.215.0.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M7RtP25890
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 23:27:56 -0800
Received: from mail5.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns4.sony.co.jp (R8/Sony) with ESMTP id g0M6RmY53227;
	Tue, 22 Jan 2002 15:27:48 +0900 (JST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id g0M6Rmh07153;
	Tue, 22 Jan 2002 15:27:48 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id g0M6RlF07136;
	Tue, 22 Jan 2002 15:27:47 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id PAA22509; Tue, 22 Jan 2002 15:32:31 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id PAA29771; Tue, 22 Jan 2002 15:27:44 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0M6RiJ04934; Tue, 22 Jan 2002 15:27:44 +0900 (JST)
To: kevink@mips.com, hjl@lucon.org, drepper@redhat.com,
   libc-hacker@sources.redhat.com, linux-mips@oss.sgi.com
Subject: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
In-Reply-To: <20020120221607T.machida@sm.sony.co.jp>
References: <20020120193843M.machida@sm.sony.co.jp>
	<002c01c1a1a9$b9f0de40$0deca8c0@Ulysses>
	<20020120221607T.machida@sm.sony.co.jp>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Jan_22_15:27:43_2002_135)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20020122152744C.machida@sm.sony.co.jp>
Date: Tue, 22 Jan 2002 15:27:44 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


----Next_Part(Tue_Jan_22_15:27:43_2002_135)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi, all.

As I said at 1/20, I'll post the short descriptions about our
test-and-set implementation and patches for linux-2.4.17 and
glibc-2.2.3. 

=====================================================================

We implemented the fast and safe user level test and set function for 
single MIPS CPUs. You don't need to use LL/SC and sysmips() with
this method. (excatly say, sysmips() is needed for initializing, but
once initialized, we don't use it any more).


  NOTE: We assume the single processor to use this method, You can
  not use our method for SMP.  


WHAT'S CHANGED:

  * kernel side change #1
	Set specific constant (we call this value
	"_TST_ACCESS_MAGIC") to K1 on every transition from kernel
	mode to user mode. This means you can use k1 in any
	exception handler as same as before our method introduced,
	except that you have to do 
		"li	k1, _TST_ACCESS_MAGIC" 
	at the very previous of
		"eret" 
	or 
		"j	k0;
		"rfe"
	.
	We choose the value of _TST_ACCESS_MAGIC, to cause SEGV
	fault when you use this value as address.


  * kernel side change #2
	On memory fault hander, kernel check write-access to 
	_TST_ACCESS_MAGIC from fixed address range of user process.
	(EPC is in  _TST_START_MAGIC to _TST_START_MAGIC+PAGE_SIZE)
	If the condtion is met, kernel restart user process 
	from _TST_START_MAGIC. 


  * kernel side change #3
	We add pseudo device driver "/dev/tst" to provide
	test_and_set procedure at the same virtual address
	(_TST_START_MAGIC) to any user process. 

	
    _TST_START_MAGIC:
	        .set noreorder
	0:
	        move    k1, a0
	        lw      v0, 0(a0)
	        nop
	        bnez    v0, 1f
	        nop
	        bne     k1, a0, 0b
	        nop			....<point A>
	        sw      a1, 0(k1)
	1:
	        jr      ra
	        nop


  * glibc change:

	We implement  test_and_set(addr, val) as follows,

		Do mmap /dev/tst to _TST_START_MAGIC, if not yet mapped.
		call _TST_START_MAGIC(addr, val)
	
	If we can't open /dev/tst then, use sysmips() as final resort.


HOW TO WORK:
	If  no context-switch is occured in _TST_START_MAGIC()
	procedure,  nobody changes the mutex var. It's no problem. 
	So you can do _TST_START_MAGIC() porcedure as you see.

	But, if some context-swtich is occured in _TST_START_MAGIC() 
	somebody chages the mutex var. It's a problem.
	We must not store to the mutex var, if context-swtich is
	occured at <point A>.  
	In our method, kernel sets k1 as _TST_ACCESS_MAGIC on
	transition to user mode.  "sw      a1, 0(k1)"  causes
	SEGV-fault if context-swtich is occured at <point A>. 
	The SEGV-fault hander catch this situation, restart user
	process from top of _TST_START_MAGIC().


PATCHES:

I attached three patches;
	1. patch for linux kernel 2.4.17 (SourceForge tree)
	2. patch for glibc 2.2.3  (of HHL 2.0)
	3. patch for linuxthread 2.2.3 (of HHL 2.0)

To test those patches; you must
	turn on CONFIG_MIPS_TST_DEV on config kernel,
	have working version of sysmips(MIPS_ATOMIC_SET),
	update kernel headers before building glibc and
	make /dev/tst device ("mknod c /dev/tst 123 0", 123 is a
	tempoary major number for this device) 

I'v tested  at ITE board. On testing, I'v made lettle changes into
"drivers/char/Config.in" and "arch/mips/kernel/sysmip.c" to enable
CONFIG_MIPS_TST_DEV and to work sysmips() at ITE board. Those chages
are not included in the patch set.

===================================================================

    You can find the paper about it in
	http://lc.linux.or.jp/lc2001/papers/tas-ps2-paper.pdf
	(sorry in japanese only)

    The abstract of the paper is following;

	The Implementation of user level test-and-set on PS2 Linux
	In the multi-thread environment like Linux, a fast
	user-level mutual exclusion mechanism is strongly
	required. But MIPS chips designed for embedded and single
	processor, like the Emotion Engine, have no atomic
	test-and-set instruction. We implemented the fast user-level
	mutual exclusion without invoking system-call and its costs,
	on the PS2 Linux. This method utilizes the memory protection 
	facility of Operating System, to detect preemption and
	nullify the operation. In this paper, we present the method
	and its evaluation.  

---
Hiroyuki Machida
Sony Corp.

----Next_Part(Tue_Jan_22_15:27:43_2002_135)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4-mips-tas.patch"

Index: arch/mips/kernel/entry.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/entry.S,v
retrieving revision 1.14
diff -u -p -r1.14 entry.S
--- arch/mips/kernel/entry.S	2001/12/10 17:46:47	1.14
+++ arch/mips/kernel/entry.S	2002/01/22 05:13:37
@@ -161,6 +161,7 @@ handle_vced:
 		addiu	k1, 1
 		sw	k1, %lo(vced_count)(k0)
 #endif
+		TST_DEV_EPILOGUE
 		eret
 
 handle_vcei:
@@ -172,6 +173,7 @@ handle_vcei:
 		addiu	k1, 1
 		sw	k1, %lo(vcei_count)(k0)
 #endif
+		TST_DEV_EPILOGUE
 		eret
 		.set    pop
 		END(except_vec3_r4000)
Index: arch/mips/kernel/gdb-low.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/gdb-low.S,v
retrieving revision 1.4
diff -u -p -r1.4 gdb-low.S
--- arch/mips/kernel/gdb-low.S	2002/01/02 17:06:08	1.4
+++ arch/mips/kernel/gdb-low.S	2002/01/22 05:13:38
@@ -304,6 +304,7 @@
 		lw	v1,GDB_FR_REG3(sp)
 		lw	v0,GDB_FR_REG2(sp)
 		lw	$1,GDB_FR_REG1(sp)
+		TST_DEV_EPILOGUE
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 		lw	k0, GDB_FR_EPC(sp)
 		lw	sp, GDB_FR_REG29(sp)		/* Deallocate stack */
Index: arch/mips/kernel/r2300_misc.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/r2300_misc.S,v
retrieving revision 1.2
diff -u -p -r1.2 r2300_misc.S
--- arch/mips/kernel/r2300_misc.S	2001/10/09 21:37:55	1.2
+++ arch/mips/kernel/r2300_misc.S	2002/01/22 05:13:38
@@ -130,9 +130,10 @@
 1:	tlbwr; \
 2:
 
-#define RET(reg) \
+#define RET(reg) /* don't pass k1 to REG */ \
 	mfc0	reg, CP0_EPC; \
 	nop; \
+	TST_DEV_EPILOGUE /* this may use k1 */ \
 	jr	reg; \
 	 rfe
 			
Index: arch/mips/kernel/r4k_misc.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/r4k_misc.S,v
retrieving revision 1.5
diff -u -p -r1.5 r4k_misc.S
--- arch/mips/kernel/r4k_misc.S	2001/10/09 21:37:55	1.5
+++ arch/mips/kernel/r4k_misc.S	2002/01/22 05:13:38
@@ -167,6 +167,7 @@ invalid_tlbl:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3	
 	eret
 	.set	mips0
@@ -191,6 +192,7 @@ nopage_tlbl:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3	
 	eret
 	.set	mips0
@@ -225,6 +227,7 @@ nopage_tlbs:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3
 	eret
 	.set	mips0
Index: arch/mips/mm/fault.c
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/fault.c,v
retrieving revision 1.8
diff -u -p -r1.8 fault.c
--- arch/mips/mm/fault.c	2001/12/07 19:28:37	1.8
+++ arch/mips/mm/fault.c	2002/01/22 05:14:37
@@ -26,6 +26,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+#if defined (CONFIG_MIPS_TST_DEV) || defined (CONFIG_MIPS_TST_DEV_MODULE)
+#include <linux/tst_dev.h>
+#endif
+
 #define development_version (LINUX_VERSION_CODE & 0x100)
 
 /*
@@ -160,6 +164,28 @@ bad_area:
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
+#if defined (CONFIG_MIPS_TST_DEV) || defined (CONFIG_MIPS_TST_DEV_MODULE)
+		/* TEST AND SET magic code */
+		/* Restart user program from _TST_START_MAGIC, 
+		  when all of following conditions are matched;
+
+		1. User program tried to wirte into _TST_ACCESS_MAGIC address.
+		2. That write access was done at the page including 
+			_TST_START_MAGIC.
+		 */
+
+		if (address == _TST_ACCESS_MAGIC && write ) {
+
+			unsigned long pc;
+			pc =  (unsigned long)regs->cp0_epc;
+			if ( _TST_START_MAGIC <= pc
+			     && pc < (_TST_START_MAGIC + PAGE_SIZE)){
+
+				regs->cp0_epc = (unsigned long)_TST_START_MAGIC;
+				return;
+			}
+		}
+#endif /* defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE) */
 		tsk->thread.cp0_badvaddr = address;
 		tsk->thread.error_code = write;
 #if 0
Index: arch/mips/mm/tlbex-r3k.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/tlbex-r3k.S,v
retrieving revision 1.3
diff -u -p -r1.3 tlbex-r3k.S
--- arch/mips/mm/tlbex-r3k.S	2002/01/04 18:04:53	1.3
+++ arch/mips/mm/tlbex-r3k.S	2002/01/22 05:14:37
@@ -48,9 +48,10 @@
 	lw	k0, (k1)
 	nop
 	mtc0	k0, CP0_ENTRYLO0
-	mfc0	k1, CP0_EPC
+	mfc0	k0, CP0_EPC
 	tlbwr
-	jr	k1
+	TST_DEV_EPILOGUE
+	jr	k0
 	rfe
 	END(except_vec0_r2300)
 
@@ -155,9 +156,11 @@
 1:	tlbwr; \
 2:
 
-#define RET(reg) \
+
+#define RET(reg) /* don't pass k1 to REG */ \
 	mfc0	reg, CP0_EPC; \
 	nop; \
+	TST_DEV_EPILOGUE /* this may use k1 */ \
 	jr	reg; \
 	 rfe
 			
Index: arch/mips/mm/tlbex-r4k.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/tlbex-r4k.S,v
retrieving revision 1.4
diff -u -p -r1.4 tlbex-r4k.S
--- arch/mips/mm/tlbex-r4k.S	2002/01/04 18:04:53	1.4
+++ arch/mips/mm/tlbex-r4k.S	2002/01/22 05:14:37
@@ -90,6 +90,7 @@
 	tlbwr					# write random tlb entry
 1:
 	nop
+	TST_DEV_EPILOGUE
 	eret					# return from trap
 	END(except_vec0_r4000)
 
@@ -117,6 +118,7 @@
 	nop
 	tlbwr
 	nop
+	TST_DEV_EPILOGUE
 	eret
 	END(except_vec0_r4600)
 
@@ -156,6 +158,7 @@
 	nop
 	tlbwr					# write random tlb entry
 	nop					# traditional nop
+	TST_DEV_EPILOGUE
 	eret					# return from trap
 	END(except_vec0_nevada)
 
@@ -187,6 +190,7 @@
 	tlbwr
 1:
 	nop
+	TST_DEV_EPILOGUE
 	eret
 	END(except_vec0_r45k_bvahwbug)
 
@@ -219,6 +223,7 @@
 	tlbwr
 1:
 	nop
+	TST_DEV_EPILOGUE
 	eret
 	END(except_vec0_r4k_mphwbug)
 #endif
@@ -250,6 +255,7 @@
 	tlbwr
 1:
 	nop
+	TST_DEV_EPILOGUE
 	eret
 	END(except_vec0_r4k_250MHZhwbug)
 
@@ -284,6 +290,7 @@
 	tlbwr
 1:
 	nop
+	TST_DEV_EPILOGUE
 	eret
 	END(except_vec0_r4k_MP250MHZhwbug)
 #endif
@@ -454,6 +461,7 @@ invalid_tlbl:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3	
 	eret
 	.set	mips0
@@ -478,6 +486,7 @@ nopage_tlbl:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3	
 	eret
 	.set	mips0
@@ -508,6 +517,7 @@ nopage_tlbs:
 	 tlbwi
 1:
 	nop
+	TST_DEV_EPILOGUE
 	.set	mips3
 	eret
 	.set	mips0
@@ -638,6 +648,7 @@ END(get_real_pte)
 	lui	k0, %hi(__saved_at)
 	lw	$at, %lo(__saved_at)(k0)	# restore at
 	lw	ra, %lo(__saved_ra)(k0)		# restore ra
+	TST_DEV_EPILOGUE
 	eret					# return from trap
 	END(translate_pte)
 
Index: drivers/char/Config.in
===================================================================
RCS file: /cvsroot/linux-mips/linux/drivers/char/Config.in,v
retrieving revision 1.29
diff -u -p -r1.29 Config.in
--- drivers/char/Config.in	2001/12/02 19:05:31	1.29
+++ drivers/char/Config.in	2002/01/22 05:33:21
@@ -269,3 +269,10 @@ if [ "$CONFIG_MIPS_ITE8172" = "y" ]; the
   tristate ' ITE GPIO' CONFIG_ITE_GPIO
 fi
 endmenu
+
+if [ "$CONFIG_MIPS" = "y" -a "$CONFIG_CPU_HAS_LLSC" = "n" ]; then
+   mainmenu_option next_comment
+   comment 'MIPS specific pseudo device driver'
+   tristate '  MIPS1 fast test and set support' CONFIG_MIPS_TST_DEV
+   endmenu
+fi
Index: drivers/char/Makefile
===================================================================
RCS file: /cvsroot/linux-mips/linux/drivers/char/Makefile,v
retrieving revision 1.24
diff -u -p -r1.24 Makefile
--- drivers/char/Makefile	2001/12/05 19:49:28	1.24
+++ drivers/char/Makefile	2002/01/22 05:33:21
@@ -24,7 +24,7 @@ obj-y	 += mem.o tty_io.o n_tty.o tty_ioc
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o lcd.o
+			au1000_gpio.o lcd.o tst_dev.o
 
 mod-subdirs	:=	joystick ftape drm pcmcia
 
@@ -247,6 +247,8 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_VR41XX_WDT) += vr41xxwdt.o
+
+obj-$(CONFIG_MIPS_TST_DEV) += tst_dev.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
Index: include/asm-mips/stackframe.h
===================================================================
RCS file: /cvsroot/linux-mips/linux/include/asm-mips/stackframe.h,v
retrieving revision 1.3
diff -u -p -r1.3 stackframe.h
--- include/asm-mips/stackframe.h	2001/10/24 23:32:54	1.3
+++ include/asm-mips/stackframe.h	2002/01/22 05:33:22
@@ -16,6 +16,15 @@
 #include <asm/offset.h>
 #include <linux/config.h>
 
+#if defined (CONFIG_MIPS_TST_DEV) || defined (CONFIG_MIPS_TST_DEV_MODULE)
+#include <linux/tst_dev.h>
+#define	TST_DEV_EPILOGUE \
+		li	k1, _TST_ACCESS_MAGIC;
+#else
+#define	TST_DEV_EPILOGUE
+#endif
+
+
 #define SAVE_AT                                          \
 		.set	push;                            \
 		.set	noat;                            \
@@ -195,6 +204,7 @@ __asm__ (                               
 		.set	noreorder;			 \
 		lw	k0, PT_EPC(sp);                  \
 		lw	sp,  PT_R29(sp);                 \
+		TST_DEV_EPILOGUE			 \
 		jr	k0;                              \
 		 rfe;					 \
 		.set	pop
@@ -230,6 +240,7 @@ __asm__ (                               
 
 #define RESTORE_SP_AND_RET                               \
 		lw	sp,  PT_R29(sp);                 \
+		TST_DEV_EPILOGUE			 \
 		.set	mips3;				 \
 		eret;					 \
 		.set	mips0
Index: include/linux/tst_dev.h
===================================================================
--- /dev/null	Wed May  6 05:32:27 1998
+++ include/linux/tst_dev.h	Mon Jan 21 14:29:50 2002
@@ -0,0 +1,37 @@
+/*
+ * tst_dev.h - MIPS1 TEST and SET pseudo device interface
+ */
+
+
+#ifndef _TST_DEV_H
+#define _TST_DEV_H
+
+#define TST_DEVICE_NAME	"tst"
+
+#ifndef _LANGUAGE_ASSEMBLY
+
+#include <linux/types.h>
+
+struct _tst_area_info {
+	__u32 	magic;
+	__u32 	pad1;
+	void 	*map_addr;
+#if _MIPS_SZPTR==32
+	__u32 	pad2;
+#endif
+	};
+
+#endif /*_LANGUAGE_ASSEMBLY*/
+
+#define _TST_INFO_MAGIC			0x20000304	/* obsolete */
+#define _TST_INFO_MAGIC_2ARGS		0x20000305
+
+#ifdef __KERNEL__
+#define _TST_ACCESS_MAGIC	0x00200000
+#define _TST_START_MAGIC	0x00300000
+#endif  /* __KERNEL_ */
+
+#endif  /*_TST_DEV_H */
+
+
+
Index: drivers/char/tst_dev.c
===================================================================
--- /dev/null	Wed May  6 05:32:27 1998
+++ drivers/char/tst_dev.c	Tue Jan 22 12:01:16 2002
@@ -0,0 +1,404 @@
+/*
+ * tst_dev.c - Test and Set device for mips which has not LL/SC. 
+ *
+ *        Copyright (C) 2000, 2001, 2002  Sony Computer Entertainment Inc.
+ *        Copyright 2001, 2002  Sony Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License Version 2. See the file "COPYING" in the main
+ * directory of this archive for more details.
+ *
+ */
+
+#include <linux/autoconf.h>
+
+#ifndef CONFIG_MIPS
+#error "Sorry, this device is for MIPS only."
+#endif
+#if  !defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+#error "Not on this device"
+#endif
+
+/*
+ * 	Setup/Clean up Driver Module
+ */
+
+#ifdef MODULE
+
+#ifndef EXPORT_SYMTAB
+#define EXPORT_SYMTAB
+#endif
+
+#if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
+#define MODVERSIONS
+#endif
+
+#ifdef MODVERSIONS
+#include <linux/modversions.h>
+#endif
+
+#endif /* MODULE */
+
+#include <linux/init.h>
+
+#include <linux/errno.h>	/* error codes */
+#include <linux/kernel.h>	/* printk() */
+#include <linux/fs.h>		/* file op. */
+#include <linux/proc_fs.h>	/* proc fs file op. */
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>	/* copy to/from user space */
+#include <asm/page.h>		/* page size */
+#include <asm/pgtable.h>	/* PAGE_READONLY */
+
+#include <linux/tst_dev.h>
+
+#include <linux/module.h>
+
+#include <linux/major.h>
+
+#ifndef TSTDEV_MAJOR
+#define TSTDEV_MAJOR    123
+#endif
+
+static int tst_major=TSTDEV_MAJOR;	
+
+EXPORT_SYMBOL(tst_major);	/* export symbole */
+MODULE_PARM(tst_major,"i");	/* as parameter on loaing */
+
+
+/*
+ * File Operations table
+ *	please refer <linux/fs.h> for other methods.
+ */
+
+static struct file_operations  tst_fops; 
+
+
+#ifndef TST_DEVICE_NAME
+#define  TST_DEVICE_NAME "tst"
+#endif 
+
+
+static spinlock_t lock;
+static struct page * tst_code_buffer = 0 ;
+static const __u32 tst_code[] = {
+/*   0:*/   0x0080d821,        //move    $k1,$a0
+/*   4:*/   0x8c820000,        //lw      $v0,0($a0)
+/*   8:*/   0x00000000,        //nop
+/*   c:*/   0x14400004,        //bnez    $v0,0x20
+/*  10:*/   0x00000000,        //nop
+/*  14:*/   0x1764fffa,        //bne     $k1,$a0,0x0
+/*  18:*/   0x00000000,        //nop
+/*  1c:*/   0xaf650000,        //sw      $a1,0($k1)
+/*  20:*/   0x03e00008,        //jr      $ra
+/*  24:*/   0x00000000,        //nop
+			0};
+
+
+EXPORT_SYMBOL(tst_code_buffer);	/* export symbole */
+
+/********************
+
+#include<asm/regdef.h>
+
+        .set noreorder
+0:
+        move    k1 ,a0
+        lw      v0, 0(a0)
+	nop
+        bnez    v0, 1f
+        nop
+        bne     k1, a0, 0b
+        nop
+        sw      a1, 0(k1)
+1:
+        jr      ra
+        nop
+
+*********************/
+
+
+
+
+static 
+int try_init_code_buffer(void)
+{
+
+	spin_lock(&lock);
+	if (!tst_code_buffer) {
+		tst_code_buffer = alloc_pages(GFP_KERNEL, 0);
+		spin_unlock(&lock);
+
+		if (!tst_code_buffer)
+			return -EBUSY;
+
+		clear_page(page_address(tst_code_buffer));
+
+		memcpy (page_address(tst_code_buffer), (void *)tst_code, 
+			sizeof (tst_code) * sizeof (tst_code[0]));
+
+	} else {
+		spin_unlock(&lock);
+	}
+	return 0;
+}
+
+#ifdef MODULE
+static 
+void try_free_code_buffer(void)
+{
+
+	spin_lock(&lock);
+	if (tst_code_buffer) {
+		page_t *pg = tst_code_buffer;
+		tst_code_buffer=0;
+		spin_unlock(&lock);
+		put_page (pg);
+	} else {
+		spin_unlock(&lock);
+	}
+}
+#endif
+
+static get_info_t get_tst_info;
+
+
+/*
+ * Caller of (*get_info)() is  proc_file_read() in fs/proc/generic.c
+ */
+static 
+int get_tst_info (char *buf, 	/*  allocated area for info */
+	       char **start, 	/*  return youown area if you allocate */
+	       off_t pos,	/*  pos arg of vfs read */
+	       int count)	/*  readable bytes */
+{
+
+/* SPRINTF does not exist in the kernel */
+#define MY_BUFSIZE 256
+#define MARGIN 16
+	char mybuf[MY_BUFSIZE+MARGIN];
+
+	int len;
+
+	len = sprintf(mybuf,
+		      "_TST_INFO_MAGIC:\t0x%8.8x\n"
+		      "_TST_START_MAGIC:\t0x%8.8x\n"
+		      "_TST_ACCESS_MAGIC:\t0x%8.8x\n",
+		      _TST_INFO_MAGIC_2ARGS,
+		      _TST_START_MAGIC,
+		      _TST_ACCESS_MAGIC
+		      );
+	if (len >= MY_BUFSIZE) mybuf[MY_BUFSIZE] = '\0';
+
+	if ( pos+count >= len ) {
+		count = len-pos;
+	}
+	memcpy (buf, mybuf+pos, count);
+	return count;
+}
+
+#ifdef MODULE
+
+#define tst_dev_init init_module
+
+void
+cleanup_module (void)
+{
+	/* free code buffer */
+	try_free_code_buffer();
+
+	/* unregister /proc entry */
+
+	(void) remove_proc_entry(TST_DEVICE_NAME, NULL);
+
+	/* unregister chrdev */
+	unregister_chrdev(tst_major, TST_DEVICE_NAME);
+}
+
+
+#endif /* MODULE */
+
+
+int __init tst_dev_init(void)
+{
+
+	int result;
+
+	spin_lock_init(&lock);
+
+	result = register_chrdev(tst_major, TST_DEVICE_NAME , &tst_fops);
+	if (result < 0) {
+		printk(KERN_WARNING 
+		       TST_DEVICE_NAME ": can't get major %d\n",tst_major);
+		return result;
+	}
+	if (tst_major == 0) tst_major = result; /* dynamic */
+
+	/*
+	 * register /proc entry, if you want.
+	 */
+
+
+	if (!create_proc_info_entry(TST_DEVICE_NAME, 0, NULL, &get_tst_info)) {
+		printk(KERN_WARNING 
+		       TST_DEVICE_NAME ": can't get proc entry\n");
+		unregister_chrdev(tst_major, TST_DEVICE_NAME);
+		return result;
+	}
+
+	(void) try_init_code_buffer();
+
+	return 0;
+}
+
+#ifndef MODULE
+__initcall(tst_dev_init);
+#endif
+
+
+//========================================================================
+
+/*
+ * VMA Opreations
+ */
+
+static void tst_vma_open(struct vm_area_struct *vma)
+{
+    MOD_INC_USE_COUNT;
+}
+
+static void tst_vma_close(struct vm_area_struct *vma)
+{
+    MOD_DEC_USE_COUNT;
+}
+
+struct page *
+tst_vma_nopage (struct vm_area_struct * area, 
+			unsigned long address, int write_access)
+{
+	if ( address  != _TST_START_MAGIC 
+	    || area->vm_start  != _TST_START_MAGIC
+	    || area->vm_pgoff != 0 )
+		return 0;
+
+	get_page(tst_code_buffer);
+	flush_page_to_ram(tst_code_buffer);
+	return tst_code_buffer;
+}
+
+
+static struct vm_operations_struct tst_vm_ops = {
+	open:tst_vma_open,
+	close:tst_vma_close,
+	nopage:tst_vma_nopage,
+};
+
+//========================================================================
+
+/*
+ * 	Device File Operations
+ */
+
+
+/*
+ * Open and Close
+ */
+
+static int tst_open (struct inode *p_inode, struct file *p_file)
+{
+	
+	int ret_code;
+        if ( p_file->f_mode & FMODE_WRITE ) {
+                return -EPERM;
+        }
+	
+	ret_code =  try_init_code_buffer ();
+	if (ret_code) {
+		return ret_code;
+	}
+
+	/* 
+	 * if you want store something for later processing, do it on
+	 * p_file->private_data .
+	 */
+        MOD_INC_USE_COUNT;
+        return 0;          /* success */
+}
+
+static int tst_release (struct inode *p_inode, struct file *p_file)
+{
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+
+/*
+ * Mmap
+ */
+static int tst_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long size;
+
+	if (vma->vm_start != _TST_START_MAGIC)
+		return -ENXIO;
+
+	if (vma->vm_pgoff != 0)
+		return -ENXIO;
+
+	size = vma->vm_end - vma->vm_start;
+	if (size != PAGE_SIZE)
+		return -EINVAL;
+
+	vma->vm_ops = &tst_vm_ops;
+
+	tst_vma_open(vma);
+
+	return 0;
+}
+
+
+/*
+ * Read
+ */
+static ssize_t tst_read(struct file *p_file, char * p_buff, size_t count, 
+		   loff_t * p_pos)
+{
+	
+	struct _tst_area_info info;
+	int data;
+	struct inode * p_inode;
+	int info_size = sizeof(info);
+
+	p_inode = p_file->f_dentry->d_inode;
+	data = MAJOR(p_inode->i_rdev);
+
+	info.magic = _TST_INFO_MAGIC_2ARGS;
+	info.pad1 = 0;
+	info.map_addr = (void *)_TST_START_MAGIC;
+#if _MIPS_SZPTR==32
+	info.pad2 = 0;
+#endif
+
+	if (*p_pos + count >= info_size){
+		count = info_size - *p_pos;
+	}
+	if(copy_to_user(p_buff,((char *)&info)+*p_pos, count)) {
+		return -EFAULT;
+	}
+	*p_pos += count;
+	return count;
+}
+
+static
+struct file_operations  tst_fops = {
+	/* ssize_t (*read) (struct file *, char *, size_t, loff_t *); */
+	read:tst_read,
+	/* int (*open) (struct inode *, struct file *); */
+	open:tst_open,
+	/* int (*release) (struct inode *, struct file *);*/
+	release:tst_release, 
+	/* int (*mmap) (struct file *, struct vm_area_struct *); */
+	mmap:tst_mmap,
+};
Index: arch/mips/kernel/head.S
===================================================================
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/head.S,v
retrieving revision 1.12
diff -u -p -r1.12 head.S
--- arch/mips/kernel/head.S	2002/01/04 18:04:53	1.12
+++ arch/mips/kernel/head.S	2002/01/22 05:48:36
@@ -101,6 +101,7 @@
 		addiu	k1, k1, 4
 1:		mtc0	k1, $24
 		RESTORE_ALL
+		TST_DEV_EPILOGUE
 		.word	0x4200001f      # deret, return EJTAG debug exception.
 		 nop
 		.set	at

----Next_Part(Tue_Jan_22_15:27:43_2002_135)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="glibc-2.2.3-mips-tas.patch"

Index: sysdeps/unix/sysv/linux/mips/Makefile
===================================================================
RCS file: /export/cvsroot/CoPE/cmplrs/glibc-2.2/sysdeps/unix/sysv/linux/mips/Makefile,v
retrieving revision 1.1.3.1
diff -u -p -r1.1.3.1 Makefile
--- sysdeps/unix/sysv/linux/mips/Makefile	13 Dec 2001 05:28:00 -0000	1.1.3.1
+++ sysdeps/unix/sysv/linux/mips/Makefile	22 Jan 2002 05:22:35 -0000
@@ -5,7 +5,7 @@ sysdep_routines += rt_sigsuspend rt_sigp
 endif
 
 ifeq ($(subdir),misc)
-sysdep_routines += cachectl cacheflush sysmips _test_and_set
+sysdep_routines += cachectl cacheflush sysmips _test_and_set mips1_tst
 
 sysdep_headers += sys/cachectl.h sys/sysmips.h sys/tas.h
 endif
Index: sysdeps/unix/sysv/linux/mips/Versions
===================================================================
RCS file: /export/cvsroot/CoPE/cmplrs/glibc-2.2/sysdeps/unix/sysv/linux/mips/Versions,v
retrieving revision 1.1.3.1
diff -u -p -r1.1.3.1 Versions
--- sysdeps/unix/sysv/linux/mips/Versions	13 Dec 2001 05:28:00 -0000	1.1.3.1
+++ sysdeps/unix/sysv/linux/mips/Versions	22 Jan 2002 05:22:35 -0000
@@ -17,5 +17,8 @@ libc {
   GLIBC_2.2 {
     # _*
     _test_and_set;
+    # mips1 test and set
+    __mips1_tst_func;
+    __mips1_tst_func_2args;
   }
 }
Index: sysdeps/unix/sysv/linux/mips/sys/tas.h
===================================================================
RCS file: /export/cvsroot/CoPE/cmplrs/glibc-2.2/sysdeps/unix/sysv/linux/mips/sys/tas.h,v
retrieving revision 1.1.3.1
diff -u -p -r1.1.3.1 tas.h
--- sysdeps/unix/sysv/linux/mips/sys/tas.h	13 Dec 2001 05:28:00 -0000	1.1.3.1
+++ sysdeps/unix/sysv/linux/mips/sys/tas.h	22 Jan 2002 05:22:35 -0000
@@ -23,6 +23,7 @@
 #include <features.h>
 #include <sgidefs.h>
 #include <sys/sysmips.h>
+#include <linux/config.h>
 
 __BEGIN_DECLS
 
@@ -34,7 +35,8 @@ extern int _test_and_set (int *p, int v)
 #  define _EXTERN_INLINE extern __inline
 # endif
 
-# if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+# if (_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE))
 
 _EXTERN_INLINE int
 _test_and_set (int *p, int v) __THROW
@@ -59,15 +61,19 @@ _test_and_set (int *p, int v) __THROW
   return r;
 }
 
-# else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+# else /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
+
+extern int (*__mips1_tst_func_2args)(volatile int *, int);
 
 _EXTERN_INLINE int
 _test_and_set (int *p, int v) __THROW
 {
-  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
+  return (*__mips1_tst_func_2args)((volatile int *)p, v); 
 }
 
-# endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+# endif /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
 
 #endif /* __USE_EXTERN_INLINES */
 
Index: sysdeps/unix/sysv/linux/mips/mips1_tst.c
===================================================================
--- /dev/null	Wed May  6 05:32:27 1998
+++ sysdeps/unix/sysv/linux/mips//mips1_tst.c	Mon Jan 21 19:35:38 2002
@@ -0,0 +1,155 @@
+/*
+- mips1_tst.c: fast test and set using /dev/tst.
+
+        Copyright (C) 2000  Sony Computer Entertainment Inc.
+        Copyright 2002  Sony Corp. 
+
+This file is subject to the terms and conditions of the GNU Library
+General Public License Version 2 or later. See the file "COPYING.LIB" 
+in the main directory of this archive for more details.
+*/
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include<sys/sysmips.h>
+
+#include<linux/tst_dev.h>
+#include<asm/sgidefs.h>
+
+
+static int init_tst_func(volatile int *spinlock);
+static int init_tst_func_2args(volatile int *spinlock, int val);
+
+static volatile short lock_setup=0;
+
+/*
+ * __mips1_tst_func: 
+ *	This interface was originally designed for glibc-2.0.[67] and 
+ *	used on PS2 linux with glibc-2.2.2. This interface can NOT accept 
+ *	2nd arg of _test_and_set() in glibc-2.2.
+ *	We maintain this old interface to keep binary compatibility.
+ *
+ * __mips1_tst_func_2args:
+ *	New interface which can accept 2nd arg of _test_and_set() 
+ *	in glibc-2.2.
+ *
+ */
+int (*__mips1_tst_func)(volatile int *) = (void *)init_tst_func;
+int (*__mips1_tst_func_2args)(volatile int *, int) = 
+					(void *)init_tst_func_2args;
+
+static int sysmips_tst_1arg(volatile int *spinlock)
+{
+    return sysmips((const int)MIPS_ATOMIC_SET,
+	    (const int)spinlock,
+	    (const int)1,
+	    (const int)NULL);
+}
+
+static int sysmips_tst_2args(volatile int *spinlock, int val)
+{
+    return sysmips((const int)MIPS_ATOMIC_SET,
+	    (const int)spinlock,
+	    (const int)val,
+	    (const int)NULL);
+}
+
+static int tst_1arg(volatile int *spinlock)
+{
+	return (*__mips1_tst_func_2args)(spinlock, 1) ;
+}
+
+static int tst_2args(volatile int *spinlock, int val)
+{
+	static volatile int lock;
+	int retval;
+
+	while ((*__mips1_tst_func)(&lock)!=0);
+	retval = *spinlock;
+	if (retval==0) {
+		*spinlock = val;
+	}
+	lock = 0;
+	return retval;
+}
+
+static void setup_tst_func(void)
+{
+	struct _tst_area_info info;
+	int fd;
+	void *addr;
+	int res;
+	size_t size = getpagesize();
+	int device_accept_2args = 0;
+
+	while (sysmips((const int)MIPS_ATOMIC_SET,
+		(const int)&lock_setup,
+		(const int)1,
+		(const int)NULL)) ;
+	
+	if ( __mips1_tst_func != init_tst_func ){
+		lock_setup=0;
+		return;
+	}
+
+	fd = open( "/dev/" TST_DEVICE_NAME , O_RDONLY);
+	if (fd < 0)  goto fail;
+
+	res = read ( fd, &info, sizeof(info));
+	switch (info.magic) {
+	    case _TST_INFO_MAGIC:
+	    	break;
+	    case _TST_INFO_MAGIC_2ARGS:
+	    	device_accept_2args = 1;
+	    	break;
+	    default:
+		close(fd);
+		goto fail;
+	}
+
+	addr=(void *)mmap(info.map_addr, size,
+		PROT_READ|PROT_EXEC, MAP_SHARED|MAP_FIXED,
+		fd, 0);
+	close(fd);
+
+	if (addr != info.map_addr ) {
+		if (addr != (void *)0 && addr !=(void *) -1)
+			munmap(addr,size);
+		goto fail;
+	}
+
+	if (device_accept_2args) {
+		/* Use new device interface */
+		__mips1_tst_func_2args = addr;
+		__mips1_tst_func = tst_1arg;
+	} else {
+		/* Use old device interface */
+		__mips1_tst_func_2args = tst_2args;
+		__mips1_tst_func = addr;
+		
+	}
+	lock_setup=0;
+    	return;
+    fail:
+    	/* last resort */
+	__mips1_tst_func = sysmips_tst_1arg;
+	__mips1_tst_func_2args = sysmips_tst_2args;
+	lock_setup=0;
+    	return;
+}
+
+static int init_tst_func(volatile int *spinlock)
+{
+	setup_tst_func();
+	return (*__mips1_tst_func)(spinlock) ;
+}
+
+static int init_tst_func_2args(volatile int *spinlock, int val)
+{
+	setup_tst_func();
+	return (*__mips1_tst_func_2args)(spinlock, val) ;
+}
+

----Next_Part(Tue_Jan_22_15:27:43_2002_135)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linuxthread-2.2.3-mips-tas.patch"

Index: linuxthreads/sysdeps/mips/pspinlock.c
===================================================================
RCS file: /export/cvsroot/CoPE/cmplrs/glibc-2.2/linuxthreads/sysdeps/mips/pspinlock.c,v
retrieving revision 1.1.3.1
diff -u -p -r1.1.3.1 pspinlock.c
--- linuxthreads/sysdeps/mips/pspinlock.c	13 Dec 2001 05:28:33 -0000	1.1.3.1
+++ linuxthreads/sysdeps/mips/pspinlock.c	22 Jan 2002 05:25:59 -0000
@@ -23,7 +23,9 @@
 #include <sys/tas.h>
 #include "internals.h"
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+
+#if (_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE))
 
 /* This implementation is similar to the one used in the Linux kernel.  */
 int
@@ -49,7 +51,8 @@ __pthread_spin_lock (pthread_spinlock_t 
   return 0;
 }
 
-#else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+#else /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
 
 int
 __pthread_spin_lock (pthread_spinlock_t *lock)
@@ -58,7 +61,8 @@ __pthread_spin_lock (pthread_spinlock_t 
   return 0;
 }
 
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+#endif /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
 
 weak_alias (__pthread_spin_lock, pthread_spin_lock)
 
@@ -66,8 +70,7 @@ weak_alias (__pthread_spin_lock, pthread
 int
 __pthread_spin_trylock (pthread_spinlock_t *lock)
 {
-  /* To be done.  */
-  return 0;
+  return (_test_and_set (lock, 1) ? EBUSY : 0);
 }
 weak_alias (__pthread_spin_trylock, pthread_spin_trylock)
 
Index: linuxthreads/sysdeps/mips/pt-machine.h
===================================================================
RCS file: /export/cvsroot/CoPE/cmplrs/glibc-2.2/linuxthreads/sysdeps/mips/pt-machine.h,v
retrieving revision 1.1.3.1
diff -u -p -r1.1.3.1 pt-machine.h
--- linuxthreads/sysdeps/mips/pt-machine.h	13 Dec 2001 05:28:33 -0000	1.1.3.1
+++ linuxthreads/sysdeps/mips/pt-machine.h	22 Jan 2002 05:25:59 -0000
@@ -33,7 +33,8 @@
 
 /* Spinlock implementation; required.  */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+#if (_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE))
 
 PT_EI long int
 testandset (int *spinlock)
@@ -60,14 +61,16 @@ testandset (int *spinlock)
   return ret;
 }
 
-#else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+#else /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
 
 PT_EI long int
 testandset (int *spinlock)
 {
   return _test_and_set (spinlock, 1);
 }
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+#endif /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/
 
 
 /* Get some notion of the current stack.  Need not be exactly the top
@@ -78,7 +81,8 @@ register char * stack_pointer __asm__ ("
 
 /* Compare-and-swap for semaphores. */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+#if (_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE))
 
 #define HAS_COMPARE_AND_SWAP
 PT_EI int
@@ -106,4 +110,5 @@ __compare_and_swap (long int *p, long in
   return ret;
 }
 
-#endif /* (_MIPS_ISA >= _MIPS_ISA_MIPS2) */
+#endif /* !((_MIPS_ISA >= _MIPS_ISA_MIPS2) && \
+       !(defined(CONFIG_MIPS_TST_DEV) || defined(CONFIG_MIPS_TST_DEV_MODULE)))*/

----Next_Part(Tue_Jan_22_15:27:43_2002_135)----
