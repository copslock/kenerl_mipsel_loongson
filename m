Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 16:44:19 +0200 (CEST)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:61792 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3ICOoQdV0QE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Sep 2013 16:44:16 +0200
Received: by mail-pb0-f45.google.com with SMTP id mc17so6052974pbc.18
        for <multiple recipients>; Tue, 03 Sep 2013 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dbmRd43FiBXuuJOqJEToGzlQ7g6OLbAs3uAgDIzA8Fw=;
        b=BDGLToU+wjcivX8CW7ODQ13VwJ/CjSXGTNmIR8AjGP3oPlD/EZaoQUK2gxdQ+ZWYqD
         kolkk7Q9Wnb+u71aF3oXgFjdVxmlpEvufr693UroEltQTQFok0Rs9CLOogiWyUquPgaj
         1v7vk+PUXkYacxCM+1IokLZN3Y1oxPSaYYdbvDhnZTD2yS+9czBTwhy46suTsYiGSISC
         rnfHZFzl5Rt0bo0NppF2dwjEyWGR6zaMkosnaLFbYT6y22076WUcAHge8QwCHIz/kNAC
         xUX6AerKW8xZZxHQYrFVYFetBKUcBlmBH1fWILYFWTlQ76rl3NSAZGsK2gldeAvnv7FM
         IMIg==
X-Received: by 10.66.121.234 with SMTP id ln10mr31886690pab.20.1378219449580;
 Tue, 03 Sep 2013 07:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.38.99 with HTTP; Tue, 3 Sep 2013 07:43:29 -0700 (PDT)
In-Reply-To: <1378209714-29372-1-git-send-email-jerinjacobk@gmail.com>
References: <1378209714-29372-1-git-send-email-jerinjacobk@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 3 Sep 2013 15:43:29 +0100
Message-ID: <CAGVrzca4g2ZFQc-QmOZi3eL2YHODhy3YN0MJqWPaRk2ZzQDysg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: DMA: Fix BUG due to smp_processor_id() in
 preemptible code
To:     Jerin Jacob <jerinjacobk@gmail.com>, jim2101024@gmail.com
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/9/3 Jerin Jacob <jerinjacobk@gmail.com>:
> The use of current_cpu_type() in cpu_is_noncoherent_r10000() is not preemption-safe.
> Use boot_cpu_type() instead to make it preemption-safe.

Looks like this will conflict with: https://patchwork.linux-mips.org/patch/5776/

>
> <log>
> / # insmod mtd_readtest.ko dev=4
> mtd_readtest: MTD device: 4
> mtd_readtest: MTD device size 996671488, eraseblock size 524288, page size 4096, count of eraseblocks 1901, pages per eraseblock 128, OOB size 224
> mtd_readtest: scanning for bad eraseblocks
> mtd_readtest: scanned 1901 eraseblocks, 0 are bad
> mtd_readtest: testing page read
> BUG: using smp_processor_id() in preemptible [00000000] code: insmod/99
> caller is mips_dma_sync_single_for_cpu+0x2c/0x128
> CPU: 2 PID: 99 Comm: insmod Not tainted 3.10.4 #67
> Stack : 00000006 69735f63 00000000 00000000 00000000 00000000 808273d6 00000032
>           80820000 00000002 8d700000 8de48fa0 00000000 00000000 00000000 00000000
>           00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>           00000000 00000000 00000000 8d6afb00 8d6afb24 80721f24 807b9927 8012c130
>           80820000 80721f24 00000002 00000063 8de48fa0 8082333c 807b98e6 8d6afaa0
>           ...
> Call Trace:
> [<80109984>] show_stack+0x64/0x7c
> [<80666230>] dump_stack+0x20/0x2c
> [<803a2210>] debug_smp_processor_id+0xe0/0xf0
> [<801116f0>] mips_dma_sync_single_for_cpu+0x2c/0x128
> [<8043456c>] nand_plat_read_page+0x16c/0x234
> [<8042fad4>] nand_do_read_ops+0x194/0x480
> [<804301dc>] nand_read+0x50/0x7c
> [<804261c8>] part_read+0x70/0xc0
> [<804231dc>] mtd_read+0x80/0xe4
> [<c0431354>] init_module+0x354/0x6f8 [mtd_readtest]
> [<8010057c>] do_one_initcall+0x140/0x1a4
> [<80176d7c>] load_module+0x1b5c/0x2258
> [<8017752c>] SyS_init_module+0xb4/0xec
> [<8010f3fc>] stack_done+0x20/0x44
>
> BUG: using smp_processor_id() in preemptible [00000000] code: insmod/99
> </log>
>
> Signed-off-by: Jerin Jacob <jerinjacobk@gmail.com>
> ---
>  arch/mips/mm/dma-default.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index aaccf1c..2f26835 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -58,8 +58,8 @@ static inline struct page *dma_addr_to_page(struct device *dev,
>  static inline int cpu_is_noncoherent_r10000(struct device *dev)
>  {
>         return !plat_device_is_coherent(dev) &&
> -              (current_cpu_type() == CPU_R10000 ||
> -              current_cpu_type() == CPU_R12000);
> +              (boot_cpu_type() == CPU_R10000 ||
> +              boot_cpu_type() == CPU_R12000);
>  }
>
>  static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
> --
> 1.7.6.5
>
>



-- 
Florian
