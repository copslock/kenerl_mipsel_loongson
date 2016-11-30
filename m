Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2016 09:18:02 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:37449 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992197AbcK3IRyljHsG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Nov 2016 09:17:54 +0100
Received: from odin.home.local (p54B04F6C.dip0.t-ipconnect.de [84.176.79.108])
        by h1.direct-netware.de (Postfix) with ESMTPA id 9DE55FFB1D
        for <linux-mips@linux-mips.org>; Wed, 30 Nov 2016 09:17:51 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id 3219E29D21
        for <linux-mips@linux-mips.org>; Wed, 30 Nov 2016 09:17:51 +0100 (CET)
From:   Tobias Wolf <dev-NTEO@vplace.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH] mm: Fix alloc_node_mem_map with ARCH_PFN_OFFSET calculation
Date:   Wed, 30 Nov 2016 09:16:41 +0100
Message-ID: <1634999.P55SYM4HsS@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.10-1-ARCH; KDE/5.28.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <dev-NTEO@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev-NTEO@vplace.de
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

Dear folks,

An rt288x (ralink) based router (Belkin F5D8235 v1) does not boot with any 
kernel beyond version 4.3 resulting in:

BUG: Bad page state in process swapper  pfn:086ac

bisect resulted in:

a1c34a3bf00af2cede839879502e12dc68491ad5 is the first bad commit
commit a1c34a3bf00af2cede839879502e12dc68491ad5
Author: Laura Abbott <laura@labbott.name>
Date:   Thu Nov 5 18:48:46 2015 -0800

    mm: Don't offset memmap for flatmem
    
    Srinivas Kandagatla reported bad page messages when trying to remove the
    bottom 2MB on an ARM based IFC6410 board
    
      BUG: Bad page state in process swapper  pfn:fffa8
      page:ef7fb500 count:0 mapcount:0 mapping:  (null) index:0x0
      flags: 0x96640253(locked|error|dirty|active|arch_1|reclaim|mlocked)
      page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
      bad because of flags:
      flags: 0x200041(locked|active|mlocked)
      Modules linked in:
      CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.0-rc3-00007-g412f9ba-dirty 
#816
      Hardware name: Qualcomm (Flattened Device Tree)
        unwind_backtrace
        show_stack
        dump_stack
        bad_page
        free_pages_prepare
        free_hot_cold_page
        __free_pages
        free_highmem_page
        mem_init
        start_kernel
      Disabling lock debugging due to kernel taint
    [...]
:040000 040000 2de013c372345fd471cd58f0553c9b38b0ef1cc4 
0a8156f848733dfa21e16c196dfb6c0a76290709 M      mm

This fix for ARM does not account ARCH_PFN_OFFSET for mem_map as later used by 
page_to_pfn anymore.

The following output was generated with two hacked in printk statements:

printk("before %p vs. %p or %p\n", mem_map, mem_map - offset, mem_map - 
(pgdat->node_start_pfn - ARCH_PFN_OFFSET));
		if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
			mem_map -= offset + (pgdat->node_start_pfn - ARCH_PFN_OFFSET);
printk("after %p\n", mem_map);

Output:

[    0.000000] before 8861b280 vs. 8861b280 or 8851b280
[    0.000000] after 8851b280

As seen in the first line mem_map with subtraction of offset does not equal the 
mem_map after subtraction of ARCH_PFN_OFFSET.

After adding the offset of ARCH_PFN_OFFSET as well to mem_map as the 
previously calculated offset is zero for the named platform it is able to boot 
4.4 and 4.9-rc7 again.

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5859,7 +5859,7 @@
 		mem_map = NODE_DATA(0)->node_mem_map;
 #if defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) || defined(CONFIG_FLATMEM)
 		if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
-			mem_map -= offset;
+			mem_map -= offset + (pgdat->node_start_pfn - ARCH_PFN_OFFSET);
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 	}
 #endif
