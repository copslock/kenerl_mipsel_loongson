Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 02:47:44 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33623 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012058AbcBBBrIFN90u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 02:47:08 +0100
Received: by mail-pf0-f195.google.com with SMTP id e126so53635pfe.0;
        Mon, 01 Feb 2016 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JC2IVwqUwtLwpzQ6k/tCc8Lb7zmFVo0j2UrhZMVLfY=;
        b=awYkwyaNUKJmeyliI96jLlSJpH0hqReFBGBeSx93q4iCrtAS/zFV4PFH9B7vR2ryRi
         AcQ07WPZJqH1d2ilEXiWU1y+m74TPfSdSS0CAAo7KRF9CVxR3C3mEDX0WI+JfdrZQ+kS
         gp2tllaELcbyuGrgeAedybW7Jcr0vpQUknfcdnQ4UQZe0fQIYII7+NiUYmG34EKucWfx
         8jjTdJOA8rpwRGRP0Gcs8geogX7eRYsgUKHwab+sdkxjkbi/Hp0Qc9DH9CLk33hWmlXO
         OnbM3Xi/11gCMEk59jrlW7/ABIZKksWJHpvkJNiKapQsywM0EKxO4qKow8uUDcKks60f
         cDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JC2IVwqUwtLwpzQ6k/tCc8Lb7zmFVo0j2UrhZMVLfY=;
        b=L7SQFXizlUYZjRraMg52Sxm5gP/6LItVsd5ymH67XmIWmk6MdthzsCy1kbNxUWd9Dk
         6BTEBSz4foJTtVBOHeBF0ptsDW2c2ekgr7KGk8N/jeIH2Hzp1vORnK0RtDxZp9uVFbc5
         eC7hWizuYIHAO7XnPbOVQBR/+WQgvF9G8wUtJF4so51+fQRksUCtd7tG+40LEn5b8GxK
         /tfFTnI67oU7GfXFMyKIpBa5hvagZ2tk7GpRI691mLURMXqWndetaOoaBH7MrRlyRLKG
         +Wx2xHuZ1vTo4wWt77Z5aFzpon1rBBNJ+CR8KRdM2+f2Pt1QvD45JS0m1ZCrqvb5pDeQ
         Rw8g==
X-Gm-Message-State: AG10YOR5IRnWOHAUKNQZsexWMSSvvOj1vU/ctDlmLY4DRTG5xPgz3qDpNJYr0VmPUEfJIw==
X-Received: by 10.98.66.157 with SMTP id h29mr43174864pfd.91.1454377622284;
        Mon, 01 Feb 2016 17:47:02 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id r77sm12195256pfa.47.2016.02.01.17.46.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2016 17:46:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u121kv00014959;
        Mon, 1 Feb 2016 17:46:57 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u121kvk8014958;
        Mon, 1 Feb 2016 17:46:57 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: OCTEON: Extend number of supported CPUs past 32
Date:   Mon,  1 Feb 2016 17:46:54 -0800
Message-Id: <1454377614-14915-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454377614-14915-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454377614-14915-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51612
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

To support more than 48 CPUs, the bootinfo structure grows a new
coremask structure.  Add the definition of the structure and add it to
struct cvmx_bootinfo.  In prom_init(), copy the new coremask data into
the sysinfo structure, and use it in smp_setup().

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c              | 19 +++++-
 arch/mips/cavium-octeon/smp.c                |  4 +-
 arch/mips/include/asm/octeon/cvmx-bootinfo.h | 14 ++++-
 arch/mips/include/asm/octeon/cvmx-coremask.h | 89 ++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-sysinfo.h  |  7 ++-
 5 files changed, 125 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-coremask.h

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101f..9c6ad2f 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -637,9 +637,22 @@ void __init prom_init(void)
 	sysinfo = cvmx_sysinfo_get();
 	memset(sysinfo, 0, sizeof(*sysinfo));
 	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
-	sysinfo->phy_mem_desc_ptr =
-		cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr);
-	sysinfo->core_mask = octeon_bootinfo->core_mask;
+	sysinfo->phy_mem_desc_addr = (u64)phys_to_virt(octeon_bootinfo->phy_mem_desc_addr);
+
+	if ((octeon_bootinfo->major_version > 1) ||
+	    (octeon_bootinfo->major_version == 1 &&
+	     octeon_bootinfo->minor_version >= 4))
+		cvmx_coremask_copy(&sysinfo->core_mask,
+				   &octeon_bootinfo->ext_core_mask);
+	else
+		cvmx_coremask_set64(&sysinfo->core_mask,
+				    octeon_bootinfo->core_mask);
+
+	/* Some broken u-boot pass garbage in upper bits, clear them out */
+	if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
+		for (i = 512; i < 1024; i++)
+			cvmx_coremask_clear_core(&sysinfo->core_mask, i);
+
 	sysinfo->exception_base_addr = octeon_bootinfo->exception_base_addr;
 	sysinfo->cpu_clock_hz = octeon_bootinfo->eclock_hz;
 	sysinfo->dram_data_rate_hz = octeon_bootinfo->dclock_hz * 2;
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index b7fa9ae..b0f9a0a 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -103,6 +103,8 @@ static void octeon_smp_setup(void)
 	int cpus;
 	int id;
 	int core_mask = octeon_get_boot_coremask();
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
+
 #ifdef CONFIG_HOTPLUG_CPU
 	unsigned int num_cores = cvmx_octeon_num_cores();
 #endif
@@ -119,7 +121,7 @@ static void octeon_smp_setup(void)
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
 	for (id = 0; id < NR_CPUS; id++) {
-		if ((id != coreid) && (core_mask & (1 << id))) {
+		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
 			__cpu_number_map[id] = cpus;
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index d92cf59..c455d34 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -32,6 +32,8 @@
 #ifndef __CVMX_BOOTINFO_H__
 #define __CVMX_BOOTINFO_H__
 
+#include "cvmx-coremask.h"
+
 /*
  * Current major and minor versions of the CVMX bootinfo block that is
  * passed from the bootloader to the application.  This is versioned
@@ -39,7 +41,7 @@
  * versions.
  */
 #define CVMX_BOOTINFO_MAJ_VER 1
-#define CVMX_BOOTINFO_MIN_VER 3
+#define CVMX_BOOTINFO_MIN_VER 4
 
 #if (CVMX_BOOTINFO_MAJ_VER == 1)
 #define CVMX_BOOTINFO_OCTEON_SERIAL_LEN 20
@@ -124,6 +126,13 @@ struct cvmx_bootinfo {
 	 */
 	uint64_t fdt_addr;
 #endif
+#if (CVMX_BOOTINFO_MIN_VER >= 4)
+	/*
+	 * Coremask used for processors with more than 32 cores
+	 * or with OCI.  This replaces core_mask.
+	 */
+	struct cvmx_coremask ext_core_mask;
+#endif
 #else				/* __BIG_ENDIAN */
 	/*
 	 * Little-Endian: When the CPU mode is switched to
@@ -177,6 +186,9 @@ struct cvmx_bootinfo {
 #if (CVMX_BOOTINFO_MIN_VER >= 3)
 	uint64_t fdt_addr;
 #endif
+#if (CVMX_BOOTINFO_MIN_VER >= 4)
+	struct cvmx_coremask ext_core_mask;
+#endif
 #endif
 };
 
diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h b/arch/mips/include/asm/octeon/cvmx-coremask.h
new file mode 100644
index 0000000..097dc09
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
@@ -0,0 +1,89 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2016  Cavium Inc. (support@cavium.com).
+ *
+ */
+
+/*
+ * Module to support operations on bitmap of cores. Coremask can be used to
+ * select a specific core, a group of cores, or all available cores, for
+ * initialization and differentiation of roles within a single shared binary
+ * executable image.
+ *
+ * The core numbers used in this file are the same value as what is found in
+ * the COP0_EBASE register and the rdhwr 0 instruction.
+ *
+ * For the CN78XX and other multi-node environments the core numbers are not
+ * contiguous.  The core numbers for the CN78XX are as follows:
+ *
+ * Node 0:	Cores 0 - 47
+ * Node 1:	Cores 128 - 175
+ * Node 2:	Cores 256 - 303
+ * Node 3:	Cores 384 - 431
+ *
+ */
+
+#ifndef __CVMX_COREMASK_H__
+#define __CVMX_COREMASK_H__
+
+#define CVMX_MIPS_MAX_CORES 1024
+/* bits per holder */
+#define CVMX_COREMASK_ELTSZ 64
+
+/* cvmx_coremask_t's size in u64 */
+#define CVMX_COREMASK_BMPSZ (CVMX_MIPS_MAX_CORES / CVMX_COREMASK_ELTSZ)
+
+
+/* cvmx_coremask_t */
+struct cvmx_coremask {
+	u64 coremask_bitmap[CVMX_COREMASK_BMPSZ];
+};
+
+/*
+ * Is ``core'' set in the coremask?
+ */
+static inline bool cvmx_coremask_is_core_set(const struct cvmx_coremask *pcm,
+					    int core)
+{
+	int n, i;
+
+	n = core % CVMX_COREMASK_ELTSZ;
+	i = core / CVMX_COREMASK_ELTSZ;
+
+	return (pcm->coremask_bitmap[i] & ((u64)1 << n)) != 0;
+}
+
+/*
+ * Make a copy of a coremask
+ */
+static inline void cvmx_coremask_copy(struct cvmx_coremask *dest,
+				      const struct cvmx_coremask *src)
+{
+	memcpy(dest, src, sizeof(*dest));
+}
+
+/*
+ * Set the lower 64-bit of the coremask.
+ */
+static inline void cvmx_coremask_set64(struct cvmx_coremask *pcm,
+				       uint64_t coremask_64)
+{
+	pcm->coremask_bitmap[0] = coremask_64;
+}
+
+/*
+ * Clear ``core'' from the coremask.
+ */
+static inline void cvmx_coremask_clear_core(struct cvmx_coremask *pcm, int core)
+{
+	int n, i;
+
+	n = core % CVMX_COREMASK_ELTSZ;
+	i = core / CVMX_COREMASK_ELTSZ;
+	pcm->coremask_bitmap[i] &= ~(1ull << n);
+}
+
+#endif /* __CVMX_COREMASK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index 78cd64a..c6c3ee3 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -32,6 +32,8 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
+#include "cvmx-coremask.h"
+
 #define OCTEON_SERIAL_LEN 20
 /**
  * Structure describing application specific information.
@@ -50,8 +52,7 @@ struct cvmx_sysinfo {
 	uint64_t system_dram_size;
 
 	/* ptr to memory descriptor block */
-	void *phy_mem_desc_ptr;
-
+	uint64_t phy_mem_desc_addr;
 
 	/* Application image specific variables */
 	/* stack top address (virtual) */
@@ -63,7 +64,7 @@ struct cvmx_sysinfo {
 	/* heap size in bytes */
 	uint32_t heap_size;
 	/* coremask defining cores running application */
-	uint32_t core_mask;
+	struct cvmx_coremask core_mask;
 	/* Deprecated, use cvmx_coremask_first_core() to select init core */
 	uint32_t init_core;
 
-- 
1.7.11.7
