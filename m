Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P4C9V03575
	for linux-mips-outgoing; Sun, 24 Feb 2002 20:12:09 -0800
Received: from dea.linux-mips.net (a1as13-p121.stg.tli.de [195.252.191.121])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P4C4903553
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 20:12:05 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1P3BtV03165;
	Mon, 25 Feb 2002 04:11:55 +0100
Date: Mon, 25 Feb 2002 04:11:54 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU emul and segmentation fault bug
Message-ID: <20020225041154.A2993@dea.linux-mips.net>
References: <3C76F53D.2C893BC7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C76F53D.2C893BC7@mvista.com>; from jsun@mvista.com on Fri, Feb 22, 2002 at 05:49:49PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 22, 2002 at 05:49:49PM -0800, Jun Sun wrote:

> I remember a while back we had a problem with FPU emulation code which causes
> a segmentation fault.  (Perhaps another symptom is bus error, but I am not
> 100% sure).
> 
> Apparently this problem is fixed in the recent kernel.  However, it shows up
> again in SMP mode.
> 
> Does anybody remember details of the problem and the fix?  I am afraid maybe
> something we did there is not SMP safe.

That's most probably a SMP cache invalidation bug.  What happens is that
remote CPUs try to invalidate the same address range as a local CPU as
well without any consideration that the active context of the remote
CPU might be different from the local one.  In combination with another
bug this may actually crash the whole system.

  Ralf
