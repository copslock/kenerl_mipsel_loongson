Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2NDxJV10735
	for linux-mips-outgoing; Sat, 23 Mar 2002 05:59:19 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2NDxFq10732
	for <linux-mips@oss.sgi.com>; Sat, 23 Mar 2002 05:59:15 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA16944;
	Sat, 23 Mar 2002 15:01:49 +0100 (MET)
Date: Sat, 23 Mar 2002 15:01:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: declance multicast filter fixes
In-Reply-To: <Pine.LNX.4.32.0203221107170.1949-100000@skynet>
Message-ID: <Pine.GSO.3.96.1020323010132.3959A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 22 Mar 2002, Dave Airlie wrote:

> I've created declance_2_4.c on http://www.csn.ul.ie/~airlied/mips
> 
> for the DS5000/200 series of DecStations..

 Thanks for the reference -- I definitely want to look how to merge the
drivers one day (well, actually the LANCE core should be common to all
drivers eventually).  There is certainly no point in keeping your code
separately.  I suppose your driver should work for the PMAD card as well. 

> it only required the BE -> LE and the additional zeroing of the filter, it
> already did the mcast_table access correctly... (by luck rather than
> design :-)

 Well, the I/O ASIC wiring of LANCE is weird.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
