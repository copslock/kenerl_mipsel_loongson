Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 13:58:56 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60281 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903547Ab2DML6u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 13:58:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6C51C8F61;
        Fri, 13 Apr 2012 13:58:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tXjUjUiPUznO; Fri, 13 Apr 2012 13:58:40 +0200 (CEST)
Received: from [134.102.26.117] (eduroam-pool6-0629.wlan.uni-bremen.de [134.102.26.117])
        by hauke-m.de (Postfix) with ESMTPSA id 3D9EF8F60;
        Fri, 13 Apr 2012 13:58:40 +0200 (CEST)
Message-ID: <4F8814EE.2050406@hauke-m.de>
Date:   Fri, 13 Apr 2012 13:58:38 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Lightning/1.0b2 Thunderbird/3.1.20
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com
Subject: Re: [PATCH v5 1/4] bcma: scan for extra address space
References: <1331851799-5968-1-git-send-email-hauke@hauke-m.de> <1331851799-5968-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1331851799-5968-2-git-send-email-hauke@hauke-m.de>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Rafał,

could you give me an Acked-by line as the Maintainer of bcma for this
patch if you are ok with this patch please.

Hauke

On 03/15/2012 11:49 PM, Hauke Mehrtens wrote:
> Some cores like the USB core have two address spaces. In the USB host
> controller one address space is used for the OHCI and the other for the
> EHCI controller interface. The USB controller is the only core I found
> with two address spaces. This code is based on the AI scan function
> ai_scan() in shared/aiutils.c in the Broadcom SDK.
> 
> CC: Rafał Miłecki <zajec5@gmail.com>
> CC: linux-wireless@vger.kernel.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/bcma/scan.c       |   19 ++++++++++++++++++-
>  include/linux/bcma/bcma.h |    1 +
>  2 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
> index 3a2f672..1fa10ed 100644
> --- a/drivers/bcma/scan.c
> +++ b/drivers/bcma/scan.c
> @@ -286,6 +286,23 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>  			return -EILSEQ;
>  	}
>  
> +	/* First Slave Address Descriptor should be port 0:
> +	 * the main register space for the core
> +	 */
> +	tmp = bcma_erom_get_addr_desc(bus, eromptr, SCAN_ADDR_TYPE_SLAVE, 0);
> +	if (tmp <= 0) {
> +		/* Try again to see if it is a bridge */
> +		tmp = bcma_erom_get_addr_desc(bus, eromptr,
> +					      SCAN_ADDR_TYPE_BRIDGE, 0);
> +		if (tmp <= 0) {
> +			return -EILSEQ;
> +		} else {
> +			pr_info("Bridge found\n");
> +			return -ENXIO;
> +		}
> +	}
> +	core->addr = tmp;
> +
>  	/* get & parse slave ports */
>  	for (i = 0; i < ports[1]; i++) {
>  		for (j = 0; ; j++) {
> @@ -298,7 +315,7 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>  				break;
>  			} else {
>  				if (i == 0 && j == 0)
> -					core->addr = tmp;
> +					core->addr1 = tmp;
>  			}
>  		}
>  	}
> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
> index 83c209f..7fe41e1 100644
> --- a/include/linux/bcma/bcma.h
> +++ b/include/linux/bcma/bcma.h
> @@ -138,6 +138,7 @@ struct bcma_device {
>  	u8 core_index;
>  
>  	u32 addr;
> +	u32 addr1;
>  	u32 wrap;
>  
>  	void __iomem *io_addr;
