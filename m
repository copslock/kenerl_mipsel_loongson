Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5LMgWnC003169
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 21 Jun 2002 15:42:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5LMgWU7003168
	for linux-mips-outgoing; Fri, 21 Jun 2002 15:42:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5LMgRnC003162
	for <linux-mips@oss.sgi.com>; Fri, 21 Jun 2002 15:42:28 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id AAA06135;
	Sat, 22 Jun 2002 00:46:05 +0200 (MET DST)
Date: Sat, 22 Jun 2002 00:46:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: "''linux-mips@oss.sgi.com' '" <linux-mips@oss.sgi.com>
Subject: Re: DECstation
In-Reply-To: <20020621211730.GO24903@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020621231916.2531D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 21 Jun 2002, Jan-Benedict Glaw wrote:

> I had X4 with framebuffer running on my DECstation with a PMAGB-B
> framebuffer. However, seems there were some threading problems (which
> might exist because the lack of ll/sc...).

 Either sysmips (ouch) or the emulation should handle them.  There may be
bugs, however...

> However, graphic was functional, but I haven't switched on that box for
> three months or so. I'm currently moving to an other city (well, quite a
> smallish town)...

 I'm on the way to getting appropriate monitor adapter cables, so I may
finally be able to access consoles.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
