Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 15:45:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46720 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012259AbaJWNpTJi8QG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Oct 2014 15:45:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9NDjF8A001710;
        Thu, 23 Oct 2014 15:45:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9NDjDAw001709;
        Thu, 23 Oct 2014 15:45:13 +0200
Date:   Thu, 23 Oct 2014 15:45:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: incomplete mips patch made 3.10.55, remains broken in 3.10.58
Message-ID: <20141023134513.GA1673@linux-mips.org>
References: <orppdsbixu.fsf@free.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orppdsbixu.fsf@free.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Greg, please apply.

Thanks,

  Ralf

On Thu, Oct 16, 2014 at 03:57:33AM -0300, Alexandre Oliva wrote:

> Commit ff522058bd717506b2fa066fa564657f2b86477e was merged into 3.10.55
> stable as commit 4f91cb537d2f7fa700a2b6d86a2cc77d20ee2616.
> 
> Without the complement, commit 5596b0b245fb9d2cefb5023b11061050351c1398,
> included below, cache invalidation functions modified by the former
> patch may return between preempt_disable() and preempt_enable(), causing
> such machines as yeeloongs to go down in flames early in the boot.
> 
> The complement patch had already made v3.12-rc4, and it's quite
> obviously needed and correct.  I've also tested that it fixes the
> regression on the yeeloong.
> 
> So, would you please merge it into the 3.10 stable series, at your
> earlier convenience, so as to fix this regression?
> 
> Thanks in advance,
> 

> >From 5596b0b245fb9d2cefb5023b11061050351c1398 Mon Sep 17 00:00:00 2001
> From: Yoichi Yuasa <yuasa@linux-mips.org>
> Date: Wed, 2 Oct 2013 15:03:03 +0900
> Subject: [PATCH] MIPS: Fix forgotten preempt_enable() when CPU has inclusive
>  pcaches
> 
> [    1.904000] BUG: scheduling while atomic: swapper/1/0x00000002
> [    1.908000] Modules linked in:
> [    1.916000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-rc2-lemote-los.git-5318619-dirty #1
> [    1.920000] Stack : 0000000031aac000 ffffffff810d0000 0000000000000052 ffffffff802730a4
>           0000000000000000 0000000000000001 ffffffff810cdf90 ffffffff810d0000
>           ffffffff8068b968 ffffffff806f5537 ffffffff810cdf90 980000009f0782e8
>           0000000000000001 ffffffff80720000 ffffffff806b0000 980000009f078000
>           980000009f290000 ffffffff805f312c 980000009f05b5d8 ffffffff80233518
>           980000009f05b5e8 ffffffff80274b7c 980000009f078000 ffffffff8068b968
>           0000000000000000 0000000000000000 0000000000000000 0000000000000000
>           0000000000000000 980000009f05b520 0000000000000000 ffffffff805f2f6c
>           0000000000000000 ffffffff80700000 ffffffff80700000 ffffffff806fc758
>           ffffffff80700000 ffffffff8020be98 ffffffff806fceb0 ffffffff805f2f6c
>           ...
> [    2.028000] Call Trace:
> [    2.032000] [<ffffffff8020be98>] show_stack+0x80/0x98
> [    2.036000] [<ffffffff805f2f6c>] __schedule_bug+0x44/0x6c
> [    2.040000] [<ffffffff805fac58>] __schedule+0x518/0x5b0
> [    2.044000] [<ffffffff805f8a58>] schedule_timeout+0x128/0x1f0
> [    2.048000] [<ffffffff80240314>] msleep+0x3c/0x60
> [    2.052000] [<ffffffff80495400>] do_probe+0x238/0x3a8
> [    2.056000] [<ffffffff804958b0>] ide_probe_port+0x340/0x7e8
> [    2.060000] [<ffffffff80496028>] ide_host_register+0x2d0/0x7a8
> [    2.064000] [<ffffffff8049c65c>] ide_pci_init_two+0x4e4/0x790
> [    2.068000] [<ffffffff8049f9b8>] amd74xx_probe+0x148/0x2c8
> [    2.072000] [<ffffffff803f571c>] pci_device_probe+0xc4/0x130
> [    2.076000] [<ffffffff80478f60>] driver_probe_device+0x98/0x270
> [    2.080000] [<ffffffff80479298>] __driver_attach+0xe0/0xe8
> [    2.084000] [<ffffffff80476ab0>] bus_for_each_dev+0x78/0xe0
> [    2.088000] [<ffffffff80478468>] bus_add_driver+0x230/0x310
> [    2.092000] [<ffffffff80479b44>] driver_register+0x84/0x158
> [    2.096000] [<ffffffff80200504>] do_one_initcall+0x104/0x160
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: linux-mips@linux-mips.org
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Patchwork: https://patchwork.linux-mips.org/patch/5941/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/mm/c-r4k.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 627883b..bc6f96f 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -609,6 +609,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>  			r4k_blast_scache();
>  		else
>  			blast_scache_range(addr, addr + size);
> +		preempt_enable();
>  		__sync();
>  		return;
>  	}
> @@ -650,6 +651,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>  			 */
>  			blast_inv_scache_range(addr, addr + size);
>  		}
> +		preempt_enable();
>  		__sync();
>  		return;
>  	}
> -- 
> 1.9.3
> 

> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer


  Ralf
