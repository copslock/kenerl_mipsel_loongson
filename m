Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I7gN8d024471
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 00:42:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I7gNsG024470
	for linux-mips-outgoing; Thu, 18 Apr 2002 00:42:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I7gH8d024460
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 00:42:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA20496;
	Thu, 18 Apr 2002 09:43:30 +0200 (MET DST)
Date: Thu, 18 Apr 2002 09:43:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: [patch] linux: Export the DECstation's "system slot" address
Message-ID: <Pine.GSO.3.96.1020418093916.20187B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is a trivial patch to export the base address of the "system slot" 
of TURBOchannel systems.  Needed if the declance driver is to be
modularized. 

 Ralf, please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-mips-2.4.18-20020412.macro/drivers/tc/tc.c linux-mips-2.4.18-20020412/drivers/tc/tc.c
--- linux-mips-2.4.18-20020412.macro/drivers/tc/tc.c	2002-04-10 02:58:49.000000000 +0000
+++ linux-mips-2.4.18-20020412/drivers/tc/tc.c	2002-04-17 00:53:43.000000000 +0000
@@ -247,4 +247,4 @@ EXPORT_SYMBOL(release_tc_card);
 EXPORT_SYMBOL(get_tc_base_addr);
 EXPORT_SYMBOL(get_tc_irq_nr);
 EXPORT_SYMBOL(get_tc_speed);
-
+EXPORT_SYMBOL(system_base);
