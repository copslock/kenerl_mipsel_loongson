Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77BlJRw000621
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 04:47:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77BlJCs000620
	for linux-mips-outgoing; Wed, 7 Aug 2002 04:47:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77BlBRw000611;
	Wed, 7 Aug 2002 04:47:12 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA18583;
	Wed, 7 Aug 2002 13:49:40 +0200 (MET DST)
Date: Wed, 7 Aug 2002 13:49:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: siginfo structure in 64-bit kernel
In-Reply-To: <3D50EE40.A4B44B4B@mips.com>
Message-ID: <Pine.GSO.3.96.1020807134433.18037B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 7 Aug 2002, Carsten Langgaard wrote:

> The siginfo structure is containing longs, which isn't consistent
> between o32 and n64.
> So we need a routine to convert siginfo from 64-bit to 32-bit, when we
> are running a 64-bit kernel on o32 userland.

 Yep, I've noticed we don't get it quite right recently, too.

> Please take a look at the patch below.

 It looks good in principle, but please use signed types for addresses.
I'll check the patch at run-time later.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
