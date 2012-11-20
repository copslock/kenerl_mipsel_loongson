Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 09:11:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36134 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816668Ab2KTILv2iq0D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Nov 2012 09:11:51 +0100
Message-ID: <50AB3AFF.2000001@phrozen.org>
Date:   Tue, 20 Nov 2012 09:10:39 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org,
        zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 1/8] bcma: add locking around GPIO register accesses
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1353365877-11131-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35054
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke

> u32 bcma_chipco_gpio_in(struct bcma_drv_cc *cc, u32 mask)
>   {
> -	return bcma_cc_read32(cc, BCMA_CC_GPIOIN)&  mask;
> +	unsigned long flags;
> +	u32 res;
> +
> +	spin_lock_irqsave(&cc->gpio_lock, flags);
> +	res = bcma_cc_read32(cc, BCMA_CC_GPIOIN)&  mask;
> +	spin_unlock_irqrestore(&cc->gpio_lock, flags);
> +
> +	return res;
>   }
>

Hi Hauke,

do you need to lock the read access ?

if bcma_cc_read32() is a simple memory read wrapper you most likely wont 
need the lock

	John
