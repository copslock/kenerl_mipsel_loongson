Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 18:20:18 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:8835 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225472AbTISRUL>; Fri, 19 Sep 2003 18:20:11 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA16658;
	Fri, 19 Sep 2003 19:19:39 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 19:19:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <20030919170825.GJ13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030919190901.9134M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2003, Thiemo Seufer wrote:

> > > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > > Together with -mabi=64 this would produce optimized ELF64 output.
> > 
> >  Hmm, what do you exactly mean -- is that what I am worrying about?
> 
> The idea is to use the assembler's 32bit macro expansions for addresses.

 So it is...

> This reduces the .text size of a n64 kernel and improves the performance,
> without tricks like -Wa,32.

 What if the final link leads to segments being mapped outside the 32-bit
address range?  We won't know about it when assembling.

 If the idea were to be implemented, there should be a flag added to the
header of object files that would forbid the linker to map addresses
outside the 32-bit range.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
