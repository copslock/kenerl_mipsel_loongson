Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I81L8d027465
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 01:01:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I81Leb027464
	for linux-mips-outgoing; Thu, 18 Apr 2002 01:01:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I81G8d027456
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 01:01:17 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA20923;
	Thu, 18 Apr 2002 10:02:35 +0200 (MET DST)
Date: Thu, 18 Apr 2002 10:02:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Dave Airlie <airlied@csn.ul.ie>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: declance: add module support, miscellanea
Message-ID: <Pine.GSO.3.96.1020418094401.20187C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 I've made several updates to the declance driver:

1. Module support.  Tested for an I/O ASIC setup (/240).  Changes seem to
work well both as a module and when built-in.

2. Multiple interface support.  While it should work in principle, its
operation is impossible until PMAD-xx support is fixed.

3. Various fixes and clean-ups, including preparations to merge PMAD-xx
changes by Dave.

 Due to a considerable size of the patch I'm not including it here.  It's
available at:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/patch-mips-2.4.18-20020412-declance-11.gz'. 
For module support the "system_base" patch is required.  It was sent to
the list and is also available at the above address.

 I'd be pleased to hear from 2100/3100 users if the driver works fine for
them. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
