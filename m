Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 16:04:16 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:41403 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123891AbSJAOEO>; Tue, 1 Oct 2002 16:04:14 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA15496;
	Tue, 1 Oct 2002 16:04:37 +0200 (MET DST)
Date: Tue, 1 Oct 2002 16:04:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [resend] System memory /proc/iomem fixes and updates
Message-ID: <Pine.GSO.3.96.1021001155746.13606E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 [Sending this for the third time -- if others don't care then at least my
MS02-NV driver depends on proper memory resource reservation.]

 I discovered /proc/iomem is broken for system memory resources.
Apparently since highmem support went in.  Here are fixes and a few
updates as follows:

1. Resource areas are measured in bytes and not pages (that's the problem
metioned above).  Includes fixes for off-by-one errors for upper limits.

2. Moved mips bootmem allocation and resource reservation to bootmem_init
similarly to mips64.

3. Added resource reservation for mips64.

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020904-mem-regions-7
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020904.macro/arch/mips/kernel/setup.c linux-mips-2.4.19-rc1-20020904/arch/mips/kernel/setup.c
--- linux-mips-2.4.19-rc1-20020904.macro/arch/mips/kernel/setup.c	2002-09-03 02:56:40.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020904/arch/mips/kernel/setup.c	2002-09-09 09:51:38.000000000 +0000
@@ -7,7 +7,7 @@
  * Copyright (C) 1995  Waldorf Electronics
  * Copyright (C) 1995, 1996, 1997, 1998, 1999, 2000, 2001  Ralf Baechle
  * Copyright (C) 1996  Stoned Elipot
- * Copyright (C) 2000, 2001  Maciej W. Rozycki
+ * Copyright (C) 2000, 2001, 2002  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -236,6 +236,235 @@ static inline void parse_mem_cmdline(voi
 	}
 }
 
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+#define MAXMEM		HIGHMEM_START
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+
+static inline void bootmem_init(void)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	unsigned long tmp;
+	unsigned long *initrd_header;
+#endif
+	unsigned long bootmap_size;
+	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
+	int i;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+	if (tmp < (unsigned long)&_end)
+		tmp += PAGE_SIZE;
+	initrd_header = (unsigned long *)tmp;
+	if (initrd_header[0] == 0x494E5244) {
+		initrd_start = (unsigned long)&initrd_header[2];
+		initrd_end = initrd_start + initrd_header[1];
+	}
+	start_pfn = PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
+#else
+	/*
+	 * Partially used pages are not usable - thus
+	 * we are rounding upwards.
+	 */
+	start_pfn = PFN_UP(__pa(&_end));
+#endif	/* CONFIG_BLK_DEV_INITRD */
+
+	/* Find the highest page frame number we have available.  */
+	max_pfn = 0;
+	first_usable_pfn = -1UL;
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long start, end;
+
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end = PFN_DOWN(boot_mem_map.map[i].addr
+		      + boot_mem_map.map[i].size);
+
+		if (start >= end)
+			continue;
+		if (end > max_pfn)
+			max_pfn = end;
+		if (start < first_usable_pfn) {
+			if (start > start_pfn) {
+				first_usable_pfn = start;
+			} else if (end > start_pfn) {
+				first_usable_pfn = start_pfn;
+			}
+		}
+	}
+
+	/*
+	 * Determine low and high memory ranges
+	 */
+	max_low_pfn = max_pfn;
+	if (max_low_pfn > MAXMEM_PFN) {
+		max_low_pfn = MAXMEM_PFN;
+#ifndef CONFIG_HIGHMEM
+		/* Maximum memory usable is what is directly addressable */
+		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
+		       MAXMEM>>20);
+		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
+#endif
+	}
+
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * Crude, we really should make a better attempt at detecting
+	 * highstart_pfn
+	 */
+	highstart_pfn = highend_pfn = max_pfn;
+	if (max_pfn > MAXMEM_PFN) {
+		highstart_pfn = MAXMEM_PFN;
+		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+		       (highend_pfn - highstart_pfn) >> (20 - PAGE_SHIFT));
+	}
+#endif
+
+	/* Initialize the boot-time allocator with low memory only.  */
+	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);
+
+	/*
+	 * Register fully available low RAM pages with the bootmem allocator.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long curr_pfn, last_pfn, size;
+
+		/*
+		 * Reserve usable memory.
+		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		/*
+		 * We are rounding up the start address of usable memory:
+		 */
+		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
+		if (curr_pfn >= max_low_pfn)
+			continue;
+		if (curr_pfn < start_pfn)
+			curr_pfn = start_pfn;
+
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
+				    + boot_mem_map.map[i].size);
+
+		if (last_pfn > max_low_pfn)
+			last_pfn = max_low_pfn;
+
+		/*
+		 * Only register lowmem part of lowmem segment with bootmem.
+		 */
+		size = last_pfn - curr_pfn;
+		if (curr_pfn > PFN_DOWN(HIGHMEM_START))
+			continue;
+		if (curr_pfn + size - 1 > PFN_DOWN(HIGHMEM_START))
+			size = PFN_DOWN(HIGHMEM_START) - curr_pfn;
+		if (!size)
+			continue;
+
+		/*
+		 * ... finally, did all the rounding and playing
+		 * around just make the area go away?
+		 */
+		if (last_pfn <= curr_pfn)
+			continue;
+
+		/* Register lowmem ranges */
+		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
+	}
+
+	/* Reserve the bootmap memory.  */
+	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Board specific code should have set up initrd_start and initrd_end */
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	if (&__rd_start != &__rd_end) {
+		initrd_start = (unsigned long)&__rd_start;
+		initrd_end = (unsigned long)&__rd_end;
+	}
+	initrd_below_start_ok = 1;
+	if (initrd_start) {
+		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start);
+		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
+		       (void *)initrd_start,
+		       initrd_size);
+		if (PHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+			printk("initrd extends beyond end of memory "
+			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			       PHYSADDR(initrd_end),
+			       PFN_PHYS(max_low_pfn));
+			initrd_start = initrd_end = 0;
+		}
+	}
+#endif /* CONFIG_BLK_DEV_INITRD  */
+}
+
+static inline void resource_init(void)
+{
+	int i;
+
+	code_resource.start = virt_to_bus(&_ftext);
+	code_resource.end = virt_to_bus(&_etext) - 1;
+	data_resource.start = virt_to_bus(&_fdata);
+	data_resource.end = virt_to_bus(&_edata) - 1;
+
+	/*
+	 * Request address space for all standard RAM.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		struct resource *res;
+		unsigned long start, end;
+
+		start = boot_mem_map.map[i].addr;
+		end = boot_mem_map.map[i].addr + boot_mem_map.map[i].size - 1;
+		if (start >= MAXMEM)
+			continue;
+		if (end >= MAXMEM)
+			end = MAXMEM - 1;
+
+		res = alloc_bootmem(sizeof(struct resource));
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_ROM_DATA:
+			res->name = "System RAM";
+			break;
+		case BOOT_MEM_RESERVED:
+		default:
+			res->name = "reserved";
+		}
+
+		res->start = start;
+		res->end = end;
+
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		request_resource(&iomem_resource, res);
+
+		/*
+		 *  We dont't know which RAM region contains kernel data,
+		 *  so we try it repeatedly and let the resource manager
+		 *  test it.
+		 */
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+	}
+}
+
+#undef PFN_UP
+#undef PFN_DOWN
+#undef PFN_PHYS
+
+#undef MAXMEM
+#undef MAXMEM_PFN
+
+
 void __init setup_arch(char **cmdline_p)
 {
 	void atlas_setup(void);
@@ -247,7 +476,7 @@ void __init setup_arch(char **cmdline_p)
 	void jazz_setup(void);
 	void sni_rm200_pci_setup(void);
 	void ip22_setup(void);
-        void ev96100_setup(void);
+	void ev96100_setup(void);
 	void malta_setup(void);
 	void sead_setup(void);
 	void ikos_setup(void);
@@ -262,15 +491,6 @@ void __init setup_arch(char **cmdline_p)
 	void swarm_setup(void);
 	void hp_setup(void);
 
-	unsigned long bootmap_size;
-	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
-#ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long tmp;
-	unsigned long* initrd_header;
-#endif
-
-	int i;
-
 #ifdef CONFIG_BLK_DEV_FD
 	fd_ops = &no_fd_ops;
 #endif
@@ -441,210 +661,11 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_mem_cmdline();
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
-#define MAXMEM		HIGHMEM_START
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
-	if (tmp < (unsigned long)&_end)
-		tmp += PAGE_SIZE;
-	initrd_header = (unsigned long *)tmp;
-	if (initrd_header[0] == 0x494E5244) {
-		initrd_start = (unsigned long)&initrd_header[2];
-		initrd_end = initrd_start + initrd_header[1];
-	}
-	start_pfn = PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
-#else
-	/*
-	 * Partially used pages are not usable - thus
-	 * we are rounding upwards.
-	 */
-	start_pfn = PFN_UP(__pa(&_end));
-#endif	/* CONFIG_BLK_DEV_INITRD */
-
-	/* Find the highest page frame number we have available.  */
-	max_pfn = 0;
-	first_usable_pfn = -1UL;
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start, end;
-
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end = PFN_DOWN(boot_mem_map.map[i].addr
-		      + boot_mem_map.map[i].size);
-
-		if (start >= end)
-			continue;
-		if (end > max_pfn)
-			max_pfn = end;
-		if (start < first_usable_pfn) {
-			if (start > start_pfn) {
-				first_usable_pfn = start;
-			} else if (end > start_pfn) {
-				first_usable_pfn = start_pfn;
-			}
-		}
-	}
-
-	/*
-	 * Determine low and high memory ranges
-	 */
-	max_low_pfn = max_pfn;
-	if (max_low_pfn > MAXMEM_PFN) {
-		max_low_pfn = MAXMEM_PFN;
-#ifndef CONFIG_HIGHMEM
-		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-		       MAXMEM>>20);
-		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
-#endif
-	}
-
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * Crude, we really should make a better attempt at detecting
-	 * highstart_pfn
-	 */
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > MAXMEM_PFN) {
-		highstart_pfn = MAXMEM_PFN;
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		       (highend_pfn - highstart_pfn) >> (20 - PAGE_SHIFT));
-	}
-#endif
-
-	/* Initialize the boot-time allocator with low memory only.  */
-	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);
-
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
-
-		/*
-		 * Reserve usable memory.
-		 */
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
-		if (curr_pfn >= max_low_pfn)
-			continue;
-		if (curr_pfn < start_pfn)
-			curr_pfn = start_pfn;
-
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
-				    + boot_mem_map.map[i].size);
-
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
-
-		/*
-		 * Only register lowmem part of lowmem segment with bootmem.
-		 */
-		size = last_pfn - curr_pfn;
-		if (curr_pfn > PFN_DOWN(HIGHMEM_START))
-			continue;
-		if (curr_pfn + size - 1 > PFN_DOWN(HIGHMEM_START))
-			size = PFN_DOWN(HIGHMEM_START) - curr_pfn;
-		if (!size)
-			continue;
-
-		/*
-		 * ... finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
-
-		/* Register lowmem ranges */
-		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
-	}
-
-	/* Reserve the bootmap memory.  */
-	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* Board specific code should have set up initrd_start and initrd_end */
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	if (&__rd_start != &__rd_end) {
-		initrd_start = (unsigned long)&__rd_start;
-		initrd_end = (unsigned long)&__rd_end;
-	}
-	initrd_below_start_ok = 1;
-	if (initrd_start) {
-		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start);
-		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *)initrd_start,
-		       initrd_size);
-		if (PHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
-			printk("initrd extends beyond end of memory "
-			       "(0x%lx > 0x%p)\ndisabling initrd\n",
-			       PHYSADDR(initrd_end),
-			       PFN_PHYS(max_low_pfn));
-			initrd_start = initrd_end = 0;
-		}
-	}
-#endif /* CONFIG_BLK_DEV_INITRD  */
+	bootmem_init();
 
 	paging_init();
 
-	code_resource.start = virt_to_bus(&_ftext);
-	code_resource.end = virt_to_bus(&_etext) - 1;
-	data_resource.start = virt_to_bus(&_fdata);
-	data_resource.end = virt_to_bus(&_edata) - 1;
-
-	/*
-	 * Request address space for all standard RAM.
-	 */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		struct resource *res;
-		unsigned long addr_pfn, end_pfn;
-
-		res = alloc_bootmem(sizeof(struct resource));
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-		case BOOT_MEM_ROM_DATA:
-			res->name = "System RAM";
-			break;
-		case BOOT_MEM_RESERVED:
-		default:
-			res->name = "reserved";
-		}
-		addr_pfn = PFN_UP(boot_mem_map.map[i].addr);
-		end_pfn = PFN_UP(boot_mem_map.map[i].addr+boot_mem_map.map[i].size);
-		if (addr_pfn > max_low_pfn)
-			continue;
-		res->start = boot_mem_map.map[i].addr;
-		if (end_pfn < max_low_pfn) {
-			res->end = res->start + boot_mem_map.map[i].size - 1;
-		} else {
-			res->end = max_low_pfn - 1;
-		}
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
-
-		/*
-		 *  We dont't know which RAM region contains kernel data,
-		 *  so we try it repeatedly and let the resource manager
-		 *  test it.
-		 */
-		request_resource(res, &code_resource);
-		request_resource(res, &data_resource);
-	}
+	resource_init();
 }
 
 static int __init fpu_disable(char *s)
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020904.macro/arch/mips64/kernel/setup.c linux-mips-2.4.19-rc1-20020904/arch/mips64/kernel/setup.c
--- linux-mips-2.4.19-rc1-20020904.macro/arch/mips64/kernel/setup.c	2002-09-03 02:58:10.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020904/arch/mips64/kernel/setup.c	2002-09-08 23:28:19.000000000 +0000
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -88,8 +89,7 @@ unsigned long mips_machgroup = MACH_GROU
 struct boot_mem_map boot_mem_map;
 
 unsigned char aux_device_present;
-
-extern void load_mmu(void);
+extern char _ftext, _etext, _fdata, _edata, _end;
 
 static char command_line[CL_SIZE] = { 0, };
        char saved_command_line[CL_SIZE];
@@ -119,6 +119,9 @@ extern void load_mmu(void);
 extern ATTRIB_NORET asmlinkage void start_kernel(void);
 extern void prom_init(int, char **, char **, int *);
 
+static struct resource code_resource = { "Kernel code" };
+static struct resource data_resource = { "Kernel data" };
+
 asmlinkage void __init init_arch(int argc, char **argv, char **envp,
 	int *prom_vec)
 {
@@ -243,7 +246,12 @@ static inline void parse_mem_cmdline(voi
 	}
 }
 
-void bootmem_init(void)
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+static inline void bootmem_init(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long tmp;
@@ -252,11 +260,6 @@ void bootmem_init(void)
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn;
 	int i;
-	extern int _end;
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
 
 	/*
 	 * Partially used pages are not usable - thus
@@ -349,12 +352,55 @@ void bootmem_init(void)
 			*memory_start_p = initrd_end;
 	}
 #endif
+}
+
+static inline void resource_init(void)
+{
+	int i;
+
+	code_resource.start = virt_to_bus(&_ftext);
+	code_resource.end = virt_to_bus(&_etext) - 1;
+	data_resource.start = virt_to_bus(&_fdata);
+	data_resource.end = virt_to_bus(&_edata) - 1;
+
+	/*
+	 * Request address space for all standard RAM.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		struct resource *res;
+
+		res = alloc_bootmem(sizeof(struct resource));
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_ROM_DATA:
+			res->name = "System RAM";
+			break;
+		case BOOT_MEM_RESERVED:
+		default:
+			res->name = "reserved";
+		}
+
+		res->start = boot_mem_map.map[i].addr;
+		res->end = boot_mem_map.map[i].addr +
+			   boot_mem_map.map[i].size - 1;
+
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		request_resource(&iomem_resource, res);
+
+		/*
+		 *  We dont't know which RAM region contains kernel data,
+		 *  so we try it repeatedly and let the resource manager
+		 *  test it.
+		 */
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+	}
+}
 
 #undef PFN_UP
 #undef PFN_DOWN
 #undef PFN_PHYS
 
-}
 
 void __init setup_arch(char **cmdline_p)
 {
@@ -385,6 +431,8 @@ void __init setup_arch(char **cmdline_p)
 	bootmem_init();
 
 	paging_init();
+
+	resource_init();
 }
 
 int __init fpu_disable(char *s)
