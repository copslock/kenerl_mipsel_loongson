Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GKh4S28017
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:43:04 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GKh3V28012
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:43:03 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA23268;
	Mon, 16 Jul 2001 22:38:41 +0200 (MET DST)
Date: Mon, 16 Jul 2001 22:38:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Harald Koerfgen <hkoerfg@web.de>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.5: DECstation LK201 keyboard non-functional
In-Reply-To: <01071622281400.00525@intel>
Message-ID: <Pine.GSO.3.96.1010716223416.22824B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 16 Jul 2001, Harald Koerfgen wrote:

> I tend to agree, but maybe I'm biased.  On the other hand, it would prpbably 
> be better to modularize the dz and zs drivers.

 They should get modularized one day anyway, but for the console purpose
this is irrelevant. 

 Also Linus plans a driver tree redesign in 2.5, IIRC.  The current tree
is messed up indeed. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
