Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:15:39 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34838 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993092AbcLSCITHqsmK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:19 +0100
Received: by mail-lf0-f66.google.com with SMTP id p100so6144202lfg.2;
        Sun, 18 Dec 2016 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d62iWTF9ESMwKUIUyARLz3OeMSOJbiq3oxejKeBEONk=;
        b=uSq+3uYo813OklvcuyA8AgQUGey1TU7jmELm+xKgpt8F8r1Ovqnpdchj0NtxQd6U9g
         fIKvzTvWJM9gxfgQHiXQUQuOqrSTTOEjAS7Jwl5WLccUrjeaTzRs5imYj2YIebAYQjYY
         R8WgCbSUG1NQOdn6bqTekZinEU8+6Svj9zDf63s31QKTRltlBetlN0ln1pkES+52rXhV
         d6lXWk1Uc4bhfK8JVAJo34OX2IddmMi0giweEDQeXOTc5icYUnfkiFNpyP3tMNXOOl1P
         mRGsXJH2FMxetipKbKRq2yBohRU5XFMo40P1QuEWulwyNaF0uAJ1BFBu7AF97FUUXvaU
         l9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d62iWTF9ESMwKUIUyARLz3OeMSOJbiq3oxejKeBEONk=;
        b=Nu5rXCGYFGVg/tNajG8PjouT+mFgwa/FadwS/T2/RL8UN+Q8p+CCOjvvuYTTDzL9US
         vJXP/gnRUiB7Aniy2tJizD9tcP7b3uyRBRc4Ue/W/dI4RKwlSpNozdbNMeGSVIipn6Gh
         kbm5bmksF3y0VxsAWBCnox65WhzzZYf9I62WMdOceQk1+/pnovc6cNsKqdKIlyytBfe9
         wci/DBAc/m58/+qGRKFdGO9TDY31tLBra2idyrQz2+PFRl+ZK7BVgnU9aJJWnNajPiHT
         kXemQSxxsFp0pwt3TT8qPCeUxoHW7FAIVP7Hx0dHvO+EPtqkDjOcQwmApTVU6RCAlQaI
         Etpg==
X-Gm-Message-State: AKaTC03Blox+VMRoPdAgGcnNPS2XSAeCFZfj1W6OxwKv3V4F8srXPrVqp2S3tnG2eFnDQw==
X-Received: by 10.25.190.79 with SMTP id o76mr4512934lff.56.1482113291457;
        Sun, 18 Dec 2016 18:08:11 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:11 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 17/21] MIPS memblock: Alter high memory freeing method
Date:   Mon, 19 Dec 2016 05:07:42 +0300
Message-Id: <1482113266-13207-18-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56081
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

Memblock regions are used to find all available high memory
and to set it free into buddy allocator.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 54 ++++++++++++++---------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6f186c7..98680fb 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -404,32 +404,6 @@ void maar_init(void)
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-int page_is_ram(unsigned long pagenr)
-{
-	int i;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		unsigned long addr, end;
-
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RAM:
-		case BOOT_MEM_INIT_RAM:
-			break;
-		default:
-			/* not usable memory */
-			continue;
-		}
-
-		addr = PFN_UP(boot_mem_map.map[i].addr);
-		end = PFN_DOWN(boot_mem_map.map[i].addr +
-			       boot_mem_map.map[i].size);
-
-		if (pagenr >= addr && pagenr < end)
-			return 1;
-	}
-
-	return 0;
-}
 
 void __init paging_init(void)
 {
@@ -458,18 +432,32 @@ static struct kcore_list kcore_kseg0;
 static inline void mem_init_free_highmem(void)
 {
 #ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
+	struct memblock_region *reg;
+	unsigned long pfn;
 
 	if (cpu_has_dc_aliases)
 		return;
 
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
+	/* Walk through all memory regions freeing highmem pages only */
+	for_each_memblock(memory, reg) {
+		unsigned long start = memblock_region_memory_base_pfn(reg);
+		unsigned long end = memblock_region_memory_end_pfn(reg);
+
+		/* Ignore complete lowmem entries */
+		if (end <= max_low_pfn)
+			continue;
 
-		if (!page_is_ram(tmp))
-			SetPageReserved(page);
-		else
-			free_highmem_page(page);
+		/* Truncate partial highmem entries */
+		if (start < max_low_pfn)
+			start = max_low_pfn;
+
+		/*
+		 * MIPS memblock allocator doesn't allocate regions from high
+		 * memory (see mips_lowmem_limit variable initialization), so
+		 * just set corresponding pages free
+		 */
+		for (pfn = start; pfn < end; pfn++)
+			free_highmem_page(pfn_to_page(pfn));
 	}
 #endif
 }
-- 
2.6.6
