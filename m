Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f450Wx030077
	for linux-mips-outgoing; Fri, 4 May 2001 17:32:59 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f450WuF30074
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 17:32:57 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f450Vek20563;
	Fri, 4 May 2001 21:31:40 -0300
Date: Fri, 4 May 2001 21:31:40 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Klaus Naumann <spock@mgnet.de>, linux-mips@oss.sgi.com
Subject: Re: Login problem on a serial console
Message-ID: <20010504213140.A20515@bacchus.dhis.org>
References: <Pine.LNX.4.21.0105011155170.12400-100000@spock.mgnet.de> <3AEE8DC8.DCCCFA9B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AEE8DC8.DCCCFA9B@mips.com>; from carstenl@mips.com on Tue, May 01, 2001 at 12:19:52PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 01, 2001 at 12:19:52PM +0200, Carsten Langgaard wrote:

> > I think this has something to do with the fixes Bachus commited
> > lately. I think he changed something which made some getty's
> > not work anymore. Can you try an other getty ?
> 
> I tried another getty and that seem to work, thanks.
> Do you know what break things, so I could redo Bachus fixes ?

Bacchus is angry about your misspelling of his name and punishes you
by el cheapo vine not under 5l ;-)

It's a change in the architecture independant code of the kernel which
result in the kernel initializing the serial tty with the CREAD flag
cleared.  mingetty doesn't do a fully initialization of the terminal
but getty (from getty_ps) or mgetty do, so they work.

I'd consider that two bugs, one in the kernel and one in mingetty.  It
means a user can messup terminal settings so completly that logging off
wouldn't fix things but only root intervention or reboot.

  Ralf
