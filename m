Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 16:19:13 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:63970 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903719Ab1KVPTD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 16:19:03 +0100
Received: by bkat2 with SMTP id t2so401410bka.36
        for <multiple recipients>; Tue, 22 Nov 2011 07:18:57 -0800 (PST)
Received: by 10.204.128.199 with SMTP id l7mr8827878bks.27.1321975137620;
        Tue, 22 Nov 2011 07:18:57 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id e18sm10322208bkr.15.2011.11.22.07.18.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 07:18:54 -0800 (PST)
Message-ID: <4ECBCB3F.3060302@mvista.com>
Date:   Tue, 22 Nov 2011 19:18:07 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3 v3] MIPS: introduce GENERIC_DUMP_TLB
References: <1321970390-10887-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1321970390-10887-1-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18696

Hello.

On 11/22/2011 04:59 PM, Florian Fainelli wrote:

> Allows us not to duplicate more lines in arch/mips/lib/Makefile.

> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> ---
> Changes since v2:
> - rebased against mips-for-linux-next (remove XLR&  XLP)

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 0c55582..cc5976d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1836,6 +1836,10 @@ config SIBYTE_DMA_PAGEOPS
>   config CPU_HAS_PREFETCH
>   	bool
>
> +config CPU_GENERIC_DUMP_TLB

   You should probably fix the patch's subject which speaks of GENERIC_DUMP_TLB...

WBR, Sergei
