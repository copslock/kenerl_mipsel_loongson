Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 16:11:46 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:50870 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032320AbcEXOLpAkLn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 16:11:45 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4OEBdtA009033
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 24 May 2016 14:11:39 GMT
Received: from localhost.localdomain ([10.144.47.5])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u4OEBaNN031508;
        Tue, 24 May 2016 16:11:38 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Subject: [PATCH 2/2] MIPS: OCTEON: setup: rename upper case variables
Date:   Tue, 24 May 2016 17:09:31 +0300
Message-Id: <1464098971-9362-2-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com>
References: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 3905
X-purgate-ID: 151667::1464099099-00002418-BE58482B/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Rename upper case variables.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/setup.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 53c1234..8719cbf 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -49,7 +49,8 @@ extern struct plat_smp_ops octeon_smp_ops;
 extern void pci_console_init(const char *arg);
 #endif
 
-static unsigned long long MAX_MEMORY = ULLONG_MAX;
+static unsigned long long max_memory = ULLONG_MAX;
+static unsigned long long reserve_low_mem;
 
 DEFINE_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
@@ -59,7 +60,6 @@ struct octeon_boot_descriptor *octeon_boot_desc_ptr;
 struct cvmx_bootinfo *octeon_bootinfo;
 EXPORT_SYMBOL(octeon_bootinfo);
 
-static unsigned long long RESERVE_LOW_MEM = 0ull;
 #ifdef CONFIG_KEXEC
 #ifdef CONFIG_SMP
 /*
@@ -109,18 +109,18 @@ static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
 	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
 	bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
 
-	addr = (OCTEON_DDR0_BASE + RESERVE_LOW_MEM + low_reserved_bytes);
+	addr = (OCTEON_DDR0_BASE + reserve_low_mem + low_reserved_bytes);
 	bootmem_desc->head_addr = 0;
 
 	if (mem_size <= OCTEON_DDR0_SIZE) {
 		__cvmx_bootmem_phy_free(addr,
-				mem_size - RESERVE_LOW_MEM -
+				mem_size - reserve_low_mem -
 				low_reserved_bytes, 0);
 		return;
 	}
 
 	__cvmx_bootmem_phy_free(addr,
-			OCTEON_DDR0_SIZE - RESERVE_LOW_MEM -
+			OCTEON_DDR0_SIZE - reserve_low_mem -
 			low_reserved_bytes, 0);
 
 	mem_size -= OCTEON_DDR0_SIZE;
@@ -799,15 +799,15 @@ void __init prom_init(void)
 
 	/* Default to 64MB in the simulator to speed things up */
 	if (octeon_is_simulation())
-		MAX_MEMORY = 64ull << 20;
+		max_memory = 64ull << 20;
 
 	arg = strstr(arcs_cmdline, "mem=");
 	if (arg) {
-		MAX_MEMORY = memparse(arg + 4, &p);
-		if (MAX_MEMORY == 0)
-			MAX_MEMORY = 32ull << 30;
+		max_memory = memparse(arg + 4, &p);
+		if (max_memory == 0)
+			max_memory = 32ull << 30;
 		if (*p == '@')
-			RESERVE_LOW_MEM = memparse(p + 1, &p);
+			reserve_low_mem = memparse(p + 1, &p);
 	}
 
 	arcs_cmdline[0] = 0;
@@ -817,11 +817,11 @@ void __init prom_init(void)
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
 		if ((strncmp(arg, "MEM=", 4) == 0) ||
 		    (strncmp(arg, "mem=", 4) == 0)) {
-			MAX_MEMORY = memparse(arg + 4, &p);
-			if (MAX_MEMORY == 0)
-				MAX_MEMORY = 32ull << 30;
+			max_memory = memparse(arg + 4, &p);
+			if (max_memory == 0)
+				max_memory = 32ull << 30;
 			if (*p == '@')
-				RESERVE_LOW_MEM = memparse(p + 1, &p);
+				reserve_low_mem = memparse(p + 1, &p);
 #ifdef CONFIG_KEXEC
 		} else if (strncmp(arg, "crashkernel=", 12) == 0) {
 			crashk_size = memparse(arg+12, &p);
@@ -910,13 +910,13 @@ void __init plat_mem_setup(void)
 	 * to consistently work.
 	 */
 	mem_alloc_size = 4 << 20;
-	if (mem_alloc_size > MAX_MEMORY)
-		mem_alloc_size = MAX_MEMORY;
+	if (mem_alloc_size > max_memory)
+		mem_alloc_size = max_memory;
 
 /* Crashkernel ignores bootmem list. It relies on mem=X@Y option */
 #ifdef CONFIG_CRASH_DUMP
-	add_memory_region(RESERVE_LOW_MEM, MAX_MEMORY, BOOT_MEM_RAM);
-	total += MAX_MEMORY;
+	add_memory_region(reserve_low_mem, max_memory, BOOT_MEM_RAM);
+	total += max_memory;
 #else
 #ifdef CONFIG_KEXEC
 	if (crashk_size > 0) {
@@ -931,7 +931,7 @@ void __init plat_mem_setup(void)
 	 */
 	cvmx_bootmem_lock();
 	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
-		&& (total < MAX_MEMORY)) {
+		&& (total < max_memory)) {
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
 						__pa_symbol(&_end), -1,
 						0x100000,
-- 
2.8.0
