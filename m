Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MCKARw022647
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 05:20:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MCKAtG022646
	for linux-mips-outgoing; Mon, 22 Jul 2002 05:20:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MCJvRw022632
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 05:19:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03440;
	Mon, 22 Jul 2002 14:21:13 +0200 (MET DST)
Date: Mon, 22 Jul 2002 14:21:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>,
   Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-Reply-To: <200207191708.TAA04858@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020722132706.2373A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Karel,

> > OK, more writeback fixes.  Please get the following patches: 
> >
> >- patch-mips-2.4.18-20020530-mb-wb-8.gz,
> >
> >- patch-mips-2.4.18-20020625-wbflush-7.gz
> >
> >from 'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/' and replace the hack I
> >sent you yesterday with the following real fix.  After applying the three
> >patches you need to rebuild the kernel from scratch, i.e. do `make
> >oldconfig dep clean boot modules' as the two above patches modify the
> >kernel's configuration.
> >
> > Please report if this works or not. 
> 
> Yes! Now I can use the TC PMAZ-AA without problems. I've copied
> some data around, without any problems. Fsck found no problems
> on the fs on that drive.

 Excellent.  I worried data corruption will happen sooner or later without
these patches, OTOH -- I'm using them since early February, when the new
IRQ code let me discover a deficiency of our synchronization primitives. 

> Will these patches go into the oss CVS (2.4) tree?

 I hope so.  I'm begging Ralf for about half a year, sigh...  The subject
was beaten to death at the list and the feedback looked positive to me
(after a few doubts were resolved), but Ralf seems to be unhappy with the
changes due to some ia64 interactions (I'm still not sure which ones,
though).  Ralf, could you please elaborate? 

 Otherwise, your case convinces me I should not care about purity or
cross-platform consistency of code in this area, anymore.  I've been
observing problems with interrupts due to the lack of iomem access
synchronization already, but unlike for your PMAZ-A problem, their result
was more of annoyance than instability.  Since stability is a priority,
although reluctantly, I will rework the changes to apply to the DECstation
code only, to keep others happy.  The interface won't change, apart from
resolving namespace clashes.

> BTW: Are your patches to the declance driver in a way that we can use
> one unified driver for the /240 and the /200 systems? I still use
> the driver modified by Dave for my /200 kernels.

 Nope, sorry.  Either we miss some hardware configuration data or DEC did
the worst mess possible with the wiring of the LANCE chip (additionally
cropping 8 high bits of the LANCE address space which forces us to waste
128kB of memory for a static, contiguous buffer, instead of using the zone
allocator).  With the current setup it's tough to get both configurations
supported with a single driver (hmm, I wonder how they solved it in
Ultrix...) and I'm not sure it's worth the hassle just for 2.4.  For 2.5
I'll try to separate drivers' frontends to work with the common 7990 core. 
Since each of the PMAX/PMIN, PMAD-A and I/O ASIC setups uses a completely
different chip wiring, there will likely be three separate frontends.  I
may backport the changes to 2.4 eventually if there is still any interest
at that stage.

 I have a patch to sync the Dave's driver to the mainstream declance.c. 
The patch became a bit outdated (not much, though), but I may update it if
there is any interest.  I've sent it to Dave, but not to the list.  I'm
not sure if he applied it.  I have made it available at: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/patch-mips-2.4.18-20020412-declance-pmad-11.gz'. 

 Politeness keeps me from stating publicly what I think of the designer of
the network hardware in DECstations. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
