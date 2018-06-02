Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2018 11:54:51 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:18504 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991783AbeFBJylNqaF2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Jun 2018 11:54:41 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5FEB2443BC;
        Sat,  2 Jun 2018 11:54:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 4BRxrAUuqCHC; Sat,  2 Jun 2018 11:54:32 +0200 (CEST)
Subject: Re: [PATCH v4 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
To:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        James Hogan <jhogan@kernel.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
References: <20180531221911.6210-1-ikegami@allied-telesis.co.jp>
 <20180531221911.6210-2-ikegami@allied-telesis.co.jp>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8f968192-0a69-3586-5e0d-e03b243110f6@hauke-m.de>
Date:   Sat, 2 Jun 2018 11:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180531221911.6210-2-ikegami@allied-telesis.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64149
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

On 06/01/2018 12:19 AM, Tokunori Ikegami wrote:
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

You do it now unconditionally on all MIPS SoCs using bcma.

There are multiple different silicons from the Broadcom BCM47xx and
BCM53xx line with a MIPS 74K core, see
https://wikidevi.com/wiki/Broadcom I haven't tested if this fix is ok
for all of them, but I think so.

> Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Cc: linux-mips@linux-mips.org

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> Changes since v3:
> - Add Reviewed-by: Paul Burton tag.
> - Remove pr_info().
> 
> Changes since v2:
> - Move the change into platform-specific code bcm47xx_cpu_fixes() function from in generic code.
> 
> Changes since v1 resent:
> - None.
> 
> Changes since v1 original:
> - Change to use set_c0_config7 instead of write_c0_config7.
> 
>  arch/mips/bcm47xx/setup.c        | 6 ++++++
>  arch/mips/include/asm/mipsregs.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 6054d49e608e..8c9cbf13d32a 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -212,6 +212,12 @@ static int __init bcm47xx_cpu_fixes(void)
>  		 */
>  		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
>  			cpu_wait = NULL;
> +
> +		/*
> +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
> +		 * Enable ExternalSync for sync instruction to take effect
> +		 */
> +		set_c0_config7(MIPS_CONF7_ES);
>  		break;
>  #endif
>  	}
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
> 
