Received:  by oss.sgi.com id <S42392AbQI2OHU>;
	Fri, 29 Sep 2000 07:07:20 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53938 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42190AbQI2OHN>;
	Fri, 29 Sep 2000 07:07:13 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24396;
	Fri, 29 Sep 2000 16:05:20 +0200 (MET DST)
Date:   Fri, 29 Sep 2000 16:05:20 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: RPM packages available
Message-ID: <Pine.GSO.3.96.1000929153254.23593A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 For anyone interested: I've made a few MIPS/Linux-related RPM packages
available.  Included, there are mipsel-linux native development tools,
libraries, as well as certain programs sort-of needed for a machine to run
interactively.  There are cross-development tools for the i386-linux host
and the mipsel-linux target.  Finally, there are host-independent
cross-development libraries for the mipsel-linux target.

 The binary packages expect glibc-2.1.3 or newer for the i386-linux system
and glibc-2.1.90 or newer for the mipsel-linux system to be available. 
Source packages generally expect glibc-2.1 or newer but were only built
using the versions mentioned above.  Exact requirements are provided in
every package separately.  Rpm-3.0 or newer is required to rebuild any of
them.

 Also available are rpm rc and macro files which I use for both native
builds and cross-compilations -- rpm doesn't support cross-compilations
directly (i.e. via a command line option) but might be configured
appropriately via macros provided spec files can handle them.

 All the above stuff is available at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/'. 
The server operates continuously, but during off-peak hours foreign hosts
receive greater bandwidth.  Off-peak hours are since 10pm till 8am, local
time, which is now CEST, i.e. UTC+0200.  During this time, the bottleneck
link has bandwidth of 10Mb/s. 

 The whole repository consumes about 170MB at the moment but the size may
vary as updates are uploaded.  If you find a package is missing (e.g.
there is a binary package, but no corresponding source one) please let me
know.  Any comments, updates and fixes are welcomed as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
