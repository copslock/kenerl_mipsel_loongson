Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 17:02:38 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:46761 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225315AbUAMRC0>; Tue, 13 Jan 2004 17:02:26 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 658794C3A9; Tue, 13 Jan 2004 18:02:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 519D947607; Tue, 13 Jan 2004 18:02:22 +0100 (CET)
Date: Tue, 13 Jan 2004 18:02:22 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040113163934.GB31459@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401131752380.3158@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
 <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
 <20040113163934.GB31459@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 13 Jan 2004, Ralf Baechle wrote:

> >  The dependency was intentional: stable for 32-bit, experimental for
> > 64-bit.  I'm reverting the change immediately.  Please always contact me
> > before applying non-obvious changes for the DECstation.
> 
> Well, this one seemed to be obvious but sometimes things are not what
> they seem to be ...

 Hmm, a change of semantics wouldn't qualify as obvious for me...

 I admit this construct may seem surprising at first sight when compared
to many other uses of EXPERIMENTAL -- the equivalent more verbose syntax
used for 2.4 leaves no doubt about the intent, though.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
