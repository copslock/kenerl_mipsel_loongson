Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 18:13:42 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4903 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492503Ab0BARNi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 18:13:38 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b670bc90000>; Mon, 01 Feb 2010 09:13:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 09:13:36 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 09:13:36 -0800
Message-ID: <4B670BC0.8030003@caviumnetworks.com>
Date:   Mon, 01 Feb 2010 09:13:36 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH urgent] MIPS: fix micro-assembly overflow in set_except_vector
References: <201002011027.37521.florian@openwrt.org>
In-Reply-To: <201002011027.37521.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2010 17:13:36.0806 (UTC) FILETIME=[E421DC60:01CAA361]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:
> Commit 24a6d9866c5f15ba7e5b14dc17be4b6edba21d0e broke
> the installation of handlers for boards which have their
> handlers above a 1 << 26 address. Fix this by making sure that
> jump_mask does not excess 0xfc000000 and add the missing ~ operator
> to jump_mask when jumping to the handler address.
> 
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 7693929..40d94c3 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1279,11 +1279,11 @@ void __init *set_except_vector(int n, void *addr)
>  
>  	exception_handlers[n] = handler;
>  	if (n == 0 && cpu_has_divec) {
> -		unsigned long jump_mask = ~((1 << 28) - 1);
> +		unsigned long jump_mask = ~((1 << 26) - 1);
>  		u32 *buf = (u32 *)(ebase + 0x200);
>  		unsigned int k0 = 26;
>  		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
> -			uasm_i_j(&buf, handler & jump_mask);
> +			uasm_i_j(&buf, handler & ~jump_mask);
>  			uasm_i_nop(&buf);
>  		} else {
>  			UASM_i_LA(&buf, k0, handler);
> 
> 
> 
