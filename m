Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UK2oe11267
	for linux-mips-outgoing; Mon, 30 Jul 2001 13:02:50 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UK2mV11264
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 13:02:48 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA20045;
	Mon, 30 Jul 2001 22:05:00 +0200 (MET DST)
Date: Mon, 30 Jul 2001 22:04:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010729021400.C6113@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010730215708.19618A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 29 Jul 2001, Florian Lohoff wrote:

> If its a TC base address all addresses must be below 128*1024 as
> a TC Slot IIRC has a 128K Window.

 Nope, it's system-dependent, with 1MB being the minimum specified (and
4MB being the real minimum implemented, IIRC).  There actually exist TC
boards that make use of more than 1MB of address space.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
