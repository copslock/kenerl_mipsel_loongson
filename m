Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EFY4P30772
	for linux-mips-outgoing; Fri, 14 Sep 2001 08:34:04 -0700
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EFXwe30769
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 08:34:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA03025;
	Fri, 14 Sep 2001 16:42:47 +0200 (MET DST)
Date: Fri, 14 Sep 2001 16:42:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kjeld Borch Egevang <kjelde@mips.com>
cc: linux-mips@oss.sgi.com
Subject: RE: Error in gcc version 2.96 20000731
In-Reply-To: <NFBBKGGKGLLGNBGCEPKIAEHDCAAA.kjelde@mips.com>
Message-ID: <Pine.GSO.3.96.1010914163838.2943A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Sep 2001, Kjeld Borch Egevang wrote:

> I was trying to port SPEC CPU 2000 (benchmarks), and one of the tests
> failed. I boiled it down to the attached program. For performance reasons it
> could be perfectly valid not to use memset(), but I agree that the code
> looks a bit odd.

 With a high optimization level and a constant size of the area to set
(you'd likely use sizeof here, which is constant) gcc will happily inline
a memset() yielding no worse performance but no bugs and better
readability.  You may have no loop at all as the result.  Check yourself! 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
