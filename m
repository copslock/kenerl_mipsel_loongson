Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 14:39:50 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:36]:37126
        "EHLO resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdGYMjmeXJaD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 14:39:42 +0200
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-04v.sys.comcast.net with ESMTP
        id Zz7ZdCi6cQQiLZz7jdNYVn; Tue, 25 Jul 2017 12:39:39 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-ch2-17v.sys.comcast.net with SMTP
        id Zz7hdxuLo3sD5Zz7idYrnj; Tue, 25 Jul 2017 12:39:39 +0000
Subject: Re: [PATCH v2] MIPS: PCI: Fix smp_processor_id() in preemptible
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle A <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
References: <1500975552-31015-1-git-send-email-matt.redfearn@imgtec.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <1a10a938-fee6-4faa-a11f-37a67a906e8f@gentoo.org>
Date:   Tue, 25 Jul 2017 08:39:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1500975552-31015-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfChVX3mVr/BsRiNPqaU4ptU/gY+FIvL21jbOVcrEv2aLwuJRwheJzUFiK2cj1ms6NkqU8r+8sgslaVMC+2HXMjxsGWgdi1nmBuk0DC/jI2EUpOdnxfZA
 wUrsYK0AfKixZoOSnCtlbblwl7dVENfr7iCvk6oaQxSDsrPpFN8Z2E8glzOOIv0sg5TKUqSTXNpOOeuiDTcgSVkjH3ZAdmJyHiJxmIbbM8ARjG67mxGh2PpA
 TTYNbM97yim12+rzO6Z9gEinTVgaEcenFJp6rM9fyljUq7xbyhKOIliv5orxMKhYJs/cHC4Cy3jsIqgdUwIK0zprkOOfhWp5J9rzAVAuXAaofT5fBYbtg1nE
 anQokho+1SsynroQ9JCvj+5SvPUpprTqhAEfw5JV88KDoHXBV6LGFJO5Luq/c25wzDLxU+zkmGlweyNW/XLYrSo1iaOcUQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 07/25/2017 05:39, Matt Redfearn wrote:
> Commit 1c3c5eab1715 ("sched/core: Enable might_sleep() and
> smp_processor_id() checks early") enables checks for might_sleep() and
> smp_processor_id() being used in preemptible code earlier in the boot
> than before. This results in a new BUG from
> pcibios_set_cache_line_size().
> 
> BUG: using smp_processor_id() in preemptible [00000000] code:
> swapper/0/1
> caller is pcibios_set_cache_line_size+0x10/0x70
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc1-00007-g3ce3e4ba4275 #615
> Stack : 0000000000000000 ffffffff81189694 0000000000000000 ffffffff81822318
>         000000000000004e 0000000000000001 800000000e20bd08 20c49ba5e3540000
>         0000000000000000 0000000000000000 ffffffff818d0000 0000000000000000
>         0000000000000000 ffffffff81189328 ffffffff818ce692 0000000000000000
>         0000000000000000 ffffffff81189bc8 ffffffff818d0000 0000000000000000
>         ffffffff81828907 ffffffff81769970 800000020ec78d80 ffffffff818c7b48
>         0000000000000001 0000000000000001 ffffffff818652b0 ffffffff81896268
>         ffffffff818c0000 800000020ec7fb40 800000020ec7fc58 ffffffff81684cac
>         0000000000000000 ffffffff8118ab50 0000000000000030 ffffffff81769970
>         0000000000000001 ffffffff81122a58 0000000000000000 0000000000000000
>         ...
> Call Trace:
> [<ffffffff81122a58>] show_stack+0x90/0xb0
> [<ffffffff81684cac>] dump_stack+0xac/0xf0
> [<ffffffff813f7050>] check_preemption_disabled+0x120/0x128
> [<ffffffff818855e8>] pcibios_set_cache_line_size+0x10/0x70
> [<ffffffff81100578>] do_one_initcall+0x48/0x140
> [<ffffffff81865dc4>] kernel_init_freeable+0x194/0x24c
> [<ffffffff8169c534>] kernel_init+0x14/0x118
> [<ffffffff8111ca84>] ret_from_kernel_thread+0x14/0x1c
> 
> Fix this by using the cpu_*cache_line_size() macros instead. These
> macros are the "proper" way to determine the CPU cache sizes.
> Since no cpu_tcache_line_size exists yet, add it.
> 
> Fixes: 1c3c5eab1715 ("sched/core: Enable might_sleep() and smp_processor_id() checks early")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Suggested-by: James Hogan <james.hogan@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> ---
> 
> Changes in v2:
> Switch to using cpu_*cache_line_size() macros
> 
> In heteregenerous systems the more correct fix for this would be to
> iterate over CPUs checking each ones cache hierarchy. However, as no
> such systems currently exist that seems wasteful.
> 
> ---
>  arch/mips/include/asm/cpu-features.h | 3 +++
>  arch/mips/pci/pci.c                  | 7 +++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 8baa9033b181..721b698bfe3c 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -428,6 +428,9 @@
>  #ifndef cpu_scache_line_size
>  #define cpu_scache_line_size()	cpu_data[0].scache.linesz
>  #endif
> +#ifndef cpu_tcache_line_size
> +#define cpu_tcache_line_size()	cpu_data[0].tcache.linesz
> +#endif
>  
>  #ifndef cpu_hwrena_impl_bits
>  #define cpu_hwrena_impl_bits		0

Not to be pedantic, but shouldn't the addition of an unimplemented
function/macro be a separate patch and this change become a (small) patch series?


> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index bd67ac74fe2d..9632436d74d7 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -28,16 +28,15 @@ EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
>  
>  static int __init pcibios_set_cache_line_size(void)
>  {
> -	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int lsize;
>  
>  	/*
>  	 * Set PCI cacheline size to that of the highest level in the
>  	 * cache hierarchy.
>  	 */
> -	lsize = c->dcache.linesz;
> -	lsize = c->scache.linesz ? : lsize;
> -	lsize = c->tcache.linesz ? : lsize;
> +	lsize = cpu_dcache_line_size();
> +	lsize = cpu_scache_line_size() ? : lsize;
> +	lsize = cpu_tcache_line_size() ? : lsize;
>  
>  	BUG_ON(!lsize);


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
