Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P3Uvp24789
	for linux-mips-outgoing; Sun, 24 Feb 2002 19:30:57 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P3Ur924766
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 19:30:53 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g1P2UpC17314;
	Sun, 24 Feb 2002 18:30:51 -0800
Date: Sun, 24 Feb 2002 18:30:51 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Is this a toolchain bug?
Message-ID: <20020224183051.B17291@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com> <20020223210608.A1424@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020223210608.A1424@nevyn.them.org>; from dan@debian.org on Sat, Feb 23, 2002 at 09:06:08PM -0500
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Okay, so I added that flag, and it actually seems to be correct.

But, the question remains, why does accessing that variable cause a
problem?  I'm going to do some more digging when I'm in the office
tomorrow, but one of the tests I already did was to put

e1000_proc_dev = NULL;

at one point in the code.  That line caused a crash with what looked like a
NULL-ptr dereference.

I'm going to re-examine this tomorrow, but I'm wondering if any of the
people on this list that are using this driver have CONFIG_PROC_FS turned
on.

Matt

On Sat, Feb 23, 2002 at 09:06:08PM -0500, Daniel Jacobowitz wrote:
> On Fri, Feb 22, 2002 at 05:57:08PM -0800, Matthew Dharm wrote:
> > If this is user-error, I'd love to know what I'm doing wrong.  If this
> > is a toolchain bug, who do I report this to?
> 
> User error, at least what you've described.  Add the -r flag to the
> objdump command line, or look at a statically linked object.
> 
> -- 
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
