Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2015 22:53:31 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:24246 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009422AbbFZUx34gjfG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2015 22:53:29 +0200
X-IronPort-AV: E=Sophos;i="5.13,686,1427785200"; 
   d="scan'208";a="68377321"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 26 Jun 2015 14:07:07 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Fri, 26 Jun 2015 13:53:13 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.235.1; Fri, 26 Jun 2015 13:53:13 -0700
Received: from [10.12.156.244] (fainelli-linux [10.12.156.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A4CA940FE5;  Fri, 26 Jun
 2015 13:51:13 -0700 (PDT)
Message-ID: <558DBB61.6090904@broadcom.com>
Date:   Fri, 26 Jun 2015 13:51:45 -0700
From:   Florian Fainelli <fainelli@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip: bcm7120-l2: use of_io_request_and_map() to claim
 iomem
References: <1434668725-24058-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1434668725-24058-1-git-send-email-computersforpeace@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <fainelli@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fainelli@broadcom.com
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

On 18/06/15 16:05, Brian Norris wrote:
> This way, the IO resources will show up in /proc/iomem, and we can make
> sure no other drivers are trying to claim these register regions.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 3ba5cc780fcb..299d4de2deb5 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -142,10 +142,10 @@ static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
>  {
>  	int ret;
>  
> -	data->map_base[0] = of_iomap(dn, 0);
> -	if (!data->map_base[0]) {
> +	data->map_base[0] = of_io_request_and_map(dn, 0, dn->full_name);
> +	if (IS_ERR(data->map_base[0])) {
>  		pr_err("unable to map registers\n");
> -		return -ENOMEM;
> +		return PTR_ERR(data->map_base[0]);
>  	}
>  
>  	data->pair_base[0] = data->map_base[0];
> @@ -178,16 +178,17 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
>  
>  	for (gc_idx = 0; gc_idx < MAX_WORDS; gc_idx++) {
>  		unsigned int map_idx = gc_idx * 2;
> -		void __iomem *en = of_iomap(dn, map_idx + 0);
> -		void __iomem *stat = of_iomap(dn, map_idx + 1);
> -		void __iomem *base = min(en, stat);
> +		void __iomem *en, *stat, *base;
> +
> +		en = of_io_request_and_map(dn, map_idx + 0, "irq-en");
> +		stat = of_io_request_and_map(dn, map_idx + 1, "irq-stat");
> +		if (IS_ERR(en) || IS_ERR(stat))
> +			break;
>  
> +		base = min(en, stat);
>  		data->map_base[map_idx + 0] = en;
>  		data->map_base[map_idx + 1] = stat;
>  
> -		if (!base)
> -			break;
> -
>  		data->pair_base[gc_idx] = base;
>  		data->en_offset[gc_idx] = en - base;
>  		data->stat_offset[gc_idx] = stat - base;
> 


-- 
Florian
