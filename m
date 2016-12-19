Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:14:26 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34833 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbcLSCIPA4EbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:15 +0100
Received: by mail-lf0-f68.google.com with SMTP id p100so6144162lfg.2;
        Sun, 18 Dec 2016 18:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NnOn2wXXADV5c0qpYYXaSQSPi6L95fPl6V6tk5EK9dc=;
        b=QEbxIoiZV+x1x2uFlsoix56vtvGbMXlJ5/SSgRocbhYyVdq3hnQesBAvWnByMvZ9sw
         G9WQUrUllAURyTttMFTkVmfp/CTBTFLvFj/swMoVOCh59xYWUg26gV0GrDKYIRpcWwsX
         wv0y7dQNtl+/dP8hgQKXjJ0F/3PE1qVnI3EbMcHpSeSAiygyZ1Vp4TfppsJxPkyGwKr1
         YRQ+gnCxolb87CcMHsf3e/j+GjEmF3X60FL7EQloIXXN8GiLsrZZSXikqwk554rr5tng
         SmXXld3ipis843mrgcRa40h7pM4adCFlGLDGBrBPFVbIzfPOFlIHUcSWhFtWelZ+v8wR
         RfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NnOn2wXXADV5c0qpYYXaSQSPi6L95fPl6V6tk5EK9dc=;
        b=oUBEHptZmAVNs/51An1ZY1hZCFP15rKUMgMZoDX/quofz4iJebqdZA/chbZLpabv3S
         39jsyQnxVHHSMqtRYe7y9OBchV/tHjsX2o+RJQqnlUxjGRh6W5Y+rJvxappjgNgTMVUF
         VvNKVH68kb5adAIA5xrP4MF7eY6EmHyrXaF4v7vwQXCqOWkw67DwEIsHQIVxDsxR+7nl
         E3wdRbVw3KU3Trtid50Oj64ozeDWUMlwi7a5TjxeWK/9b+6LG9faEzPxVpnWEjLkpaKi
         bF9aSF9vDPwyKPRlqQzuK36DQaK+xGHfAWETNe4oYoWrXL7u4UdYJaeNTQMk+skgWbei
         cApQ==
X-Gm-Message-State: AKaTC029Oa7pTjaPCNdOZIAnkDTUJqhFjxVGZ/yEordU3zLpEdpcKooXQyxQavtSg2unGA==
X-Received: by 10.25.16.71 with SMTP id f68mr4479367lfi.93.1482113289459;
        Sun, 18 Dec 2016 18:08:09 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:08 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 15/21] MIPS memblock: Alter weakened MAAR initialization method
Date:   Mon, 19 Dec 2016 05:07:40 +0300
Message-Id: <1482113266-13207-16-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56078
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

MAAR initialization method can be slightly simplified, since
memblock allocator is fully available.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a4f49c7..49db909 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/memblock.h>
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
@@ -245,28 +246,26 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 #endif
 }
 
-unsigned __weak platform_maar_init(unsigned num_pairs)
+/*
+ * Platform-specific method of MAAR registers initialization
+ */
+unsigned int __weak platform_maar_init(unsigned int num_pairs)
 {
 	struct maar_config cfg[BOOT_MEM_MAP_MAX];
-	unsigned i, num_configured, num_cfg = 0;
+	struct memblock_region *reg;
+	unsigned int num_configured, num_cfg = 0;
 
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-		case BOOT_MEM_INIT_RAM:
+	/* Collect RAM regions within MAAR config array */
+	for_each_memblock(memory, reg) {
+		if (num_cfg >= BOOT_MEM_MAP_MAX) {
+			pr_info("Too many memory regions to init MAARs");
 			break;
-		default:
-			continue;
 		}
-
 		/* Round lower up */
-		cfg[num_cfg].lower = boot_mem_map.map[i].addr;
-		cfg[num_cfg].lower = (cfg[num_cfg].lower + 0xffff) & ~0xffff;
+		cfg[num_cfg].lower = (reg->base + 0xffff) & ~0xffff;
 
 		/* Round upper down */
-		cfg[num_cfg].upper = boot_mem_map.map[i].addr +
-					boot_mem_map.map[i].size;
-		cfg[num_cfg].upper = (cfg[num_cfg].upper & ~0xffff) - 1;
+		cfg[num_cfg].upper = ((reg->base + reg->size) & ~0xffff) - 1;
 
 		cfg[num_cfg].attrs = MIPS_MAAR_S;
 		num_cfg++;
-- 
2.6.6
