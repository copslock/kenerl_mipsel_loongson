Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g728Z7Rw027944
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 01:35:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g728Z700027943
	for linux-mips-outgoing; Fri, 2 Aug 2002 01:35:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g728Z0Rw027930;
	Fri, 2 Aug 2002 01:35:01 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA24499;
	Fri, 2 Aug 2002 10:36:58 +0200 (MET DST)
Date: Fri, 2 Aug 2002 10:36:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <3D4A4191.DF5EFFC4@mips.com>
Message-ID: <Pine.GSO.3.96.1020802103630.24360B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2 Aug 2002, Carsten Langgaard wrote:

> The Malta board is a system that both run coherent and non-coherent, so I would
> prefer, that we either make the coherency a configuration option or make it
> possible to determine at run time.

 The latter, definitely.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
