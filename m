Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IDVSR06547
	for linux-mips-outgoing; Wed, 18 Jul 2001 06:31:28 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IDVOV06540
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 06:31:26 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA10555;
	Wed, 18 Jul 2001 15:33:18 +0200 (MET DST)
Date: Wed, 18 Jul 2001 15:33:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: Harald Koerfgen <hkoerfg@web.de>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.5: DECstation LK201 keyboard non-functional
In-Reply-To: <Pine.LNX.4.32.0107172102470.3817-100000@skynet>
Message-ID: <Pine.GSO.3.96.1010718144016.8064B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 17 Jul 2001, Dave Airlie wrote:

> Well that file you've moved is still a DEC specific file .. all the arch
> non-specific stuff is in drivers/char/dz.c and drivers/tc/zs.c already..
> the decserial.c file does nothing for any other arch but the DECstation..
> 
> I'd rather it was fixed with the serial.c file in the old place... but
> hey I'm not exactly contributing a fix here so feel free to ignore this
> rant :-)

 I think the file can (and should) be removed altogether one day. 
Especially as it's not flexible enough, considering PMAC-A.  The stuff in
tty_io.c should handle a console on both kinds of serial chips fine, just
like it handles a number of other chips already, but it needs careful
checking of both drivers to handle all cases fine.  Improving the serial
drivers is on my to-do list, but don't hold your breath.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
