Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q2E9R03884
	for linux-mips-outgoing; Mon, 25 Feb 2002 18:14:09 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q2E3903880
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 18:14:03 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16fWBL-0000dx-00; Mon, 25 Feb 2002 20:13:27 -0500
Date: Mon, 25 Feb 2002 20:13:27 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Kevin Paul Herbert <kph@ayrnetworks.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Is this a toolchain bug?
Message-ID: <20020225201327.A2427@nevyn.them.org>
References: <a05100303b8a033ebf33b@[192.168.1.5]> <NEBBLJGMNKKEEMNLHGAIGEMACFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIGEMACFAA.mdharm@momenco.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 12:30:38PM -0800, Matthew Dharm wrote:
> Well, that fixes it.  The driver works out-of-the-box with just some
> minor makefile modifications.
> 
> So, we've got a problem somewhere in the module handling.  Either the
> symbol wasn't being relocated properly, or it wasn't being allocated
> properly, or something.  I'm not an expert in this region of the
> kernel, but my guess is that we're going to see this more and more
> often, so someone with a clue should take a look at this.
> 
> I'm more than willing to help, as I seem to be the only person with a
> 100% reproducable situation.  But I really have no idea even where to
> begin looking... my expertise ends right about at objdump, and even
> then I'm not certain how some of that data should look for loadable
> modules.

Silly question... was the module built with the correct flags?  Look at
a command line; does it have all the same options as when you build a
module in the kernel source?

I bet something's missing.  Probably -G 0...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
