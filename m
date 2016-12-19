Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:13:08 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36757 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbcLSCIMGiR-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:12 +0100
Received: by mail-lf0-f65.google.com with SMTP id o20so6141524lfg.3;
        Sun, 18 Dec 2016 18:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vpcV73qrpaIirqyCwoV3DJTPAXGdQqh8p0HMVgVNjGk=;
        b=oEAf7kl6V+xwWswnNqT71PXJZ6bKUdrSGKg/rDTAWuZ4JXFKfiwcKQYMRylgTjd6iA
         YvTfGzV14WkNKK/ZpkTJv/NsT/D+UAVkesb1Wmv/MTOsbUkxfmqpyCgnSjG3gJ4GeVKA
         oFPTVwIfqAl49na4UodCY2SEeA47qRvsdTNti7N/mWe4LwGCEs6KFf5zjITGDQn28P4u
         gywQJBKoYg9GLfHm1omSiJAwTInbB0ZQ3vvM/nGn1Ncy2bu9fd66r335NGlTACxrPkIV
         Hu6rsr40nyoRQ+4ICMc1PpnciQgaBxyzhytd/OBua5Z+/0LH0CetBU7/VTbG4aKjwQI8
         IfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpcV73qrpaIirqyCwoV3DJTPAXGdQqh8p0HMVgVNjGk=;
        b=SbvNgydaGCdlowIY2Jdr+ftz7YZpdPT91Dm99ZrCdF/+d/Qorf3oq0+hd+7Xl1CBuz
         V7F/NAijKfjLu5CROkrIPmnnu0kpCRIFImeWWXFv9Z7lqp9wODO5pk0LdzfQwxkHoLY9
         Y4481771vLJZGsWCnoid/iztb+i8AyGMIBPDX3mojjwqL8lccSu/CzPO3+vzibWtOG0P
         RWcUmVloDfaGisax1vYTM+UV7/duhWEO9ZVfQ+Vda+wh8oNSnxWkNzv33omxDsfVBob2
         SJnhG0yifhWDfRk6OoIoxVS4t8VfCSbO0slAMZd2Tx7u7ipCC0tTqF8RQTdHLs7DLEJc
         QiFg==
X-Gm-Message-State: AIkVDXIywO9ql0VMQ1cAX670TOpXSKnuLCrCX9t5zSCuGXBvqrylFkZAoSCK9hi86TsSGA==
X-Received: by 10.46.69.137 with SMTP id s131mr6255723lja.26.1482113285372;
        Sun, 18 Dec 2016 18:08:05 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:04 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 11/21] MIPS memblock: Add memblock sanity check method
Date:   Mon, 19 Dec 2016 05:07:36 +0300
Message-Id: <1482113266-13207-12-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56075
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

Perform memory sanity check right after basic memory is added.
It makes sure there is low memory available and there is no high
memory if one isn't supported. Additionally low memory limit needs
to be calculated so memblock would have a proper upper boundary for
memory allocations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 6562f55..d2f410d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -472,6 +472,86 @@ static void __init mips_reserve_initrd_mem(void) { }
 #endif
 
 /*
+ * Check initialized memory.
+ */
+static void __init sanity_check_meminfo(void)
+{
+	phys_addr_t physmem_start = PFN_PHYS(ARCH_PFN_OFFSET);
+	phys_addr_t size_limit = 0;
+	struct memblock_region *reg;
+	bool highmem = false;
+	bool should_use_highmem = false;
+
+	/*
+	 * Walk over all memory ranges discarding highmem if it's disabled and
+	 * calculating the memblock allocator limit
+	 */
+	for_each_memblock(memory, reg) {
+		phys_addr_t block_start = reg->base;
+		phys_addr_t block_end = reg->base + reg->size;
+		phys_addr_t block_size = reg->size;
+
+		if (block_start >= HIGHMEM_START) {
+			highmem = true;
+			size_limit = block_size;
+		} else {
+			size_limit = HIGHMEM_START - block_start;
+		}
+
+		/* Discard highmem physical memory if it isn't supported */
+		if (!IS_BUILTIN(CONFIG_HIGHMEM)) {
+			/* Discard the whole highmem memory block */
+			if (highmem) {
+				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
+					&block_start, &block_end);
+				memblock_remove(block_start, block_size);
+				should_use_highmem = true;
+				continue;
+			}
+			/* Truncate memory block */
+			if (block_size > size_limit) {
+				phys_addr_t overlap_size = block_size - size_limit;
+				phys_addr_t highmem_start = HIGHMEM_START;
+
+				pr_notice("Truncate highmem %pa-%pa to -%pa\n",
+					&block_start, &block_end, &highmem_start);
+				memblock_remove(highmem_start, overlap_size);
+				block_end = highmem_start;
+				should_use_highmem = true;
+			}
+		}
+		/* Truncate region if it starts below ARCH_PFN_OFFSET */
+		if (block_start < physmem_start) {
+			phys_addr_t overlap_size = physmem_start - block_start;
+
+			pr_notice("Truncate lowmem %pa-%pa to %pa-\n",
+				&block_start, &block_end, &physmem_start);
+			memblock_remove(block_start, overlap_size);
+		}
+
+		/* Calculate actual lowmem limit for memblock allocator */
+		if (!highmem) {
+			if (block_end > mips_lowmem_limit) {
+				if (block_size > size_limit)
+					mips_lowmem_limit = HIGHMEM_START;
+				else
+					mips_lowmem_limit = block_end;
+			}
+		}
+	}
+
+	/* Panic if no lowmem has been determined */
+	if (!mips_lowmem_limit)
+		panic("Oops, where is low memory? 0_o\n");
+
+	if (should_use_highmem)
+		pr_notice("Consider using HIGHMEM enabled kernel\n");
+
+	/* Set memblock allocator limit */
+	memblock_set_current_limit(mips_lowmem_limit);
+}
+
+/*
  * Reserve kernel code and data within memblock allocator
  */
 static void __init mips_reserve_kernel_mem(void)
@@ -712,6 +792,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Parse passed parameters */
 	mips_parse_param(cmdline_p);
 
+	/* Sanity check the specified memory */
+	sanity_check_meminfo();
+
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
-- 
2.6.6
