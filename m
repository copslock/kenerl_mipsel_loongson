Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PC3QnC013757
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 05:03:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PC3Pqk013756
	for linux-mips-outgoing; Tue, 25 Jun 2002 05:03:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PC3JnC013752;
	Tue, 25 Jun 2002 05:03:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA01135;
	Tue, 25 Jun 2002 14:07:07 +0200 (MET DST)
Date: Tue, 25 Jun 2002 14:07:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
In-Reply-To: <3D183EF2.FB26BA59@mips.com>
Message-ID: <Pine.GSO.3.96.1020625140549.29623C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 25 Jun 2002, Carsten Langgaard wrote:

> The msgbuf.h file is now a copy from i386, instead of alpha.
> I guess the fix goes for 64-bit kernel as well.

 I guess not, as long is 64-bit there, thus the Alpha version is more
appropriate. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
