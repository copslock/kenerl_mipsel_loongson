Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 12:38:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13713 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225206AbTEOLio>; Thu, 15 May 2003 12:38:44 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA16131;
	Thu, 15 May 2003 13:39:30 +0200 (MET DST)
Date: Thu, 15 May 2003 13:39:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
In-Reply-To: <20030514184256.GE8833@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030515133141.16026A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2003, Thiemo Seufer wrote:

> >  Of course the choice of the default should be configurable (for binutils
> > it probably already is
> 
> It isn't, and probably will never be. Of course you could introduce
> just another configuration, with the bfd vector of your choice as
> default.

 Hmm, I would assume "mipsn32*-linux" defaults to n32 and "mips64*-linux" 
-- to (n)64.  It isn't the case, indeed.

> > -- I recall Richard Sandiford making changes in
> > this area, for gcc -- no idea).
> 
> It would also need a different config which defines a different
> MIPS_DEFAULT_ABI.

 I will do the change as described above when I am working on mips64
glibc.  Also config.guess will probably have to be updated to be capable
to determine which one of these two configurations is used in a given
system, so that one need not specify "--build=" to get what is desired.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
