Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 01:41:05 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:1093
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225002AbUKXBk6>; Wed, 24 Nov 2004 01:40:58 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CWm9S-0007az-00; Wed, 24 Nov 2004 02:40:58 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CWm9R-00081j-00; Wed, 24 Nov 2004 02:40:57 +0100
Date: Wed, 24 Nov 2004 02:40:57 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de>
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
X-archive-position: 6429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 22 Nov 2004, Manish Lachwani wrote:
> 
> > However, the crash still occurs. I dont think your patch was intended to 
> > fix the problem that I see below (resulting in crash).
> 
>  Certainly, it wasn't, but it couldn't have hurt, either.
> 
> > Data bus error, epc == 801f83b8, ra == 80323f04
> 
>  The reason are cp0 hazards, likely leading to an incorrect mapping.  Try
> the following patch; already applied to the mainline as obviously correct.
[snip]
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

Does r24k really need both delays? If not, it should get its own case.
Probably it should be separated even if it is identical, the code above
is nothing but a guess based on preexisting code.


Thiemo
