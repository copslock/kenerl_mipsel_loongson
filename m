Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 17:47:04 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:32897 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225472AbTISQqw>; Fri, 19 Sep 2003 17:46:52 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA15879;
	Fri, 19 Sep 2003 18:46:31 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 18:46:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030919184248.9134L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2003, Thiemo Seufer wrote:

> > OK as in "it works for me", and OK as in "this is the correct usage" are
> > two different things. I believe that for a 64-bit kernel either -mabi=64
> > or -mabi=n32 (-mlong64) are the right long term answer,
> 
> A third answer is to add a -msign-extend-addresses switch in the assembler.
> Together with -mabi=64 this would produce optimized ELF64 output.

 Hmm, what do you exactly mean -- is that what I am worrying about?

> > part of Daniel's
> > problem was that his bootloader couldn't deal with ELF64.
> 
> Well, implementing an ELF64 bootloader ins't that hard. :-)

 That depends on how hard it's to replace some firmware.  Using a
secondary boot loader is not always feasible, either.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
