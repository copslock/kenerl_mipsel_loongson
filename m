Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J1Hl8d017060
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 18:17:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3J1HlPL017059
	for linux-mips-outgoing; Thu, 18 Apr 2002 18:17:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J1Hi8d017056
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 18:17:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3J1Inu05981;
	Thu, 18 Apr 2002 18:18:49 -0700
Date: Thu, 18 Apr 2002 18:18:48 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Robert Franklin <daniel@ieee.uow.edu.au>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux on the Origin 2000
Message-ID: <20020418181848.B25562@dea.linux-mips.net>
References: <E16y0Hf-0001Ag-00@klystron.ieee.uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16y0Hf-0001Ag-00@klystron.ieee.uow.edu.au>; from daniel@ieee.uow.edu.au on Thu, Apr 18, 2002 at 11:00:22AM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 18, 2002 at 11:00:22AM +1000, Daniel Robert Franklin wrote:

> My research centre has been donated a beautiful SGI Origin 2000 server (512
> MB RAM, 2x180 MHz R10000 CPU) machine... we got IRIX up on it, but I'm quite
> keen to try running Linux on it as well. I note in the linux-mips HOWTO
> there is a mention that as of last year the kernel boots, and code to
> support this machine is now in CVS, but it all sounds rather experimental.
> 
> Can anyone tell me what the status of Origin 2000 support is, and is it
> worth trying to install? I'd be quite keen to help in testing Linux on this
> machine (if I can get Debian up and running on it I will be very very happy
> indeed :)

Lacking access to a machine the code may have suffered some bitrot but
basically it's supposed to work though not as fullfeatured as the 32-bit
kernel.  We had it running on MP systems of 2-128 processors.

  Ralf
