Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61HflnC013234
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 10:41:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61Hflpv013233
	for linux-mips-outgoing; Mon, 1 Jul 2002 10:41:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61HffnC013221
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 10:41:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA12750;
	Mon, 1 Jul 2002 19:46:02 +0200 (MET DST)
Date: Mon, 1 Jul 2002 19:46:01 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karel van Houten <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
In-Reply-To: <200207011725.TAA16476@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020701194019.7601L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 1 Jul 2002, Karel van Houten wrote:

> Indeed, I'm now running 2.4.18, and for the first time my DS5000/260 and
> DS5000/200 can keep exact time, even under heavy load.

 Well, for the /200 you should have always had stable time, although with
a coarse resolution, due to the lack of a high-precision timer (which for
the DECstation family is available either internally in R4k CPUs or
externally in the I/O ASIC).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
