Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NHDDg32014
	for linux-mips-outgoing; Thu, 23 Aug 2001 10:13:13 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NHDAd32010
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 10:13:10 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7NHFfA26332;
	Thu, 23 Aug 2001 10:15:41 -0700
Message-ID: <3B8537C2.E18E5125@mvista.com>
Date: Thu, 23 Aug 2001 10:05:06 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010823174707.21718F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Thu, 23 Aug 2001, Gleb O. Raiko wrote:
> 
> > In order to read a PCI ID, you need to know how to do it. In pc world,
> > you may rely on configuation access types, at least, ports are known. On
> > other arches, you need to know where such "ports" are. Even if hardware
> > supports, say, configuration type 1 accesses, developers are free to put
> > port addresses anywhere.
> 
>  Yep, I see.  MIPS is quite special here, because, unlike for Alphas,
> PowerPCs, SPARCs, etc. there is a couple of independend vendors making
> systems, so there is no single way of obtaining a system ID.  So you need
> to know how to access chipset from elsewhere.
> 
> > >  How do you set up mips_machtype on your system in the first place?  At
> > > kernel_entry the code does not know what machine it's running on anyway,
> > > so it has to set mips_machtype based on a detection algorithm.
> >
> > First, mips_machtype is accessed far later than kernel_entry is
> 
>  That's quite obvious -- nothing can be done in Linux earlier. ;-)  But
> you need to initialize mips_machtype somehow.
> 
> > executed. Personally, I am lucky :-), I may read firmware environment
> > variables.
> 
>  Well, other system might as well (e.g. DECstations can), but that doesn't
> solve the problem -- to access firmware variables you need to know which
> kind of firmware you are on.
> 

I talked about machine detection a while back.  My idea is following:

0. all machines that are *configured* into the image will supply <my>_detect()
and <my>_setup() functions.

1. at MIPS start up, we loop through all <my>_detect(), which returns three
values, a) run-time detection negative, b) run-time detection positive, and c)
no run-time detection code, but I return positive because I am configured in.

2. the startup code resolves conflicts (which sometimes may panic); and decide
on one machine.

3. then the startup code calls the right <my>_setup() code which will set up
the mach_type and other stuff. 

BTW, a side benenfit of doing this is that we can remove all the machine
specific code in common files such as bootinfo.h, setup.c, etc, which are
getting harder and harder to maintain as we are adding more and more embedded
boards to the tree.  

If we push it to an extreme by using mechnism like do_initcalls(), we can
achieve zero common source file modification when adding a new a machine. 
This will greatly facilitate embedded development as it allows more parallel
development and allow people to maintain their own board code much easier
before the code is submitted to the tree.

Jun
