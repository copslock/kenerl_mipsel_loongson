Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 22:01:44 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:34608
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224941AbTLWWBn>; Tue, 23 Dec 2003 22:01:43 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AYuay-0002nd-00; Tue, 23 Dec 2003 23:01:40 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AYuay-00039E-00; Tue, 23 Dec 2003 23:01:40 +0100
Date: Tue, 23 Dec 2003 23:01:40 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@ds2.pg.gda.pl, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
Message-ID: <20031223220140.GO12050@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl> <20031223.220213.74756743.anemo@mba.ocn.ne.jp> <20031223204405.GL12050@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223204405.GL12050@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Atsushi Nemoto wrote:
> [snip]
> > >>>>> On Tue, 16 Dec 2003 22:33:41 +0100 (CET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
> > macro>  The patch implements a make macro called set_gccflags which
> > macro> accepts two sets of options consisting of a CPU name and an ISA
> > macro> name each.  Within both sets "-march=" and failing that
> > macro> "-mcpu=" is checked with the CPU name and the ISA name is
> > macro> checked simultaneously.  For gcc if the first set of options
> > macro> fails, the second one is selected even if it would lead to a
> > macro> failure.  For gas both sets are checked and if none succeeds,
> > macro> an empty set is selected.
> > 
> > With this patch, most r4k use MIPS3 ISA, right?
> 
> Since -mips2 is retained they actually use -march=r6000 and still
> MIPS2 ISA.

Well, I should actually read the code instead of speculating. :-)
Now it is -mips3, which means -march=r4000. All _MIPS_ISA defines
abused to check for the O32 ABI are broken now.


Thiemo
