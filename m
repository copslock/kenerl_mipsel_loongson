Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:07:23 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:59995
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226132AbULBAHS>; Thu, 2 Dec 2004 00:07:18 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZeV8-0007u8-00; Thu, 02 Dec 2004 01:07:14 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZeV7-000612-00; Thu, 02 Dec 2004 01:07:13 +0100
Date: Thu, 2 Dec 2004 01:07:13 +0100
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] tlbwr hazard for NEC VR4100
Message-ID: <20041202000713.GO3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> Hi Ralf,
> 
> This patch had added tlbwr hazard for NEC VR4100.
> Please apply this patch to 2.6.
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
> diff -urN -X dontdiff a-orig/arch/mips/mm/tlbex.c a/arch/mips/mm/tlbex.c
> --- a-orig/arch/mips/mm/tlbex.c	Tue Nov 30 20:42:08 2004
> +++ a/arch/mips/mm/tlbex.c	Wed Dec  1 23:23:11 2004
> @@ -820,6 +820,25 @@
>  		i_ssnop(p);
>  		break;
>  
> +	case CPU_VR4111:
> +	case CPU_VR4121:
> +	case CPU_VR4122:
> +	case CPU_VR4181:
> +	case CPU_VR4181A:
> +		i_nop(p);
> +		i_nop(p);
> +		i_tlbwr(p);
> +		i_nop(p);
> +		i_nop(p);
> +		break;
> +
> +	case CPU_VR4131:
> +	case CPU_VR4133:
> +		i_nop(p);
> +		i_nop(p);
> +		i_tlbwr(p);
> +		break;

If 64bit kernels are ever relevant for VR41xx, you might want to use
the same branch trick as it is used for R4[04]00. IIRC it reduced the
handler size from 34 to 30 instructions, saving another branch.

(If the XTLB refill handler doesn't fit in 32 instructions, it wraps
around to the 32bit TLB handler space and continues there. This costs
1-3 additional instructions.)


Thiemo
