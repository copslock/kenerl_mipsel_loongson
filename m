Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FDD7N17489
	for linux-mips-outgoing; Fri, 15 Feb 2002 05:13:07 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FDCc917484
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 05:12:39 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA01131;
	Fri, 15 Feb 2002 13:11:16 +0100 (MET)
Date: Fri, 15 Feb 2002 13:11:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <006e01c1b606$27b1b060$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1020215130906.29773C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Kevin D. Kissell wrote:

> So I think that the Linux code was perfectly correct in considering
> the TX39 to be without SYNC, just as a Vr4101 must be
> consdered to be without LL/SC.  They decode the instructions,
> but they don't actually implement them as specified.

 The code is not correct if "bc0f" is needed to be sure a write-back
happened.  If that is the case, the processors need their own wbflush() 
implementation like R2k/R3k configurations in older DECstations. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
