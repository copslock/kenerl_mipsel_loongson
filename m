Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 23:42:44 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:19698 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992818AbeDXVmhTapTr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 23:42:37 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 562B6432C7;
        Tue, 24 Apr 2018 23:42:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id bSrw_-9J3hvh; Tue, 24 Apr 2018 23:42:29 +0200 (CEST)
Subject: Re: [PATCH] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for
 BCM47XX PCIe erratum
To:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc:     James Hogan <jhogan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424191939.16082-1-smtpuser@allied-telesis.co.jp>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <95d854d4-e24b-e10f-679d-25e047f02cb9@hauke-m.de>
Date:   Tue, 24 Apr 2018 23:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180424191939.16082-1-smtpuser@allied-telesis.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63738
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

On 04/24/2018 09:19 PM, smtpuser wrote:
> From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> 
> The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as below.
> 
>   R10: PCIe Transactions Periodically Fail
> 
>     Description: The BCM5300X PCIe does not maintain transaction ordering.
>                  This may cause PCIe transaction failure.
>     Fix Comment: Add a dummy PCIe configuration read after a PCIe
>                  configuration write to ensure PCIe configuration access
>                  ordering. Set ES bit of CP0 configu7 register to enable
>                  sync function so that the sync instruction is functional.
>     Resolution:  hndpci.c: extpci_write_config()
>                  hndmips.c: si_mips_init()
>                  mipsinc.h CONF7_ES
> 
> This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
> Also the dummy PCIe configuration read is already implemented in the Linux
> BCMA driver.
> Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
> too so that the sync instruction is externalised.
> 
> Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Cc: linux-mips@linux-mips.org
> ---
> I have just fixed your comments.
> This patch will be sent by git-send-email.
> Also for our company mail system the sender mail address is needed to be set as smtpuser <smtpuser@allied-telesis.co.jp>.
> But do not reply to the email address smtpuser <smtpuser@allied-telesis.co.jp>.
> Please reply to my email address if any comemnt or problem.
> Sorry for inconvinient about this.

Does the CFE boot loader normally apply this workaround? All devices I
have with this SoC use CFE to boot Linux and I am wondering why "only"
the workaround in the driver helped to workaround this problem.

Not all Broadcom MIPS SoCs from the BRCM47xx line with MIPS 74K CPUs are
affected.

See here, we only apply this for the BCM4716 SoCs:
https://git.kernel.org/linus/25c15566635fef86e87f762f73a19f24598e45fa

Here the brcmsmac driver provided by Broadcom, it says that only BCM4716
and BCM4706 are affected:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmsmac/types.h#n255

I am not sure if the version of the bcm4706 which is used on most
devices is affected as this workaround is not applied for this SoC in
b43, could be that Broadcom fixed that in a later revision and the
broken revision never made it into mass production.

Do you ses the problem on the BCM53001 I think this is the same silicon
as the bcm4706?

>  arch/mips/include/asm/mipsregs.h |  3 +++
>  arch/mips/kernel/cpu-probe.c     | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 858752dac337..0f94acf60144 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -680,6 +680,8 @@
>  #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
>  
>  #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
> +/* ExternalSync */
> +#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
>  
>  #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
>  #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
> @@ -2759,6 +2761,7 @@ __BUILD_SET_C0(status)
>  __BUILD_SET_C0(cause)
>  __BUILD_SET_C0(config)
>  __BUILD_SET_C0(config5)
> +__BUILD_SET_C0(config7)
>  __BUILD_SET_C0(intcontrol)
>  __BUILD_SET_C0(intctl)
>  __BUILD_SET_C0(srsmap)
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index cf3fd549e16d..75039e89694f 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -427,8 +427,18 @@ static inline void check_errata(void)
>  		 * making use of VPE1 will be responsable for that VPE.
>  		 */
>  		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
> -			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
> +			set_c0_config7(MIPS_CONF7_RPS);
>  		break;
> +#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
> +	case CPU_74K:
> +		/*
> +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
> +		 * Enable ExternalSync for sync instruction to take effect
> +		 */
> +		pr_info("ExternalSync has been enabled\n");
> +		set_c0_config7(MIPS_CONF7_ES);
> +		break;
> +#endif
>  	default:
>  		break;
>  	}
> 
