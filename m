Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 15:48:36 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:57777 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225197AbTDCOsg>; Thu, 3 Apr 2003 15:48:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23198;
	Thu, 3 Apr 2003 16:48:22 +0200 (MET DST)
Date: Thu, 3 Apr 2003 16:48:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030403162428.A2460@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030403163046.19058F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 3 Apr 2003, Ralf Baechle wrote:

> I know of one machine where changing the size of the cacheline is supposed
> not to work, that's the MIPS Magnum 4000 and it's close relatives.

 Hmm, why -- is such a change observable externally in any way?  Of
course you can't switch the other way if the s-cache uses a line width of
16 bytes.  Maybe that's the case with the Magnum?

> Anyway, I put the check there for the unlikely case there are broken
> systems out there.  In practice I assume vendors were aware of this
> problem and the check is purely theoretical and for paranoid correctness's
> sake.

 Still V3.0 should be taken into account.

> It seems like changing the configuration to larger cache lines where
> possible should improve performance somewhat.  If all the cache code is

 Why?  It isn't that obvious especially as a p-cache miss costs a single
cycle only.

> working truly correct we also should no longer see VCE exceptions on
> R4000SC processors - the reason why Indys are still a valuable test tool.

 As are DECstations which use the opposite endianness -- so you can test
code both ways.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
