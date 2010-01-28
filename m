Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 17:56:37 +0100 (CET)
Received: from gateway-2929.mvista.com ([206.112.117.47]:56163 "HELO
        gateway-2929.mvista.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492461Ab0A1Q4d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 17:56:33 +0100
Received: from [192.168.11.174] (unknown [10.150.0.9])
        by hermes.mvista.com (Postfix) with ESMTP
        id 6410D1DC65; Thu, 28 Jan 2010 08:39:20 -0800 (PST)
Message-ID: <4B61BD4D.5060406@ru.mvista.com>
Date:   Thu, 28 Jan 2010 19:37:33 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 3/3] MIPS: deal with larger physical offsets
References: <201001281522.37939.florian@openwrt.org>
In-Reply-To: <201001281522.37939.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 25724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18306

Florian Fainelli wrote:
> AR7 has a larger physical offset than other MIPS based
> systems and therefore needs to setup its handlers beyond
> the usual KSEG0 range. When running the kernel in mapped
> mode this modification is also required. Remove function
> comment which is now incorrect.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 574608e..14d515f 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
...]
> @@ -1283,9 +1279,18 @@ void __init *set_except_vector(int n, void *addr)
>  
>  	exception_handlers[n] = handler;
>  	if (n == 0 && cpu_has_divec) {
> -		*(u32 *)(ebase + 0x200) = 0x08000000 |
> -					  (0x03ffffff & (handler >> 2));
> -		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> +		unsigned long jump_mask = ~((1 << 28) - 1);
> +		u32 *buf = (u32 *)(ebase + 0x200);
> +		unsigned int k0 = 26;
> +		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
>   

  Missing space after *if* (should be easy for Ralf to fix manually 
though). You should run the patch thru scripts/checkpatch.pl first.

WBR, Sergei
