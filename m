Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g155TdE12673
	for linux-mips-outgoing; Mon, 4 Feb 2002 21:29:39 -0800
Received: from xyzzy.stargate.net ([198.144.45.122])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g155TZA12670
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 21:29:35 -0800
Received: (from justin@localhost)
	by xyzzy.stargate.net (8.11.6/8.11.6) id g155UMa04455;
	Tue, 5 Feb 2002 00:30:22 -0500
X-Authentication-Warning: xyzzy.stargate.net: justin set sender to justinca@ri.cmu.edu using -f
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
From: Justin Carlson <justinca@ri.cmu.edu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "H . J . Lu" <hjl@lucon.org>, Dominic Sweetman <dom@algor.co.uk>,
   GNU C
	Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
In-Reply-To: <20020204234710.A7094@nevyn.them.org>
References: <1012676003.1563.6.camel@xyzzy.stargate.net>
	<20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1>
	<yov5ofj65elj.fsf@broadcom.com>
	<15454.22661.855423.532827@gladsmuir.algor.co.uk>
	<20020204083115.C13384@lucon.org>
	<15454.47823.837119.847975@gladsmuir.algor.co.uk>
	<20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org>
	<20020204204247.A25254@lucon.org>  <20020204234710.A7094@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 05 Feb 2002 00:30:22 -0500
Message-Id: <1012887022.3343.9.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-02-04 at 23:47, Daniel Jacobowitz wrote:
> 
> Won't this cause some gratuitous thrashing if someone else is trying to
> get the spinlock at the same time?
> 

Actually, if you look at the required semantics of ll, no.  A ll by
itself can never cause a sc from another cpu to fail.  It's part of the
semantic definition to avoid potential livelock cases, e.g.

A does ll
B does ll, foiling A's lock attempt
A does sc, which fails
A does ll, foiling B's lock attempt
B does sc, which fails
B does ll, foiling A's lock attempt
...

Instead, this case becomes:
A does ll
B does ll
A does sc, which succeeds, even though B has done a ll
B does sc which fails
A does critical section work
B spins on ll until A releases the lock


-Justin
