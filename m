Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 18:40:50 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:48686
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225472AbTISRkr>; Fri, 19 Sep 2003 18:40:47 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A0PFH-0003eu-00; Fri, 19 Sep 2003 19:40:39 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A0PFH-0001ZG-00; Fri, 19 Sep 2003 19:40:39 +0200
Date: Fri, 19 Sep 2003 19:40:39 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030919174039.GK13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030919170825.GJ13578@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030919190901.9134M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030919190901.9134M-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 19 Sep 2003, Thiemo Seufer wrote:
> 
> > > > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > > > Together with -mabi=64 this would produce optimized ELF64 output.
> > > 
> > >  Hmm, what do you exactly mean -- is that what I am worrying about?
> > 
> > The idea is to use the assembler's 32bit macro expansions for addresses.
> 
>  So it is...
> 
> > This reduces the .text size of a n64 kernel and improves the performance,
> > without tricks like -Wa,32.
> 
>  What if the final link leads to segments being mapped outside the 32-bit
> address range?  We won't know about it when assembling.

Then the resulting code is broken. It's the programmers responsibility
to care about it. IMHO that's not a problem, this feature is only
useful for kernels, and the tricks currently done there are worse.

>  If the idea were to be implemented, there should be a flag added to the
> header of object files that would forbid the linker to map addresses
> outside the 32-bit range.

Please don't add any header flag. An additional (.note?) section would
be nice, but is not a priority for me.


Thiemo
