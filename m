Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C9u1Rw018040
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 02:56:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C9u1Kv018039
	for linux-mips-outgoing; Fri, 12 Jul 2002 02:56:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f201.dialo.tiscali.de [62.246.18.201])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C9trRw018021
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 02:55:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6CA0O820810;
	Fri, 12 Jul 2002 12:00:24 +0200
Date: Fri, 12 Jul 2002 12:00:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Sigcontext->sc_pc Passed to User
Message-ID: <20020712120024.A20727@dea.linux-mips.net>
References: <00b401c228ba$88b29bf0$10eca8c0@grendel> <20020712034015.C16608@dea.linux-mips.net> <003301c2297a$380ed400$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003301c2297a$380ed400$10eca8c0@grendel>; from kevink@mips.com on Fri, Jul 12, 2002 at 10:00:27AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 12, 2002 at 10:00:27AM +0200, Kevin D. Kissell wrote:

> The IRIX team made some stunningly bad design 
> decisions over the years, my favorite being "virtual
> swap space" and its side effect of deliberately killing 
> system daemons at random under load.  A signal scheme
> such as we have now in MIPS/Linux, where a user program
> *cannot* identify the instruction causing a signal if
> that instruction was in the delay slot of a taken branch,
> is broken from first principles.

Certainly you're right when you say a signal handler show know which
instruction was causing a fault.  Ours is simply a too bad implementation
of their interface ...

IRIX virtual swap space is simply memory overcommit.  Linux has that too
and it's been subject to frequent religious discussions on Linux kernel.
Non-overcommit means large amounts of memory are required when forking
of a new process.  The standard example is a fat bloated Mozilla forking
for printing.  Non-overcommit means you need those 50 or 100 megs of
Mozilla process size once more and if not as physical memory then at
least as swap space.  Deciede yourself if you're paranoid and want that
operation to only succeed if that much memory is actually available or
if you take the risk of the fork & exec operation failing the other way.

  Ralf
