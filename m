Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 00:09:26 +0200 (CEST)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:41539 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835094Ab3DNWJYNHYbR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 00:09:24 +0200
Received: by mail-pb0-f42.google.com with SMTP id up7so2181548pbc.15
        for <multiple recipients>; Sun, 14 Apr 2013 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=41DW7Gvg1ox6jgmx7iJg7bVCRo4Uj0ptUaUZ2ZUU9AI=;
        b=y+r/WzEQSKzbvRQ9o1X4sSs7XiG/5wllUrS+eMlwRwG1HbApGLbARYS1t+m5EJ51lt
         CQ2GMolJhfeybt45PBah1SRvaJm3fOURNcp43emVyIODgsVFkP/TPlyD98m4V6qcvpvH
         e6E3f5wuE4m0OHRLW40hRdAs+MurVCajyjC9OcV1SW7ykCoDrGjoBebS0XMrLzcEuqmF
         gE9NIfAPZBOleG/qrKPUoOTPf8wm7xRefcwaC/MJLhmR7iVyt0CsELi7vDP6yVWgNHbq
         oL7UG+WtKwIJ3WvSVMXY46Ay7X7ZQOaqfSq2l1UFZElvt9oiv0/Q+endvx9sYEsnjpij
         5y6w==
X-Received: by 10.68.141.161 with SMTP id rp1mr25406115pbb.94.1365977357621;
        Sun, 14 Apr 2013 15:09:17 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id j13sm16988223pat.17.2013.04.14.15.09.15
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 15:09:16 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r3EM9Dir017765;
        Sun, 14 Apr 2013 15:09:14 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r3EM9CnT017764;
        Sun, 14 Apr 2013 15:09:12 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: OCTEON: Allow kernel memory allocation from cvmx_bootmem named blocks.
Date:   Sun, 14 Apr 2013 15:09:11 -0700
Message-Id: <1365977351-17732-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

In order to allow precise allocation of kernel memory, we add support
for kernel command parameter mem=block:???,???.  This is especially
useful in the case of KEXEC where we want to reused exactly the same
memory that was used by the previous kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
---

This should obsolete: https://patchwork.linux-mips.org/patch/5109/

 arch/mips/cavium-octeon/setup.c | 237 ++++++++++------------------------------
 1 file changed, 58 insertions(+), 179 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0baa29..2be8030 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -83,56 +83,6 @@ static void octeon_kexec_smp_down(void *ignored)
 }
 #endif
 
-#define OCTEON_DDR0_BASE    (0x0ULL)
-#define OCTEON_DDR0_SIZE    (0x010000000ULL)
-#define OCTEON_DDR1_BASE    (0x410000000ULL)
-#define OCTEON_DDR1_SIZE    (0x010000000ULL)
-#define OCTEON_DDR2_BASE    (0x020000000ULL)
-#define OCTEON_DDR2_SIZE    (0x3e0000000ULL)
-#define OCTEON_MAX_PHY_MEM_SIZE (16*1024*1024*1024ULL)
-
-static struct kimage *kimage_ptr;
-
-static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
-{
-	int64_t addr;
-	struct cvmx_bootmem_desc *bootmem_desc;
-
-	bootmem_desc = cvmx_bootmem_get_desc();
-
-	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
-		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
-		pr_err("Error: requested memory too large,"
-		       "truncating to maximum size\n");
-	}
-
-	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
-	bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
-
-	addr = (OCTEON_DDR0_BASE + RESERVE_LOW_MEM + low_reserved_bytes);
-	bootmem_desc->head_addr = 0;
-
-	if (mem_size <= OCTEON_DDR0_SIZE) {
-		__cvmx_bootmem_phy_free(addr,
-				mem_size - RESERVE_LOW_MEM -
-				low_reserved_bytes, 0);
-		return;
-	}
-
-	__cvmx_bootmem_phy_free(addr,
-			OCTEON_DDR0_SIZE - RESERVE_LOW_MEM -
-			low_reserved_bytes, 0);
-
-	mem_size -= OCTEON_DDR0_SIZE;
-
-	if (mem_size > OCTEON_DDR1_SIZE) {
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, OCTEON_DDR1_SIZE, 0);
-		__cvmx_bootmem_phy_free(OCTEON_DDR2_BASE,
-				mem_size - OCTEON_DDR1_SIZE, 0);
-	} else
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, mem_size, 0);
-}
-
 static int octeon_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -163,73 +113,23 @@ static int octeon_kexec_prepare(struct kimage *image)
 			break;
 		}
 	}
-
-	/*
-	 * Information about segments will be needed during pre-boot memory
-	 * initialization.
-	 */
-	kimage_ptr = image;
 	return 0;
 }
 
 static void octeon_generic_shutdown(void)
 {
-	int i;
 #ifdef CONFIG_SMP
 	int cpu;
-#endif
-	struct cvmx_bootmem_desc *bootmem_desc;
-	void *named_block_array_ptr;
-
-	bootmem_desc = cvmx_bootmem_get_desc();
-	named_block_array_ptr =
-		cvmx_phys_to_ptr(bootmem_desc->named_block_array_addr);
-
-#ifdef CONFIG_SMP
+	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
+	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
 	/* disable watchdogs */
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
 	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
 #endif
-	if (kimage_ptr != kexec_crash_image) {
-		memset(named_block_array_ptr,
-			0x0,
-			CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
-			sizeof(struct cvmx_bootmem_named_block_desc));
-		/*
-		 * Mark all memory (except low 0x100000 bytes) as free.
-		 * It is the same thing that bootloader does.
-		 */
-		kexec_bootmem_init(octeon_bootinfo->dram_size*1024ULL*1024ULL,
-				0x100000);
-		/*
-		 * Allocate all segments to avoid their corruption during boot.
-		 */
-		for (i = 0; i < kimage_ptr->nr_segments; i++)
-			cvmx_bootmem_alloc_address(
-				kimage_ptr->segment[i].memsz + 2*PAGE_SIZE,
-				kimage_ptr->segment[i].mem - PAGE_SIZE,
-				PAGE_SIZE);
-	} else {
-		/*
-		 * Do not mark all memory as free. Free only named sections
-		 * leaving the rest of memory unchanged.
-		 */
-		struct cvmx_bootmem_named_block_desc *ptr =
-			(struct cvmx_bootmem_named_block_desc *)
-			named_block_array_ptr;
-
-		for (i = 0; i < bootmem_desc->named_block_num_blocks; i++)
-			if (ptr[i].size)
-				cvmx_bootmem_free_named(ptr[i].name);
-	}
 	kexec_args[2] = 1UL; /* running on octeon_main_processor */
 	kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
-#ifdef CONFIG_SMP
-	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
-	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
-#endif
 }
 
 static void octeon_shutdown(void)
@@ -269,6 +169,9 @@ static int octeon_uart;
 extern asmlinkage void handle_int(void);
 extern asmlinkage void plat_irq_dispatch(void);
 
+/* Up to four blocks may be specified. */
+static char __initdata named_memory_blocks[4][CVMX_BOOTMEM_NAME_LEN];
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -771,22 +674,31 @@ void __init prom_init(void)
 	if (octeon_is_simulation())
 		MAX_MEMORY = 64ull << 20;
 
-	arg = strstr(arcs_cmdline, "mem=");
-	if (arg) {
-		MAX_MEMORY = memparse(arg + 4, &p);
-		if (MAX_MEMORY == 0)
-			MAX_MEMORY = 32ull << 30;
-		if (*p == '@')
-			RESERVE_LOW_MEM = memparse(p + 1, &p);
-	}
-
 	arcs_cmdline[0] = 0;
 	argc = octeon_boot_desc_ptr->argc;
 	for (i = 0; i < argc; i++) {
-		const char *arg =
-			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
-		if ((strncmp(arg, "MEM=", 4) == 0) ||
-		    (strncmp(arg, "mem=", 4) == 0)) {
+		arg = phys_to_virt(octeon_boot_desc_ptr->argv[i]);
+		if (strncmp(arg, "mem=block:", 10) == 0) {
+			const char *pos = arg + 10;
+			int j;
+
+			for (j = 0; pos[0] && j < ARRAY_SIZE(named_memory_blocks); j++) {
+				int len;
+				char *comma = strchr(pos, ',');
+				if (comma)
+					len = comma - pos;
+				else
+					len = max(strlen(pos), ARRAY_SIZE(named_memory_blocks[0]));
+				strncpy(named_memory_blocks[j], pos, len);
+				if (comma)
+					pos = comma + 1;
+				else
+					break;
+			}
+			for (j = 0; j < ARRAY_SIZE(named_memory_blocks); j++)
+				pr_err("Named Block[%d] = \"%s\"\n", j, named_memory_blocks[j]);
+		} else if ((strncmp(arg, "MEM=", 4) == 0) ||
+			   (strncmp(arg, "mem=", 4) == 0)) {
 			MAX_MEMORY = memparse(arg + 4, &p);
 			if (MAX_MEMORY == 0)
 				MAX_MEMORY = 32ull << 30;
@@ -878,15 +790,39 @@ void __init plat_mem_setup(void)
 	uint64_t mem_alloc_size;
 	uint64_t total;
 	uint64_t crashk_end;
+	const struct cvmx_bootmem_named_block_desc *named_block;
 #ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
-	uint64_t kernel_start;
-	uint64_t kernel_size;
 #endif
 
 	total = 0;
 	crashk_end = 0;
 
+	if (named_memory_blocks[0][0]) {
+		/* Memory from named blocks only */
+		int i;
+
+		for (i = 0;
+		     named_memory_blocks[i][0] && i < ARRAY_SIZE(named_memory_blocks);
+		     i++) {
+			named_block = cvmx_bootmem_find_named_block(named_memory_blocks[i]);
+			if (!named_block) {
+				pr_err("Error: Couldn't find cvmx_bootmem block \"%s\"",
+				       named_memory_blocks[i]);
+				return;
+			}
+			pr_info("Adding memory from \"%s\": %016lx @ %016lx\n",
+				named_memory_blocks[i],
+				(unsigned long)named_block->size,
+				(unsigned long)named_block->base_addr);
+			add_memory_region(named_block->base_addr,
+					  named_block->size,
+					  BOOT_MEM_RAM);
+			total += named_block->size;
+		}
+		goto mem_alloc_done;
+	}
+
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
@@ -903,12 +839,7 @@ void __init plat_mem_setup(void)
 	add_memory_region(RESERVE_LOW_MEM, MAX_MEMORY, BOOT_MEM_RAM);
 	total += MAX_MEMORY;
 #else
-#ifdef CONFIG_KEXEC
-	if (crashk_size > 0) {
-		add_memory_region(crashk_base, crashk_size, BOOT_MEM_RAM);
-		crashk_end = crashk_base + crashk_size;
-	}
-#endif
+
 	/*
 	 * When allocating memory, we want incrementing addresses from
 	 * bootmem_alloc so the code in add_memory_region can merge
@@ -923,9 +854,6 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
-#ifdef CONFIG_KEXEC
-			uint64_t end;
-#endif
 
 			/*
 			 * exclude a page at the beginning and end of
@@ -938,68 +866,19 @@ void __init plat_mem_setup(void)
 			memory_exclude_page(CVMX_PCIE_BAR1_PHYS_BASE +
 					    CVMX_PCIE_BAR1_PHYS_SIZE,
 					    &memory, &size);
-#ifdef CONFIG_KEXEC
-			end = memory + mem_alloc_size;
 
-			/*
-			 * This function automatically merges address regions
-			 * next to each other if they are received in
-			 * incrementing order
-			 */
-			if (memory < crashk_base && end >  crashk_end) {
-				/* region is fully in */
-				add_memory_region(memory,
-						  crashk_base - memory,
-						  BOOT_MEM_RAM);
-				total += crashk_base - memory;
-				add_memory_region(crashk_end,
-						  end - crashk_end,
-						  BOOT_MEM_RAM);
-				total += end - crashk_end;
-				continue;
-			}
-
-			if (memory >= crashk_base && end <= crashk_end)
-				/*
-				 * Entire memory region is within the new
-				 *  kernel's memory, ignore it.
-				 */
-				continue;
-
-			if (memory > crashk_base && memory < crashk_end &&
-			    end > crashk_end) {
-				/*
-				 * Overlap with the beginning of the region,
-				 * reserve the beginning.
-				  */
-				mem_alloc_size -= crashk_end - memory;
-				memory = crashk_end;
-			} else if (memory < crashk_base && end > crashk_base &&
-				   end < crashk_end)
-				/*
-				 * Overlap with the beginning of the region,
-				 * chop of end.
-				 */
-				mem_alloc_size -= end - crashk_base;
-#endif
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			if (size)
+				add_memory_region(memory, size, BOOT_MEM_RAM);
 			total += mem_alloc_size;
-			/* Recovering mem_alloc_size */
-			mem_alloc_size = 4 << 20;
 		} else {
 			break;
 		}
 	}
 	cvmx_bootmem_unlock();
-	/* Add the memory region for the kernel. */
-	kernel_start = (unsigned long) _text;
-	kernel_size = ALIGN(_end - _text, 0x100000);
-
-	/* Adjust for physical offset. */
-	kernel_start &= ~0xffffffff80000000ULL;
-	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
 #endif /* CONFIG_CRASH_DUMP */
 
+mem_alloc_done:
+
 #ifdef CONFIG_CAVIUM_RESERVE32
 	/*
 	 * Now that we've allocated the kernel memory it is safe to
-- 
1.7.11.7
