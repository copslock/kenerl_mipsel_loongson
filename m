Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 08:07:22 +0000 (GMT)
Received: from smtp9.wanadoo.fr ([IPv6:::ffff:193.252.22.22]:14398 "EHLO
	smtp9.wanadoo.fr") by linux-mips.org with ESMTP id <S8225273AbVANIHM>;
	Fri, 14 Jan 2005 08:07:12 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0907.wanadoo.fr (SMTP Server) with ESMTP id 17C621C00174
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 09:07:06 +0100 (CET)
Received: from smtp.innova-card.com (AMarseille-206-1-6-143.w80-14.abo.wanadoo.fr [80.14.198.143])
	by mwinf0907.wanadoo.fr (SMTP Server) with ESMTP id 0D6C01C00102
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 09:07:05 +0100 (CET)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP id 55F543803D
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 09:07:00 +0100 (CET)
Message-ID: <41E77D7A.50303@innova-card.com>
Date: Fri, 14 Jan 2005 09:06:18 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c (clean up only)
References: <41E38CDA.0@innova-card.com> <41E39204.1000204@innova-card.com>
In-Reply-To: <41E39204.1000204@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <franck.bui-huu@innova-card.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: franck.bui-huu@innova-card.com
Precedence: bulk
X-list: linux-mips

Well, thanks for your answers...
Are there any protocols for submiting patchs that I should know ?

Thanks.

    Franck

Franck Bui-Huu wrote:

> Here it is !
>
>    Franck.
>
> Franck Bui-Huu wrote:
>
>> Hi,
>>
>> Here is a patch that contains some clean up for bootmem_init()
>> function. It should be (...well I hope so :-) ) a little bit more
>> readable than previous versions.
>>
>> Now IP27's specific code could be easly moved into its boot
>> memory init. Look for FIXME pattern...
>>
>>    Franck.
>>
>>
>>
>
>------------------------------------------------------------------------
>
>--- setup-1_178.c	2005-01-10 19:18:29.000000000 +0100
>+++ setup.c	2005-01-11 09:12:17.401209352 +0100
>@@ -67,6 +67,7 @@
> EXPORT_SYMBOL(mips_machtype);
> EXPORT_SYMBOL(mips_machgroup);
> 
>+int bootmem_init_ok;
> struct boot_mem_map boot_mem_map;
> 
> static char command_line[CL_SIZE];
>@@ -76,7 +77,7 @@
>  * mips_io_port_base is the begin of the address space to which x86 style
>  * I/O ports are mapped.
>  */
>-const unsigned long mips_io_port_base = -1;
>+unsigned long mips_io_port_base = -1;
> EXPORT_SYMBOL(mips_io_port_base);
> 
> /*
>@@ -192,7 +193,102 @@
> 	}
> }
> 
>-static inline int parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
>+#define PFN_UP(x)	phys_to_pfn(PAGE_ALIGN(x))
>+#define PFN_DOWN(x)	phys_to_pfn(x)
>+#define PFN_PHYS(x)	pfn_to_phys(x)
>+
>+#define MAXMEM		HIGHMEM_START
>+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
>+
>+static void __init register_bootmem_low_pages(unsigned long max_low_pfn, 
>+					      unsigned long start_pfn)
>+{
>+	unsigned long curr_pfn, last_pfn, size;
>+	int i;
>+
>+	for (i = 0; i < boot_mem_map.nr_map; i++) {
>+		/*
>+		 * Reserve usable memory.
>+		 */
>+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>+			continue;
>+
>+		/*
>+		 * We are rounding up the start address of usable memory:
>+		 */
>+		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
>+		if (curr_pfn >= max_low_pfn)
>+			continue;
>+		if (curr_pfn < start_pfn)
>+			curr_pfn = start_pfn;
>+
>+		/*
>+		 * ... and at the end of the usable range downwards:
>+		 */
>+		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
>+				    + boot_mem_map.map[i].size);
>+
>+		if (last_pfn > max_low_pfn)
>+			last_pfn = max_low_pfn;
>+
>+		/*
>+		 * Only register lowmem part of lowmem segment with bootmem.
>+		 */
>+		size = last_pfn - curr_pfn;
>+		if (curr_pfn > PFN_DOWN(HIGHMEM_START))
>+			continue;
>+		if (curr_pfn + size - 1 > PFN_DOWN(HIGHMEM_START))
>+			size = PFN_DOWN(HIGHMEM_START) - curr_pfn;
>+		if (!size)
>+			continue;
>+
>+		/*
>+		 * ... finally, did all the rounding and playing
>+		 * around just make the area go away?
>+		 */
>+		if (last_pfn <= curr_pfn)
>+			continue;
>+
>+		/* Register lowmem ranges */
>+		free_bootmem(PFN_PHYS(curr_pfn), size * PAGE_SIZE);
>+	}
>+}
>+
>+static unsigned long  __init find_max_pfn(unsigned long start_pfn)
>+{
>+	unsigned long first_usable_pfn = -1UL;
>+	int i;
>+	
>+	max_pfn = 0;
>+
>+	for (i = 0; i < boot_mem_map.nr_map; i++) {
>+		unsigned long start, end;
>+
>+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>+			continue;
>+
>+		start = PFN_UP(boot_mem_map.map[i].addr);
>+		end = PFN_DOWN(boot_mem_map.map[i].addr
>+		      + boot_mem_map.map[i].size);
>+
>+		if (start >= end)
>+			continue;
>+		if (end > max_pfn)
>+			max_pfn = end;
>+		if (start < first_usable_pfn) {
>+			if (start > start_pfn) {
>+				first_usable_pfn = start;
>+			} else if (end > start_pfn) {
>+				first_usable_pfn = start_pfn;
>+			}
>+		}
>+	}
>+	return first_usable_pfn;
>+}
>+
>+#ifdef CONFIG_BLK_DEV_INITRD
>+
>+static int __init parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
> {
> 	/*
> 	 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
>@@ -255,79 +351,114 @@
> 	return 0;
> }
> 
>-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
>-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
>-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
>+unsigned long __init init_initrd(void)
>+{
>+	unsigned long tmp, end;
>+	u32 *initrd_header;
> 
>-#define MAXMEM		HIGHMEM_START
>-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
>+	ROOT_DEV = Root_RAM0;
>+	if (parse_rd_cmdline(&initrd_start, &initrd_end))
>+		return initrd_end;
>+
>+	/* 
>+	 * Board specific code should have set up initrd_start 
>+	 * and initrd_end...
>+	 */
>+	end = (unsigned long)&_end;
>+	tmp = ((end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
>+	if (tmp < end)
>+		tmp += PAGE_SIZE;
>+	
>+	initrd_header = (u32 *)tmp;
>+	if (initrd_header[0] == 0x494E5244) {
>+		initrd_start = (unsigned long)&initrd_header[2];
>+		initrd_end = initrd_start + initrd_header[1];
>+	}
>+	return initrd_end;
>+}
>+
>+void __init finalize_initrd(void)
>+{
>+	unsigned long phys_initrd_start;
>+	unsigned long phys_initrd_end;
>+	unsigned long initrd_size;
>+	unsigned long phys_min_low;
>+
>+	phys_initrd_start = __pa(initrd_start);
>+	phys_initrd_end   = __pa(initrd_end);
>+	initrd_size       = phys_initrd_end - phys_initrd_start;
>+
>+	if (!initrd_size) {
>+		printk(KERN_INFO "Initrd not found or empty");
>+		goto check_ko;
>+	}
>+	if (phys_initrd_end > PFN_PHYS(max_low_pfn)) {
>+		printk(KERN_CRIT "Initrd extends beyond end of memory ");
>+		goto check_ko;
>+	}
>+	/* 
>+	 * This seems to be the right place for this
>+	 */
>+	phys_min_low = PFN_PHYS(min_low_pfn);
>+        if (!initrd_below_start_ok && phys_initrd_start < phys_min_low) {
>+                printk(KERN_CRIT "Initrd overwritten (0x%p < 0x%p)",
>+		       (void *)initrd_start, phys_to_virt(phys_min_low));
>+                goto check_ko;
>+        }
>+
>+	reserve_bootmem(__pa(initrd_start), initrd_size);
>+	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
>+	       (void *)initrd_start, initrd_size);
>+	return;
>+check_ko:
>+	printk(" - disabling initrd\n");
>+	initrd_start = 0;
>+	initrd_end = 0;
>+}
>+
>+#else
>+
>+unsigned long __init init_initrd(void) { return 0; }
>+void __init finalize_initrd(void) {}
> 
>-static inline void bootmem_init(void)
>+#endif /* CONFIG_BLK_DEV_INITRD  */
>+
>+
>+static void  __init bootmem_init(void)
> {
> 	unsigned long start_pfn;
>-	unsigned long reserved_end = (unsigned long)&_end;
>-#ifndef CONFIG_SGI_IP27
>+	unsigned long reserved_end;
> 	unsigned long first_usable_pfn;
> 	unsigned long bootmap_size;
>-	int i;
>+
>+#ifdef CONFIG_SGI_IP27
>+	/* FIXME: This should be move in ip27 code */
>+	init_initrd();
>+	finalize_initrd();
>+	bootmem_init_ok = 1; 
> #endif
>-#ifdef CONFIG_BLK_DEV_INITRD
>-	int initrd_reserve_bootmem = 0;
>+	if (bootmem_init_ok)
>+		return;
> 
>-	/* Board specific code should have set up initrd_start and initrd_end */
>- 	ROOT_DEV = Root_RAM0;
>-	if (parse_rd_cmdline(&initrd_start, &initrd_end)) {
>-		reserved_end = max(reserved_end, initrd_end);
>-		initrd_reserve_bootmem = 1;
>-	} else {
>-		unsigned long tmp;
>-		u32 *initrd_header;
>-
>-		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - sizeof(u32) * 2;
>-		if (tmp < reserved_end)
>-			tmp += PAGE_SIZE;
>-		initrd_header = (u32 *)tmp;
>-		if (initrd_header[0] == 0x494E5244) {
>-			initrd_start = (unsigned long)&initrd_header[2];
>-			initrd_end = initrd_start + initrd_header[1];
>-			reserved_end = max(reserved_end, initrd_end);
>-			initrd_reserve_bootmem = 1;
>-		}
>-	}
>-#endif	/* CONFIG_BLK_DEV_INITRD */
>+	/* 
>+	 * Init initrd_start & initrd_end, in case we need
>+	 * to support an init ram disk
>+	 */
>+	reserved_end = max((unsigned long)&_end, init_initrd());
> 
> 	/*
> 	 * Partially used pages are not usable - thus
> 	 * we are rounding upwards.
> 	 */
>+#if defined(CONFIG_MIPS64) && !defined(CONFIG_BUILD_ELF64)
> 	start_pfn = PFN_UP(CPHYSADDR(reserved_end));
>-
>-#ifndef CONFIG_SGI_IP27
>-	/* Find the highest page frame number we have available.  */
>-	max_pfn = 0;
>-	first_usable_pfn = -1UL;
>-	for (i = 0; i < boot_mem_map.nr_map; i++) {
>-		unsigned long start, end;
>-
>-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>-			continue;
>-
>-		start = PFN_UP(boot_mem_map.map[i].addr);
>-		end = PFN_DOWN(boot_mem_map.map[i].addr
>-		      + boot_mem_map.map[i].size);
>-
>-		if (start >= end)
>-			continue;
>-		if (end > max_pfn)
>-			max_pfn = end;
>-		if (start < first_usable_pfn) {
>-			if (start > start_pfn) {
>-				first_usable_pfn = start;
>-			} else if (end > start_pfn) {
>-				first_usable_pfn = start_pfn;
>-			}
>-		}
>-	}
>+#else
>+	start_pfn = PFN_UP(__pa(reserved_end));	
>+#endif
>+	/* 
>+	 * Find the highest page frame number we have available.
>+	 */
>+	first_usable_pfn = find_max_pfn(start_pfn);
> 
> 	/*
> 	 * Determine low and high memory ranges
>@@ -335,111 +466,48 @@
> 	max_low_pfn = max_pfn;
> 	if (max_low_pfn > MAXMEM_PFN) {
> 		max_low_pfn = MAXMEM_PFN;
>-#ifndef CONFIG_HIGHMEM
>-		/* Maximum memory usable is what is directly addressable */
>-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
>-		       MAXMEM >> 20);
>-		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
>-#endif
> 	}
> 
> #ifdef CONFIG_HIGHMEM
> 	/*
>-	 * Crude, we really should make a better attempt at detecting
>-	 * highstart_pfn
>+	 * Crude, we really should make a better attempt at 
>+	 * detecting highstart_pfn
> 	 */
>-	highstart_pfn = highend_pfn = max_pfn;
>-	if (max_pfn > MAXMEM_PFN) {
>-		highstart_pfn = MAXMEM_PFN;
>-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
>-		       (highend_pfn - highstart_pfn) >> (20 - PAGE_SHIFT));
>-	}
>+	highstart_pfn = max_low_pfn;
>+	highend_pfn = max_pfn;
>+
>+	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
>+	       (highend_pfn - highstart_pfn) >> (20 - PAGE_SHIFT));
> #endif
>+	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
>+	       (max_low_pfn - first_usable_pfn) >> (20 - PAGE_SHIFT));
> 
>-	/* Initialize the boot-time allocator with low memory only.  */
>+	/* 
>+	 * Initialize the boot-time allocator with low memory only.
>+	 */
> 	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);
> 
> 	/*
> 	 * Register fully available low RAM pages with the bootmem allocator.
> 	 */
>-	for (i = 0; i < boot_mem_map.nr_map; i++) {
>-		unsigned long curr_pfn, last_pfn, size;
>-
>-		/*
>-		 * Reserve usable memory.
>-		 */
>-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>-			continue;
>+	register_bootmem_low_pages(max_low_pfn, start_pfn);
> 
>-		/*
>-		 * We are rounding up the start address of usable memory:
>-		 */
>-		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
>-		if (curr_pfn >= max_low_pfn)
>-			continue;
>-		if (curr_pfn < start_pfn)
>-			curr_pfn = start_pfn;
>-
>-		/*
>-		 * ... and at the end of the usable range downwards:
>-		 */
>-		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
>-				    + boot_mem_map.map[i].size);
>-
>-		if (last_pfn > max_low_pfn)
>-			last_pfn = max_low_pfn;
>-
>-		/*
>-		 * Only register lowmem part of lowmem segment with bootmem.
>-		 */
>-		size = last_pfn - curr_pfn;
>-		if (curr_pfn > PFN_DOWN(HIGHMEM_START))
>-			continue;
>-		if (curr_pfn + size - 1 > PFN_DOWN(HIGHMEM_START))
>-			size = PFN_DOWN(HIGHMEM_START) - curr_pfn;
>-		if (!size)
>-			continue;
>-
>-		/*
>-		 * ... finally, did all the rounding and playing
>-		 * around just make the area go away?
>-		 */
>-		if (last_pfn <= curr_pfn)
>-			continue;
>-
>-		/* Register lowmem ranges */
>-		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
>-	}
>-
>-	/* Reserve the bootmap memory.  */
>+	/*
>+	 * Reserve the bootmem bitmap itself as well. We do this in two
>+	 * steps (first step was init_bootmem()) because this catches
>+	 * the (very unlikely) case of us accidentally initializing the
>+	 * bootmem allocator with an invalid RAM area.
>+	 */
> 	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
>-#endif /* CONFIG_SGI_IP27 */
>-
>-#ifdef CONFIG_BLK_DEV_INITRD
>-	initrd_below_start_ok = 1;
>-	if (initrd_start) {
>-		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start);
>-		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
>-		       (void *)initrd_start, initrd_size);
>-
>-		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
>-			printk("initrd extends beyond end of memory "
>-			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
>-			       sizeof(long) * 2,
>-			       (unsigned long long)CPHYSADDR(initrd_end),
>-			       sizeof(long) * 2,
>-			       (unsigned long long)PFN_PHYS(max_low_pfn));
>-			initrd_start = initrd_end = 0;
>-			initrd_reserve_bootmem = 0;
>-		}
> 
>-		if (initrd_reserve_bootmem)
>-			reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
>-	}
>-#endif /* CONFIG_BLK_DEV_INITRD  */
>+	/*
>+	 * Eventually, check that initrd values are correct and not
>+	 * confloct with memory limits
>+	 */
>+	finalize_initrd();
> }
> 
>-static inline void resource_init(void)
>+static void resource_init(void)
> {
> 	int i;
> 
>@@ -453,10 +521,10 @@
> 	data_resource.start = CPHYSADDR(&_etext);
> 	data_resource.end = CPHYSADDR(&_edata) - 1;
> #else
>-	code_resource.start = virt_to_phys(&_text);
>-	code_resource.end = virt_to_phys(&_etext) - 1;
>-	data_resource.start = virt_to_phys(&_etext);
>-	data_resource.end = virt_to_phys(&_edata) - 1;
>+ 	code_resource.start = virt_to_phys(&_text);
>+ 	code_resource.end = virt_to_phys(&_etext) - 1;
>+ 	data_resource.start = virt_to_phys(&_etext);
>+ 	data_resource.end = virt_to_phys(&_edata) - 1;
> #endif
> 
> 	/*
>@@ -567,5 +635,4 @@
> 
> 	return 1;
> }
>-
> __setup("nofpu", fpu_disable);
>  
>
