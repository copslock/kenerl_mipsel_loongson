Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 17:52:15 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:15031
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225243AbVBDRv7>;
	Fri, 4 Feb 2005 17:51:59 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 4 Feb 2005 09:51:55 -0800
Message-ID: <4203B636.6060606@avtrex.com>
Date:	Fri, 04 Feb 2005 09:51:50 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Dominic Sweetman <dom@mips.com>, Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <16899.37525.412441.558873@gargle.gargle.HOWL> <20050204154532.GA22217@linux-mips.org> <20050204155340.GB22217@linux-mips.org>
In-Reply-To: <20050204155340.GB22217@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2005 17:51:55.0443 (UTC) FILETIME=[372BC830:01C50AE2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> This is what I've checked in.
> 
>   Ralf
> 
> Index: arch/mips/mm/c-r4k.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
> retrieving revision 1.97
> diff -u -r1.97 c-r4k.c
> --- arch/mips/mm/c-r4k.c	4 Feb 2005 15:19:01 -0000	1.97
> +++ arch/mips/mm/c-r4k.c	4 Feb 2005 15:48:38 -0000
> @@ -1012,9 +1012,17 @@
>  	 * normally they'd suffer from aliases but magic in the hardware deals
>  	 * with that for us so we don't need to take care ourselves.
>  	 */
> -	if (c->cputype != CPU_R10000 && c->cputype != CPU_R12000)
> +	switch (c->cputype) {
>  		if (c->dcache.waysize > PAGE_SIZE)
> -		        c->dcache.flags |= MIPS_CACHE_ALIASES;
> +			
> +	case CPU_R10000:
> +	case CPU_R12000:
> +		break;
> +	case CPU_24K:
> +		if (!(read_c0_config7() & (1 << 16)))
> +	default:
> +			c->dcache.flags |= MIPS_CACHE_ALIASES;
> +	}
>  
>  	switch (c->cputype) {
>  	case CPU_20KC:

That may be legal C, but I have a difficult time figuring out exactly 
what it is supposed to do as case labels in the middle of statements 
confuses me.

Does the first if in the switch do anything?  My reading of the spec 
indicates that it is unreachable code.

Just my $0.02

David Daney.
