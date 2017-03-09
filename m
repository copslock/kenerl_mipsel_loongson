Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 22:28:52 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:51219 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbdCIV2pMcClb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Mar 2017 22:28:45 +0100
Received: from raspberrypi-3.musicnaut.iki.fi (85-76-82-11-nat.elisa-mobile.fi [85.76.82.11])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id CC3861A268D;
        Thu,  9 Mar 2017 23:28:44 +0200 (EET)
Date:   Thu, 9 Mar 2017 23:28:44 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Clean up platform code.
Message-ID: <20170309212844.c44inv7ukb3mgpjo@raspberrypi-3.musicnaut.iki.fi>
References: <1489068963-9836-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489068963-9836-1-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Thu, Mar 09, 2017 at 08:16:03AM -0600, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> Remove unused headers and fix warnings from checkpatch.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 72d2a5e..1a1e11f 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -7,8 +7,6 @@
>   * Copyright (C) 2008 Wind River Systems
>   */
>  
> -#include <linux/init.h>
> -#include <linux/delay.h>
>  #include <linux/etherdevice.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_fdt.h>
> @@ -440,7 +438,7 @@ static int __init octeon_rng_device_init(void)
>  }
>  device_initcall(octeon_rng_device_init);
>  
> -static struct of_device_id __initdata octeon_ids[] = {
> +const struct of_device_id octeon_ids[] __initconst = {

I think it should static const.

A.
