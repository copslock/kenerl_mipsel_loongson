Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 19:29:52 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:25052 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122165AbSKHS3w>; Fri, 8 Nov 2002 19:29:52 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA10834;
	Fri, 8 Nov 2002 19:30:15 +0100 (MET)
Date: Fri, 8 Nov 2002 19:30:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
In-Reply-To: <20021108183549.A9711@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1021108192005.3217J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 8 Nov 2002, Ralf Baechle wrote:

> >  Renaming CONFIG_SERIAL_CONSOLE to CONFIG_SGI_SERIAL_CONSOLE where
> > appropriate should suffice.
> 
> That's my part to fix, I guess.  However since not all SGI's are

 Yes, please -- I can do that myself, but it'd better be done by someone
familiar with SGI hardware, so that all details are handled right.

> using the Zilog 8530 for their serial interfaces I'll rename it
> CONFIG_IP22_SERIAL_CONSOLE.

 Well, the name of a variable doesn't matter (as my analysis professor
used to say). ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
