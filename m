Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:35:51 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225555AbSLWLed>; Mon, 23 Dec 2002 11:34:33 +0000
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:19851 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S868816AbSLUVbJ>; Sat, 21 Dec 2002 22:31:09 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA10315;
	Sat, 21 Dec 2002 22:28:02 +0100 (MET)
Date: Sat, 21 Dec 2002 22:28:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
In-Reply-To: <m2lm2jdtl5.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021221221459.7158C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 21 Dec 2002, Juan Quintela wrote:

> BTW, are you using mips64 in a r4k? If so, do you need any additional
> patches?

 Yep, for quite some time now, running a DECstation 5000/260 with an
R4400SC.  Yep, a few. 

 I'm merging the patches slowly, but it's not that easy.  Errata for the
R4000 and the R4400 require toolchain changes and bits in the patches
depend on fixed tools.  So chances are I won't merge everything until
changes are applied to tools. 

> I am having some memory corruption :(

 What kind of?  And what processor (PRId) have you got? 

 My system seems reasonably stable, but sometimes it crashes under a load.
I have yet to get at tracking the problem down.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
