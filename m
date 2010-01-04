Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 18:55:39 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10867 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493254Ab0ADRzZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 18:55:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b422b7e0000>; Mon, 04 Jan 2010 09:55:10 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 4 Jan 2010 09:54:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 4 Jan 2010 09:54:50 -0800
Message-ID: <4B422B68.3090508@caviumnetworks.com>
Date:   Mon, 04 Jan 2010 09:54:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: deal with larger physical offset
References: <201001032117.26581.florian@openwrt.org>
In-Reply-To: <201001032117.26581.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2010 17:54:50.0709 (UTC) FILETIME=[03208050:01CA8D67]
X-archive-position: 25511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2533

Florian Fainelli wrote:
> AR7 has a larger physical offset than other MIPS based
> systems and therefore needs to setup handlers differently.
> This version uses uasm instead of the hand crafted assembly
> previously sent. This modification is also required for
> running the kernel in mapped address space.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 308e434..dbf52ab 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -51,6 +51,8 @@
>  #include <asm/stacktrace.h>
>  #include <asm/irq.h>
>  
> +#include "../mm/uasm.h"
> +


The first time this came up, it was suggested that uasm.h move to 
asm/uasm.h so that we don't have this ugliness.  I think it is still a 
good idea.

>  extern void check_wait(void);
>  extern asmlinkage void r4k_wait(void);
>  extern asmlinkage void rollback_handle_int(void);
> @@ -1283,9 +1285,18 @@ void *set_except_vector(int n, void *addr)
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
> +			uasm_i_j(&buf, handler & jump_mask);
> +			uasm_i_nop(&buf);
> +		} else {
> +			UASM_i_LA(&buf, k0, handler);
> +			uasm_i_jr(&buf, k0);
> +			uasm_i_nop(&buf);
> +		}
> +		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);


I would expect that this causes section mismatch build warnings.

You may have to make this function __init or __cpu_init (and change 
trap_init() to __cpu_init too).

You should also fix the comment, as after the patch it is no longer 
accurate.

>  	}
>  	return (void *)old_handler;
>  }
> 
> 
