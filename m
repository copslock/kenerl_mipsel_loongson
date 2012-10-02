Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2012 09:21:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50111 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901548Ab2JBHVC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Oct 2012 09:21:02 +0200
Message-ID: <506A953A.4010908@phrozen.org>
Date:   Tue, 02 Oct 2012 09:18:18 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] MIPS: BCM47XX: improve memory size detection
References: <1348942326-27195-1-git-send-email-hauke@hauke-m.de> <1348942326-27195-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1348942326-27195-3-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34566
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

On 29/09/12 20:12, Hauke Mehrtens wrote:
> The memory size is detected by finding a place where it repeats in
> memory. Currently we are just checking when the function prom_init is
> seen again, but with this patch it also checks some more bytes.
>
> This should fix a problem we saw in OpenWrt, where the detected
> available memory decreased on some devices when doing a soft reboot.
>
> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   arch/mips/bcm47xx/prom.c |   14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 22258a4..c18f59a 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -1,6 +1,7 @@
>   /*
>    *  Copyright (C) 2004 Florian Schirmer<jolt@tuxbox.org>
>    *  Copyright (C) 2007 Aurelien Jarno<aurelien@aurel32.net>
> + *  Copyright (C) 2010-2012 Hauke Mehrtens<hauke@hauke-m.de>
>    *
>    *  This program is free software; you can redistribute  it and/or modify it
>    *  under  the terms of  the GNU General  Public License as published by the
> @@ -128,6 +129,7 @@ static __init void prom_init_mem(void)
>   {
>   	unsigned long mem;
>   	unsigned long max;
> +	unsigned long off, data, off1, data1;
>   	struct cpuinfo_mips *c =&current_cpu_data;
>
>   	/* Figure out memory size by finding aliases.
> @@ -145,15 +147,19 @@ static __init void prom_init_mem(void)
>   	 * max contains the biggest possible address supported by the platform.
>   	 * If the method wants to try something above we assume 128MB ram.
>   	 */
> -	max = ((unsigned long)(prom_init) | ((128<<  20) - 1));
> +	off = (unsigned long)prom_init;
> +	data = *(unsigned long *)prom_init;
> +	off1 = off + 4;
> +	data1 = *(unsigned long *)off1;
> +	max = off | ((128<<  20) - 1);
>   	for (mem = (1<<  20); mem<  (128<<  20); mem += (1<<  20)) {
> -		if (((unsigned long)(prom_init) + mem)>  max) {
> +		if ((off + mem)>  max) {
>   			mem = (128<<  20);
>   			printk(KERN_DEBUG "assume 128MB RAM\n");
>   			break;
>   		}
> -		if (*(unsigned long *)((unsigned long)(prom_init) + mem) ==
> -		    *(unsigned long *)(prom_init))
> +		if ((*(unsigned long *)(off + mem) == data)&&
> +			(*(unsigned long *)(off1 + mem) == data1))
>   			break;
>   	}
>

Hi Hauke,

somehow i have the feeling, that using memcmp() should be used here 
instead of comparing memory by hand.

	John
