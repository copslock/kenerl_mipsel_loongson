Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 00:21:15 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33488 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbeAEXVEvDyTF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 00:21:04 +0100
Received: by mail-ot0-f195.google.com with SMTP id x15so5185605ote.0;
        Fri, 05 Jan 2018 15:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jS0EDtKp3J7hEq++QbWurWbGjKfPAZ5R+EzwhkTQI1g=;
        b=fvcIsxelH3Na4lrUz32BBPttmksoKihikCguVJfNACMjZIW18h5ka4TTlovBffapvx
         ji65uwtHYyVH7DskoP1gF8bVIUATVBcs5XKNU1wFDntNEjA1uGpy2d/aBsdsC3jtRLnu
         hhWADv2u7TYqv5f2p2rP4oKTDWkCvY0dt+hd672lbxMU3Rhs5tYc7HfymAg9hJvNBdHY
         AgV72NLI2RwnzF6yCYu+l026gQgysr5VL0PQdzdRi0xTER4y8+7i3JG8AWUlQHtOAhw7
         iGfUMytHF5oPpU1xzNaZayTZ+k1dP2fLg5CM4lDMk5OVkfWasB0q+SYVtSZSNOBPFgq8
         x8Vg==
X-Gm-Message-State: AKwxytcAJkVLv/Js2Nqj3ZtGtwOMvrCXzPrr7uwuAcZtycQl283cwCXt
        GwbMDRxf9m6m4Yvv+cb+uA==
X-Google-Smtp-Source: ACJfBov8RgM6wXg8Ye3wRHQIFFnTbMbtkwhC1s5gzhrjglHZp7qltaGmJNyoI6JnhnkGGCzBGJAK0Q==
X-Received: by 10.157.63.215 with SMTP id i23mr2915809ote.70.1515194458979;
        Fri, 05 Jan 2018 15:20:58 -0800 (PST)
Received: from xps15.usacommunications.tv (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.googlemail.com with ESMTPSA id u1sm1969998otc.3.2018.01.05.15.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 15:20:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-cris-kernel@axis.com
Subject: [PATCH 1/7] of/fdt: use memblock_virt_alloc for early alloc
Date:   Fri,  5 Jan 2018 17:20:48 -0600
Message-Id: <20180105232054.27394-2-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180105232054.27394-1-robh@kernel.org>
References: <20180105232054.27394-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

memblock_virt_alloc() works for both memblock and bootmem, so use it and
make early_init_dt_alloc_memory_arch a static function. The arches using
bootmem define early_init_dt_alloc_memory_arch as either:

__alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS))

or:

alloc_bootmem_align(size, align)

Both of these evaluate to the same thing as does memblock_virt_alloc for
bootmem. So we can disable the arch specific functions by making
early_init_dt_alloc_memory_arch static and they can be removed in
subsequent commits.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c       | 16 ++++------------
 drivers/of/unittest.c  | 11 ++++++++---
 include/linux/of_fdt.h |  1 -
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4675e5ac4d11..444e65aa0d29 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -14,6 +14,7 @@
 #include <linux/crc32.h>
 #include <linux/kernel.h>
 #include <linux/initrd.h>
+#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -1183,14 +1184,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 	return memblock_reserve(base, size);
 }

-/*
- * called from unflatten_device_tree() to bootstrap devicetree itself
- * Architectures can override this definition if memblock isn't used
- */
-void * __init __weak early_init_dt_alloc_memory_arch(u64 size, u64 align)
-{
-	return __va(memblock_alloc(size, align));
-}
 #else
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
@@ -1209,13 +1202,12 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 		  &base, &size, nomap ? " (nomap)" : "");
 	return -ENOSYS;
 }
+#endif

-void * __init __weak early_init_dt_alloc_memory_arch(u64 size, u64 align)
+static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 {
-	WARN_ON(1);
-	return NULL;
+	return memblock_virt_alloc(size, align);
 }
-#endif

 bool __init early_init_dt_verify(void *params)
 {
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 0f8052f1355c..7a9abaae874d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -5,6 +5,7 @@

 #define pr_fmt(fmt) "### dt-test ### " fmt

+#include <linux/bootmem.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -2053,6 +2054,11 @@ static struct overlay_info overlays[] = {

 static struct device_node *overlay_base_root;

+static void * __init dt_alloc_memory(u64 size, u64 align)
+{
+	return memblock_virt_alloc(size, align);
+}
+
 /*
  * Create base device tree for the overlay unittest.
  *
@@ -2092,8 +2098,7 @@ void __init unittest_unflatten_overlay_base(void)
 		return;
 	}

-	info->data = early_init_dt_alloc_memory_arch(size,
-					     roundup_pow_of_two(FDT_V17_SIZE));
+	info->data = dt_alloc_memory(size, roundup_pow_of_two(FDT_V17_SIZE));
 	if (!info->data) {
 		pr_err("alloc for dtb 'overlay_base' failed");
 		return;
@@ -2102,7 +2107,7 @@ void __init unittest_unflatten_overlay_base(void)
 	memcpy(info->data, info->dtb_begin, size);

 	__unflatten_device_tree(info->data, NULL, &info->np_overlay,
-				early_init_dt_alloc_memory_arch, true);
+				dt_alloc_memory, true);
 	overlay_base_root = info->np_overlay;
 }

diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 444e6e283828..02c05028d0ba 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -83,7 +83,6 @@ extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern int early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size);
 extern int early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool no_map);
-extern void * early_init_dt_alloc_memory_arch(u64 size, u64 align);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);

 /* Early flat tree scan hooks */
--
2.14.1
