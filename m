Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 19:15:05 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:40837 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225472AbTISSPC>; Fri, 19 Sep 2003 19:15:02 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA17729;
	Fri, 19 Sep 2003 20:14:46 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 20:14:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
In-Reply-To: <20030919174039.GK13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030919200133.9134N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2003, Thiemo Seufer wrote:

> >  What if the final link leads to segments being mapped outside the 32-bit
> > address range?  We won't know about it when assembling.
> 
> Then the resulting code is broken. It's the programmers responsibility
> to care about it. IMHO that's not a problem, this feature is only

 Sure, but some kind of aid, perhaps conditional, from tools would be
good.  The linker is already unconditionally picky about certain
properties of object files, e.g. it won't link a PIC and a PDC object
together, even if there are no relocations in them.  One could say it's a
programmer's responsibility, too. 

> useful for kernels, and the tricks currently done there are worse.

 No doubt.

> >  If the idea were to be implemented, there should be a flag added to the
> > header of object files that would forbid the linker to map addresses
> > outside the 32-bit range.
> 
> Please don't add any header flag. An additional (.note?) section would
> be nice, but is not a priority for me.

 Well, I might not really care of something I'm not going to use, but we
should try to assure some level of engineering quality whenever possible.
A flag vs a special section is alike to me.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
