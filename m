Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:55:39 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33578 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012147AbaJ2QzhXGEqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:55:37 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so3572453pad.3
        for <multiple recipients>; Wed, 29 Oct 2014 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xb8eYqsPyaZxAGTivVNgDRZG15L/yWE3gGV9+nzsvrQ=;
        b=BAHOfsm6zVaTdv2gqUg6uLX9C5SojJS14lD55z+ZSA0puRBoc/1St3a0ChXX9sE72M
         LMk5TYJdzEqnsoTsXthcg0edi1vvqjK6D4tZdo6NJSQQHmPqBL8Es2rIiPTQGEdcFIUk
         h6ehPnqGCUJUUxpZve3zfUcC+H3Cq6HwBnPRD0+3mFG7ygfFYMJe6hzkIx9U7cCAoWpY
         ZnA5TnFCazUJDMtk8T1H8u/d3FuHKSvq9bNqziZ9iCdHhibPt6Pp971uEBbz2s/T+gzM
         29JjjwikzoZgHuiz8CimpTX7uxz5dC3RxnnrKNJRnoxpU5N2ZvmfRX8m1LBrwFJk3eDr
         AkyQ==
X-Received: by 10.66.252.193 with SMTP id zu1mr2152735pac.153.1414601731113;
        Wed, 29 Oct 2014 09:55:31 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ri9sm4838037pbc.5.2014.10.29.09.55.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:55:30 -0700 (PDT)
Message-ID: <54511BE8.6020905@gmail.com>
Date:   Wed, 29 Oct 2014 09:55:04 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 08/11] irqchip: bcm7120-l2: Fix missing nibble in gc->unused
 mask
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-8-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-8-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 10/28/2014 08:58 PM, Kevin Cernekee wrote:
> This mask should have been 0xffff_ffff, not 0x0fff_ffff.
> 
> The change should not have an effect on current users (STB) because bits
> 31:27 are unused.

Nice catch!

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index f041992..e9331f8 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -171,7 +171,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
>  	}
>  
>  	gc = irq_get_domain_generic_chip(data->domain, 0);
> -	gc->unused = 0xfffffff & ~data->irq_map_mask;
> +	gc->unused = 0xffffffff & ~data->irq_map_mask;
>  	gc->reg_base = data->base;
>  	gc->private = data;
>  	ct = gc->chip_types;
> 
