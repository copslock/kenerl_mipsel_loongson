Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MFGXY12108
	for linux-mips-outgoing; Fri, 22 Feb 2002 07:16:33 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MFGH912102
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 07:16:18 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08019;
	Fri, 22 Feb 2002 15:10:55 +0100 (MET)
Date: Fri, 22 Feb 2002 15:10:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: kevink@mips.com, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <20020222.113634.45519920.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1020222150523.5266E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 22 Feb 2002, Atsushi Nemoto wrote:

> The contradiction is came from some confusion about usage of a word
> "Core" in TX39 manual.  Maybe a writer of the quoted statements
> assumes a write buffer is outside of a "R3900 Processor Core".  So if
> he said "operation is completed" it means "data are sent to a write

 That's how I understand it.

> buffer".  Of course this point of view is not acceptable for software
> programmers...

 If we handle it for the DECstation, we can do so for the TX39 as well.

> macro> It's clear "sync" is strong on the TX39, stronger then required
> macro> by MIPS II.
> 
> So unfortunately this is not true.

 It is, considering the write buffer is actually external to the CPU. 
It's even required to be executed before checking the write buffer, as
otherwise you may get a false positive result. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
