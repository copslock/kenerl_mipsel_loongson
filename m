Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:59:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10116 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492570Ab0GWR6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:58:01 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d8420000>; Fri, 23 Jul 2010 10:58:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:57:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHvsJ9024468;
        Fri, 23 Jul 2010 10:57:54 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHvrVl024467;
        Fri, 23 Jul 2010 10:57:53 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Octeon: HOTPLUG_CPU fixes.
Date:   Fri, 23 Jul 2010 10:57:51 -0700
Message-Id: <1279907871-24419-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907871-24419-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:57:59.0258 (UTC) FILETIME=[9620CBA0:01CB2A90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

* Rename camel-case InitTLBStart_addr to octeon_bootloader_entry_addr.

* Convert calls to cvmx_read64_uint32(), to simple pointer
  dereferences.

* Set proper ebase.

* Don't confuse coreid and cpu numbers.

* Try to maintain consistent bootloader coremask.

* Update the signature and boot_init_vector of supported bootloaders.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon_boot.h |   16 +++--
 arch/mips/cavium-octeon/smp.c         |  125 ++++++++++++++-------------------
 arch/mips/include/asm/octeon/octeon.h |    2 +
 3 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
index 0f7f84a..428864b 100644
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ b/arch/mips/cavium-octeon/octeon_boot.h
@@ -23,14 +23,16 @@
 #include <linux/types.h>
 
 struct boot_init_vector {
-	uint32_t stack_addr;
-	uint32_t code_addr;
+	/* First stage address - in ram instead of flash */
+	uint64_t code_addr;
+	/* Setup code for application, NOT application entry point */
 	uint32_t app_start_func_addr;
+	/* k0 is used for global data - needs to be passed to other cores */
 	uint32_t k0_val;
-	uint32_t flags;
-	uint32_t boot_info_addr;
+	/* Address of boot info block structure */
+	uint64_t boot_info_addr;
+	uint32_t flags;         /* flags */
 	uint32_t pad;
-	uint32_t pad2;
 };
 
 /* similar to bootloader's linux_app_boot_info but without global data */
@@ -40,7 +42,7 @@ struct linux_app_boot_info {
 	uint32_t avail_coremask;
 	uint32_t pci_console_active;
 	uint32_t icache_prefetch_disable;
-	uint32_t InitTLBStart_addr;
+	uint64_t InitTLBStart_addr;
 	uint32_t start_app_addr;
 	uint32_t cur_exception_base;
 	uint32_t no_mark_private_data;
@@ -58,7 +60,7 @@ struct linux_app_boot_info {
 
 #define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
 
-#define LABI_SIGNATURE 0xAABBCCDD
+#define LABI_SIGNATURE 0xAABBCC01
 
 /*  from uboot-headers/octeon_mem_map.h */
 #define EXCEPTION_BASE_INCR     (4 * 1024)
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index ceb7649..183e641 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -27,7 +27,8 @@ volatile unsigned long octeon_processor_sp;
 volatile unsigned long octeon_processor_gp;
 
 #ifdef CONFIG_HOTPLUG_CPU
-static unsigned int InitTLBStart_addr;
+uint64_t octeon_bootloader_entry_addr;
+EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif
 
 static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
@@ -80,20 +81,13 @@ static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 static void octeon_smp_hotplug_setup(void)
 {
 #ifdef CONFIG_HOTPLUG_CPU
-	uint32_t labi_signature;
-
-	labi_signature =
-		cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-					LABI_ADDR_IN_BOOTLOADER +
-					offsetof(struct linux_app_boot_info,
-						    labi_signature)));
-	if (labi_signature != LABI_SIGNATURE)
-		pr_err("The bootloader version on this board is incorrect\n");
-	InitTLBStart_addr =
-		cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-				   LABI_ADDR_IN_BOOTLOADER +
-					   offsetof(struct linux_app_boot_info,
-						    InitTLBStart_addr)));
+	struct linux_app_boot_info *labi;
+
+	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
+	if (labi->labi_signature != LABI_SIGNATURE)
+		panic("The bootloader version on this board is incorrect.");
+
+	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
 #endif
 }
 
@@ -181,18 +175,21 @@ static void octeon_init_secondary(void)
 {
 	const int coreid = cvmx_get_core_num();
 	union cvmx_ciu_intx_sum0 interrupt_enable;
+	unsigned int sr;
 
 #ifdef CONFIG_HOTPLUG_CPU
-	unsigned int cur_exception_base;
-
-	cur_exception_base = cvmx_read64_uint32(
-		CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-			     LABI_ADDR_IN_BOOTLOADER +
-			     offsetof(struct linux_app_boot_info,
-				      cur_exception_base)));
-	/* cur_exception_base is incremented in bootloader after setting */
-	write_c0_ebase((unsigned int)(cur_exception_base - EXCEPTION_BASE_INCR));
+	struct linux_app_boot_info *labi;
+
+	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
+
+	if (labi->labi_signature != LABI_SIGNATURE)
+		panic("The bootloader version on this board is incorrect.");
 #endif
+
+	sr = set_c0_status(ST0_BEV);
+	write_c0_ebase((u32)ebase);
+	write_c0_status(sr);
+
 	octeon_check_cpu_bist();
 	octeon_init_cvmcount();
 	/*
@@ -299,8 +296,8 @@ static int octeon_cpu_disable(void)
 static void octeon_cpu_die(unsigned int cpu)
 {
 	int coreid = cpu_logical_map(cpu);
-	uint32_t avail_coremask;
-	struct cvmx_bootmem_named_block_desc *block_desc;
+	uint32_t mask, new_mask;
+	const struct cvmx_bootmem_named_block_desc *block_desc;
 
 	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
 		cpu_relax();
@@ -309,52 +306,40 @@ static void octeon_cpu_die(unsigned int cpu)
 	 * This is a bit complicated strategics of getting/settig available
 	 * cores mask, copied from bootloader
 	 */
+
+	mask = 1 << coreid;
 	/* LINUX_APP_BOOT_BLOCK is initialized in bootoct binary */
 	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
 
 	if (!block_desc) {
-		avail_coremask =
-			cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-						   LABI_ADDR_IN_BOOTLOADER +
-						   offsetof
-						   (struct linux_app_boot_info,
-						    avail_coremask)));
-	} else {		       /* alternative, already initialized */
-	       avail_coremask =
-		   cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-						   block_desc->base_addr +
-						  AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK));
-	}
+		struct linux_app_boot_info *labi;
 
-	avail_coremask |= 1 << coreid;
+		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
 
-	/* Setting avail_coremask for bootoct binary */
-	if (!block_desc) {
-		cvmx_write64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-						LABI_ADDR_IN_BOOTLOADER +
-						offsetof(struct linux_app_boot_info,
-							 avail_coremask)),
-				   avail_coremask);
-	} else {
-		cvmx_write64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-						block_desc->base_addr +
-						AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK),
-				   avail_coremask);
+		labi->avail_coremask |= mask;
+		new_mask = labi->avail_coremask;
+	} else {		       /* alternative, already initialized */
+		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
+							       AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
+		*p |= mask;
+		new_mask = *p;
 	}
 
-	pr_info("Reset core %d. Available Coremask = %x\n", coreid,
-		avail_coremask);
+	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
+	mb();
 	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
 	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
 void play_dead(void)
 {
-	int coreid = cvmx_get_core_num();
+	int cpu = cpu_number_map(cvmx_get_core_num());
 
 	idle_task_exit();
 	octeon_processor_boot = 0xff;
-	per_cpu(cpu_state, coreid) = CPU_DEAD;
+	per_cpu(cpu_state, cpu) = CPU_DEAD;
+
+	mb();
 
 	while (1)	/* core will be reset here */
 		;
@@ -367,29 +352,27 @@ static void start_after_reset(void)
 	kernel_entry(0, 0, 0);  /* set a2 = 0 for secondary core */
 }
 
-int octeon_update_boot_vector(unsigned int cpu)
+static int octeon_update_boot_vector(unsigned int cpu)
 {
 
 	int coreid = cpu_logical_map(cpu);
-	unsigned int avail_coremask;
-	struct cvmx_bootmem_named_block_desc *block_desc;
+	uint32_t avail_coremask;
+	const struct cvmx_bootmem_named_block_desc *block_desc;
 	struct boot_init_vector *boot_vect =
-		(struct boot_init_vector *) cvmx_phys_to_ptr(0x0 +
-						  BOOTLOADER_BOOT_VECTOR);
+		(struct boot_init_vector *)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
 
 	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
 
 	if (!block_desc) {
-		avail_coremask =
-			cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-					   LABI_ADDR_IN_BOOTLOADER +
-						offsetof(struct linux_app_boot_info,
-						avail_coremask)));
+		struct linux_app_boot_info *labi;
+
+		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
+
+        	avail_coremask = labi->avail_coremask;
+		labi->avail_coremask &= ~(1 << coreid);
 	} else {		       /* alternative, already initialized */
-	       avail_coremask =
-		   cvmx_read64_uint32(CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
-						   block_desc->base_addr +
-						   AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK));
+		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
+			block_desc->base_addr + AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
 	}
 
 	if (!(avail_coremask & (1 << coreid))) {
@@ -400,9 +383,9 @@ int octeon_update_boot_vector(unsigned int cpu)
 
 	boot_vect[coreid].app_start_func_addr =
 		(uint32_t) (unsigned long) start_after_reset;
-	boot_vect[coreid].code_addr = InitTLBStart_addr;
+	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
 
-	CVMX_SYNC;
+	mb();
 
 	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
 
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 8a3eb3b..917a6c4 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -254,4 +254,6 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 
 extern struct cvmx_bootinfo *octeon_bootinfo;
 
+extern uint64_t octeon_bootloader_entry_addr;
+
 #endif /* __ASM_OCTEON_OCTEON_H */
-- 
1.7.1.1
