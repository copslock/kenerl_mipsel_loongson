Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 21:16:33 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:64284 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1122958AbSIETQc>; Thu, 5 Sep 2002 21:16:32 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17n22B-002SVZ-00; Thu, 05 Sep 2002 21:11:19 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17n271-0001iG-00; Thu, 05 Sep 2002 21:16:19 +0200
Date: Thu, 5 Sep 2002 21:16:19 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hartvig Ekner <hartvige@mips.com>,
	Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905191619.GV4194@rembrandt.csv.ica.uni-stuttgart.de>
References: <200209051807.g85I73W06904@coplin09.mips.com> <Pine.GSO.3.96.1020905204345.7444N-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905204345.7444N-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Hartvig Ekner wrote:
> 
> > The technical benefits of n32 over o32 are:
[snip]
> > * 64-bit datapath of CPU can be utilized with big impact on certain
> >   applications
> 
>  But an old program doesn't make use of them, so it won't normally
> benefit.

An o32 program using compiler synthesized 64 bit integers will
do so when recompiled for n32.


Thiemo
