Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JCW3Rw006059
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 05:32:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JCW3Nk006058
	for linux-mips-outgoing; Mon, 19 Aug 2002 05:32:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JCVuRw006049
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 05:31:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15593
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 14:35:20 +0200 (MET DST)
Date: Mon, 19 Aug 2002 14:35:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <200208130138.g7D1cYk3010974@oss.sgi.com>
Message-ID: <Pine.GSO.3.96.1020819141201.14441C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 12 Aug 2002, Ralf Baechle wrote:

> Modified files:
> 	arch/mips      : config-shared.in defconfig defconfig-decstation 
> 	                 defconfig-ip22 defconfig-nino defconfig-osprey 
> 	                 defconfig-sb1250-swarm defconfig-sead 
> 	arch/mips64    : defconfig-ip22 defconfig-sb1250-swarm 
> 	                 defconfig-sead 
> 
> Log message:
> 	Make CONFIG_IDE selectable independant of the bus type.

 Hmm, what's the intent of the change?  IDE, or more properly ATA, was
originally an ISA-only device and is still only available as ISA-style
implementations, AFAIK.  I'd prefer it to be available only if any of
CONFIG_ISA, CONFIG_EISA, CONFIG_PCI (unsure about CONFIG_MCA) is set.

 That said, the place for such decisions seems to be inappropriate
currently.  It'd be much more elegant just to source all relevant drivers,
net, etc. Config.in scripts unconditionally and make global enable/disable
decisions at the top of the relevant script, like e.g. 
drivers/message/i2o/Config.in already does. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
