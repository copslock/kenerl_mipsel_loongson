Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:12:02 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36754 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992902AbcLSCIIvar4K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:08 +0100
Received: by mail-lf0-f65.google.com with SMTP id o20so6141500lfg.3;
        Sun, 18 Dec 2016 18:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hR/61BRWFWGXf16fB2jFs0RyZmSljXhR8Aps1zXXTg=;
        b=Sr7DvHo8tgfzhj7JnvXX2UeVunWCZ+uHXgswIQhjxCFDqWLjwVrF27NBsPUSVMz8on
         n8liDsewOI3fU+ipdoNPouxv2lQ/0v2+akTF7ARLZO/ABJF1mZBD0sWRMQCe6CNtJvqh
         oJ5aOig5qKzDwcQjmT4CBG1vuWOE6mPl5tc4HYujAt0b2EiOiKFSy3AqAW1jR81iS+Q2
         71kG+ceOn3ZL3w3FYgdewnQJ4Yg9bLX1im37kqPPUjP1Ufn1JWBJgIq6I30hT6IkiFx8
         Gl5pHcWqtIVWQRO6ksU1wzRQiC/K1llmeoXiG0NYhTdO2So31jnH/vXCdq0ZZ800Pi5A
         QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hR/61BRWFWGXf16fB2jFs0RyZmSljXhR8Aps1zXXTg=;
        b=YqZcVE+OS9AZa0ZPDf78X4YDq4cGEzekhY8jXzcJ1Vmxf4e8+q0JuNrnvZo/AfCooa
         W+dWc9tbqbwmcd2p+utLD0QxlRRBj77TxL4hPFa4ZjDg2mwQwOb56as/BGiBQ1uTn2Ff
         XIJbG1rx4dKRZeTJCYMqNdg5UCM7ga++WopY48+B602Pffontch239/m/a0vW2sSKCLr
         1zrRptvfqIAeeTwRq8WhsQPX6Anlg30H6t9WM8rUIqxax7XYYVX2N6H429+A22xy53XK
         iVOUVUg2bQGYVy1+hUKhshyOzN2nYdc5mIyHcMtiilIiG/WJawjExDJ7pWNmjSI21F94
         9Y4w==
X-Gm-Message-State: AIkVDXKQujHzDXRlbEW/cxxMV+Cich/CiTQ00JD8RBOB4B2WE5UJ6zyP+rpZ1K5b3CBeNw==
X-Received: by 10.46.8.9 with SMTP id 9mr5786851lji.47.1482113283339;
        Sun, 18 Dec 2016 18:08:03 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:02 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 09/21] MIPS memblock: Move kernel memory reservation to individual method
Date:   Mon, 19 Dec 2016 05:07:34 +0300
Message-Id: <1482113266-13207-10-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56072
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

The whole kernel text/data/bss must be reserved to prevent sudden
kernel crashes, for instance, due to unexpected non-zero default static
variables initializations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 117 +++++++++++++++--------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9c1a60d..e746793 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -472,6 +472,62 @@ static void __init mips_reserve_initrd_mem(void) { }
 #endif
 
 /*
+ * Reserve kernel code and data within memblock allocator
+ */
+static void __init mips_reserve_kernel_mem(void)
+{
+	phys_addr_t start, size;
+
+	/*
+	 * Add kernel _text, _data, _bss, __init*, upto __end sections to
+	 * boot_mem_map and memblock. We must reserve all of them!
+	 */
+	start = __pa_symbol(&_text);
+	size = __pa_symbol(&_end) - start;
+	add_memory_region(start, size, BOOT_MEM_RAM);
+	/*
+	 * It needs to be reserved within memblock as well. It's ok if memory
+	 * has already been reserved with previous method
+	 */
+	memblock_reserve(start, size);
+
+	/* Reserve nosave region for hibernation */
+	start = __pa_symbol(&__nosave_begin);
+	size = __pa_symbol(&__nosave_end) - start;
+	add_memory_region(start, size, BOOT_MEM_RAM);
+	memblock_reserve(start, size);
+
+	/* Initialize some init_mm fieldis. We may not need this? */
+	init_mm.start_code = (unsigned long)&_text;
+	init_mm.end_code = (unsigned long)&_etext;
+	init_mm.end_data = (unsigned long)&_edata;
+	init_mm.brk = (unsigned long)&_end;
+
+	/*
+	 * The kernel reserves all memory below its _end symbol as bootmem,
+	 * but the kernel may now be at a much higher address. The memory
+	 * between the original and new locations may be returned to the system.
+	 */
+#ifdef CONFIG_RELOCATABLE
+	if (__pa_symbol(&_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
+		phys_addr_t offset;
+		extern void show_kernel_relocation(const char *level);
+
+		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
+		memblock_free(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
+
+#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
+		/*
+		 * This information is necessary when debugging the kernel
+		 * But is a security vulnerability otherwise!
+		 */
+		show_kernel_relocation(KERN_INFO);
+#endif
+	}
+#endif
+}
+
+/*
  * Reserve memory occupied by elfcorehdr
  */
 static void __init mips_reserve_elfcorehdr(void)
@@ -590,6 +646,9 @@ static void __init bootmem_init(void)
 	unsigned long bootmap_size;
 	int i;
 
+	/* Reserve kernel code/data memory */
+	mips_reserve_kernel_mem();
+
 	/* Check and reserve memory occupied by initrd */
 	mips_reserve_initrd_mem();
 
@@ -766,29 +825,6 @@ static void __init bootmem_init(void)
 	 * Reserve the bootmap memory.
 	 */
 	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
-
-#ifdef CONFIG_RELOCATABLE
-	/*
-	 * The kernel reserves all memory below its _end symbol as bootmem,
-	 * but the kernel may now be at a much higher address. The memory
-	 * between the original and new locations may be returned to the system.
-	 */
-	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
-		extern void show_kernel_relocation(const char *level);
-
-		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
-		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
-
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
-		/*
-		 * This information is necessary when debugging the kernel
-		 * But is a security vulnerability otherwise!
-		 */
-		show_kernel_relocation(KERN_INFO);
-#endif
-	}
-#endif
 }
 
 #endif	/* CONFIG_SGI_IP27 */
@@ -816,25 +852,6 @@ static void __init bootmem_init(void)
  * initialization hook for anything else was introduced.
  */
 
-static void __init arch_mem_addpart(phys_addr_t mem, phys_addr_t end, int type)
-{
-	phys_addr_t size;
-	int i;
-
-	size = end - mem;
-	if (!size)
-		return;
-
-	/* Make sure it is in the boot_mem_map */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (mem >= boot_mem_map.map[i].addr &&
-		    mem < (boot_mem_map.map[i].addr +
-			   boot_mem_map.map[i].size))
-			return;
-	}
-	add_memory_region(mem, size, type);
-}
-
 static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
@@ -846,19 +863,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Parse passed parameters */
 	mips_parse_param(cmdline_p);
 
-	/*
-	 * Make sure all kernel memory is in the maps.  The "UP" and
-	 * "DOWN" are opposite for initdata since if it crosses over
-	 * into another memory section you don't want that to be
-	 * freed when the initdata is freed.
-	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
-
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
@@ -873,9 +877,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
 			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-
-	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
-			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
 }
 
 static void __init resource_init(void)
-- 
2.6.6
