Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 15:19:31 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:42474 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDDOTa>; Fri, 4 Apr 2003 15:19:30 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA09630;
	Fri, 4 Apr 2003 16:19:45 +0200 (MET DST)
Date: Fri, 4 Apr 2003 16:19:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@linux-mips.org
Subject: Re: Unknown ARCS message/hang
In-Reply-To: <20030404131935.GF11906@bogon.ms20.nix>
Message-ID: <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Apr 2003, Guido Guenther wrote:

> > > Obtaining /vmlinux.64 from server
> > > 1813568+1150976+172144 entry: 0xa8000000211c4000
> > > 
> > > *** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018 RA=0xffffffff9fc5ace4
> [..snip..] 
> > 
> >  0x211c4018 is a mapped address, which you can't use that early in a boot.
> Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
> seems to look at the lower 32bits of PC though.

 0xa8000000211c4000 is indeed in XKPHYS but the code jumps to 0x211c4018.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
