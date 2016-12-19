Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:14:05 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34828 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993078AbcLSCIOVyx-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:14 +0100
Received: by mail-lf0-f67.google.com with SMTP id p100so6144098lfg.2;
        Sun, 18 Dec 2016 18:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gz2lGQ/GWOFvOjpj0ijKVLgcBmXy97Hr1+bCljUV5NI=;
        b=Ic1k1JsEQNQ5yfhRANHu06GmqHwTMjPeg1aYjqfAJpRa+zQ3zg8XlnL0XhFM8M1SeE
         sQflikr6h5ClXp1LUG+d5aa+XHmNp4Gxq5o1eJC80WreIj5ZC0uRg7AtlTueS4vNvbf2
         a8vBotcEZwQL9Ubcsojgkc3xZtMq1fSa4PyI5WSEqO/qrgw8y0fvR58Kn7RBJn/DDyaP
         qit/48hMa6Rk2nWWi72N0NdadBbS+4lKW5nxEE+IuriJdrieqz2Kk4YJJ+QmEmPTlD1u
         Ubz2fFekBwe7MqzF0pRgngbiT2uyYVagdAZfiOIpSRR47PTD1iVnqvdNtSQ4oQH1AsDg
         33gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gz2lGQ/GWOFvOjpj0ijKVLgcBmXy97Hr1+bCljUV5NI=;
        b=lIhuX6xOQTX35xNVUGX8a5939nQngvcgYUZmTbrJPbz5wTtlFzNxP3lSRSwIrtqqGn
         g0DDxUZBOx0smcykxkDZZi6fKNR6B5A4/I+4VpusdQK2BRZsLk4zafYJp9PcWhuda0LQ
         H9oOyb+fbogu3kxm5qVlH53ha5mgOeAk4p29y8feVa6N++4gTONvqDco/dvIcg4TQYmD
         VwhdId3ckIgqWFzv7BUNXvO+lsWIdh5mKCv0M4feagtSC7dKbOViysn9tqxlfv5Q17yP
         /8mILmpu3DOkShf49bBl5PUj0uTIdAw2AhRGmxhu9USUHZ0ClXtTgXhD58na6TU7E+XL
         cDuQ==
X-Gm-Message-State: AKaTC00lqsCvVJeE6w/ECocz49Ztih52ZgzprkARxR8b1xpfeZnie4o0eYKelqW1egeOIg==
X-Received: by 10.25.133.135 with SMTP id h129mr3692239lfd.127.1482113288434;
        Sun, 18 Dec 2016 18:08:08 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:07 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 14/21] MIPS memblock: Alter IO resources initialization method
Date:   Mon, 19 Dec 2016 05:07:39 +0300
Message-Id: <1482113266-13207-15-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56077
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

Replace resource initialization method with one using memblocks.
It fully reflects all available system RAM within memory regions.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 40 +++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b18d38c..8bef2d3 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -868,46 +868,30 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 }
 
+/*
+ * Declare memory within system resources
+ */
 static void __init resource_init(void)
 {
-	int i;
+	struct memblock_region *reg;
 
 	if (UNCAC_BASE != IO_BASE)
 		return;
 
+	/* Kernel code and data need to be registered within proper regions */
 	code_resource.start = __pa_symbol(&_text);
 	code_resource.end = __pa_symbol(&_etext) - 1;
 	data_resource.start = __pa_symbol(&_etext);
 	data_resource.end = __pa_symbol(&_edata) - 1;
 
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
+	/* Register RAM resources */
+	for_each_memblock(memory, reg) {
 		struct resource *res;
-		unsigned long start, end;
-
-		start = boot_mem_map.map[i].addr;
-		end = boot_mem_map.map[i].addr + boot_mem_map.map[i].size - 1;
-		if (start >= HIGHMEM_START)
-			continue;
-		if (end >= HIGHMEM_START)
-			end = HIGHMEM_START - 1;
-
-		res = alloc_bootmem(sizeof(struct resource));
-
-		res->start = start;
-		res->end = end;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-		case BOOT_MEM_INIT_RAM:
-		case BOOT_MEM_ROM_DATA:
-			res->name = "System RAM";
-			res->flags |= IORESOURCE_SYSRAM;
-			break;
-		case BOOT_MEM_RESERVED:
-		default:
-			res->name = "reserved";
-		}
+		res = memblock_virt_alloc(sizeof(*res), 0);
+		res->name  = "System RAM";
+		res->start = PFN_PHYS(memblock_region_memory_base_pfn(reg));
+		res->end = PFN_PHYS(memblock_region_memory_end_pfn(reg)) - 1;
+		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 
 		request_resource(&iomem_resource, res);
 
-- 
2.6.6
