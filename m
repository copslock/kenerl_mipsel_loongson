Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KG50nC018610
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 09:05:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KG4xb7018608
	for linux-mips-outgoing; Mon, 20 May 2002 09:04:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4KG4snC018596
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 09:04:55 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01973;
	Mon, 20 May 2002 18:05:58 +0200 (MET DST)
Date: Mon, 20 May 2002 18:05:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Greg Lindahl <lindahl@keyresearch.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
In-Reply-To: <20020520085743.A1748@wumpus.keyresearch.com>
Message-ID: <Pine.GSO.3.96.1020520175955.19733H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 20 May 2002, Greg Lindahl wrote:

> >  Well, the surprise is going to happen in drivers, I'm afraid...
> 
> Linux drivers as a whole are 64-bit clean; alpha's been around for a
> long time. MIPS-only devices might be dirtier.

 Well, that is wishful thinking.  Obviously if a driver is actually used
on a 64-bit system, one can be moderately confident the driver is clean,
although there might still be corner cases.  Otherwise expect all kinds of
weirdness.  See e.g. the ISA stuff.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
