Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T7Ieb00788
	for linux-mips-outgoing; Mon, 28 Jan 2002 23:18:40 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T7IXP00774
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 23:18:33 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0T6ITE24783;
	Mon, 28 Jan 2002 22:18:29 -0800
Date: Mon, 28 Jan 2002 22:18:29 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Pete Popov <ppopov@pacbell.net>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Help with OOPSes, anyone?
Message-ID: <20020128221829.A24770@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIIEBLCFAA.mdharm@momenco.com> <1012271362.8518.219.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012271362.8518.219.camel@zeus>; from ppopov@pacbell.net on Mon, Jan 28, 2002 at 06:29:22PM -0800
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Do you know who, precisely, got the CD?  I'm going to try to chase this
down, but exact names would be helpful.

Also, when you push that material out to the community, when did you do
that?  That is, if your work is 2.4.2-based, is it reasonable to assume
that 2.4.2 or 2.4.3 in the CVS repository will work?  Or do you take a more
"fire and forget" sort of approach?

Matthew Dharm

On Mon, Jan 28, 2002 at 06:29:22PM -0800, Pete Popov wrote:
> 
> > And 2.4.17 with the wait instruction turned off still crashes.
>  
> > The Montavista kernel (which claims to be 2.4.0 #5 build by jsun)
> > seems to work...  
> 
> Strange, that must have been some interim build Jun did.
> 
> > I've done several recompiles on it, and lots of I/O
> > traffic with no problems.  Unfortunatly, I don't have the source code
> > to this particular kernel... tho I believe that Montavista is required
> > to release their source cod by the GPL.
> 
> All of the open source work we do we push out to the community tree 
> immediately.  That's a rule we live by and there's no exceptions.  The Ocelot 
> code was pushed out back then. Since then I've seen lots of additions to that 
> directory and obviously something got broke.
> 
> QED did receive an Alliance CD with the Ocelot LSP on it, so they should
> be able to provide you with a copy of the cdimage, including the
> source.  But the kernel will be 2.4.2 based though -- I don't know where
> the 2.4.0 came from.
>  
> > Tho here's a question:  What is the best compiler to build a kernel
> > with?  I've built all mine with egcs-2.91.66 which I downloaded from
> > oss.sgi.com a while ago.
> 
> MontaVista's, but I'm biased ;-)  The toolchain will be on the CD as
> well.
> 
> Pete
> 

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
