Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0RNOCi00884
	for linux-mips-outgoing; Sun, 27 Jan 2002 15:24:12 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0RNO7P00871
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 15:24:07 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0RMO4Y18080;
	Sun, 27 Jan 2002 14:24:04 -0800
Date: Sun, 27 Jan 2002 14:24:04 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Help with OOPSes, anyone?
Message-ID: <20020127142404.B18041@momenco.com>
References: <20020127002242.A11373@momenco.com> <1012152783.2026.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012152783.2026.7.camel@localhost.localdomain>; from ppopov@mvista.com on Sun, Jan 27, 2002 at 09:33:02AM -0800
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, we're using very late RM7000 silicon, so I doubt that's the problem.
But it's a good thing to look at, anyway.

Tho it kinda conflicts with the datapoint that we actually had a stable
kernel on this hardware before.  Tho, like I said, that's not much of a
datapoint -- more testing coming!

Matt

On Sun, Jan 27, 2002 at 09:33:02AM -0800, Pete Popov wrote:
> 
> > But, under certain conditions, the kernel OOPSes.  Attached to this message
> > are a few of those OOPSes (serial console is wonderful!) along with the
> > ksymoops output.  I think the read_lsmod() warning is bogus, because there
> > are, actually, no modules loaded.
> > 
> > My instincts are telling me that these are all being caused by the same
> > problem, but I'll be damned if I can figure out what that is.  Caching is a
> > good suspect, but that's just because it's always a good suspect.
> 
> Native compiles have indeed proven a great way to shake out hardware and
> software bugs. 
> 
> One suggestion. The rm7k, at least some of the silicon versions, have
> hardware erratas with the 'wait' instruction, used in the cpu_idle()
> loop.  The CPU I have on one of the EV96100 boards, in combination with
> the gt96100, will hang hard every time if I don't disable the use of
> 'wait'.  So while this bug might not have anything to do with what
> you're observing, I would ifdef-out the 'wait' instruction in
> check_wait(), just to be sure that that's not the cause or one of the
> problems.
> 
> Pete

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
