Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 22:58:55 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:60947 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991112AbeKFV6lSyLGT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2018 22:58:41 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7716920510; Tue,  6 Nov 2018 22:58:40 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 22D1020379;
        Tue,  6 Nov 2018 22:58:30 +0100 (CET)
Date:   Tue, 6 Nov 2018 22:58:29 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
Message-ID: <20181106225829.5ecbe19e@bbrezillon>
In-Reply-To: <20181106214416.11342-1-geert@linux-m68k.org>
References: <20181106214416.11342-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

On Tue,  6 Nov 2018 22:44:16 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Toshiba RBTX4927, where map_probe is supposed to fail:
> 
>     Creating 2 MTD partitions on "physmap-flash.0":
>     0x000000c00000-0x000001000000 : "boot"
>     0x000000000000-0x000000c00000 : "user"
>     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
>     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
>     ...
>     Call Trace:
>     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
>     [<80321004>] do_map_probe+0x20/0x90
>     [<80328448>] physmap_flash_probe+0x484/0x4ec
> 
> The access to rom_probe_types[] was changed from a sentinel-based loop
> to an infinite loop, causing a crash when reaching the sentinel.

Oops. Do you mind if I fix that in-place (squash your changes in
Ricardo's original commit)?

> 
> Fix this by:
>   - Removing the no longer needed sentinel,
>   - Limiting the number of loop iterations to the actual number of ROM
>     types.
> 
> Fixes: c7afe08496fa463e ("mtd: maps: physmap: Invert logic on if/else branch")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/mtd/maps/physmap-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
> index 33b77bd9022ce251..e8c3b250d8421edc 100644
> --- a/drivers/mtd/maps/physmap-core.c
> +++ b/drivers/mtd/maps/physmap-core.c
> @@ -396,7 +396,7 @@ static int physmap_flash_of_init(struct platform_device *dev)
>  #endif /* IS_ENABLED(CONFIG_MTD_PHYSMAP_OF) */
>  
>  static const char * const rom_probe_types[] = {
> -	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom", NULL
> +	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom",
>  };
>  
>  static const char * const part_probe_types[] = {
> @@ -524,7 +524,7 @@ static int physmap_flash_probe(struct platform_device *dev)
>  		} else {
>  			int j;
>  
> -			for (j = 0; ARRAY_SIZE(rom_probe_types); j++) {
> +			for (j = 0; j < ARRAY_SIZE(rom_probe_types); j++) {
>  				info->mtds[i] = do_map_probe(rom_probe_types[j],
>  							     &info->maps[i]);
>  				if (info->mtds[i])
