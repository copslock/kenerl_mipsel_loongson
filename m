Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56Hr9p09070
	for linux-mips-outgoing; Wed, 6 Jun 2001 10:53:09 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56HoVh08855
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 10:51:02 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA09122;
	Wed, 6 Jun 2001 19:48:25 +0200 (MET DST)
Date: Wed, 6 Jun 2001 19:48:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010606090816.C21351@lucon.org>
Message-ID: <Pine.GSO.3.96.1010606193612.2113E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, H . J . Lu wrote:

> There are many changes in gdb, especially in thread and C++ supports.
> We need those on mips also. I am willing to spend my time. But I need
> some help. I don't know much about mips :-(.

 It would be nice to have at least basic C support in mainline. 

> I'd like to get gdb working first. Do you have time to answer some
> questions?

 I often have time to write mails (but I don't have most of my development
resources here).  Feel free to ask -- I'll try to answer as I can.  I
haven't been into MIPS/Linux development tools for some time now, since
they are mostly working for me, so my memory might be vague.  I'm working
on the kernel mostly these days -- my primary goal is to find out why
Linux crashes hard when building binutils natively on my DECstation (the
progress is at a snail speed, unfortunately). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
