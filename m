Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TH5vj22511
	for linux-mips-outgoing; Mon, 29 Oct 2001 09:05:57 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TH5l022502
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 09:05:47 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA12748;
	Mon, 29 Oct 2001 18:05:24 +0100 (MET)
Date: Mon, 29 Oct 2001 18:05:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: linux-mips@oss.sgi.com
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
cc: linux-vax@mithra.physics.montana.edu
Subject: FYI: Mopd ELF support
Message-ID: <Pine.GSO.3.96.1011029170937.3407G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 I've made a preliminary version of mopd with ELF support available.  It's
Mats O. Jansson's mopd 2.5.3 with several fixes, updates and enhancements.
The work is definitely not finished, but basic functionality is already
implemented.  I'm making it available due to the amount of PITA
maintenance of traditional mopd image formats incurs, in hope someone will
find it useful.  Libelf is required for this version of mopd.  It should
build and run on any Linux system, regardless of endianness.  It might
work on other systems as well.

 I've made RPM packages available at the usual place (i.e. 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/').  Beside source packages there are
i386 and mipsel binary ones available.  Grab the latest version; olders
are for a reference only.  To aid people with no RPM support in their
systems I've unpacked the source package into the "mopd" directory.  Still
you need to study the .spec file to figure how to build binaries. 

 Any feedback will be appreciated; I'm especially interested in reports
from VAX users, as I've only been able to verify the operation booting
Linux on a DECstation 5000 (i.e. MIPS) system.  Note: this version of mopd
does not require switching devices into the PROMISC or ALLMULTI modes of
operation. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
