Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:27:43 +0100 (CET)
Received: from mx1.mailbox.org ([80.241.60.212]:46400 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990397AbeCLV1fHa7Nf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:27:35 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 2CD8442998;
        Mon, 12 Mar 2018 22:27:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id RNN2ldaVJZYx; Mon, 12 Mar 2018 22:27:27 +0100 (CET)
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-2-hauke@hauke-m.de>
Message-ID: <32b80178-7590-9df7-54fb-512d75b4e724@hauke-m.de>
Date:   Mon, 12 Mar 2018 22:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180311174123.2578-2-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 03/11/2018 06:41 PM, Hauke Mehrtens wrote:
> From: Mathias Kresin <dev@kresin.me>
> 
> On Danube and AR9 the USB core is connected to the AHB bus, hence we need
> to enable the AHB Bus as well.
> 
> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index f11f1dd10493..e0af39b33e28 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
>  		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>  				ltq_ar9_fpi_hz(), CLOCK_250M);
>  		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> -		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>  		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
> -		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
> +		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
>  		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> @@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
>  	} else {
>  		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>  				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>  		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> 
