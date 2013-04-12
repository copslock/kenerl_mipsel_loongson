Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 19:11:02 +0200 (CEST)
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:35595
        "EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835071Ab3DLRK4wtFif (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Apr 2013 19:10:56 +0200
Received: from mail217-ch1-R.bigfish.com (10.43.68.253) by
 CH1EHSOBE017.bigfish.com (10.43.70.67) with Microsoft SMTP Server id
 14.1.225.23; Fri, 12 Apr 2013 17:10:48 +0000
Received: from mail217-ch1 (localhost [127.0.0.1])      by
 mail217-ch1-R.bigfish.com (Postfix) with ESMTP id 2BE981602C4; Fri, 12 Apr
 2013 17:10:48 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.1.197;KIP:(null);UIP:(null);IPV:NLI;H:BLUPRD0712HT001.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -3
X-BigFish: PS-3(zzbb2dI98dI9371I1432Izz1f42h1fc6h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ahzz8275bh8275dhz2dh2a8h668h839h947he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1889i1155h)
Received: from mail217-ch1 (localhost.localdomain [127.0.0.1]) by mail217-ch1
 (MessageSwitch) id 136578664635311_8295; Fri, 12 Apr 2013 17:10:46 +0000
 (UTC)
Received: from CH1EHSMHS035.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.232])        by mail217-ch1.bigfish.com (Postfix) with ESMTP id
 065524A0088;   Fri, 12 Apr 2013 17:10:46 +0000 (UTC)
Received: from BLUPRD0712HT001.namprd07.prod.outlook.com (132.245.1.197) by
 CH1EHSMHS035.bigfish.com (10.43.70.35) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 12 Apr 2013 17:10:45 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.162) with Microsoft SMTP Server (TLS) id 14.16.293.5; Fri, 12 Apr
 2013 17:10:45 +0000
Message-ID: <51684012.2020602@caviumnetworks.com>
Date:   Fri, 12 Apr 2013 10:10:42 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
CC:     <linux-mips@linux-mips.org>, <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2] Octeon: fix broken plat_mem_setup()
References: <51683BCB.8060209@nsn.com>
In-Reply-To: <51683BCB.8060209@nsn.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 04/12/2013 09:52 AM, Alexander Sverdlin wrote:
> Octeon: fix broken plat_mem_setup()
>
> Upstream patch abe77f90dc9c65a7c9a4d61c2cbb8db4d5566e4f (MIPS: Octeon:
> Add kexec
> and kdump support) seems to be untested and broken Linux 3.8 on Octeon
> -- in
> comparison with 3.7 Linux crashes with
>
[...]
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>
> There are at least couple of issues in the patch:
>
> 1. reason for add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM)
> instead of
> add_memory_region(memory, size, BOOT_MEM_RAM) is unclear, especially
> because it
> will discard corrections performed by two preceding calls to
> memory_exclude_page().
> This is fixed using size again instead of mem_alloc_size, moreover,
> block sizes
> calculation could be simplified.
>
> 2. add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM) marks
> kernel body
> as RAM available for allocation, that's why the kernel later crashes
> overwritting
> itself. Marking it as BOOT_MEM_INIT_RAM solves the crash and still
> allows to load
> the same kernel with kexec (tested also).
>

I have a different patch I am testing that gets rid of all this crap.

The strategy we are using is to use cvmx_bootmem named blocks for all 
memory in a KEXEC environment.

David Daney


> Signed-off-by: Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>
> Changes in V2:
> * corrected "end" calculation, simplified "size" calculation
> * Mapped the kernel correctly as INIT RAM, instead of throwing this code
> out
>
> As a result, kernel not only boots succefully, but also able to load itself
> with "kexec -l <image>".
>
> --- linux.orig/arch/mips/cavium-octeon/setup.c
> +++ linux/arch/mips/cavium-octeon/setup.c
> @@ -936,14 +936,14 @@ void __init plat_mem_setup(void)
>                           CVMX_PCIE_BAR1_PHYS_SIZE,
>                           &memory, &size);
>   #ifdef CONFIG_KEXEC
> -            end = memory + mem_alloc_size;
> +            end = memory + size;
>
>               /*
>                * This function automatically merges address regions
>                * next to each other if they are received in
>                * incrementing order
>                */
> -            if (memory < crashk_base && end >  crashk_end) {
> +            if (memory < crashk_base && end > crashk_end) {
>                   /* region is fully in */
>                   add_memory_region(memory,
>                             crashk_base - memory,
> @@ -969,20 +969,20 @@ void __init plat_mem_setup(void)
>                    * Overlap with the beginning of the region,
>                    * reserve the beginning.
>                     */
> -                mem_alloc_size -= crashk_end - memory;
> +                size = end - crashk_end;
>                   memory = crashk_end;
>               } else if (memory < crashk_base && end > crashk_base &&
> -                   end < crashk_end)
> +                   end < crashk_end) {
>                   /*
>                    * Overlap with the beginning of the region,
>                    * chop of end.
>                    */
> -                mem_alloc_size -= end - crashk_base;
> +                size = crashk_base - memory;
> +            }
>   #endif
> -            add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
> +            if (size)
> +                add_memory_region(memory, size, BOOT_MEM_RAM);
>               total += mem_alloc_size;
> -            /* Recovering mem_alloc_size */
> -            mem_alloc_size = 4 << 20;
>           } else {
>               break;
>           }
> @@ -994,7 +994,7 @@ void __init plat_mem_setup(void)
>
>       /* Adjust for physical offset. */
>       kernel_start &= ~0xffffffff80000000ULL;
> -    add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
> +    add_memory_region(kernel_start, kernel_size, BOOT_MEM_INIT_RAM);
>   #endif /* CONFIG_CRASH_DUMP */
>
>   #ifdef CONFIG_CAVIUM_RESERVE32
>
>
