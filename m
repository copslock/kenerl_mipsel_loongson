Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56JZ5s20220
	for linux-mips-outgoing; Wed, 6 Jun 2001 12:35:05 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56JZ4h20209
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 12:35:04 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06629
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 12:27:26 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA10913;
	Wed, 6 Jun 2001 20:40:08 +0200 (MET DST)
Date: Wed, 6 Jun 2001 20:40:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010606110019.A23009@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010606203714.10246B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, Daniel Jacobowitz wrote:

> I've actually spent this week porting the gdb CVS head to MIPS; I've
> got it almost entirely working now.  There's one problem with SIGTRAP

 Make sure your kernel is flushing the icache right. 

> that I haven't quite figured out yet, and thread attach isn't quite
> working, and there's a kernel bug I've been repeatedly triggering that
> I think I just fixed.  I anticipate it all being done in a couple of
> days - I'll post here and on the GDB list when I have it in slightly
> better shape.

 Great!  Did you do you work from scratch -- hopefully not?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
