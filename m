Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:19:48 +0100 (WEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:30461 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023445AbZFASTl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:19:41 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a241a4c0000>; Mon, 01 Jun 2009 14:13:37 -0400
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 11:13:29 -0700
Message-ID: <4A241A49.1020706@caviumnetworks.com>
Date:	Mon, 01 Jun 2009 11:13:29 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/9] mips: deal with larger physical offsets
References: <200906011359.47216.florian@openwrt.org>
In-Reply-To: <200906011359.47216.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2009 18:13:29.0476 (UTC) FILETIME=[AA530C40:01C9E2E4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:
> TI AR7 has larger physical offsets than other MIPS-based
> systems. A long jump to the target is required instead of
> a short jump like on other systems.
> 
> Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index e83da17..44f7141 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1256,9 +1256,22 @@ void *set_except_vector(int n, void *addr)
>  
>  	exception_handlers[n] = handler;
>  	if (n == 0 && cpu_has_divec) {
> -		*(u32 *)(ebase + 0x200) = 0x08000000 |
> -					  (0x03ffffff & (handler >> 2));
> -		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> +		if ((handler ^ (ebase + 4)) & 0xfc000000) {
> +			/* lui k0, 0x0000 */
> +			*(u32 *)(ebase + 0x200) = 0x3c1a0000 | (handler >> 16);
> +			/* ori k0, 0x0000 */
> +			*(u32 *)(ebase + 0x204) =
> +					0x375a0000 | (handler & 0xffff);
> +			/* jr k0 */
> +			*(u32 *)(ebase + 0x208) = 0x03400008;
> +			/* nop */
> +			*(u32 *)(ebase + 0x20C) = 0x00000000;
> +			local_flush_icache_range(ebase + 0x200, ebase + 0x210);
> +		} else {
> +			*(u32 *)(ebase + 0x200) =
> +				0x08000000 | (0x03ffffff & (handler >> 2));
> +			local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> +		}
>  	}
>  	return (void *)old_handler;
>  }
> 

I had to do a similar change for my mapped kernel patch.  However in 
mine, I used uasm.  I wonder if the extra memory occupied by uasm is too 
steep a penalty to pay for the ability to use it outside of __init code. 
  If not, we should move uasm out of __init and use it instead of this 
manual assembly.

David Daney
