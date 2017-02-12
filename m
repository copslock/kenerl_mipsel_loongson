Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2017 09:03:55 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:34901 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990511AbdBLIDsbZ5RS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Feb 2017 09:03:48 +0100
Subject: Re: [PATCH] MIPS: Lantiq: Keep ethernet enabled during boot
To:     Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org
References: <20170119132009.55709-1-nbd@nbd.name>
Cc:     ralf@linux-mips.org, hauke.mehrtens@lantiq.com
From:   John Crispin <john@phrozen.org>
Message-ID: <6c7672fc-4acb-98a9-b6e3-3387d33ba69f@phrozen.org>
Date:   Sun, 12 Feb 2017 09:03:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170119132009.55709-1-nbd@nbd.name>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 19/01/2017 14:20, Felix Fietkau wrote:
> Disabling ethernet during reboot (only to enable it again when the
> ethernet driver attaches) can put the chip into a faulty state where it
> corrupts the header of all incoming packets.
> 
> This happens if packets arrive during the time window where the core is
> disabled, and it can be easily reproduced by rebooting while sending a
> flood ping to the broadcast address.
> 
> Cc: john@phrozen.org
> Cc: hauke.mehrtens@lantiq.com
> Cc: stable@vger.kernel.org
> Fixes: 95135bfa7ead ("MIPS: Lantiq: Deactivate most of the devices by default")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: John Crispin <john@phrozen.org>

> ---
>  arch/mips/lantiq/xway/sysctrl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 236193b5210b..9a61671c00a7 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -545,7 +545,7 @@ void __init ltq_soc_init(void)
>  		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
>  		clkdev_add_pmu("1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
>  		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
> -		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH | PMU_PPE_DP);
> +		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>  	} else if (of_machine_is_compatible("lantiq,ar10")) {
> @@ -553,7 +553,7 @@ void __init ltq_soc_init(void)
>  				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
>  		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
>  		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
> -		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH |
> +		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
>  			       PMU_PPE_DP | PMU_PPE_TC);
>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>  		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
> @@ -575,11 +575,11 @@ void __init ltq_soc_init(void)
>  		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
>  
>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
> -		clkdev_add_pmu("1e108000.eth", NULL, 1, 0,
> +		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
>  				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
>  				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
>  				PMU_PPE_QSB | PMU_PPE_TOP);
> -		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
> +		clkdev_add_pmu("1f203000.rcu", "gphy", 0, 0, PMU_GPHY);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>  		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> 
