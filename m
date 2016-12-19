Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:11:05 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33945 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992836AbcLSCIHMFO7K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:07 +0100
Received: by mail-lf0-f67.google.com with SMTP id 30so4661491lfy.1;
        Sun, 18 Dec 2016 18:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lq7zFvdGLh7vMzOzGN1Veqkth8oaxOxcyVAOBs70pVc=;
        b=uLRmC2FC7Uh9vkDjpxwdPPzYzwOomFut0luv4NImjkFOoluMcKqEaKIXiQEOlclRxO
         aauYvQPhB773wDxcJTRua/9i/w4xjF76PLsy8Vgdqp+v1ounHfKrSZlPhmUt1pVwHZrx
         TU5jDtj1p+xvCviUoc9wyEpx0i4t1n0iNWvw9xaaoKz7q9L4Z3qOHMxYIxUclZ9DrQS4
         ymahpDJPh/qUR3SYcw8RDCVKQEU6/EybHmurSL1wJl4vFAMhKK9XJnQSjhjtFNu3f1Wt
         dzLZV1WZbgLygZVL7ve+4C7MTgb+9tFOTNARukrySvXK8zltZzKPWICDJYJa9vPl92fy
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lq7zFvdGLh7vMzOzGN1Veqkth8oaxOxcyVAOBs70pVc=;
        b=gPhyM9HOCiu2bd0LwbKgNegBp8rIfikPxlTwRp/4NF6EdNeQaTXUezGYsuPBVjx+Yq
         RczMU+nqgn+repqu6HLWY7os1laC/833phUEl7WS0pk5zbdlsj9gSjUpMUnrTltKDko2
         eCRW7sQIB5EH1vwSVmkx5LJiZ8YchZ282dnD7+2hoH582OoNx39+WYo2eHoMSM8jnHtl
         C6VXx+bwxB6o0sDwLCKQV3/7q6kE6FQT2mJt0h1ILy8IU8wSIdpkuW28eiHCLQN7vCtC
         pppdcN/kcAVrqxHZwrkRqlveaJlsyY16nSbnv2PnhdlMp/bTplK6TECnPzzlbhtTIb8F
         mrtg==
X-Gm-Message-State: AIkVDXJdYWbqqNxFGwtf87Xo+9iXxvqMEoRmb8p/xbcuJykWbrTv7zTs4lieiAIaHqCZTw==
X-Received: by 10.46.76.1 with SMTP id z1mr6070976lja.41.1482113280983;
        Sun, 18 Dec 2016 18:08:00 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:00 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 07/21] MIPS memblock: Alter elfcorehdr parameters parser
Date:   Mon, 19 Dec 2016 05:07:32 +0300
Message-Id: <1482113266-13207-8-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56070
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

Memblock API can be successfully used to verify whether elfcorehdr
memory region belongs to lowmemory, then it can be reserved within
memblock allocator. There is also available default method for
early parameters parser in kernel/crash_dump.c: setup_elfcorehdr(),
so it's wise to use one instead of creating our own doing actually
the same thing.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 91 +++++++++++++++++-------------
 1 file changed, 52 insertions(+), 39 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index cc6d06b..52205fb 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -426,6 +426,55 @@ static void __init mips_reserve_initrd_mem(void) { }
 
 #endif
 
+/*
+ * Reserve memory occupied by elfcorehdr
+ */
+static void __init mips_reserve_elfcorehdr(void)
+{
+#ifdef CONFIG_PROC_VMCORE
+	/*
+	 * Don't reserve anything if kernel isn't booting after a panic and
+	 * vmcore is usable (see linux/crash_dump.h for details)
+	 */
+	if (!is_vmcore_usable())
+		return;
+
+	/* Check whether the passed address belongs to low memory */
+	if (elfcorehdr_addr + elfcorehdr_size >= mips_lowmem_limit) {
+		pr_err("Elfcorehdr %08zx @ %pa doesn't belong to low memory",
+			(size_t)elfcorehdr_size, &elfcorehdr_addr);
+		return;
+	}
+
+	/*
+	 * If elfcorehdr_size hasn't been specified, then try to reserve upto
+	 * low memory limit
+	 */
+	if (!elfcorehdr_size)
+		elfcorehdr_size = mips_lowmem_limit - elfcorehdr_addr;
+
+	/* Check the region belongs to actual memory (size can be zero) */
+	if (!memblock_is_region_memory(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_err("Elfcorehdr %08zx @ %pa is not a memory region",
+			(size_t)elfcorehdr_size, &elfcorehdr_addr);
+		return;
+	}
+
+	/* Check whether elfcorehdr region is free */
+	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_err("Elfcorehdr %08zx @ %pa overlaps in-use memory",
+			(size_t)elfcorehdr_size, &elfcorehdr_addr);
+		return;
+	}
+
+	/* Reserve elfcorehdr within memblock */
+	memblock_reserve(elfcorehdr_addr, PAGE_ALIGN(elfcorehdr_size));
+
+	pr_info("Reserved memory for kdump at %08zx @ %pa\n",
+		(size_t)elfcorehdr_size, &elfcorehdr_addr);
+#endif /* CONFIG_PROC_VMCORE */
+}
+
 #ifdef CONFIG_KEXEC
 /*
  * Parse passed crashkernel parameter and reserve corresponding memory
@@ -499,6 +548,9 @@ static void __init bootmem_init(void)
 	/* Check and reserve memory occupied by initrd */
 	mips_reserve_initrd_mem();
 
+	/* Reserve memory for elfcorehdr */
+	mips_reserve_elfcorehdr();
+
 	/* Parse crashkernel parameter */
 	mips_parse_crashkernel();
 
@@ -719,37 +771,6 @@ static void __init bootmem_init(void)
  * initialization hook for anything else was introduced.
  */
 
-#ifdef CONFIG_PROC_VMCORE
-unsigned long setup_elfcorehdr, setup_elfcorehdr_size;
-static int __init early_parse_elfcorehdr(char *p)
-{
-	int i;
-
-	setup_elfcorehdr = memparse(p, &p);
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long start = boot_mem_map.map[i].addr;
-		unsigned long end = (boot_mem_map.map[i].addr +
-				     boot_mem_map.map[i].size);
-		if (setup_elfcorehdr >= start && setup_elfcorehdr < end) {
-			/*
-			 * Reserve from the elf core header to the end of
-			 * the memory segment, that should all be kdump
-			 * reserved memory.
-			 */
-			setup_elfcorehdr_size = end - setup_elfcorehdr;
-			break;
-		}
-	}
-	/*
-	 * If we don't find it in the memory map, then we shouldn't
-	 * have to worry about it, as the new kernel won't use it.
-	 */
-	return 0;
-}
-early_param("elfcorehdr", early_parse_elfcorehdr);
-#endif
-
 static void __init arch_mem_addpart(phys_addr_t mem, phys_addr_t end, int type)
 {
 	phys_addr_t size;
@@ -833,14 +854,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	parse_early_param();
 
 	bootmem_init();
-#ifdef CONFIG_PROC_VMCORE
-	if (setup_elfcorehdr && setup_elfcorehdr_size) {
-		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
-		       setup_elfcorehdr, setup_elfcorehdr_size);
-		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
-				BOOTMEM_DEFAULT);
-	}
-#endif
 
 	device_tree_init();
 	sparse_init();
-- 
2.6.6
