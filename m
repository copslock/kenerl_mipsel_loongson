Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 18:08:38 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:32558
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225472AbTISRIc>; Fri, 19 Sep 2003 18:08:32 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A0Ok5-0003O6-00; Fri, 19 Sep 2003 19:08:25 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A0Ok5-0003lM-00; Fri, 19 Sep 2003 19:08:25 +0200
Date: Fri, 19 Sep 2003 19:08:25 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030919170825.GJ13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030919184248.9134L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030919184248.9134L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 19 Sep 2003, Thiemo Seufer wrote:
> 
> > > OK as in "it works for me", and OK as in "this is the correct usage" are
> > > two different things. I believe that for a 64-bit kernel either -mabi=64
> > > or -mabi=n32 (-mlong64) are the right long term answer,
> > 
> > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > Together with -mabi=64 this would produce optimized ELF64 output.
> 
>  Hmm, what do you exactly mean -- is that what I am worrying about?

The idea is to use the assembler's 32bit macro expansions for addresses.
This reduces the .text size of a n64 kernel and improves the performance,
without tricks like -Wa,32.


Thiemo
