Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MEPtRw024570
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 07:25:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MEPtCp024569
	for linux-mips-outgoing; Mon, 22 Jul 2002 07:25:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MEPmRw024552
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 07:25:49 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA05975;
	Mon, 22 Jul 2002 16:27:00 +0200 (MET DST)
Date: Mon, 22 Jul 2002 16:27:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: [uHOWTO] Booting a DECstation via MOP
In-Reply-To: <20020720183919.GV8891@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020722161247.2373H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 20 Jul 2002, Jan-Benedict Glaw wrote:

> Instead of apt-get'ing a mopd, go to
> ftp://ftp.ds2.pg.gda.pl/pub/macro/mopd/ and download all of the files in
> this directory (this will be mopd-2.5.3 at this moment plus several
> patches. Extract the .tar.gz and apply all patches (you *may* need to
> fix some .rej's depending on the order you apply these patches).

 Thanks for appreciating my effort.  It's nice too see it's useful for the
others as well.

 For the right order of applying the patches see the README file there. 
;-)  Also there are ready to use RPM packages nearby.

> At least on my Alpha, I had to add '-DNOAOUT' to the CFLAGS in
> ./mopd-2.5.3/Makefile to let it compile. For booting a Linux kernel,
> this is not a problem. Compile it, start it (I started it as './mopd
> -a'), place your ELF Linux kernel (this is what normally gets generated
> in ./linux/vmlinux) in /tftpboot/mop/ and be happy.

 Cross-platform a.out support is tricky.  I'll check what is wrong with
the Alpha; otherwise that's the correct workaround.

 BTW, you need not edit any Makefile to change CC, CFLAGS or LDFLAGS --
you may override them at the command line, e.g. `make "CFLAGS=-O2
-DNOAOUT"'.  I've taken specific care for this to work.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
