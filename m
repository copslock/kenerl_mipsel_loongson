Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Mar 2013 08:32:25 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44217 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816743Ab3CXHcJ5yeiP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Mar 2013 08:32:09 +0100
Received: by mail-pd0-f172.google.com with SMTP id w10so2137301pde.3
        for <multiple recipients>; Sun, 24 Mar 2013 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/FlTapNljIg727M2jb8cFlduge2JMGej3FmoiK7wV28=;
        b=TeL78mMTymz8VsAX0hyMDe+ajsRzQH6f1LvWCwl2sH3KQAPd7nH3vzN+Po4B1zfEF7
         k6EuNVWlrNlxW/0FmUhdBKHkuhrwTm37lC4evAIZPGb+s5SM3bsFE7ypDSLU5lHA3Su8
         afLNFP5Uo2/dTy+NvanoEHhpfmubdBU39aFzDAWK73tvmPPRREbRXJFQ2hgYt7o5Jo8n
         cxxSeB9ymZMwqPgzI4YB+/qedsx4y4+x8lEhCG21Xw7pTNS8BnzKdeKyLVC5sCjVUMxR
         gGmwRjzul/8aX5yxWBpL2ch9z9WTedef4iExKOWtPVa9F3reESGpmNQj+lWT15hG76cM
         N0GQ==
X-Received: by 10.68.228.164 with SMTP id sj4mr10836532pbc.180.1364110323424;
        Sun, 24 Mar 2013 00:32:03 -0700 (PDT)
Received: from localhost.localdomain ([114.246.175.231])
        by mx.google.com with ESMTPS id ce16sm9876553pac.5.2013.03.24.00.31.54
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 00:32:01 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Jiang Liu <jiang.liu@huawei.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.cz>,
        Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jkosina@suse.cz>,
        John Crispin <blogic@openwrt.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org
Subject: [RFC PATCH v2, part4 24/39] mm/MIPS: prepare for removing num_physpages and simplify mem_init()
Date:   Sun, 24 Mar 2013 15:25:05 +0800
Message-Id: <1364109934-7851-40-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
References: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com>
X-archive-position: 35963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: John Crispin <blogic@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/mm/init.c              |   57 ++++++++++++--------------------------
 arch/mips/pci/pci-lantiq.c       |    2 +-
 arch/mips/sgi-ip27/ip27-memory.c |   21 ++------------
 3 files changed, 21 insertions(+), 59 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index c1d7b9f..8149946 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -358,11 +358,24 @@ void __init paging_init(void)
 static struct kcore_list kcore_kseg0;
 #endif
 
-void __init mem_init(void)
+static inline void mem_init_free_highmem(void)
 {
-	unsigned long codesize, reservedpages, datasize, initsize;
-	unsigned long tmp, ram;
+#ifdef CONFIG_HIGHMEM
+	unsigned long tmp;
 
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
+
+		if (!page_is_ram(tmp))
+			SetPageReserved(page);
+		else
+			free_highmem_page(page);
+	}
+#endif
+}
+
+void __init mem_init(void)
+{
 #ifdef CONFIG_HIGHMEM
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
@@ -375,32 +388,8 @@ void __init mem_init(void)
 
 	free_all_bootmem();
 	setup_zero_pages();	/* Setup zeroed pages.  */
-
-	reservedpages = ram = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		if (page_is_ram(tmp) && pfn_valid(tmp)) {
-			ram++;
-			if (PageReserved(pfn_to_page(tmp)))
-				reservedpages++;
-		}
-	num_physpages = ram;
-
-#ifdef CONFIG_HIGHMEM
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
-
-		if (!page_is_ram(tmp)) {
-			SetPageReserved(page);
-			continue;
-		}
-		free_highmem_page(page);
-	}
-	num_physpages += totalhigh_pages;
-#endif
-
-	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
-	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
-	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
+	mem_init_free_highmem();
+	mem_init_print_info(NULL);
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
@@ -409,16 +398,6 @@ void __init mem_init(void)
 		kclist_add(&kcore_kseg0, (void *) CKSEG0,
 				0x80000000 - 4, KCORE_TEXT);
 #endif
-
-	printk(KERN_INFO "Memory: %luk/%luk available (%ldk kernel code, "
-	       "%ldk reserved, %ldk data, %ldk init, %ldk highmem)\n",
-	       nr_free_pages() << (PAGE_SHIFT-10),
-	       ram << (PAGE_SHIFT-10),
-	       codesize >> 10,
-	       reservedpages << (PAGE_SHIFT-10),
-	       datasize >> 10,
-	       initsize >> 10,
-	       totalhigh_pages << (PAGE_SHIFT-10));
 }
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 9568178..8cc3250 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -89,7 +89,7 @@ static inline u32 ltq_calc_bar11mask(void)
 	u32 mem, bar11mask;
 
 	/* BAR11MASK value depends on available memory on system. */
-	mem = num_physpages * PAGE_SIZE;
+	mem = get_num_physpages() * PAGE_SIZE;
 	bar11mask = (0x0ffffff0 & ~((1 << (fls(mem) - 1)) - 1)) | 8;
 
 	return bar11mask;
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 4042e06..41646d7 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -357,8 +357,6 @@ static void __init szmem(void)
 	int slot;
 	cnodeid_t node;
 
-	num_physpages = 0;
-
 	for_each_online_node(node) {
 		nodebytes = 0;
 		for (slot = 0; slot < MAX_MEM_SLOTS; slot++) {
@@ -381,7 +379,6 @@ static void __init szmem(void)
 				slot = MAX_MEM_SLOTS;
 				continue;
 			}
-			num_physpages += slot_psize;
 			memblock_add_node(PFN_PHYS(slot_getbasepfn(node, slot)),
 					  PFN_PHYS(slot_psize), node);
 		}
@@ -480,10 +477,9 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	unsigned long codesize, datasize, initsize, tmp;
 	unsigned node;
 
-	high_memory = (void *) __va(num_physpages << PAGE_SHIFT);
+	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
 
 	for_each_online_node(node) {
 		/*
@@ -494,18 +490,5 @@ void __init mem_init(void)
 
 	setup_zero_pages();	/* This comes from node 0 */
 
-	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
-	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
-	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
-
-	tmp = nr_free_pages();
-	printk(KERN_INFO "Memory: %luk/%luk available (%ldk kernel code, "
-	       "%ldk reserved, %ldk data, %ldk init, %ldk highmem)\n",
-	       tmp << (PAGE_SHIFT-10),
-	       num_physpages << (PAGE_SHIFT-10),
-	       codesize >> 10,
-	       (num_physpages - tmp) << (PAGE_SHIFT-10),
-	       datasize >> 10,
-	       initsize >> 10,
-	       totalhigh_pages << (PAGE_SHIFT-10));
+	mem_init_print_info(NULL);
 }
-- 
1.7.9.5
