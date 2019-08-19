Return-Path: <SRS0=C2k9=WP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71990C3A5A0
	for <linux-mips@archiver.kernel.org>; Mon, 19 Aug 2019 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FAD20651
	for <linux-mips@archiver.kernel.org>; Mon, 19 Aug 2019 14:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fp/r0BJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHSOXi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:23:38 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:40809 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfHSOXh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 19 Aug 2019 10:23:37 -0400
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 39BAA5F80B86;
        Mon, 19 Aug 2019 17:23:35 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jH6FHrjhxH-NY34tveE;
        Mon, 19 Aug 2019 17:23:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1566224615;
        bh=+AXpXjCX0caLLhkpPjImy6Vp/q2NyWAxqIUV2X1NAQk=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=fp/r0BJjoQhQo+yHexFF0os4MQfiIsFCLi7SxzeLboJZ2e8z9s+837Cd9ZL3lS4P3
         5EyqsBPICW44A7/SkKj4gzprr12FZcGT3msFnA1wjLZ21LTW6kpT2IFSssN8Joetvm
         yZLYqZuu2gsQBrr8HkvUrOkoBTpWPBTHOJZvw52E=
Authentication-Results: mxback10o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id StE3L42zOl-NUUmBat8;
        Mon, 19 Aug 2019 17:23:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     paul.burton@mips.com, yasha.che3@gmail.com, aurelien@aurel32.net,
        sfr@canb.auug.org.au, fancer.lancer@gmail.com,
        matt.redfearn@mips.com, chenhc@lemote.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v1 1/8] MIPS: OCTEON: Drop boot_mem_map
Date:   Mon, 19 Aug 2019 22:23:06 +0800
Message-Id: <20190819142313.3535-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190819142313.3535-1-jiaxun.yang@flygoat.com>
References: <20190819142313.3535-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Replace walk through boot_mem_map with for_each_memblock.
And remove the check of total boot_mem_map.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/cavium-octeon/dma-octeon.c | 17 +++++++----------
 arch/mips/cavium-octeon/setup.c      |  3 +--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 11d5a4e90736..72f24a4db099 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/memblock.h>
 
 #include <asm/bootinfo.h>
 
@@ -190,7 +191,7 @@ char *octeon_swiotlb;
 
 void __init plat_swiotlb_setup(void)
 {
-	int i;
+	struct memblock_region *mem;
 	phys_addr_t max_addr;
 	phys_addr_t addr_size;
 	size_t swiotlbsize;
@@ -199,19 +200,15 @@ void __init plat_swiotlb_setup(void)
 	max_addr = 0;
 	addr_size = 0;
 
-	for (i = 0 ; i < boot_mem_map.nr_map; i++) {
-		struct boot_mem_map_entry *e = &boot_mem_map.map[i];
-		if (e->type != BOOT_MEM_RAM && e->type != BOOT_MEM_INIT_RAM)
-			continue;
-
+	for_each_memblock(memory, mem) {
 		/* These addresses map low for PCI. */
-		if (e->addr > 0x410000000ull && !OCTEON_IS_OCTEON2())
+		if (mem->base > 0x410000000ull && !OCTEON_IS_OCTEON2())
 			continue;
 
-		addr_size += e->size;
+		addr_size += mem->size;
 
-		if (max_addr < e->addr + e->size)
-			max_addr = e->addr + e->size;
+		if (max_addr < mem->base + mem->size)
+			max_addr = mem->base + mem->size;
 
 	}
 
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 8bf43c5a7bc7..95034bf5ca83 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1007,8 +1007,7 @@ void __init plat_mem_setup(void)
 	 * regions next to each other.
 	 */
 	cvmx_bootmem_lock();
-	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
-		&& (total < max_memory)) {
+	while (total < max_memory) {
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
 						__pa_symbol(&_end), -1,
 						0x100000,
-- 
2.22.0

