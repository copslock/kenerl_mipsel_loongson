Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 16:50:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:5860 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225220AbTDYPup>; Fri, 25 Apr 2003 16:50:45 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA14880
	for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 17:51:26 +0200 (MET DST)
Date: Fri, 25 Apr 2003 17:51:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: Re: [patch] wait instruction on vr4181
In-Reply-To: <20030425154112.GK19131@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030425174751.14121C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 25 Apr 2003, Thiemo Seufer wrote:

> >  But if I try to build for anything else, say for R3k or MIPS64, there
> > will be "-mcpu=r3000" or "-mcpu=r4600" passed and an assembly will fail as
> > the "standby" instruction won't magically disappear.  That's why
> > r4k_wait() and au1k_wait() use ".set mips3" for "wait". 
> 
> The relevant function was #ifdef'ed.

 Whis clutters the source and shouldn't be there IMO.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
