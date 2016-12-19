Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:09:05 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33067 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbcLSCIAuKwuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:00 +0100
Received: by mail-lf0-f67.google.com with SMTP id y21so6156782lfa.0;
        Sun, 18 Dec 2016 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpbxVjqb6dSQcFevIEv3p5jxi8rf5BpTV42y+OYsO5Y=;
        b=MJwFbwKLaFs1SqZ/9murq5/7Ow1iQgUlUegeI50VG7CwinuRh7bhueduEM9EW0pnrN
         5i1SiVLyGvB55+T7aUojYamVL8GyAl0gJCzUYshY+sXsVftm/TR1ZRHoDuokG+ITpbTx
         DQwtxhj0YfXdIrzK3WHPV/dRL7kEW93gDhYi2WzLXasmYk8u61itjYSq6u4BE1RpZUxS
         CKTxvWY096LLWda2XWLn9FcsyatYsOjw9LYf5DJCXtWcVdR/IwCTivaY7utCZhtfZ8rl
         LkVMOt9/s15/pGtALoTt8P29gCCIG9eZnQHAmjwW1jopyg/+oM+98YLsL9GoHaxLsGdz
         mMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YpbxVjqb6dSQcFevIEv3p5jxi8rf5BpTV42y+OYsO5Y=;
        b=dneHDDjl4EC+TMcBBxv+9Ur8I+74jryWqWwKFM8FqU8jm1zOTEe67946ixufjLcPa4
         GNAIGxRXkCWZM2grtVf0V/dzJpcP0JVqROLf3f6wn3/hxtP/uSBMogubZRlKAqvE66Mi
         W+YZ4i4wQL0nsOGi1bKnDtwEd6xIF0oelDbzczUjMnnuwjLV6A13c12w5md6DOKL/bfg
         SsxAFcF/hc+jbwC6SGgTchQ7Paw+b/h20WgNrCJs4CGYKbEwT+cgiUrqtM3sD3gK5BS7
         OZl5BkTDmSKs2GZkzz/s0xJfVGIqLDUbklDyIb2EVTAiNJjjuWH8BnZiui+W+4oR0Gpq
         brbA==
X-Gm-Message-State: AKaTC01+F3/hH2eTt3w1wIZPg4VHNB35v2y0Fx8AY5uzjH/+1dNsJ/ASHKkHMuXY/9tJBA==
X-Received: by 10.46.76.10 with SMTP id z10mr5799590lja.48.1482113275345;
        Sun, 18 Dec 2016 18:07:55 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:54 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 02/21] MIPS memblock: Add dts mem and reserved-mem callbacks
Date:   Mon, 19 Dec 2016 05:07:27 +0300
Message-Id: <1482113266-13207-3-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56065
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

In order to get a structured table of platform devices, it is
widespread amongst modern systems to use fdt'es.
MIPS should support one as well. Particularly /memory/ and
/reserved-memory/ should be analyzed and corresponding regions
registered with memblock subsystem.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/prom.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5fcec30..f21eb8c 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/memblock.h>
 
 #include <asm/bootinfo.h>
 #include <asm/page.h>
@@ -41,7 +42,36 @@ char *mips_get_machine_name(void)
 #ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	return add_memory_region(base, size, BOOT_MEM_RAM);
+	/* Check whether specified region is well formed */
+	if (sanity_check_dt_memory(&base, &size))
+		return;
+
+	/* Memory region should be in boot_mem_map, so use the old method */
+	add_memory_region(base, size, BOOT_MEM_RAM);
+}
+
+int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
+					     phys_addr_t size, bool nomap)
+{
+	/*
+	 * NOTE We don't use add_memory_region() method here, since fdt
+	 * reserved-memory regions are declared within already added memory,
+	 * while boot_mem_map consists of unique regions
+	 */
+
+	/* Check whether region is free. If so just ignore it */
+	if (memblock_is_region_reserved(base, size)) {
+		pr_err("FDT reserve-node %08zx @ %pa overlaps in-use memory\n",
+			(size_t)size, &base);
+		return -EBUSY;
+	}
+
+	/* If it can be mapped, then just reserve the region */
+	if (!nomap)
+		return memblock_reserve(base, size);
+
+	/* Completely remove region if it shouldn't be mapped */
+	return memblock_remove(base, size);
 }
 
 void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
-- 
2.6.6
