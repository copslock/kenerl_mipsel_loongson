Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 02:16:50 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:60997
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225002AbUKXCQp>; Wed, 24 Nov 2004 02:16:45 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CWmi4-0007ur-00; Wed, 24 Nov 2004 03:16:44 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CWmi4-0008Ca-00; Wed, 24 Nov 2004 03:16:44 +0100
Date: Wed, 24 Nov 2004 03:16:44 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041124021644.GF902@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com> <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
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

Just FYI, I took the ssnop definition from _ssnop in
include/asm-mips/hazards.h, which is different from SSNOP in
include/asm-mips/asm.h. I hope the difference is not meant to
mean more than a typo. :-)


Thiemo
