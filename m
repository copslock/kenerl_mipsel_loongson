Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1O36iU16550
	for linux-mips-outgoing; Sat, 23 Feb 2002 19:06:44 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1O36g916547
	for <linux-mips@oss.sgi.com>; Sat, 23 Feb 2002 19:06:42 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16eo3E-0000Oj-00; Sat, 23 Feb 2002 21:06:08 -0500
Date: Sat, 23 Feb 2002 21:06:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Is this a toolchain bug?
Message-ID: <20020223210608.A1424@nevyn.them.org>
References: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 22, 2002 at 05:57:08PM -0800, Matthew Dharm wrote:
> If this is user-error, I'd love to know what I'm doing wrong.  If this
> is a toolchain bug, who do I report this to?

User error, at least what you've described.  Add the -r flag to the
objdump command line, or look at a statically linked object.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
