Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ADaR312399
	for linux-mips-outgoing; Fri, 10 Aug 2001 06:36:27 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ADaOV12396
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 06:36:25 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07315;
	Fri, 10 Aug 2001 15:37:58 +0200 (MET DST)
Date: Fri, 10 Aug 2001 15:37:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
In-Reply-To: <20010810132056.D23866@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010810153057.7147A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 10 Aug 2001, Ralf Baechle wrote:

> That's a libtool bug.  My RH 7.0 port has the fix.

 Libtool doesn't really need the file program for decent shared library
systems.  Linux/ELF is one of them and the current CVS version of libtool
shouldn't depend on file for MIPS/Linux anymore. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
