Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 20:32:04 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:57415
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225804AbUDMTcD>; Tue, 13 Apr 2004 20:32:03 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BDTdX-00065a-00
	for <linux-mips@linux-mips.org>; Tue, 13 Apr 2004 21:31:59 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BDTdW-0004up-00
	for <linux-mips@linux-mips.org>; Tue, 13 Apr 2004 21:31:58 +0200
Date: Tue, 13 Apr 2004 21:31:58 +0200
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] catch "new" gcc 3.4.0 sections
Message-ID: <20040413193158.GO27939@rembrandt.csv.ica.uni-stuttgart.de>
References: <028001c4218c$6d792350$8d01010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028001c4218c$6d792350$8d01010a@prefect>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Bradley D. LaRonde wrote:
> Building with gcc 3.4.0 emits a couple new sections, .rodata.cst4 and
> .rodata.str1.4, which the current ld.script doesn't contemplate.  Here is a
> patch to catch them (and maybe some other latent ones).
> 
> Anyone know why or when these sections are emitted?

I'd guess to keep differently aligned strings in separate sections,
as a preliminary for improved string merging.

> Regards,
> Brad
> 
> 
> diff -u -r1.1.1.1 ld.script.in
> --- arch/mips/ld.script.in      10 Nov 2003 21:06:52 -0000      1.1.1.1
> +++ arch/mips/ld.script.in      13 Apr 2004 19:18:25 -0000
> @@ -11,6 +11,11 @@
>      *(.text)
>      *(.rodata)
>      *(.rodata1)
> +    *(.rodata.str1.1);
> +    *(.rodata.str1.4);
> +    *(.rodata.str1.32);
> +    *(.rodata.cst4);
> +    *(.rodata.cst8);

Why not just *(.rodata*); ?


Thiemo
