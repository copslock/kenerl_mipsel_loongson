Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68HN6Rw027847
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 10:23:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68HN631027846
	for linux-mips-outgoing; Mon, 8 Jul 2002 10:23:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68HN0Rw027837
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 10:23:01 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA06996;
	Mon, 8 Jul 2002 19:27:45 +0200 (MET DST)
Date: Mon, 8 Jul 2002 19:27:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Steven Seeger <sseeger@stellartec.com>
cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: never mind
In-Reply-To: <020401c2253d$5a4cca90$3501a8c0@wssseeger>
Message-ID: <Pine.GSO.3.96.1020708192637.6296C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 6 Jul 2002, Steven Seeger wrote:

> Well I fixed it. Somehow kswapd_wait gets a bad entry in its task_list and
> it's always 0xffffffff8. So, putting a hack in __wake_up_common to look for
> that address and break out (since that always seems to be at the end of the
> list) fixed the problem. How odd. Of course I really should find out why
> that bad value gets in there, but I'm so lazy.

 And the bug will remain uncovered, waiting for another victim forever...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
