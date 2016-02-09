Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 23:07:35 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:6007 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012167AbcBIWHdyGS5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Feb 2016 23:07:33 +0100
Received: from tock (unknown [80.171.101.200])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C0EC9A617D;
        Tue,  9 Feb 2016 23:05:09 +0100 (CET)
Date:   Tue, 9 Feb 2016 23:07:21 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC v5 03/15] MIPS: ath79: use clk-ath79.c driver for AR933X
Message-ID: <20160209230721.660ebd7b@tock>
In-Reply-To: <1455005641-7079-4-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51929
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

On Tue,  9 Feb 2016 11:13:49 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/ath79/clock.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
> index eb5117c..3c98eba 100644
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
> @@ -441,7 +442,9 @@ static void __init qca955x_clocks_init(void)
>  
>  void __init ath79_clocks_init(void)
>  {
> -	if (soc_is_ar71xx())
> +	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
> +		/* pass */
> +	} else if (soc_is_ar71xx())

This will break all non AR9330 SoC as their clock won't be properly
initialized, so this is not acceptable.

I would also really prefer if we can avoid having two completely
different implementation for legacy and OF platforms. Ideally both
legacy and OF should use the same core code, just with 2 different
wrappers. The OF wrapper would just need to get the parent clock from
DT and call the core setup. The legacy code path would need to create
the fixed rate parent clock with the current hard coded value, call the
core setup, then register the clkdev and alias mapping.

I find it important to avoid code duplication because that mean double
the amount of testing work. But in practice that generally mean that
only one half get tested as no one wants to do double the work.

> @@ -484,7 +487,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
>  CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
>  CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
>  CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
> -CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
>  CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
>  CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
>  #endif

This should have been part of the new driver, otherwise this will break
bisecting as there would be a version with 2 CLK_OF_DECLARE for ar9330.

Alban
