Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 15:51:01 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:52323
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225272AbUEOOvA>; Sat, 15 May 2004 15:51:00 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BP0V6-0001DM-00; Sat, 15 May 2004 16:50:56 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BP0V6-0008Ax-00; Sat, 15 May 2004 16:50:56 +0200
Date: Sat, 15 May 2004 16:50:56 +0200
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: XKPHYS_KERNEL patch - kernel in 64-bit space
Message-ID: <20040515145056.GC14219@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.4.10.10405151626200.27563-200000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10405151626200.27563-200000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
[snip]
> diff -urN linux-mips-cvs-mdules/arch/mips/mm/tlb-andes.c linux-mips-xkphys/arch/mips/mm/tlb-andes.c
> --- linux-mips-cvs-mdules/arch/mips/mm/tlb-andes.c	Wed Mar 17 22:26:44 2004
> +++ linux-mips-xkphys/arch/mips/mm/tlb-andes.c	Sat May 15 16:09:42 2004
> @@ -264,7 +264,7 @@
>  #endif
>  #ifdef CONFIG_MIPS64
>  	memcpy((void *)(CKSEG0 + 0x000), &except_vec0_generic, 0x80);
> -	memcpy((void *)(CKSEG0 + 0x080), except_vec1_r10k, 0x80);
> +	memcpy((void *)(CKSEG0 + 0x080), &except_vec1_r10k, 0x80);
>  	flush_icache_range(CKSEG0 + 0x80, CKSEG0 + 0x100);

This flush_icache_range should start from CKSEG0, not (CKSEG0 + 80).


Thiemo
