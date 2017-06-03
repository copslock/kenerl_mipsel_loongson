Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 17:55:29 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:55682 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbdFCPzVzkTzW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 17:55:21 +0200
Received: from [192.168.10.172] (p4FD97990.dip0.t-ipconnect.de [79.217.121.144])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 6C3DD100036;
        Sat,  3 Jun 2017 17:55:15 +0200 (CEST)
Subject: Re: [PATCH] MIPS: Lantiq: Fix ASC0/ASC1 clocks
To:     Martin Schiller <ms@dev.tdt.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1496118874-4251-1-git-send-email-ms@dev.tdt.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, arnd@arndb.de, nbd@nbd.name
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <13a14a47-1609-4b44-1bb1-6f58c9cda914@hauke-m.de>
Date:   Sat, 3 Jun 2017 17:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1496118874-4251-1-git-send-email-ms@dev.tdt.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58195
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

On 05/30/2017 06:34 AM, Martin Schiller wrote:
> ASC1 is available on every Lantiq SoC (also AmazonSE) and should be
> enabled like the other generic xway clocks instead of ASC0, which is
> only available for AR9 and Danube.

This is correct.

> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/lantiq/xway/sysctrl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 95bec46..cd6dbea 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -484,9 +484,9 @@ void __init ltq_soc_init(void)
>  
>  	/* add our generic xway clocks */
>  	clkdev_add_pmu("10000000.fpi", NULL, 0, 0, PMU_FPI);
> -	clkdev_add_pmu("1e100400.serial", NULL, 0, 0, PMU_ASC0);
>  	clkdev_add_pmu("1e100a00.gptu", NULL, 1, 0, PMU_GPT);
>  	clkdev_add_pmu("1e100bb0.stp", NULL, 1, 0, PMU_STP);
> +	clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>  	clkdev_add_pmu("1e104100.dma", NULL, 1, 0, PMU_DMA);
>  	clkdev_add_pmu("1e100800.spi", NULL, 1, 0, PMU_SPI);
>  	clkdev_add_pmu("1e105300.ebu", NULL, 0, 0, PMU_EBU);
> @@ -501,7 +501,6 @@ void __init ltq_soc_init(void)
>  	}
>  
>  	if (!of_machine_is_compatible("lantiq,ase")) {
> -		clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>  		clkdev_add_pci();
>  	}
>  
> 
