Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LJ4JO08187
	for linux-mips-outgoing; Thu, 21 Mar 2002 11:04:19 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LJ49q08184
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 11:04:09 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA26129;
	Thu, 21 Mar 2002 19:04:11 +0100 (MET)
Date: Thu, 21 Mar 2002 19:04:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: declance multicast filter fixes
Message-ID: <Pine.GSO.3.96.1020321185116.22279D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Following are a few trivial fixes for the DECstation's LANCE driver
needed for the chip's multicast filter to be set up correctly.  The patch
is needed for multicast reception to work, in particular for the IPv6's
neighbor discovery.  The CRC generation was verified using the AMD's
reference code and it was checked at the run time for selected multicast
addresses as well.  Please apply. 

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020129-declance-mcast-11
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/drivers/net/declance.c linux-mips-2.4.17-20020129/drivers/net/declance.c
--- linux-mips-2.4.17-20020129.macro/drivers/net/declance.c	Wed Aug 22 04:27:03 2001
+++ linux-mips-2.4.17-20020129/drivers/net/declance.c	Tue Mar 19 19:42:20 2002
@@ -793,6 +793,8 @@ static int lance_open(struct net_device 
 	ib->mode = 0;
 	ib->filter [0] = 0;
 	ib->filter [2] = 0;
+	ib->filter [4] = 0;
+	ib->filter [6] = 0;
 
 	lance_init_ring(dev);
 	load_csrs(lp);
@@ -920,7 +922,7 @@ static void lance_load_multicast(struct 
 	struct dev_mc_list *dmi = dev->mc_list;
 	char *addrs;
 	int i, j, bit, byte;
-	u32 crc, poly = CRC_POLYNOMIAL_BE;
+	u32 crc, poly = CRC_POLYNOMIAL_LE;
 
 	/* set all multicast bits */
 	if (dev->flags & IFF_ALLMULTI) {
@@ -959,7 +961,7 @@ static void lance_load_multicast(struct 
 			}
 
 		crc = crc >> 26;
-		mcast_table[crc >> 3] |= 1 << (crc & 0xf);
+		mcast_table[2 * (crc >> 4)] |= 1 << (crc & 0xf);
 	}
 	return;
 }
