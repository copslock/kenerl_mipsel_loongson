Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 01:42:00 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:42278 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103469AbZAHBl5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 01:41:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496559d40000>; Wed, 07 Jan 2009 20:41:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 17:41:39 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 17:41:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n081fbfN025951;
	Wed, 7 Jan 2009 17:41:37 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n081fapH025949;
	Wed, 7 Jan 2009 17:41:36 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Add option for running kernel in mapped address space.
Date:	Wed,  7 Jan 2009 17:41:36 -0800
Message-Id: <1231378896-25925-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 08 Jan 2009 01:41:39.0673 (UTC) FILETIME=[403BBC90:01C97132]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a preliminary patch to allow the kernel to run in mapped
address space via a wired TLB entry.  Probably in a future version I
would factor out the OCTEON specific parts to a separate patch.

Each supported processor would probably need to doctor up its
kernel-entry-init.h in a similar manner.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                                  |   17 +++++++
 arch/mips/Makefile                                 |   10 ++++-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   50 ++++++++++++++++++++
 arch/mips/include/asm/page.h                       |   10 ++++-
 arch/mips/include/asm/pgtable-64.h                 |    7 ++-
 arch/mips/kernel/traps.c                           |   23 +++++++--
 arch/mips/kernel/vmlinux.lds.S                     |   11 ++++-
 arch/mips/mm/page.c                                |    6 ++
 arch/mips/mm/tlb-r4k.c                             |    4 ++
 9 files changed, 129 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 780b520..d9c46a4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1431,6 +1431,23 @@ config PAGE_SIZE_64KB
 
 endchoice
 
+config MAPPED_KERNEL
+	bool "Mapped kernel"
+	help
+	  Select this option if you want the kernel's code and data to
+	  be in mapped memory.  The kernel will be mapped using a
+	  single wired TLB entry, thus reducing the number of
+	  available TLB entries by one.  Kernel modules will be able
+	  to use a more efficient calling convention.
+
+config PHYS_LOAD_ADDRESS
+	hex "Physical load address"
+	depends on MAPPED_KERNEL
+	default ffffffff81400000
+	help
+	  The physical load address reflected as the program header
+	  physical address in the kernel ELF image.
+
 config BOARD_SCACHE
 	bool
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0bc2120..5468f6d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -82,7 +82,10 @@ all-$(CONFIG_BOOT_ELF64)	:= $(vmlinux-64)
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
 cflags-y			+= -msoft-float
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
+
+ifndef CONFIG_MAPPED_KERNEL
 MODFLAGS			+= -mlong-calls
+endif
 
 cflags-y += -ffreestanding
 
@@ -605,6 +608,11 @@ endif
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
+ifdef CONFIG_MAPPED_KERNEL
+  PHYS_LOAD_ADDRESS = -D"PHYSADDR=0x$(CONFIG_PHYS_LOAD_ADDRESS)"
+  load-y = 0xffffffffc0000000
+endif
+
 ifdef CONFIG_32BIT
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 JIFFIES			= jiffies_64
@@ -662,7 +670,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
 
 CPPFLAGS_vmlinux.lds := \
 	$(KBUILD_CFLAGS) \
-	-D"LOADADDR=$(load-y)" \
+	-D"LOADADDR=$(load-y)" $(PHYS_LOAD_ADDRESS) \
 	-D"JIFFIES=$(JIFFIES)" \
 	-D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index 0b2b5eb..bf36d82 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -27,6 +27,56 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+#ifdef CONFIG_MAPPED_KERNEL
+	# Set up the TLB index 0 for wired access to kernel.
+	# Assume we were loaded with sufficient alignment so that we
+	# can cover the image with two pages.
+	dla	v0, _end
+	dla	v1, _text
+	dsubu	v0, v0, v1	# size of image
+	move	v1, zero
+	li	t1, -1		# shift count.
+1:	dsrl	v0, v0, 1	# mask into v1
+	dsll	v1, v1, 1
+	daddiu	t1, t1, 1
+	ori	v1, v1, 1
+	bne	v0, zero, 1b
+	daddiu	t2, t1, -6
+	mtc0	v1, $5, 0	# PageMask
+	dla	t3, 0xffffffffc0000000 # kernel address
+	dmtc0	t3, $10, 0	# EntryHi
+	bal	1f
+1:	dla	v0, 0x7fffffff
+	and	ra, ra, v0	# physical address of pc in ra
+	dsrl	v1, v1, 1
+	nor	v1, v1, zero
+	and	ra, ra, v1
+	dsubu	v1, t3, ra	# virtual to physical offset into v1
+	dsrlv	v0, ra, t1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $2, 0  # EntryLo1
+	dsrlv	v0, ra, t1
+	daddiu	v0, v0, 1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $3, 0  # EntryLo2
+	mtc0	$0, $0, 0  # Set index to zero
+	tlbwi
+	li	v0, 1
+	mtc0	v0, $6, 0  # Wired
+	dla	v0, phys_to_kernel_offset
+	sd	v1, 0(v0)
+	dla	v0, kernel_image_end
+	li	v1, 2
+	dsllv	v1, v1, t1
+	daddu	v1, v1, t3
+	sd	v1, 0(v0)
+	dla	v0, continue_in_mapped_space
+	jr	v0
+
+continue_in_mapped_space:
+#endif
 	# Read the cavium mem control register
 	dmfc0   v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index fe7a88e..5a20413 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -151,7 +151,15 @@ typedef struct { unsigned long pgprot; } pgprot_t;
     ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
 #endif
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
-#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+
+#ifndef __ASSEMBLY__
+# ifdef CONFIG_MAPPED_KERNEL
+extern unsigned long phys_to_kernel_offset;
+#  define __pa_symbol(x)	(RELOC_HIDE((unsigned long)(x), 0) - phys_to_kernel_offset)
+# else
+#  define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
+# endif
+#endif
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 943515f..1905a43 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -107,7 +107,12 @@
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
-#define MODULE_START	CKSSEG
+#ifdef CONFIG_MAPPED_KERNEL
+extern unsigned long kernel_image_end;
+#define MODULE_START	kernel_image_end
+#else
+#define MODULE_START   CKSSEG
+#endif
 #define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
 extern pgd_t module_pg_dir[PTRS_PER_PGD];
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1055348..b44bcf8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -49,6 +49,8 @@
 #include <asm/stacktrace.h>
 #include <asm/irq.h>
 
+#include "../mm/uasm.h"
+
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
 extern asmlinkage void rollback_handle_int(void);
@@ -1295,9 +1297,18 @@ void *set_except_vector(int n, void *addr)
 
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
-		*(u32 *)(ebase + 0x200) = 0x08000000 |
-					  (0x03ffffff & (handler >> 2));
-		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
+		unsigned long jump_mask = ~((1 << 28) - 1);
+		u32 *buf = (u32 *)(ebase + 0x200);
+		unsigned int k0 = 26;
+		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
+			uasm_i_j(&buf, handler & jump_mask);
+			uasm_i_nop(&buf);
+		} else {
+			UASM_i_LA(&buf, k0, handler);
+			uasm_i_jr(&buf, k0);
+			uasm_i_nop(&buf);
+		}
+		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);
 	}
 	return (void *)old_handler;
 }
@@ -1570,6 +1581,8 @@ void __cpuinit per_cpu_trap_init(void)
 			evpe(vpflags);
 		} else
 			set_c0_cause(CAUSEF_IV);
+	} else {
+		clear_c0_cause(CAUSEF_IV);
 	}
 
 	/*
@@ -1670,9 +1683,9 @@ void __init trap_init(void)
 		return;	/* Already done */
 #endif
 
-	if (cpu_has_veic || cpu_has_vint)
+	if (cpu_has_veic || cpu_has_vint) {
 		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
-	else {
+	} else {
 		ebase = CAC_BASE;
 		if (cpu_has_mips_r2)
 			ebase += (read_c0_ebase() & 0x3ffff000);
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 58738c8..f96c332 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -4,11 +4,20 @@
 #undef mips
 #define mips mips
 OUTPUT_ARCH(mips)
+#ifdef PHYSADDR
+ENTRY(phys_entry)
+#define AT_LOCATION AT(PHYSADDR)
+#else
 ENTRY(kernel_entry)
+#define AT_LOCATION
+#endif
 PHDRS {
-	text PT_LOAD FLAGS(7);	/* RWX */
+	text PT_LOAD AT_LOCATION FLAGS(7);	/* RWX */
 	note PT_NOTE FLAGS(4);	/* R__ */
 }
+#ifdef PHYSADDR
+phys_entry = kernel_entry - LOADADDR + PHYSADDR;
+#endif
 jiffies = JIFFIES;
 
 SECTIONS
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 1417c64..0070aa0 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -687,3 +687,9 @@ void copy_page(void *to, void *from)
 }
 
 #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
+
+#ifdef CONFIG_MAPPED_KERNEL
+/* Initialized so it is not clobbered when .bss is zeroed.  */
+unsigned long phys_to_kernel_offset = 1;
+unsigned long kernel_image_end = 1;
+#endif
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 5ce2fa7..ebe4ee8 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -477,8 +477,12 @@ void __cpuinit tlb_init(void)
 	 */
 	probe_tlb(config);
 	write_c0_pagemask(PM_DEFAULT_MASK);
+#ifndef CONFIG_MAPPED_KERNEL
 	write_c0_wired(0);
+#endif
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 	write_c0_framemask(0);
+#endif
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
         /* From this point on the ARC firmware is dead.  */
-- 
1.5.6.6
