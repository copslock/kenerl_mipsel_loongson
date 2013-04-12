Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 18:52:39 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:10694 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826551Ab3DLQwhyAuB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Apr 2013 18:52:37 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r3CGqSR0013566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 12 Apr 2013 18:52:28 +0200
Received: from [10.151.24.91] ([10.151.24.91])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r3CGqR2d000719;
        Fri, 12 Apr 2013 18:52:27 +0200
Message-ID: <51683BCB.8060209@nsn.com>
Date:   Fri, 12 Apr 2013 18:52:27 +0200
From:   Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, david.daney@cavium.com
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH V2] Octeon: fix broken plat_mem_setup()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 7798
X-purgate-ID: 151667::1365785550-00004D0E-539543DC/0-0/0-0
Return-Path: <alexander.sverdlin.ext@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36115
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
This is fixed using size again instead of mem_alloc_size, moreover, block sizes
calculation could be simplified.

2. add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM) marks kernel body
as RAM available for allocation, that's why the kernel later crashes overwritting
itself. Marking it as BOOT_MEM_INIT_RAM solves the crash and still allows to load
the same kernel with kexec (tested also).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---

Changes in V2:
* corrected "end" calculation, simplified "size" calculation
* Mapped the kernel correctly as INIT RAM, instead of throwing this code out

As a result, kernel not only boots succefully, but also able to load itself
with "kexec -l <image>".

--- linux.orig/arch/mips/cavium-octeon/setup.c
+++ linux/arch/mips/cavium-octeon/setup.c
@@ -936,14 +936,14 @@ void __init plat_mem_setup(void)
  					    CVMX_PCIE_BAR1_PHYS_SIZE,
  					    &memory, &size);
  #ifdef CONFIG_KEXEC
-			end = memory + mem_alloc_size;
+			end = memory + size;

  			/*
  			 * This function automatically merges address regions
  			 * next to each other if they are received in
  			 * incrementing order
  			 */
-			if (memory < crashk_base && end >  crashk_end) {
+			if (memory < crashk_base && end > crashk_end) {
  				/* region is fully in */
  				add_memory_region(memory,
  						  crashk_base - memory,
@@ -969,20 +969,20 @@ void __init plat_mem_setup(void)
  				 * Overlap with the beginning of the region,
  				 * reserve the beginning.
  				  */
-				mem_alloc_size -= crashk_end - memory;
+				size = end - crashk_end;
  				memory = crashk_end;
  			} else if (memory < crashk_base && end > crashk_base &&
-				   end < crashk_end)
+				   end < crashk_end) {
  				/*
  				 * Overlap with the beginning of the region,
  				 * chop of end.
  				 */
-				mem_alloc_size -= end - crashk_base;
+				size = crashk_base - memory;
+			}
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
@@ -994,7 +994,7 @@ void __init plat_mem_setup(void)

  	/* Adjust for physical offset. */
  	kernel_start &= ~0xffffffff80000000ULL;
-	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
+	add_memory_region(kernel_start, kernel_size, BOOT_MEM_INIT_RAM);
  #endif /* CONFIG_CRASH_DUMP */

  #ifdef CONFIG_CAVIUM_RESERVE32
