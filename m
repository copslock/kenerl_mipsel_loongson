Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PBJ6Rw001040
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 04:19:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PBJ6vj001039
	for linux-mips-outgoing; Thu, 25 Jul 2002 04:19:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PBJ1Rw001030
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 04:19:02 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA00109;
	Thu, 25 Jul 2002 13:20:26 +0200 (MET DST)
Date: Thu, 25 Jul 2002 13:20:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: linux-mips@oss.sgi.com
Subject: Re: _stext is ill-defined / SysRq-T broken
In-Reply-To: <20020725110538.GA6804@convergence.de>
Message-ID: <Pine.GSO.3.96.1020725131053.27463I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 25 Jul 2002, Johannes Stezenbach wrote:

> On most systems the .fill 0x400 is unnecessary  and wastes 1KB (more
> than the .text.init size of head.o). Wouldn't it be better to remove the
> .fill and require the LOADADDR in arch/mips/Makefile to be >= 0x80000400?

 It probably would, but I'm afraid we are bound by various firmware's
limitations.  Not all systems seem to be able to load a system executable
at an arbitrary address.  Anyone can comment?

 Anyway a linker script magic seems to be possible to achieve a similar
result without hurting systems that set LOADADDR above 0x800003ff.  I'll
look into it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
