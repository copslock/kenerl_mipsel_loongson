Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 05:01:24 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:39606
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994863AbeBBDz1fJ4E0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:27 +0100
Received: by mail-lf0-x241.google.com with SMTP id w27so29442159lfd.6;
        Thu, 01 Feb 2018 19:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pc3tfGnvyG0fIEhCRUtvxswdiqOghm1Ne/BfkFPGIEM=;
        b=NGYtG001ShrrWmGkyMKcJsNJPFkXon07bw0LcQfLMJyhu0y5eCQu5LXPvRVmE0t7FC
         uVLJf37DUBMoTUmoqgDfMcbAdo4Cm4sHUcv/6Tevk8x79gITxh2+voajZReNxICOXTAh
         +KBI2Q3dYjp1ignQD2kvssGVnkMV4q1BuSqCFCVdN8l7OUgB2KmV/v/hDFxT6auKPFEx
         IK33uivSoHpKQZ8rTDsRnD9uZo0/rln8fdYYRSfa+auvfz812CHDX0U/pXooG8Ey3cKR
         C9JiESYW74QKxsdHn1TWETlxISNIrVACtcZR9BXSJu7Jj6DqIm45LjjCwMg0ZDgAn5nn
         saYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pc3tfGnvyG0fIEhCRUtvxswdiqOghm1Ne/BfkFPGIEM=;
        b=tOb/wzm4bqumzpixoc0y7WELRSxyRQykhAbn19i8REUDxCmlJXJn1/k8y54dqTPU/r
         7/dW6QsbTghi1C58Ueux7uVhDUmnJKbPuDnQ5K8xuUk+cbsqxbbHaCfzlu5Zlf7GTUR/
         7ZK4bLxp4LDB3myTDoVGiqlSW46Ks9Vj5wjx0cpfrwg9t+WYjNcfUBSmydjh0PWHq/Cb
         ia/fNU1rJUI3HdjhKKwhBqkiSYIK9Bq7IsHIWbeV3Isbd67pVY80W5Ip5asry8feX1GN
         Me37wrK5Ks+I+5BblW8cDwyfXkQq0foqjE/h6sTgKPJEl4Hp9lBDVBieQ6un951k92NZ
         1RVg==
X-Gm-Message-State: AKwxyteWjiZ5cwseHKRkGXjG7ndQj/TkFfSIL375ryIKLFgXt9Nl1zDN
        TcXS4egKxGFbRSiT36rDW2+pBYWq
X-Google-Smtp-Source: AH8x2264dtwq9j4QWGaYGoZR4gaAApe47Z1sRCxqBjikBdf7zJPN/2KgqgWAhY1ATrfawB+6+Bl49w==
X-Received: by 10.46.71.211 with SMTP id u202mr21970203lja.56.1517543721800;
        Thu, 01 Feb 2018 19:55:21 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:21 -0800 (PST)
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
Subject: [PATCH v2 14/15] MIPS: memblock: Discard bootmem from SGI IP27 code
Date:   Fri,  2 Feb 2018 06:54:57 +0300
Message-Id: <20180202035458.30456-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62421
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
index 59133d0abc83..c480ee3eca96 100644
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
