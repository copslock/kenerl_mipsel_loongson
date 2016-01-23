Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 14:09:06 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:38347 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008721AbcAWNJEreDJI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 14:09:04 +0100
Received: by nf-2.local (Postfix, from userid 501)
        id D47941298E90B; Sat, 23 Jan 2016 14:09:02 +0100 (CET)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org
Subject: [RFC] MIPS: fix crash in __update_cache for highmem pages
Date:   Sat, 23 Jan 2016 14:09:02 +0100
Message-Id: <1453554542-91509-1-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 2.2.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

When __update_cache gets a highmem page, page_address(page) returns 0
and the code attempts to do a cache flush on the NULL pointer leading to
a crash.

I have no idea if doing nothing for highmem pages is the right approach
here, but it makes my MT7621 based device with highmem boot properly
again.

The crash that happens early during init is this one:

[    7.060000] CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80028374, ra == 800295e0
[    7.070000] Oops[#1]:
[    7.070000] CPU: 0 PID: 311 Comm: kmodloader Not tainted 4.3.3 #15
[    7.070000] task: 8f9405a8 ti: 8faf0000 task.ti: 8faf0000
[    7.070000] $ 0   : 00000000 00000001 00000000 00000001
[    7.070000] $ 4   : 00000000 00001000 00000000 8097eb9e
[    7.070000] $ 8   : 000000a1 00000009 8f53fd40 00000000
[    7.070000] $12   : 00000000 00000000 00000118 00000040
[    7.070000] $16   : 00000000 80980000 00000000 77333000
[    7.070000] $20   : 8facbccc 00000000 00000000 00040000
[    7.070000] $24   : ffff0000 ff000000
[    7.070000] $28   : 8faf0000 8faf1d18 ffffffbf 800295e0
[    7.070000] Hi    : 00000004
[    7.070000] Lo    : 00000000
[    7.070000] epc   : 80028374 r4k_blast_dcache_page_dc32+0x18/0xb8
[    7.070000] ra    : 800295e0 r4k_flush_data_cache_page+0x70/0x84
[    7.070000] Status: 11000403 KERNEL EXL IE
[    7.070000] Cause : 40800008 (ExcCode 02)
[    7.070000] BadVA : 00000000
[    7.070000] PrId  : 0001992f (MIPS 1004Kc)
[    7.070000] Modules linked in:
[    7.070000] Process kmodloader (pid: 311, threadinfo=8faf0000, task=8f9405a8, tls=7733ec94)
[    7.070000] Stack : 00000001 8fa21c80 00000cc8 804844c0 77333000 00001000 814711e0 800212fc
          80488920 000200da 2388fa21 814711e0 2388fa21 814711e0 8fa26480 800ed0a8
          8f82c000 8007790c 8faf1e48 00000007 814711e0 8f53fd5c 8faf1e00 8fa21c80
          8f540334 00000001 8fa26480 800c5ffc 00000000 00000000 77332000 8011e214
          00000000 00000000 00000001 00000040 00000007 8fa26480 77332000 8f540338
          ...
[    7.070000] Call Trace:
[    7.070000] [<80028374>] r4k_blast_dcache_page_dc32+0x18/0xb8
[    7.070000] [<800295e0>] r4k_flush_data_cache_page+0x70/0x84
[    7.070000] [<800212fc>] __update_cache+0xb8/0xe4
[    7.070000] [<800ed0a8>] do_set_pte+0x160/0x188
[    7.070000] [<800c5ffc>] filemap_map_pages+0x1cc/0x300
[    7.070000] [<800ed674>] handle_mm_fault+0x5a4/0xe68
[    7.070000] [<80021a50>] __do_page_fault+0x144/0x52c
[    7.070000] [<80005420>] ret_from_exception+0x0/0x10
[    7.070000]
[    7.070000]
Code: 00001021  10430027  00000000 <bc950000> bc950020  bc950040  bc950060  bc950080  bc9500a0
[    7.260000] ---[ end trace c024e8d58a661a38 ]---
---
 arch/mips/mm/cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index aab218c..15266bf 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -141,7 +141,11 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn)))
 		return;
+
 	page = pfn_to_page(pfn);
+	if (PageHighMem(page))
+		return;
+
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
 		addr = (unsigned long) page_address(page);
 		if (exec || pages_do_alias(addr, address & PAGE_MASK))
-- 
2.2.2
