Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:10:18 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35825 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992659AbcLSCIELx0XK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:04 +0100
Received: by mail-lf0-f66.google.com with SMTP id p100so6143924lfg.2;
        Sun, 18 Dec 2016 18:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swmwSbPH+BGFunSeIUDTYiOy+tVn5i06qvDBcuVTOHo=;
        b=TNreLMMwfFzdOEEMkrN7Vvk8JxvEnUP90AezT7jgJ/dq9zDBWD34Zp8XZYBSITw6Bn
         YcACeKBncLsK5SrluyZFSrjCLX7apIZ3so/lEfnBwjgBkyh/DGpmBq/sItQH+KyDJGlG
         8PzTL+3Uq2iljICgKAW6UMdGm4dr1e50/gRGvL7SERk+f1QyQ899bLIUXX0Sb3BIktaW
         jOCyGghfU4NNgSgvBEkj4lBPiPgTg6QYDvpEWZuOzjRojAs5Nopq0lk/426R0nui8+H9
         fiDytD8nEXGmKS3daKs1af9jVqwgtGF1KIhr6zIENQ+JBRE/PTUQbr9GMwn4YVsPkPh3
         ko9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swmwSbPH+BGFunSeIUDTYiOy+tVn5i06qvDBcuVTOHo=;
        b=lseSo3p9tYyZRPq8Tr1V1nTgXiEWnDLVEbyOnALkIup9Z2FSnpjTccd59RsLHMjlVs
         5nGwHa7/paUSakkB3vVaumpeHdSQtrfUYKPgjMJvRra10iMvJx3yMikLztW48NQ3mB3A
         88IqP6bJtswp2YZjQPj3jFxKm0j0gjRCqkCtbVfhaZpOOn9C64BZXJ+ZedYdz2VkkPYQ
         Bja1IbigyS9ubpBGFfy/UxWqc/q/oQkZ1wM7T7AWqwOT8bLmufe1v6M6gUyQlP8bTH8B
         /wSAwnzU9i3r3W6ncfmHqiu1O5zk1VLPtUWL9fDXSXTWLv4yH+/ffFHcHWQSGT5QaJaH
         oawQ==
X-Gm-Message-State: AIkVDXKA4iVL6P9xuU6pgKIEd08JSkFCoEg6BiYo5pY9zXV/JCPSl0qy010dElqoKLJ0Kw==
X-Received: by 10.46.9.73 with SMTP id 70mr6251377ljj.2.1482113278648;
        Sun, 18 Dec 2016 18:07:58 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:58 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 05/21] MIPS memblock: Alter initrd memory reservation method
Date:   Mon, 19 Dec 2016 05:07:30 +0300
Message-Id: <1482113266-13207-6-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Since memblock is used, initrd memory region can be easily
verified and reserved if looks ok. Verification method will be
useful for other reservation methods.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 157 ++++++++++++++++-------------
 1 file changed, 87 insertions(+), 70 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 789aafe..d2f38ac 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -82,6 +82,8 @@ static struct resource data_resource = { .name = "Kernel data", };
 
 static void *detect_magic __initdata = detect_memory_region;
 
+static phys_addr_t __initdata mips_lowmem_limit;
+
 /*
  * General method to add RAM regions to the system
  *
@@ -266,6 +268,38 @@ static int __init early_parse_mem(char *p)
 early_param("mem", early_parse_mem);
 
 /*
+ * Helper method checking whether passed lowmem region is valid
+ */
+static bool __init is_lowmem_and_valid(const char *name, phys_addr_t base,
+				       phys_addr_t size)
+{
+	phys_addr_t end = base + size;
+
+	/* Check whether region belongs to actual memory */
+	if (!memblock_is_region_memory(base, size)) {
+		pr_err("%s %08zx @ %pa is not a memory region", name,
+			(size_t)size, &base);
+		return false;
+	}
+
+	/* Check whether region belongs to low memory */
+	if (end > mips_lowmem_limit) {
+		pr_err("%s %08zx @ %pa is out of low memory", name,
+			(size_t)size, &base);
+	       return false;
+	}
+
+	/* Check whether region is free */
+	if (memblock_is_region_reserved(base, size)) {
+		pr_err("%s %08zx @ %pa overlaps in-use memory", name,
+			(size_t)size, &base);
+		return false;
+	}
+
+	return true;
+}
+
+/*
  * Manage initrd
  */
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -292,47 +326,6 @@ static int __init rd_size_early(char *p)
 }
 early_param("rd_size", rd_size_early);
 
-/* it returns the next free pfn after initrd */
-static unsigned long __init init_initrd(void)
-{
-	unsigned long end;
-
-	/*
-	 * Board specific code or command line parser should have
-	 * already set up initrd_start and initrd_end. In these cases
-	 * perfom sanity checks and use them if all looks good.
-	 */
-	if (!initrd_start || initrd_end <= initrd_start)
-		goto disable;
-
-	if (initrd_start & ~PAGE_MASK) {
-		pr_err("initrd start must be page aligned\n");
-		goto disable;
-	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
-
-	/*
-	 * Sanitize initrd addresses. For example firmware
-	 * can't guess if they need to pass them through
-	 * 64-bits values if the kernel has been built in pure
-	 * 32-bit. We need also to switch from KSEG0 to XKPHYS
-	 * addresses now, so the code can now safely use __pa().
-	 */
-	end = __pa(initrd_end);
-	initrd_end = (unsigned long)__va(end);
-	initrd_start = (unsigned long)__va(__pa(initrd_start));
-
-	ROOT_DEV = Root_RAM0;
-	return PFN_UP(end);
-disable:
-	initrd_start = 0;
-	initrd_end = 0;
-	return 0;
-}
-
 /* In some conditions (e.g. big endian bootloader with a little endian
    kernel), the initrd might appear byte swapped.  Try to detect this and
    byte swap it if needed.  */
@@ -362,26 +355,64 @@ static void __init maybe_bswap_initrd(void)
 #endif
 }
 
-static void __init finalize_initrd(void)
+/*
+ * Check and reserve memory occupied by initrd
+ */
+static void __init mips_reserve_initrd_mem(void)
 {
-	unsigned long size = initrd_end - initrd_start;
+	phys_addr_t phys_initrd_start, phys_initrd_end, phys_initrd_size;
 
-	if (size == 0) {
-		printk(KERN_INFO "Initrd not found or empty");
+	/*
+	 * Board specific code or command line parser should have already set
+	 * up initrd_start and initrd_end. In these cases perform sanity checks
+	 * and use them if all looks good.
+	 */
+	if (!initrd_start || initrd_end <= initrd_start) {
+		pr_info("No initrd found");
 		goto disable;
 	}
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		printk(KERN_ERR "Initrd extends beyond end of memory");
+	if (initrd_start & ~PAGE_MASK) {
+		pr_err("Initrd start must be page aligned");
 		goto disable;
 	}
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("Initrd start < PAGE_OFFSET");
+		goto disable;
+	}
+
+	/*
+	 * Sanitize initrd addresses. For example firmware can't guess if they
+	 * need to pass them through 64-bits values if the kernel has been
+	 * built in pure 32-bit. We need also to switch from KSEG0 to XKPHYS
+	 * addresses now, so the code can now safely use __pa().
+	 */
+	phys_initrd_start = __pa(initrd_start);
+	phys_initrd_end = __pa(initrd_end);
+	phys_initrd_size = phys_initrd_end - phys_initrd_start;
 
+	/* Check whether initrd region is within available lowmem and free */
+	if (!is_lowmem_and_valid("Initrd", phys_initrd_start, phys_initrd_size))
+		goto disable;
+
+	/* Initrd may be byteswapped in Octeon */
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	/* Memory for initrd can be reserved now */
+	memblock_reserve(phys_initrd_start, phys_initrd_size);
+
+	/* Convert initrd to virtual addresses back (needed for x32 -> x64) */
+	initrd_start = (unsigned long)__va(phys_initrd_start);
+	initrd_end = (unsigned long)__va(phys_initrd_end);
+
+	/* It's OK to have initrd below actual memory start. Really? */
 	initrd_below_start_ok = 1;
 
-	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
-		initrd_start, size);
+	pr_info("Initial ramdisk at: 0x%lx (%zu bytes)\n",
+		initrd_start, (size_t)phys_initrd_size);
+
+	/* Set root device to be first ram disk */
+	ROOT_DEV = Root_RAM0;
+
 	return;
 disable:
 	printk(KERN_CONT " - disabling initrd\n");
@@ -391,12 +422,7 @@ disable:
 
 #else  /* !CONFIG_BLK_DEV_INITRD */
 
-static unsigned long __init init_initrd(void)
-{
-	return 0;
-}
-
-#define finalize_initrd()	do {} while (0)
+static void __init mips_reserve_initrd_mem(void) { }
 
 #endif
 
@@ -408,8 +434,8 @@ static unsigned long __init init_initrd(void)
 
 static void __init bootmem_init(void)
 {
-	init_initrd();
-	finalize_initrd();
+	/* Check and reserve memory occupied by initrd */
+	mips_reserve_initrd_mem();
 }
 
 #else  /* !CONFIG_SGI_IP27 */
@@ -421,13 +447,9 @@ static void __init bootmem_init(void)
 	unsigned long bootmap_size;
 	int i;
 
-	/*
-	 * Sanity check any INITRD first. We don't take it into account
-	 * for bootmem setup initially, rely on the end-of-kernel-code
-	 * as our memory range starting point. Once bootmem is inited we
-	 * will reserve the area used for the initrd.
-	 */
-	init_initrd();
+	/* Check and reserve memory occupied by initrd */
+	mips_reserve_initrd_mem();
+
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
 	/*
@@ -618,11 +640,6 @@ static void __init bootmem_init(void)
 #endif
 	}
 #endif
-
-	/*
-	 * Reserve initrd memory if needed.
-	 */
-	finalize_initrd();
 }
 
 #endif	/* CONFIG_SGI_IP27 */
-- 
2.6.6
