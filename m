Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 17:24:39 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:10221 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225413AbUANRYa>; Wed, 14 Jan 2004 17:24:30 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7AAB54C3A8; Wed, 14 Jan 2004 18:24:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 57C464C15E; Wed, 14 Jan 2004 18:24:25 +0100 (CET)
Date: Wed, 14 Jan 2004 18:24:25 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040114170001.GA20227@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401141808470.9549@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
 <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl> <20040113172751.GN9677@fs.tum.de>
 <Pine.LNX.4.55.0401141230400.1436@jurand.ds.pg.gda.pl>
 <20040114170001.GA20227@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jan 2004, Ralf Baechle wrote:

> >  Going back to the subject -- what's the problem with dependencies?
> 
> Nothing.  It was looking like you meant something else and me and Adrian
> got trapped by that.  Feel free to change it back to what it was but
> maybe "depends on MIPS32 || (MIPS64 && EXPERIMENTAL)" is less ambigous?

 I thought the construct triggered a problem elsewhere and the change was
supposed to work it around.  I'm pretty surprised you've forgotten I
ported the DECstation code to 64 bits -- it's already over a year and a
half since I did the first boot.

 I feel a bit hesitant about changing the expression, but perhaps I may
add a comment to the help text, on why it's experimental for 64-bit.  I
suspect hardly anyone will notice, though -- if built with unpatched tools
and run on a problematic processor the kernel complains and refuses to run
asking to contact <linux-mips@linux-mips.org> and nobody did that yet...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
