Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 17:27:17 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:36906 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011932AbaJTP1My0eOP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Oct 2014 17:27:12 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XgErV-0000Qz-Ai; Mon, 20 Oct 2014 17:27:09 +0200
Date:   Mon, 20 Oct 2014 17:27:09 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, 764223@bugs.debian.org,
        Martin Zobel-Helas <zobel@debian.org>
Subject: Re: [PATCH V3 4/8] MIPS: Add NUMA support for Loongson-3
Message-ID: <20141020152709.GD19066@hall.aurel32.net>
References: <1403754092-26607-1-git-send-email-chenhc@lemote.com>
 <1403754092-26607-5-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1403754092-26607-5-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Hi,

On Thu, Jun 26, 2014 at 11:41:28AM +0800, Huacai Chen wrote:
> Multiple Loongson-3A chips can be interconnected with HT0-bus. This is
> a CC-NUMA system that every chip (node) has its own local memory and
> cache coherency is maintained by hardware. The 64-bit physical memory
> address format is as follows:
> 
> 0x-0000-YZZZ-ZZZZ-ZZZZ
> 
> The high 16 bits should be 0, which means the real physical address
> supported by Loongson-3 is 48-bit. The "Y" bits is the base address of
> each node, which can be also considered as the node-id. The "Z" bits is
> the address offset within a node, which means every node has a 44 bits
> address space.
> 
> Macros XPHYSADDR and MAX_PHYSMEM_BITS are modified unconditionally,
> because many other MIPS CPUs have also extended their address spaces.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

[snip]

> diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
> index d2da53c..b1071c1 100644
> --- a/arch/mips/include/asm/sparsemem.h
> +++ b/arch/mips/include/asm/sparsemem.h
> @@ -11,7 +11,7 @@
>  #else
>  # define SECTION_SIZE_BITS	28
>  #endif
> -#define MAX_PHYSMEM_BITS	35
> +#define MAX_PHYSMEM_BITS	48
>  
>  #endif /* CONFIG_SPARSEMEM */
>  #endif /* _MIPS_SPARSEMEM_H */

This part of the patch has broken Loongson 2E support. The pata_via
module fails to allocate memory in the DMA zone:

| [    4.708000] swapper: page allocation failure: order:0, mode:0x10d1
| [    4.716000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.17-1-loongson-2e #1 Debian 3.17-1~exp1
| [    4.724000] Stack : 0000000000000050 ffffffff8016c7d8 0000000000000004 000000000000000b
|           0000000000000000 0000000000000000 0000000000000000 0000000000000000
|           ffffffff8074b9f0 ffffffff8080f347 ffffffff8092e3b8 980000002e06b868
|           0000000000000001 0000000000000000 0000000000000000 0000000000000000
|           0000000000000000 ffffffff80655c84 00000000000010d1 980000002e06f838
|           0000000000000001 ffffffff8016ddec 980000002e06b460 00ffffff8074b9f0
|           0000000000000000 0000000000000000 0000000000000000 0000000000000000
|           0000000000000000 980000002e06f780 0000000000000000 ffffffff801f72e8
|           0000000000000000 00000000bc3e288d 00000000000010d1 0000000000000000
|           0000000000000001 ffffffff801098f0 ffffffff80892718 ffffffff801f72e8
|           ...
| [    4.792000] Call Trace:
| [    4.796000] [<ffffffff801098f0>] show_stack+0x78/0x90
| [    4.800000] [<ffffffff801f72e8>] warn_alloc_failed+0x100/0x148
| [    4.808000] [<ffffffff801faabc>] __alloc_pages_nodemask+0x6e4/0x9c0
| [    4.812000] [<ffffffff801fadbc>] __get_free_pages+0x24/0xa0
| [    4.820000] [<ffffffff8011988c>] mips_dma_alloc_coherent+0x10c/0x1e0
| [    4.824000] [<ffffffff804a925c>] dmam_alloc_coherent+0x84/0x100
| [    4.832000] [<ffffffff804ed540>] ata_bmdma_port_start+0x48/0x68
| [    4.840000] [<ffffffff804f3a1c>] via_port_start+0x2c/0x70
| [    4.844000] [<ffffffff804d904c>] ata_host_start+0x124/0x270
| [    4.848000] [<ffffffff804edfac>] ata_pci_sff_activate_host+0x54/0x270
| [    4.856000] [<ffffffff804ee688>] ata_pci_init_one+0x150/0x208
| [    4.864000] [<ffffffff804f36ac>] via_init_one+0x1b4/0x2d8
| [    4.868000] [<ffffffff80424268>] pci_device_probe+0xb0/0x100
| [    4.876000] [<ffffffff804984ac>] driver_probe_device+0xdc/0x400
| [    4.880000] [<ffffffff804988a0>] __driver_attach+0xd0/0xd8
| [    4.888000] [<ffffffff80496260>] bus_for_each_dev+0x70/0xc0
| [    4.892000] [<ffffffff804978c8>] bus_add_driver+0x128/0x248
| [    4.896000] [<ffffffff80499308>] driver_register+0x90/0x138
| [    4.904000] [<ffffffff801005c0>] do_one_initcall+0x110/0x210
| [    4.908000] [<ffffffff808a8e60>] kernel_init_freeable+0x17c/0x248
| [    4.916000] [<ffffffff806546f8>] kernel_init+0x20/0x118
| [    4.920000] [<ffffffff80103d50>] ret_from_kernel_thread+0x14/0x1c
| [    4.928000]
| [    4.928000] Mem-Info:
| [    4.932000] DMA per-cpu:
| [    4.936000] CPU    0: hi:    0, btch:   1 usd:   0
| [    4.940000] Normal per-cpu:
| [    4.944000] CPU    0: hi:   42, btch:   7 usd:  37
| [    4.948000] active_anon:0 inactive_anon:0 isolated_anon:0
| [    4.948000]  active_file:1657 inactive_file:1899 isolated_file:0
| [    4.948000]  unevictable:0 dirty:0 writeback:0 unstable:0
| [    4.948000]  free:25711 slab_reclaimable:315 slab_unreclaimable:191
| [    4.948000]  mapped:0 shmem:0 pagetables:0 bounce:0
| [    4.948000]  free_cma:0
| [    4.980000] DMA free:0kB min:0kB low:0kB high:0kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0k
| B present:16384kB managed:0kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0
| kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
| [    5.020000] lowmem_reserve[]: 0 116 116
| [    5.024000] Normal free:411376kB min:2752kB low:3440kB high:4128kB active_anon:0kB inactive_anon:0kB active_file:26512kB inactive_file:30384kB unevictable:0kB isolated(an
| on):0kB isolated(file):0kB present:638960kB managed:478096kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:5040kB slab_unreclaimable:3056kB kerne
| l_stack:352kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
| [    5.064000] lowmem_reserve[]: 0 0 0
| [    5.068000] DMA: 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 0kB
| [    5.080000] Normal: 5*16kB (EM) 5*32kB (UEM) 2*64kB (EM) 3*128kB (EM) 6*256kB (UEM) 3*512kB (EM) 2*1024kB (M) 6*2048kB (EM) 2*4096kB (UM) 3*8192kB (EM) 2*16384kB (EM) 10*
| 32768kB (MR) = 411376kB
| [    5.100000] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
| [    5.108000] 3559 total pagecache pages
| [    5.112000] 0 pages in swap cache
| [    5.116000] Swap cache stats: add 0, delete 0, find 0/0
| [    5.120000] Free swap  = 0kB
| [    5.124000] Total swap = 0kB
| [    5.128000] 40959 pages RAM
| [    5.132000] 0 pages HighMem/MovableOnly
| [    5.136000] 10054 pages reserved
| [    5.140000] pata_via 0000:00:05.1: failed to start port 0 (errno=-12)
| [    5.144000] pata_via: probe of 0000:00:05.1 failed with error -12

Does anyone has an idea of the problem, or have experienced the issue
with other MIPS platforms?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
