Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OGNLRw032599
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 09:23:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OGNL9I032598
	for linux-mips-outgoing; Wed, 24 Jul 2002 09:23:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OGNERw032589
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 09:23:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA03644;
	Wed, 24 Jul 2002 18:24:39 +0200 (MET DST)
Date: Wed, 24 Jul 2002 18:24:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pete Popov <ppopov@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: [patch] wbflush() fixes and updates
In-Reply-To: <1027527551.18017.13.camel@zeus.mvista.com>
Message-ID: <Pine.GSO.3.96.1020724182216.27732J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 24 Jul 2002, Pete Popov wrote:

> The Au1x00 looks fine.  I suppose I'll have to update the defconfig
> files to include CONFIG_CPU_HAS_SYNC.

 No need to, as the option is not user selectable.  No hurt though,
either.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
