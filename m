Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g78F5gRw017852
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 8 Aug 2002 08:05:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g78F5fDx017851
	for linux-mips-outgoing; Thu, 8 Aug 2002 08:05:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g78F5XRw017841;
	Thu, 8 Aug 2002 08:05:34 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA14957;
	Thu, 8 Aug 2002 17:08:08 +0200 (MET DST)
Date: Thu, 8 Aug 2002 17:08:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: memcpy.S patch in 64-bit
In-Reply-To: <3D52711F.D5C6A8FC@mips.com>
Message-ID: <Pine.GSO.3.96.1020808170518.13783D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 8 Aug 2002, Carsten Langgaard wrote:

> The __copy_user function (in arch/mips64/lib/memcpy.S) calls __bzero.
> We can't do that because __bzero might modify len, which we want to
> return in case of an error.
> The following patch take care of the problem.

 Hmm, how about simply cloning arch/mips/lib/memcpy.S?  It seems:

1. Designed to work on mips64 as well.

2. More up to date.

And it would ease maintenance. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
