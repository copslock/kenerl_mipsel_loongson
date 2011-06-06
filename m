Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 11:25:26 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:36797 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1FFJZX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 11:25:23 +0200
Received: by wwb17 with SMTP id 17so3005863wwb.24
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 02:25:17 -0700 (PDT)
Received: by 10.216.143.96 with SMTP id k74mr2144266wej.100.1307352317218;
        Mon, 06 Jun 2011 02:25:17 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.84.124])
        by mx.google.com with ESMTPS id ge4sm2717580wbb.47.2011.06.06.02.25.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:25:15 -0700 (PDT)
Message-ID: <4DEC9CC5.9010700@mvista.com>
Date:   Mon, 06 Jun 2011 13:24:21 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 10/10] bcm47xx: fix irq assignment for new SoCs.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <1307311658-15853-11-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1307311658-15853-11-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4003

Hello.

On 06-06-2011 2:07, Hauke Mehrtens wrote:

> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   arch/mips/bcm47xx/irq.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/bcm47xx/irq.c b/arch/mips/bcm47xx/irq.c
> index 325757a..3642cee 100644
> --- a/arch/mips/bcm47xx/irq.c
> +++ b/arch/mips/bcm47xx/irq.c
[...]
> @@ -51,5 +52,12 @@ void plat_irq_dispatch(void)
>
>   void __init arch_init_irq(void)
>   {
> +	if (bcm47xx_active_bus_type == BCM47XX_BUS_TYPE_BCMA) {
> +		bcma_write32(bcm47xx_bus.bcma.drv_mips.core,
> +			     BCMA_MIPS_MIPS74K_INTMASK(5), 1<<  31);
> +		/* the kernel reads the timer irq from some register and thinks
> +		 * it's #5, but we offset it by 2 and route to #7 */

    The preferred style for the multi-line comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
