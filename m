Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2015 23:34:51 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:48413 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013080AbbHVVetm5cBS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2015 23:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pTWoat1fwLCls+1evXYVD6rhqu9nbU6qkGnHm68t4ro=;
        b=8j48XW+6nsDosOA13TYaNGYMg+XLRDPXqKvVbeux1381vRNJnr4zaY++Tc1Uq+npJEZMkV6Py4gtXgDBFMwfeZo+w4FBZ9NPi9WSqMJb8A3clrUlTM6CquQfJXkwkkkBraGMUO5biyPzrhaWwgxiHweHhrApQHZxTPG88syWjJo=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57594 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZTGQz-001iDR-5S; Sat, 22 Aug 2015 21:34:42 +0000
Date:   Sat, 22 Aug 2015 14:34:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: mips: Fix console output for Fulong2e system
Message-ID: <20150822213434.GA14985@roeck-us.net>
References: <1438927036-1435-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438927036-1435-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Aug 06, 2015 at 10:57:16PM -0700, Guenter Roeck wrote:
> Commit 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
> made the number of UARTs dynamic if LEFI_FIRMWARE_INTERFACE is configured.
> Unfortunately, it did not initialize the number of UARTs if
> LEFI_FIRMWARE_INTERFACE is not configured. As a result, the Fulong2e
> system has no console.
> 
> Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
> Cc: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Hello Ralf,

please let me know if anything is wrong with this patch.
Should I resend with Huacai Chen's Ack and capital MIPS in the subject line ?

Thanks,
Guenter

> ---
> Never mind my earlier e-mail, I figured it out.
> Should be a candidate for stable (v3.19+, ie v4.1 in practice).
> 
>  arch/mips/loongson64/common/env.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
> index f6c44dd332e2..d6d07ad56180 100644
> --- a/arch/mips/loongson64/common/env.c
> +++ b/arch/mips/loongson64/common/env.c
> @@ -64,6 +64,9 @@ void __init prom_init_env(void)
>  	}
>  	if (memsize == 0)
>  		memsize = 256;
> +
> +	loongson_sysconf.nr_uarts = 1;
> +
>  	pr_info("memsize=%u, highmemsize=%u\n", memsize, highmemsize);
>  #else
>  	struct boot_params *boot_p;
