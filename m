Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KC0NEC024990
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 05:00:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KC0NVc024989
	for linux-mips-outgoing; Tue, 20 Aug 2002 05:00:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KC0HEC024980
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 05:00:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA10473;
	Tue, 20 Aug 2002 14:03:42 +0200 (MET DST)
Date: Tue, 20 Aug 2002 14:03:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Linux on RM600
In-Reply-To: <20020816092912.GF10730@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020820134109.8700C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 16 Aug 2002, Jan-Benedict Glaw wrote:

> Flo has got EB, you've got EL. I once again think about an archive of
> EPROM, EEPROM and flash contents... That would especially also help
> those broken /240 with MOP-only firmware...

 Well, MOP actually works reasonably and is overall better supported by
DEC hardware (consider non-working ARP).  Then there is a legal problem --
the license doesn't permit redistribution.

 That said, I have snapshots of: KN03-AA V5.1b (TFTP broken), KN03-AA
V5.2b (OK) and KN05 V2.1k (OK), as well as of PMAG-CA V5.3a.  I have
images of the host accessible areas of: PMAF-AA 5.2 (ROM rev. 1.0,
firmware rev. 1.1) and PMAGB-BA V1.1, but they are flashable and the
layout may be incorrect for the respective flashers, especially the former
lacks m68k firmware.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
