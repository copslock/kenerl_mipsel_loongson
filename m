Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1CCfjK30130
	for linux-mips-outgoing; Tue, 12 Feb 2002 04:41:45 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1CCfQ930125
	for <linux-mips@oss.sgi.com>; Tue, 12 Feb 2002 04:41:27 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA17975;
	Tue, 12 Feb 2002 12:41:02 +0100 (MET)
Date: Tue, 12 Feb 2002 12:41:01 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthew Dharm <mdharm@momenco.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: RE: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIMEHBCFAA.mdharm@momenco.com>
Message-ID: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Matthew Dharm wrote:

> Aren't there more processors that have sync?  I thought the RM7000
> (PMC-Sierra) did too...

 Obviously there are as "sync" is standard for MIPS II and above.  That's
why only CONFIG_CPU_R3000 and CONFIG_CPU_TX39XX disable "sync".

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
