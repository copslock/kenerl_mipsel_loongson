Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f811BbN02660
	for linux-mips-outgoing; Fri, 31 Aug 2001 18:11:37 -0700
Received: from dink.res.cmu.edu (adsl-63-200-41-36.steelrain.org [63.200.41.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f811BWd02656
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 18:11:32 -0700
Received: from drow by dink.res.cmu.edu with local (Exim 3.22 #1 (Debian))
	id 15czJE-0008Re-00; Fri, 31 Aug 2001 18:10:52 -0700
Date: Fri, 31 Aug 2001 18:10:52 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Ton Truong <ttruong@broadcom.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: The Linux binutils 2.11.90.0.31 is released.
Message-ID: <20010831181052.A32426@false.org>
References: <20010831135539.B3999@lucon.org> <001101c1327f$c7cbc460$0766030a@pc-ir003385.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <001101c1327f$c7cbc460$0766030a@pc-ir003385.broadcom.com>; from ttruong@broadcom.com on Fri, Aug 31, 2001 at 05:48:13PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Both GCC and glibc patches are necessary.  With some help from Simon
Gee, I got this working a week ago; I'll post the patches when my
machine is available again in a few days. 

On Fri, Aug 31, 2001 at 05:48:13PM -0700, Ton Truong wrote:
> Thanks H.J.
> 
> Yes I mean gprof on Linux/mipsel.  It was not there in 2.11.90.0.29.
> 
> Regards,
> 
> Ton
> 
> > -----Original Message-----
> > From: H . J . Lu [mailto:hjl@lucon.org]
> > Sent: Friday, August 31, 2001 1:56 PM
> > To: Ton Truong
> > Cc: linux-mips@oss.sgi.com
> > Subject: Re: The Linux binutils 2.11.90.0.31 is released.
> > 
> > 
> > On Fri, Aug 31, 2001 at 01:02:13PM -0700, Ton Truong wrote:
> > > H.J.
> > > 
> > > Does this version of binutils support gprof?
> > > 
> > 
> > If you were asking if gprof works on Linux/mips, I don't know. I don't
> > have the time to work on it.
> > 
> > 
> > H.J.
> > 
> > 
> 
> 

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
