Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53HLpnC003045
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 10:21:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53HLp9V003044
	for linux-mips-outgoing; Mon, 3 Jun 2002 10:21:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53HLinC003041;
	Mon, 3 Jun 2002 10:21:45 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA20558;
	Mon, 3 Jun 2002 19:23:56 +0200 (MET DST)
Date: Mon, 3 Jun 2002 19:23:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justinca@cs.cmu.edu>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
In-Reply-To: <1022713145.7644.363.camel@ldt-sj3-022.sj.broadcom.com>
Message-ID: <Pine.GSO.3.96.1020603191851.14451I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 29 May 2002, Justin Carlson wrote:

> This is true;  I hadn't thought about the cases of userland touching
> hardware directly.  Of course, I think these cases should be hunted down
> and eliminated (go framebuffer device!), but alas, if that ever really
> happens, it's not going to be soon.

 Userland drivers are justified in many cases, so they'd better not go
away.  Besides, not all display adapters are framebuffers -- do you want
an X server in the kernel???

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
