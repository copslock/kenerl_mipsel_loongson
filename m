Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 23:28:10 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6797 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1124260AbSKTW2J>; Wed, 20 Nov 2002 23:28:09 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA10724;
	Wed, 20 Nov 2002 23:28:27 +0100 (MET)
Date: Wed, 20 Nov 2002 23:28:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org, linux-vax@mithra.physics.montana.edu
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: [announce] MOP support for FDDI
Message-ID: <Pine.GSO.3.96.1021120223710.5853F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 This may be of interest to DECstation and VAX users.

 I did some work on mopd sources recently again.  As a result, it is now
possible to boot a system over a FDDI link.  I was able to successfully
boot my DECstation 5000/240 using its DEC FDDIcontroller 700 (aka
DEFZA-AA) from my i386-based development box using a DEC
FDDIcontroller/PCI (DEFPA-AB).  The performance is not astonishing,
supposedly due to the funky hardware and firmware of the DEFZA -- a kernel
loads about 1.5 times longer than via the onboard Ethernet (LANCE) 
interface, even though both interfaces request the same packet length for
incoming packets.  A DEC FDDIcontroller/TURBOchannel (DEFTA-xx) would
likely perform much better. 

 I suppose a VAX equipped with a TURBOchannel adapter and either of the
controllers would be able to boot using it as well.  And similarly for the
native FDDI interfaces (DEC FDDIcontroller 400, aka DEMFA, etc.). 

 Both MOP version 3 and 4 are supported.  While the DEFZA uses version 3,
differences between the versions are minimal (different SNAP protocol
IDs), so even though untested, version 4 should just work, too.

 Apart from adding FDDI support, I did a few clean-ups.  One detail to
note is mopd now binds packet sockets it creates to specific interfaces. 
As a result response packets are only directed to the interface requests
come from.  There is a drawback of the change, though -- if any of the
interfaces mopd listens on gets down, the daemon dies.  This is yet to be
resolved. 

 Raw patches as well as RPM packages (source, mipsel and i386) are
available at the usual places -- the master site is at
'ftp://ftp.ds2.pg.gda.pl/pub/macro/'.

 Please cc replies, if any, to the linux-mips list or to me directly. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
