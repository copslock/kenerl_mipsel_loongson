Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 19:09:03 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:18399 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225242AbTENSJB>; Wed, 14 May 2003 19:09:01 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA02257;
	Wed, 14 May 2003 20:09:42 +0200 (MET DST)
Date: Wed, 14 May 2003 20:09:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
In-Reply-To: <20030514175011.GD8833@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030514195854.26213L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2003, Thiemo Seufer wrote:

> >  Well, "32" is 32-bit address/data and "64" is 64-bit address/data. 
> > That's essentially pure 32-bit and 64-bit, respectively.  Of course some
> > data format has to be emitted by tools, so there has to be an ABI
> > associated with each of these variants. 
> 
> That's just backwards. An ABI defines much more, e.g. calling
> conventions and GOT sizes. The register size is just another
> property of the ABI.

 OK -- maybe I am biased because there is only a single ABI for 32-bit and
64-bit binaries each.  So please just forget it.

> What's desireable here depends on the target system. For Linux,
> the current way is IMHO the best: o32 only for mips-linux, and
> o32, n32 and n64 for mips64-linux, with n32 as default.

 Of course the choice of the default should be configurable (for binutils
it probably already is -- I recall Richard Sandiford making changes in
this area, for gcc -- no idea).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
