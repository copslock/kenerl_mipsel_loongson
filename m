Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMgro14354
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:42:53 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMgoV14351
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:42:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id AAA22415;
	Tue, 31 Jul 2001 00:45:10 +0200 (MET DST)
Date: Tue, 31 Jul 2001 00:45:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Dave Airlie <airlied@csn.ul.ie>, SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010731002421.A19713@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1010731003328.19618F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 31 Jul 2001, Jan-Benedict Glaw wrote:

> Of course. I wouldn't even *try* to do sth other. In fact, I'm looking
> around for various specs of various implementations (as seen from
> the bus) of the LANCE chip to see if I could manage the job to
> unify them all together:

 Yep, that would really be desireable, but there are quirks such as
third-party DMA controllers that must be taken into account when writing
generic chip support functions.  In the DECstation's case the DMA
controller is the I/O ASIC.

 It's probably doable by writing a generic backend and various interfaces
(see e.g. the 8390 driver), but much care must be taken.  And one must
work on the generic tree -- e.g. the Alan's one -- as otherwise changes
will be impossible to test by most of people.

> Well, I'll start off in merging in those two declance drivers. But

 Excellent.

> this will come no earlier that in two weeks or so. I'll first do
> the serial keyboard with dz.c.

 Excellent.

> PS: Looking at ~23 Am7990 and ~5 Z8530 drivers I think I should go to
>     *BSD :-) Who will ever attempt to clean up?

 Z8530 is on my to-do list.  Our driver really sucks: neither DMA (the I/O
ASIC again) nor sychronous mode, just basic asynchronous support.  I'm
going to look at LANCE one day, too, but it's lower on the list.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
