Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Mar 2013 16:09:47 +0100 (CET)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:14198 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823124Ab3CHPJmnAJ1c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Mar 2013 16:09:42 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r28F9aQF031824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 8 Mar 2013 16:09:36 +0100
Received: from [10.151.24.91] ([10.151.24.91])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r28F9ZsH022841;
        Fri, 8 Mar 2013 16:09:35 +0100
Message-ID: <5139FF2F.2000003@nsn.com>
Date:   Fri, 08 Mar 2013 16:09:35 +0100
From:   Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     david.daney@cavium.com, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Octeon: fix broken plat_mem_setup()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 7483
X-purgate-ID: 151667::1362755376-00001023-DFCD97CE/0-0/0-0
X-archive-position: 35860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin.ext@nsn.com
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

Octeon: fix broken plat_mem_setup()

Upstream patch abe77f90dc9c65a7c9a4d61c2cbb8db4d5566e4f (MIPS: Octeon: Add kexec
and kdump support) seems to be untested and broken Linux 3.8 on Octeon -- in
comparison with 3.7 Linux crashes with

[    0.000000] BUG: Bad page state in process swapper  pfn:00000
[    0.000000] page:8000000001016000 count:0 mapcount:1 mapping:          (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] Modules linked in:
[    0.000000] Call Trace:
[    0.000000] [<ffffffff80550b1c>] dump_stack+0x8/0x34
[    0.000000] [<ffffffff801fe7d4>] bad_page+0xdc/0x170
[    0.000000] [<ffffffff80200118>] free_pages_prepare+0x188/0x190
[    0.000000] [<ffffffff80200140>] __free_pages_ok+0x20/0x110
[    0.000000] [<ffffffff80738778>] free_all_bootmem_core+0x274/0x2cc
[    0.000000] [<ffffffff8073885c>] free_all_bootmem+0x8c/0xa4
[    0.000000] [<ffffffff8072fc8c>] mem_init+0x54/0x1c4
[    0.000000] [<ffffffff80724904>] start_kernel+0x1d4/0x4e8
[    0.000000]
[    0.000000] Disabling lock debugging due to kernel taint
... skipped some simillar output...
[    0.000000] BUG: Bad page state in process swapper  pfn:0003b
[    0.000000] page:8000000001016ce8 count:0 mapcount:1 mapping:          (null) index:0x0
[    0.000000] page flags: 0x0()
[    0.000000] Modules linked in:
[    0.000000] Call Trace:
[    0.000000] [<ffffffff80550b1c>] dump_stack+0x8/0x34
[    0.000000] [<ffffffff801fe7d4>] bad_page+0xdc/0x170
[    0.000000] [<ffffffff80200118>] free_pages_prepare+0x188/0x190
[    0.000000] [<ffffffff80200140>] __free_pages_ok+0x20/0x110
[    0.000000] [<ffffffff80738778>] free_all_bootmem_core+0x274/0x2cc
[    0.000000] [<ffffffff8073885c>] free_all_bootmem+0x8c/0xa4
[    0.000000] [<ffffffff8072fc8c>] mem_init+0x54/0x1c4
[    0.000000] [<ffffffff80724904>] start_kernel+0x1d4/0x4e8
[    0.000000]
[    0.000000] CPU 0 Unable to handle kernel paging request at virtual address 0000000000380000, epc == ffffffff8074b85c, ra == ffffffff80738778
[    0.000000] Oops[#1]:
[    0.000000] Cpu 0
[    0.000000] $ 0   : 0000000000000000 00000000101000e0 0000000000000001 0000000000380038
[    0.000000] $ 4   : 0000000000000001 0000000000000006 0000000000380000 0000000000000040
[    0.000000] $ 8   : 0000000000380000 fffffffffffffbff 0000000000000040 ffffffff80f9dd00
[    0.000000] $12   : 6db6db6db6db6db7 0000000000000000 6db6db6db6db0000 ffffffff80700000
[    0.000000] $16   : 0000000000010000 ffffffffffffffff 0000000000071c00 0000000000010040
[    0.000000] $20   : ffffffff80753070 000000000000fe73 ffffffff80f9dd00 0000000000050000
[    0.000000] $24   : 0000000000000002 0000000000200200
[    0.000000] $28   : ffffffff806b4000 ffffffff806b7d60 fffffffffffffffc ffffffff80738778
[    0.000000] Hi    : 0000000000000000
[    0.000000] Lo    : 0000000000000370
[    0.000000] epc   : ffffffff8074b85c __free_pages_bootmem+0xcc/0xe4
[    0.000000]     Tainted: G    B
[    0.000000] ra    : ffffffff80738778 free_all_bootmem_core+0x274/0x2cc
[    0.000000] Status: 101000e2    KX SX UX KERNEL EXL
[    0.000000] Cause : 40808008
[    0.000000] BadVA : 0000000000380000
[    0.000000] PrId  : 000d9009 (Cavium Octeon II)
[    0.000000] Modules linked in:
[    0.000000] Process swapper (pid: 0, threadinfo=ffffffff806b4000, task=ffffffff806dcbf0, tls=0000000000000000)
[    0.000000] *HwTLS: 000000ffec6c46c0
[    0.000000] Stack : 0000000000000000 ffffffff80753070 ffffffff80753060 ffffffff80750000
         ffffffff8074fab0 ffffffff80770000 ffffffff806d0000 ffffffffc0111bf0
         0000000000000000 ffffffff8073885c ffffff8000000001 ffffffff806e0000
         ffffffff80fa0000 ffffffff8072fc8c ffffff8000000001 0000000000000084
         ffffffff80770000 ffffffff80750000 ffffffff8074fab0 ffffffff80770000
         ffffffff806d0000 ffffffff80724904 ffffffff8074fab0 0000000000000000
         ffffffffc00a56c8 800000000fd01030 800000000fda5688 0000000000000001
         ffffffff80541dc0 000000000000000b 000000000000000b ffffffffc00018b8
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
[    0.000000] Call Trace:
[    0.000000] [<ffffffff8074b85c>] __free_pages_bootmem+0xcc/0xe4
[    0.000000] [<ffffffff80738778>] free_all_bootmem_core+0x274/0x2cc
[    0.000000] [<ffffffff8073885c>] free_all_bootmem+0x8c/0xa4
[    0.000000] [<ffffffff8072fc8c>] mem_init+0x54/0x1c4
[    0.000000] [<ffffffff80724904>] start_kernel+0x1d4/0x4e8
[    0.000000]
[    0.000000]
Code: fc6206b8  0808011c  ad06001c <dcc20000> cc7c0000  00491024  fcc20000  081d2def  ac60ffe4
[    0.000000] ---[ end trace 139ce121c98e96c9 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

There are at least couple of issues in the patch:
1. reason for add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM) instead of
add_memory_region(memory, size, BOOT_MEM_RAM) is unclear, especially because it
will discard corrections performed by two preceding calls to memory_exclude_page().
2. add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM) seems to be not related
to KEXEC functionality and has no visible reason in 3.8 kernel... Probably these are
some traces of the original 2010 patch for older kernels... In any case, this is the
reason for the crash.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
--- linux.orig/arch/mips/cavium-octeon/setup.c
+++ linux/arch/mips/cavium-octeon/setup.c
@@ -1092,8 +1092,6 @@ void __init plat_mem_setup(void)
  	uint64_t crashk_end;
  #ifndef CONFIG_CRASH_DUMP
  	int64_t memory;
-	uint64_t kernel_start;
-	uint64_t kernel_size;
  #endif
  	const struct cvmx_bootmem_named_block_desc *named_block;

@@ -1217,7 +1215,7 @@ void __init plat_mem_setup(void)
  			 * next to each other if they are received in
  			 * incrementing order
  			 */
-			if (memory < crashk_base && end >  crashk_end) {
+			if (memory < crashk_base && end > crashk_end) {
  				/* region is fully in */
  				add_memory_region(memory,
  						  crashk_base - memory,
@@ -1243,7 +1241,7 @@ void __init plat_mem_setup(void)
  				 * Overlap with the beginning of the region,
  				 * reserve the beginning.
  				  */
-				mem_alloc_size -= crashk_end - memory;
+				size -= crashk_end - memory;
  				memory = crashk_end;
  			} else if (memory < crashk_base && end > crashk_base &&
  				   end < crashk_end)
@@ -1251,24 +1249,16 @@ void __init plat_mem_setup(void)
  				 * Overlap with the beginning of the region,
  				 * chop of end.
  				 */
-				mem_alloc_size -= end - crashk_base;
+				size -= end - crashk_base;
  #endif
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			if (size)
+				add_memory_region(memory, size, BOOT_MEM_RAM);
  			total += mem_alloc_size;
-			/* Recovering mem_alloc_size */
-			mem_alloc_size = 4 << 20;
  		} else {
  			break;
  		}
  	}
  	cvmx_bootmem_unlock();
-	/* Add the memory region for the kernel. */
-	kernel_start = (unsigned long) _text;
-	kernel_size = ALIGN(_end - _text, 0x100000);
-
-	/* Adjust for physical offset. */
-	kernel_start &= ~0xffffffff80000000ULL;
-	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
  #endif /* CONFIG_CRASH_DUMP */

  mem_alloc_done:
