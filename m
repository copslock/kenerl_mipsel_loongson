Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86CUES15465
	for linux-mips-outgoing; Thu, 6 Sep 2001 05:30:14 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86CTPd15444
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 05:29:25 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA29203;
	Thu, 6 Sep 2001 14:31:45 +0200 (MET DST)
Date: Thu, 6 Sep 2001 14:31:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: linux 2.4.8: The DECstation 5000/2x0 NVRAM module driver
Message-ID: <Pine.GSO.3.96.1010906141756.28792A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 I've prepared a syntactic update to the DECstation 5000/2x0 NVRAM module
driver for linux 2.4.8.  There are no functional changes at the moment. 
The driver patch and supplementary changes are available at:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/ms02-nv/'.  

 I'm looking for a tester with a DECstation 5000/200 and a MS02 NVRAM
module.  I'm going to improve the module detection code in the next
version to make it less firmware-dependent.  This is needed to support
multiple modules as well as single modules in non-standard slots.  I need
to make sure I can rely on bus error exceptions just like in the /240. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
