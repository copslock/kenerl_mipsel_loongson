Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OFAGRw020930
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 08:10:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OFAGPt020929
	for linux-mips-outgoing; Wed, 24 Jul 2002 08:10:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OFA9Rw020919;
	Wed, 24 Jul 2002 08:10:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA00650;
	Wed, 24 Jul 2002 17:11:38 +0200 (MET DST)
Date: Wed, 24 Jul 2002 17:11:37 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
In-Reply-To: <3D3D9E5D.8080309@mvista.com>
Message-ID: <Pine.GSO.3.96.1020724170604.27732G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Jul 2002, Jun Sun wrote:

> This structure allows maximum code sharing for conforming CPUs and also give 
> an easy for unique ones or buggy, early-production ones.  It should also make 
> it easy to add or remove support for particular CPU or CPU family.  Of course, 
> more details need to be fleshed out.

 Go ahead, that sounds much reasonable.  Most of the hassle will be for
pre-MIPS32/64 processors, obviously.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
