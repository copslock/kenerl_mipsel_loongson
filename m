Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OEt2Rw020234
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 07:55:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OEt27N020233
	for linux-mips-outgoing; Wed, 24 Jul 2002 07:55:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OEssRw020220;
	Wed, 24 Jul 2002 07:54:55 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA29984;
	Wed, 24 Jul 2002 16:56:26 +0200 (MET DST)
Date: Wed, 24 Jul 2002 16:56:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] make PIIX4 ide driver available for MIPS
In-Reply-To: <20020724164602.E28010@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020724164937.27732E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Jul 2002, Ralf Baechle wrote:

> >  It's actually weird there are any CPU conditionals there at all.  The
> > PIIX4 is a generic PCI-ISA bridge after all, so it can be used on any
> > system equipped with a PCI bus.  DEC Alpha systems used to use Intel's
> > bridges for EISA and ISA busses as well.
> 
> I bet it's historical reasons and the whole architecture conditional
> plain should go away ...

 The explicit support for the PIIX family is relatively new, IIRC.  I
suppose it's rather the "it's an Intel, so obviously it works with an
Intel only" thinking.  I'm for the removal as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
