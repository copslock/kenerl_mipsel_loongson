Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 12:06:12 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:60457 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491120Ab0CCLFj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 12:05:39 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so1188708bwz.27
        for <multiple recipients>; Wed, 03 Mar 2010 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:from:subject:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=3aF9N4T+CRJwoloTH9XjL7mXI+oRP4EmAh/Xcf/x6Hs=;
        b=a6qhc1auwRtYV0US9OrMYGXzrSEKi8AClKM9OmWsBPOw5ZXCPkeBsHZHhq/DX5Kly7
         PRjb9faIvPR4oeX32DsM5EDDmWPDL78W8x/h8H+qFsKb3nCNadESVLSLUCDJj6VtVR36
         ADNm7YkaxiLXnOBVFnVuBSTOXrqdmQKF2ssPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:from:subject:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=NK3gWSjM+HndhsZ1ZMF9D9qfKkeoBlQ/j2T4vH50T/63eX/9KAis4MWVdiwGm7W3hM
         YkM5JnwXH3IEL5lpWEsGnbYTpPpb2PyRjlR0Uyy/0VfBx6yeAw9Gjocgh86vX9rAwM0h
         HUPwY3fYEeFEwiIT8S4v38PewOkxPOmaPdKr4=
Received: by 10.204.25.194 with SMTP id a2mr5826561bkc.191.1267614339283;
        Wed, 03 Mar 2010 03:05:39 -0800 (PST)
Received: from ?127.0.1.1? (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id 14sm3626984bwz.14.2010.03.03.03.05.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:05:38 -0800 (PST)
To:     linux-mips@linux-mips.org, kexec@lists.infradead.org
Cc:     horms@verge.net.au, ralf@linux-mips.org
From:   Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH 2/2] MIPS Cavium Octeon board kexec,kdump support
Date:   Wed, 03 Mar 2010 14:05:36 +0300
Message-ID: <20100303110536.11233.99481.stgit@muvarov>
In-Reply-To: <20100303110527.11233.20400.stgit@muvarov>
References: <20100303110527.11233.20400.stgit@muvarov>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello folks,

Please find here MIPS crash and kdump patches.
This is patch set of 3 patches:
1. generic MIPS changes (kernel);
2. MIPS Cavium Octeon board kexec/kdump code (kernel);
3. Kexec user space MIPS changes.

Patches were tested on the latest linux-mips@ git kernel and the latest
kexec-tools git on Cavium Octeon 50xx board.

I also made the same code working on RMI XLR/XLS boards for both
mips32 and mips64 kernels.

Best regards,
Maxim Uvarov.


---

 arch/mips/cavium-octeon/dma-octeon.c             |    6 
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |    5 
 arch/mips/cavium-octeon/setup.c                  |  309 +++++++++++++++++++++-
 arch/mips/cavium-octeon/smp.c                    |    5 
 arch/mips/include/asm/octeon/cvmx-bootmem.h      |    2 
 arch/mips/kernel/relocate_kernel.S               |   19 +
 6 files changed, 326 insertions(+), 20 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index be531ec..679d7b5 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -105,7 +105,8 @@ dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 			pr_warning("dma_map_single: Warning: "
 				   "Mapping memory address that might "
 				   "conflict with devices 0x%llx-0x%llx\n",
-				   physical, physical+size-1);
+				   (unsigned long long) physical,
+				   (unsigned long long) (physical + size - 1));
 		/* The 2nd 256MB is mapped at 256<<20 instead of 0x410000000 */
 		if ((physical >= 0x410000000ull) && physical < 0x420000000ull)
 			result = physical - 0x400000000ull;
@@ -115,7 +116,8 @@ dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 			panic("dma_map_single: Attempt to map address "
 			      "0x%llx-0x%llx, which can't be accessed "
 			      "according to the dma mask 0x%llx\n",
-			      physical, physical+size-1, dma_mask);
+			      physical, (unsigned long long)(physical+size-1),
+			      dma_mask);
 		goto done;
 
 	case OCTEON_DMA_BAR_TYPE_BIG:
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index fdf5f19..1ae35ec 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -688,3 +688,8 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 		cvmx_spinlock_unlock((cvmx_spinlock_t *)&(cvmx_bootmem_desc->lock));
 	return addr_allocated;
 }
+
+void *cvmx_bootmem_get_desc(void)
+{
+    return cvmx_bootmem_desc;
+}
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b321d3b..2f246d2 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/kexec.h>
 
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -55,11 +56,205 @@ struct octeon_boot_descriptor *octeon_boot_desc_ptr;
 struct cvmx_bootinfo *octeon_bootinfo;
 EXPORT_SYMBOL(octeon_bootinfo);
 
+static unsigned long long RESERVE_LOW_MEM = 0ull;
+#ifdef CONFIG_KEXEC
+#ifdef CONFIG_SMP
+/*
+ * Wait for relocation code is prepared and send
+ * secondary CPUs to spin until kernel is relocated.
+ */
+void octeon_kexec_smp_down(void *ignored)
+{
+	int cpu = smp_processor_id();
+	local_irq_disable();
+	cpu_clear(cpu, cpu_online_map);
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+	asm volatile ("synci 0($0)\n");
+	relocated_kexec_smp_wait(NULL);
+}
+#endif
+
+#define OCTEON_DDR0_BASE    (0x0ULL)
+#define OCTEON_DDR0_SIZE    (0x010000000ULL)
+#define OCTEON_DDR1_BASE    (0x410000000ULL)
+#define OCTEON_DDR1_SIZE    (0x010000000ULL)
+#define OCTEON_DDR2_BASE    (0x020000000ULL)
+#define OCTEON_DDR2_SIZE    (0x3e0000000ULL)
+#define OCTEON_MAX_PHY_MEM_SIZE (16*1024*1024*1024ULL)
+
+static struct kimage *kimage_ptr;
+
+static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
+{
+	int64_t addr;
+	struct cvmx_bootmem_desc *bootmem_desc;
+
+	bootmem_desc =
+		(struct cvmx_bootmem_desc *)cvmx_bootmem_get_desc();
+
+	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
+		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
+		printk(KERN_ERR "ERROR: requested memory size too large,"
+				"truncating to maximum size\n");
+	}
+
+	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
+	bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
+
+	addr = (OCTEON_DDR0_BASE + RESERVE_LOW_MEM + low_reserved_bytes);
+	bootmem_desc->head_addr = 0;
+
+	if (mem_size <= OCTEON_DDR0_SIZE) {
+		__cvmx_bootmem_phy_free(addr,
+				mem_size - RESERVE_LOW_MEM -
+				low_reserved_bytes, 0);
+		return;
+	}
+
+	__cvmx_bootmem_phy_free(addr,
+			OCTEON_DDR0_SIZE - RESERVE_LOW_MEM -
+			low_reserved_bytes, 0);
+
+	mem_size -= OCTEON_DDR0_SIZE;
+
+	if (mem_size > OCTEON_DDR1_SIZE) {
+		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, OCTEON_DDR1_SIZE, 0);
+		__cvmx_bootmem_phy_free(OCTEON_DDR2_BASE,
+				mem_size - OCTEON_DDR1_SIZE, 0);
+	} else
+		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, mem_size, 0);
+}
+
+int octeon_kexec_prepare(struct kimage *image)
+{
+	int i;
+	char *bootloader = "kexec";
+
+	octeon_boot_desc_ptr->argc = 0;
+	for (i = 0; i < image->nr_segments; i++) {
+		if (!strncmp(bootloader, (char *)image->segment[i].buf,
+				strlen(bootloader))) {
+			/*
+			 * convert command line string to array
+			 * of parameters (as bootloader does).
+			 */
+			int argc = 0, offt;
+			char *str = (char *)image->segment[i].buf;
+			char *ptr = strchr(str, ' ');
+			while (ptr && (OCTEON_ARGV_MAX_ARGS > argc)) {
+				*ptr = '\0';
+				if (ptr[1] != ' ') {
+					offt = (int)(ptr - str + 1);
+					octeon_boot_desc_ptr->argv[argc] =
+						image->segment[i].mem + offt;
+					argc++;
+				}
+				ptr = strchr(ptr + 1, ' ');
+			}
+			octeon_boot_desc_ptr->argc = argc;
+			break;
+		}
+	}
+
+	/*
+	 * Information about segments will be needed during pre-boot memory
+	 * initialization.
+	 */
+	kimage_ptr = image;
+	return 0;
+}
+
+static void octeon_generic_shutdown(void)
+{
+	int cpu, i;
+	struct cvmx_bootmem_desc *bootmem_desc;
+	void *named_block_array_ptr;
+
+	bootmem_desc =
+		(struct cvmx_bootmem_desc *)cvmx_bootmem_get_desc();
+	named_block_array_ptr =
+		cvmx_phys_to_ptr(bootmem_desc->named_block_array_addr);
+
+#ifdef CONFIG_SMP
+	/* disable watchdogs */
+	for_each_online_cpu(cpu)
+		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
+#else
+	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+#endif
+	if (kimage_ptr != kexec_crash_image) {
+		memset(named_block_array_ptr,
+			0x0,
+			CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
+			sizeof(struct cvmx_bootmem_named_block_desc));
+		/*
+		 * Mark all memory (except low 0x100000 bytes) as free.
+		 * It is the same thing that bootloader does.
+		 */
+		kexec_bootmem_init(octeon_bootinfo->dram_size*1024ULL*1024ULL,
+				0x100000);
+		/*
+		 * Allocate all segments to avoid their corruption during boot.
+		 */
+		for (i = 0; i < kimage_ptr->nr_segments; i++)
+			cvmx_bootmem_alloc_address(
+				kimage_ptr->segment[i].memsz + 2*PAGE_SIZE,
+				kimage_ptr->segment[i].mem - PAGE_SIZE,
+				PAGE_SIZE);
+	} else {
+		/*
+		 * Do not mark all memory as free. Free only named sections
+		 * leaving the rest of memory unchanged.
+		 */
+		struct cvmx_bootmem_named_block_desc *ptr =
+			(struct cvmx_bootmem_named_block_desc *)
+			named_block_array_ptr;
+
+		for (i = 0; i < bootmem_desc->named_block_num_blocks; i++)
+			if (ptr[i].size)
+				cvmx_bootmem_free_named(ptr[i].name);
+	}
+	kexec_args[2] = 1UL; /* running on octeon_main_processor */
+	kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
+#ifdef CONFIG_SMP
+	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
+	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
+#endif
+}
+
+void octeon_shutdown(void)
+{
+	octeon_generic_shutdown();
+#ifdef CONFIG_SMP
+	smp_call_function(octeon_kexec_smp_down, NULL, 0);
+	smp_wmb();
+	while (num_online_cpus() > 1) {
+		cpu_relax();
+		mdelay(1);
+	}
+#endif
+}
+
+void octeon_crash_shutdown(struct pt_regs *regs)
+{
+	octeon_generic_shutdown();
+	default_machine_crash_shutdown(regs);
+}
+
+#endif
+
 #ifdef CONFIG_CAVIUM_RESERVE32
 uint64_t octeon_reserve32_memory;
 EXPORT_SYMBOL(octeon_reserve32_memory);
 #endif
 
+#ifdef CONFIG_KEXEC
+/* crashkernel cmdline parameter is parsed _after_ memory setup
+ * we also parse it here (workaround for EHB5200) */
+static uint64_t crashk_size, crashk_base;
+#endif
+
 static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
@@ -467,6 +662,8 @@ void __init prom_init(void)
 	int i;
 	int argc;
 	struct uart_port octeon_port;
+	char *p;
+	const char *arg;
 #ifdef CONFIG_CAVIUM_RESERVE32
 	int64_t addr = -1;
 #endif
@@ -629,6 +826,15 @@ void __init prom_init(void)
 	if (octeon_is_simulation())
 		MAX_MEMORY = 64ull << 20;
 
+	arg = strstr(arcs_cmdline, "mem=");
+	if (arg) {
+		MAX_MEMORY = memparse(arg + 4, &p);
+		if (MAX_MEMORY == 0)
+			MAX_MEMORY = 32ull << 30;
+		if (*p == '@')
+			RESERVE_LOW_MEM = memparse(p + 1, &p);
+	}
+
 	arcs_cmdline[0] = 0;
 	argc = octeon_boot_desc_ptr->argc;
 	for (i = 0; i < argc; i++) {
@@ -636,16 +842,25 @@ void __init prom_init(void)
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
 		if ((strncmp(arg, "MEM=", 4) == 0) ||
 		    (strncmp(arg, "mem=", 4) == 0)) {
-			sscanf(arg + 4, "%llu", &MAX_MEMORY);
-			MAX_MEMORY <<= 20;
+			MAX_MEMORY = memparse(arg + 4, &p);
 			if (MAX_MEMORY == 0)
 				MAX_MEMORY = 32ull << 30;
+			if (*p == '@')
+				RESERVE_LOW_MEM = memparse(p + 1, &p);
 		} else if (strcmp(arg, "ecc_verbose") == 0) {
 #ifdef CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
 			__cvmx_interrupt_ecc_report_single_bit_errors = 1;
 			pr_notice("Reporting of single bit ECC errors is "
 				  "turned on\n");
 #endif
+#ifdef CONFIG_KEXEC
+		} else if (strncmp(arg, "crashkernel=", 12) == 0) {
+			crashk_size = memparse(arg+12, &p);
+			if (*p == '@')
+				crashk_base = memparse(p+1, &p);
+			strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, arg);
+#endif
 		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
 			   sizeof(arcs_cmdline) - 1) {
 			strcat(arcs_cmdline, " ");
@@ -685,6 +900,12 @@ void __init prom_init(void)
 	_machine_restart = octeon_restart;
 	_machine_halt = octeon_halt;
 
+#ifdef CONFIG_KEXEC
+	_machine_kexec_shutdown = octeon_shutdown;
+	_machine_crash_shutdown = octeon_crash_shutdown;
+	_machine_kexec_prepare = octeon_kexec_prepare;
+#endif
+
 	memset(&octeon_port, 0, sizeof(octeon_port));
 	/*
 	 * For early_serial_setup we don't set the port type or
@@ -717,17 +938,15 @@ void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
 	uint64_t total;
+	uint64_t crashk_end;
+#ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
+	uint64_t kernel_start;
+	uint64_t kernel_size;
+#endif
 
 	total = 0;
-
-	/* First add the init memory we will be returning.  */
-	memory = __pa_symbol(&__init_begin) & PAGE_MASK;
-	mem_alloc_size = (__pa_symbol(&__init_end) & PAGE_MASK) - memory;
-	if (mem_alloc_size > 0) {
-		add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
-		total += mem_alloc_size;
-	}
+	crashk_end = 0;
 
 	/*
 	 * The Mips memory init uses the first memory location for
@@ -740,6 +959,17 @@ void __init plat_mem_setup(void)
 	if (mem_alloc_size > MAX_MEMORY)
 		mem_alloc_size = MAX_MEMORY;
 
+/* Crashkernel ignores bootmem list. It relies on mem=X@Y option */
+#ifdef CONFIG_CRASH_DUMP
+	add_memory_region(RESERVE_LOW_MEM, MAX_MEMORY, BOOT_MEM_RAM);
+	total += MAX_MEMORY;
+#else
+#ifdef CONFIG_KEXEC
+	if (crashk_size > 0) {
+		add_memory_region(crashk_base, crashk_size, BOOT_MEM_RAM);
+		crashk_end = crashk_base + crashk_size;
+	}
+#endif
 	/*
 	 * When allocating memory, we want incrementing addresses from
 	 * bootmem_alloc so the code in add_memory_region can merge
@@ -750,9 +980,10 @@ void __init plat_mem_setup(void)
 		&& (total < MAX_MEMORY)) {
 #if defined(CONFIG_64BIT) || defined(CONFIG_64BIT_PHYS_ADDR)
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
-						__pa_symbol(&__init_end), -1,
-						0x100000,
+						RESERVE_LOW_MEM,
+						/*-1*/0, 0x100000,
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
 #elif defined(CONFIG_HIGHMEM)
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 1ull << 31,
 						0x100000,
@@ -763,19 +994,61 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 #endif
 		if (memory >= 0) {
-			/*
-			 * This function automatically merges address
-			 * regions next to each other if they are
-			 * received in incrementing order.
-			 */
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+#ifdef CONFIG_KEXEC
+				uint64_t end = memory + mem_alloc_size;
+			/* This function automatically merges address
+			   regions next to each other if they are
+			   received in incrementing order */
+			if (memory < crashk_base && end >  crashk_end) {
+				/* region is fully in */
+				add_memory_region(memory,
+						  crashk_base - memory,
+						  BOOT_MEM_RAM);
+				total += crashk_base - memory;
+				add_memory_region(crashk_end,
+						  end - crashk_end,
+						  BOOT_MEM_RAM);
+				total += end - crashk_end;
+				continue;
+			}
+
+			if (memory >= crashk_base && end <= crashk_end)
+				/* Entire memory region is within the
+				 * new kernel's memory, ignore it. */
+				continue;
+
+			if (memory > crashk_base && memory < crashk_end &&
+			    end > crashk_end) {
+				/* Overlap with the beginning of the
+				 * region, reserve the beginning. */
+				mem_alloc_size -= crashk_end - memory;
+				memory = crashk_end;
+			} else if (memory < crashk_base && end > crashk_base &&
+				   end < crashk_end)
+				/* Overlap with the beginning of the
+				 * region, chop of end. */
+				mem_alloc_size -= end - crashk_base;
+#endif
+			add_memory_region(memory, mem_alloc_size,
+					  BOOT_MEM_RAM);
 			total += mem_alloc_size;
+
+			/* Recovering mem_alloc_size */
+			mem_alloc_size = 4 << 20;
 		} else {
 			break;
 		}
 	}
 	cvmx_bootmem_unlock();
+	/* Add the memory region for the kernel. */
+	kernel_start = (unsigned long) _text;
+	kernel_size = ALIGN(_end - _text, 0x100000);
+
+	/* Adjust for physical offset. */
+	kernel_start &= ~0xffffffff80000000ULL;
+	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
 
+#endif /* CONFIG_CRASH_DUMP */
 #ifdef CONFIG_CAVIUM_RESERVE32
 	/*
 	 * Now that we've allocated the kernel memory it is safe to
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 51e9802..06fe291 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -65,6 +65,11 @@ void octeon_send_ipi_single(int cpu, unsigned int action)
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
+void core_send_ipi(int cpu, unsigned int action)
+{
+	octeon_send_ipi_single(cpu, action);
+}
+
 static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 					unsigned int action)
 {
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 8e708bd..2f3cb9f 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -370,4 +370,6 @@ void cvmx_bootmem_lock(void);
  */
 void cvmx_bootmem_unlock(void);
 
+void  *cvmx_bootmem_get_desc(void);
+
 #endif /*   __CVMX_BOOTMEM_H__ */
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 0abaf7a..961c10b 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -78,7 +78,19 @@ done:
  	LONG_S		zero,(t0)
 #endif
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+ 	/* We need to flush I-cache before jumping to new kernel.
+ 	 * Unfortunatelly, this code is cpu-specific.
+ 	 */
+ 	.set push
+ 	.set noreorder
+ 	syncw
+ 	syncw
+ 	synci		0($0)
+ 	.set pop
+#else
 	sync
+#endif
 	/* jump to kexec_start_address */
 	j		s1
 	END(relocate_new_kernel)
@@ -110,7 +122,14 @@ LEAF(kexec_smp_wait)
 1:	LONG_L		s0, (t0)
 	bne		s0, zero,1b
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	.set push
+	.set noreorder
+	synci		0($0)
+	.set pop
+#else
 	sync
+#endif
 	j		s1
 	END(kexec_smp_wait)
 #endif


Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
