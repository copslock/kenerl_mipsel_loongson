Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0P1nhv10408
	for linux-mips-outgoing; Thu, 24 Jan 2002 17:49:43 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0P1neP10402
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 17:49:40 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0OIxPc02626;
	Thu, 24 Jan 2002 10:59:25 -0800
Date: Thu, 24 Jan 2002 10:59:15 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Machida Hiroyuki <machida@sm.sony.co.jp>
Cc: kevink@mips.com, aj@suse.de, hjl@lucon.org, linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Message-ID: <20020124105915.A838@dea.linux-mips.net>
References: <20020122232529V.machida@sm.sony.co.jp> <005301c1a368$87d27ed0$10eca8c0@grendel> <20020123145634M.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123145634M.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Wed, Jan 23, 2002 at 02:56:34PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 23, 2002 at 02:56:34PM +0900, Machida Hiroyuki wrote:

> > It should in principle be SMP safe.
> 
> I don't think so.
> 
> Suppose that 
> 	THREAD A is bound to CPU A and THREAD B is bound to CPU B.
> 	THREAD A and THREAD B are running on_atomic_inc_nollsc(). 
> Two threads are really running at the same time, without
> context-switch. In this case nobody clear k1.

There is a method for mutual exclusion called Dekker's Algorithem (sp?)
which only requires just atomic stores and can be implemented in plain
C.  Downside is it's weak performance that renders it pretty much a CS
only thing.

  Ralf
