Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:24:37 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:39225 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011469AbcAYWYfdE7jc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:35 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id D2B0B8227E;
        Mon, 25 Jan 2016 23:23:03 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:24:28 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC v3 02/14] MIPS: ath79: use clk-ath79.c driver for
 AR913X/AR933X
Message-ID: <20160125232428.6472f4e6@tock>
In-Reply-To: <1453580251-2341-3-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 23 Jan 2016 23:17:19 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/ath79/clock.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
> index eb5117c..8a287bf 100644
> --- a/arch/mips/ath79/clock.c
> +++ b/arch/mips/ath79/clock.c
> @@ -24,6 +24,7 @@
>  #include <asm/mach-ath79/ath79.h>
>  #include <asm/mach-ath79/ar71xx_regs.h>
>  #include "common.h"
> +#include "machtypes.h"
>  
>  #define AR71XX_BASE_FREQ	40000000
>  #define AR724X_BASE_FREQ	5000000
> @@ -133,6 +134,10 @@ static void __init ar913x_clocks_init(void)
>  	u32 freq;
>  	u32 div;
>  
> +	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
> +		return;
> +	}
> +

I think it would make more sense to move the whole implementation to
drivers/clk, otherwise we'll need to maintain two implementations.

Alban
