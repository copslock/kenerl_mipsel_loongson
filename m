Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3D0RS8d030613
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 17:27:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3D0RSU4030612
	for linux-mips-outgoing; Fri, 12 Apr 2002 17:27:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3D0RN8d030609
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 17:27:23 -0700
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 16wBOM-0003ev-00; Fri, 12 Apr 2002 20:27:46 -0400
Date: Fri, 12 Apr 2002 20:27:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
Message-ID: <20020412202746.A14017@nevyn.them.org>
References: <Pine.GSO.3.96.1020412195812.14896B-100000@delta.ds2.pg.gda.pl> <012f01c1e250$c93fb0a0$4c00a8c0@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012f01c1e250$c93fb0a0$4c00a8c0@prefect>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 12, 2002 at 02:35:13PM -0400, Bradley D. LaRonde wrote:
> ----- Original Message -----
> From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> To: "Bradley D. LaRonde" <brad@ltc.com>
> Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
> Sent: Friday, April 12, 2002 2:05 PM
> Subject: Re: Can modules be stripped?
> 
> 
> > On Fri, 12 Apr 2002, Bradley D. LaRonde wrote:
> >
> > > OK, you can't strip kernel modules (news to me, then again how often do
> I
> > > use modules?), but it can't be because they "are relocatables".  I
> routinely
> > > strip libraries without problem, and those are relocatables too.
> >
> >  What kind of libraries?  Shared libraries are shared objects and not
> > relocatables.
> 
> Oh, oops. :-P  Now I see what you mean.  I confused shared object
> w/relocatable.  My bad.
> 
> Did I know that kernel modules were "object files" i.e. relocatables.  Yes.
> But I've always referred to them as object files (.o), not relocatables,
> hence the confusion.
> 
> Which brings up an interesting question - why doesn't the kernel use .so
> files for modules?

If you're really curious, compare the gunk in insmod (quite a bit) with
the gunk in ld.so (unspeakable).  Shared libraries are a great deal
more complicated than modules need to be.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
