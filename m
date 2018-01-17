Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:29:10 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:38490
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994708AbeAQWXmbLEKW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:42 +0100
Received: by mail-lf0-x241.google.com with SMTP id g72so18531616lfg.5;
        Wed, 17 Jan 2018 14:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTZl+/y/9Zwi5KRqyXSYxRJj6BFxsWiuqIIh7Th3fL8=;
        b=bUpxcUcYlq3klrqlHoCSQVLluH+7ot7PgKR5xpDIx0NKvqqmPFGzoUewGtcBzk1E4p
         sgC7uUuMHhqGF3B4mcsvxQvfX7L29wsRb63yWRVR+fsWYXGThoTrbuDQzJI+oPpIFPvo
         o2JlwG0Nfym+4eXzDodeAbENGSCquTN8+7ttwAjUJ3WT9orUdsTved/sAL9C1rDbp1ZD
         Rtf/Jo0SrQuTTzYvAhOf0hvVPFMz1gCk7+qgxtSlH6lvVsZoxNEJZfjvpiwqfkjohwiQ
         xZlYSbxhwn6/P3h6RHc9dLvE63ddgai86DiBewrvyYFrXJCIN/Xy/FaSOcbvJ/AQGzdz
         uWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTZl+/y/9Zwi5KRqyXSYxRJj6BFxsWiuqIIh7Th3fL8=;
        b=MTLO/lRmRU93xl7mlxYOyziMFPEL2B9wIcCW/GEagTVIMrIawJj8E5jeugZzRxLPeu
         M7Sjqo7QkqfFVqEs1/PNDcwSVkFKoPT0HOZS2M25lxpdktwOgHKmH1655Aj700eH7kpX
         lxYNsBSATYIg7XRz2eUlh93aZLMilZJL+Pnz0Qmm8zji16HEbDz2pZO0E55lQQLHy3lC
         cm3X4Br9tNvhe2Pe9jhniW+TMXGGUWFa4/BaTPJEW2NUzuLzESQ+79TjHQ6ytkDNABoV
         Gaevv7INrYwfbG1OvFkq1Crr0HypbQjtAUJqghMplC5OBZSMx7IiS5Ooo/abhTVxM0xI
         nLaA==
X-Gm-Message-State: AKwxytd4IOQeD1wwZ6KPgPAqnJCD65AC2S4OXCRG1cLy6pNPoyIghUSZ
        T4p3g6Mm2OoFVYYYy7typXoeNBg6
X-Google-Smtp-Source: ACJfBouZphcwHQfXilYvUx/CEXWXlCq/go2VlanqBlGIVrzJjlzlVI98rBac/t3Ku2LPwQdvkIQXlA==
X-Received: by 10.46.53.18 with SMTP id z18mr7441969ljz.4.1516227816806;
        Wed, 17 Jan 2018 14:23:36 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:36 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 13/14] MIPS: memblock: Discard bootmem from SGI IP27 code
Date:   Thu, 18 Jan 2018 01:23:11 +0300
Message-Id: <20180117222312.14763-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62224
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

SGI IP27 got its own code to set the early memory allocator up since it's
NUMA-based system. So in order to be compatible with NO_BOOTMEM config
we need to discard the bootmem allocator initialization and insert the
memblock reservation method. Although in my opinion the code isn't
working anyway since I couldn't find a place where prom_meminit() called
and kernel memory isn't reserved. It must have been untested since the
time the arch/mips/mips-boards/generic code was in the kernel.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/sgi-ip27/ip27-memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 8d0eb2643..d25758e25 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -389,7 +389,6 @@ static void __init node_mem_init(cnodeid_t node)
 {
 	unsigned long slot_firstpfn = slot_getbasepfn(node, 0);
 	unsigned long slot_freepfn = node_getfirstfree(node);
-	unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn;
 
 	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
@@ -400,7 +399,6 @@ static void __init node_mem_init(cnodeid_t node)
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
 	memset(__node_data[node], 0, PAGE_SIZE);
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
@@ -409,12 +407,9 @@ static void __init node_mem_init(cnodeid_t node)
 	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
 			       sizeof(struct hub_data));
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
-	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
-		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+	memblock_reserve(slot_firstpfn << PAGE_SHIFT,
+		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT));
 	sparse_memory_present_with_active_regions(node);
 }
 
-- 
2.12.0
