Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OEgQRw019873
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 07:42:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OEgQhf019872
	for linux-mips-outgoing; Wed, 24 Jul 2002 07:42:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OEgMRw019863
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 07:42:23 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA29460;
	Wed, 24 Jul 2002 16:43:40 +0200 (MET DST)
Date: Wed, 24 Jul 2002 16:43:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] make PIIX4 ide driver available for MIPS
In-Reply-To: <3D3DF04E.7070401@mvista.com>
Message-ID: <Pine.GSO.3.96.1020724164114.27732D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Jul 2002, Jun Sun wrote:

> Malta uses this chip.  The native driver does provide significant gain in 
> performance.  See attached bonnie++ test results.

 It's actually weird there are any CPU conditionals there at all.  The
PIIX4 is a generic PCI-ISA bridge after all, so it can be used on any
system equipped with a PCI bus.  DEC Alpha systems used to use Intel's
bridges for EISA and ISA busses as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
