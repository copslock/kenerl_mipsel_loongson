Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 00:31:18 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:57097 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821742AbaFQWbMrJsX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 00:31:12 +0200
Received: by mail-ig0-f176.google.com with SMTP id a13so4704627igq.3
        for <multiple recipients>; Tue, 17 Jun 2014 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rDJj3Q9vv5J3QnH7HXdpEBYcJph96w+ZlOfAEa5irCI=;
        b=fDX9FTpql2xBLVKBgdFZvTMxtDk41CQh6/91U2tl6Nga7E+ACN5qZiCxy23qFIJnBh
         15vHA0YDmPY4AJprZNM+6VylyfDlG7rby0AUgsBJBJLaY6X4RPzlWbfxqBxMbO3RiT8n
         g7hNoULgcYA/XvQ18DRfEsO5QcjnOp4HAGLftZ8PWEoQ4xt6V6MS+01D6hpaqyjTIlmA
         ec2o+mAsqp73GjTkg+ZvoiMDkjuv7L7DekGV59tPxt7iXZv+uZHVNMBBLUYlNAYPunsZ
         rzQwQh/YikQ+tVm6AKWCOYaEYzpe3CNDqdIFafLm/vr3ea1OGyw0loxmn0ABs5FnKBnO
         XZNg==
X-Received: by 10.42.231.147 with SMTP id jq19mr5038185icb.88.1403044263406;
        Tue, 17 Jun 2014 15:31:03 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id c5sm1118882ign.1.2014.06.17.15.31.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 15:31:02 -0700 (PDT)
Message-ID: <53A0C1A5.2050709@gmail.com>
Date:   Tue, 17 Jun 2014 15:31:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/3] MIPS: OCTEON: SMP: delete redundant check
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/16/2014 01:06 PM, Aaro Koskinen wrote:
> The same check is already done earlier in octeon_smp_hotplug_setup().
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This seems fine, we want to move away from panicking the kernel towards 
runtime detection of capabilities.  This is certainly no worse in that 
regard.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/cavium-octeon/smp.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index a7b3ae1..2c8d156 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -192,14 +192,6 @@ static void octeon_init_secondary(void)
>    */
>   void octeon_prepare_cpus(unsigned int max_cpus)
>   {
> -#ifdef CONFIG_HOTPLUG_CPU
> -	struct linux_app_boot_info *labi;
> -
> -	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
> -
> -	if (labi->labi_signature != LABI_SIGNATURE)
> -		panic("The bootloader version on this board is incorrect.");
> -#endif
>   	/*
>   	 * Only the low order mailbox bits are used for IPIs, leave
>   	 * the other bits alone.
>
