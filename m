Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g158djH01673
	for linux-mips-outgoing; Tue, 5 Feb 2002 00:39:45 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g158ddA01653
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 00:39:39 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA01772;
	Tue, 5 Feb 2002 00:39:30 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA03164;
	Tue, 5 Feb 2002 00:39:29 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g158d3A21047;
	Tue, 5 Feb 2002 09:39:04 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id JAA00051;
	Tue, 5 Feb 2002 09:39:27 +0100 (MET)
Message-Id: <200202050839.JAA00051@copsun18.mips.com>
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
To: justinca@ri.cmu.edu (Justin Carlson)
Date: Tue, 5 Feb 2002 09:39:27 +0100 (MET)
Cc: dan@debian.org (Daniel Jacobowitz), hjl@lucon.org (H . J . Lu),
   dom@algor.co.uk (Dominic Sweetman),
   libc-alpha@sources.redhat.com (GNU C Library), linux-mips@oss.sgi.com
In-Reply-To: <1012887022.3343.9.camel@xyzzy.stargate.net> from "Justin Carlson" at Feb 05, 2002 12:30:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Note that the issue of a "LL" will trigger bus watching activity in the
system logic (and maybe delays?) I would personally try to avoid issuing
"dangling" ll's in the normal case, even though the functionality would
be ok, and in some cases they are inavoidable.

/Hartvig

Justin Carlson writes:
> 
> On Mon, 2002-02-04 at 23:47, Daniel Jacobowitz wrote:
> > 
> > Won't this cause some gratuitous thrashing if someone else is trying to
> > get the spinlock at the same time?
> > 
> 
> Actually, if you look at the required semantics of ll, no.  A ll by
> itself can never cause a sc from another cpu to fail.  It's part of the
> semantic definition to avoid potential livelock cases, e.g.
> 
> A does ll
> B does ll, foiling A's lock attempt
> A does sc, which fails
> A does ll, foiling B's lock attempt
> B does sc, which fails
> B does ll, foiling A's lock attempt
> ...
> 
> Instead, this case becomes:
> A does ll
> B does ll
> A does sc, which succeeds, even though B has done a ll
> B does sc which fails
> A does critical section work
> B spins on ll until A releases the lock
> 
> 
> -Justin
> 
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
