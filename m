Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32EE8N14661
	for linux-mips-outgoing; Mon, 2 Apr 2001 07:14:08 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32EB0M14513
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 07:11:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23208;
	Mon, 2 Apr 2001 15:46:31 +0200 (MET DST)
Date: Mon, 2 Apr 2001 15:46:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Karel van Houten <vhouten@kpn.com>, Carsten Langgaard <carstenl@mips.com>,
   Keith M Wesolowski <wesolows@foobazco.org>, David Jez <dave.jez@seznam.cz>,
   linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
In-Reply-To: <Pine.GSO.4.10.10104020828400.3028-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010402152703.21839A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2 Apr 2001, Geert Uytterhoeven wrote:

> So it may make sense to post the not-yet-cleant-up patch to linux-kernel now.
> Perhaps someone there has more time to clean it up.

 It already went there back in July, 2000.  I sent it again a few months
later again, IIRC (January 2001?).  I've received no response at all.  I'm
bored with sending patches into a black hole over and over again, sorry. 
I'll clean it up sooner or later and I will submit the resulting patch
then -- while no one is interested, Linus might accept it for the sake of 
correctness.

 Anyway, I can continue to live with a private patch, as I already do for
several months now -- the patch actually caused me no trouble at all since
-test4 as there were no conflicts with kernel patches so far.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
