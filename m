Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 15:56:38 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:8993
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224897AbUKVP4d>; Mon, 22 Nov 2004 15:56:33 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CWGYK-0005vQ-00; Mon, 22 Nov 2004 16:56:32 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CWGYJ-0002o1-00; Mon, 22 Nov 2004 16:56:31 +0100
Date: Mon, 22 Nov 2004 16:56:31 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041122155631.GD902@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0411221428330.31113@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411221428330.31113@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 21 Nov 2004, Thiemo Seufer wrote:
> 
> > Aww, fatal error in the spelling module. :-)
> > Updated.
> 
>  Great stuff!  Thanks a lot.  I gave it some testing on hardware available 
> to me and it works just fine.  I've got a couple of warnings upon 
> building, though:
> 
> arch/mips/mm/tlbex.c:500: warning: 'i_LA' defined but not used
> arch/mips/mm/tlbex.c:568: warning: 'insn_has_bdelay' defined but not used
> arch/mips/mm/tlbex.c:582: warning: 'il_bltz' defined but not used
> arch/mips/mm/tlbex.c:588: warning: 'il_b' defined but not used
> 
> How about marking them "attribute((unused))"?  I can do that if you agree.

Please do so, but IIRC there's a compiler-independent Linux-specific
define which is preferable. Newest gcc just removes unused static
functions without further notice, AFAIK.


Thiemo
