Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 22:37:57 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:40675 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835031Ab3FTUh4BEx3f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 22:37:56 +0200
Message-ID: <51C36818.5040902@imgtec.com>
Date:   Thu, 20 Jun 2013 15:37:44 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     <linux-mips@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>,
        "David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH V2] MIPS: flush TLB handlers before calling them
References: <1371760182-637-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1371760182-637-1-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.177]
X-SEF-Processed: 7_3_0_01192__2013_06_20_21_37_47
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/20/2013 03:29 PM, Jonas Gorski wrote:
> When having enabled MIPS_PGD_C0_CONTEXT, trap_init() might call the
> generated tlbmiss_handler_setup_pgd before it was committed to memory,
> causing boot failures:
>
>    trap_init()
>     |- per_cpu_trap_init()
>     |   |- TLBMISS_HANDLER_SETUP()
>     |       |- tlbmiss_handler_setup_pgd()
>     |- flush_tlb_handlers()
>
> To avoid this, move flush_tlb_handlers() into per_cpu_trap_init() to
> ensure the generated handler is always committed on all cpus.
>
> This issue was introduced in 3d8bfdd0307223de678962f1c1907a7cec549136
> ("MIPS: Use C0_KScratch (if present) to hold PGD pointer.").
>
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>
> V1 -> V2:
>   * Move flush_tlb_handlers into per_cpu_trap_init() to also fix it for
>     !boot_cpu.
>
Great work on finding this! This works on Malta with a 1074K in
uniprocessor and SMP kernel configurations. Linking a microMIPS kernel
is still broken as evidenced with:

    mips-linux-gnu-ld: arch/mips/built-in.o: .cpuinit.text+0x1572:
    Unsupported jump between ISA modes; consider recompiling with
    interlinking enabled.
    mips-linux-gnu-ld: final link failed: Bad value
    make: *** [vmlinux] Error 1

The array:

    u32 tlbmiss_handler_setup_pgd_array[16] __cacheline_aligned;

Needs to be replaced using the method in the commit "MIPS: Refactor
'clear_page' and 'copy_page' functions." with hash
c022630633624a75b3b58f43dd3c6cc896a56cff.

-Steve
