Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DApTd08360
	for linux-mips-outgoing; Fri, 13 Jul 2001 03:51:29 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DApKV08350;
	Fri, 13 Jul 2001 03:51:21 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA03973;
	Fri, 13 Jul 2001 12:52:56 +0200 (MET DST)
Date: Fri, 13 Jul 2001 12:52:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010712224520.C23062@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 12 Jul 2001, Ralf Baechle wrote:

> There is a bunch of patches for ll/sc and MIPS_ATOMIC_SET floating around.
> I came to the conclusion that I don't like any of them so I'm just working
> on fixing the thing once and for all.

 What about the _test_and_set syscall?  Having it implemented we could get
rid of the MIPS_ATOMIC_SET hack for post-2.4.  Glibc may be made ready for
the transition any time now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
