Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 23:41:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:23031 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225002AbUKWXlD>; Tue, 23 Nov 2004 23:41:03 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 2A786185E2; Tue, 23 Nov 2004 15:41:02 -0800 (PST)
Message-ID: <41A3CA8D.1060804@mvista.com>
Date: Tue, 23 Nov 2004 15:41:01 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com> <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Maciej,

Maciej W. Rozycki wrote:
> On Mon, 22 Nov 2004, Manish Lachwani wrote:
> 
> 
>>However, the crash still occurs. I dont think your patch was intended to 
>>fix the problem that I see below (resulting in crash).
> 
> 
>  Certainly, it wasn't, but it couldn't have hurt, either.

I never said that your patch could have hurt ;)

> 
> 
>>Data bus error, epc == 801f83b8, ra == 80323f04
> 
> 
>  The reason are cp0 hazards, likely leading to an incorrect mapping.  Try
> the following patch; already applied to the mainline as obviously correct.


I did sync with the latest CVS sometime back and have been trying it out 
on the MIPS Malta 24Kc. Looks stable upto now ...

Thanks
Manish Lachwani



> 
>   Maciej
> 
> patch-mips-2.6.10-rc1-20041112-mips-tlb-ehb-0
> diff -up --recursive --new-file linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c
> --- linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c	2004-11-23 19:52:53.000000000 +0000
> +++ linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c	2004-11-23 19:58:31.000000000 +0000
> @@ -448,7 +448,8 @@ L_LA(_split)
>  #define i_bnez(buf, rs, off) i_bne(buf, rs, 0, off)
>  #define i_move(buf, a, b) i_ADDU(buf, a, 0, b)
>  #define i_nop(buf) i_sll(buf, 0, 0, 0)
> -#define i_ssnop(buf) i_sll(buf, 0, 2, 1)
> +#define i_ssnop(buf) i_sll(buf, 0, 0, 1)
> +#define i_ehb(buf) i_sll(buf, 0, 0, 3)
>  
>  #if CONFIG_MIPS64
>  static __init int in_compat_space_p(long addr)
> @@ -799,12 +800,12 @@ static __init void build_tlb_write_rando
>  	default:
>  		/*
>  		 * Others are assumed to have one cycle mtc0 hazard,
> -		 * and one cycle tlbwr hazard.
> +		 * and one cycle tlbwr hazard or to understand ehb.
>  		 * XXX: This might be overly general.
>  		 */
> -		i_nop(p);
> +		i_ehb(p);
>  		i_tlbwr(p);
> -		i_nop(p);
> +		i_ehb(p);
>  		break;
>  	}
>  }
