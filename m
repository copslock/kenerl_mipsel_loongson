Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMvso14656
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:57:54 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMvqV14650
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:57:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id BAA22733;
	Tue, 31 Jul 2001 01:00:16 +0200 (MET DST)
Date: Tue, 31 Jul 2001 01:00:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Dave Airlie <airlied@csn.ul.ie>, SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010731004556.C19713@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1010731005417.19618H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 31 Jul 2001, Jan-Benedict Glaw wrote:

> You you facing towards all those Z8530 implementation or only to
> "ours"?

 I'd like to merge all of them, of course.  Especially as working on a
single driver only might prevent me from seeing certain device-specific
quirks that have to be handled in a non-conflicting way.  For example the
Z8530 application as used by DEC has a few "interesting" details when it
comes to chip's wiring.

 Don't hold your breath, though... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
