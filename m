Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0INHP613308
	for linux-mips-outgoing; Fri, 18 Jan 2002 15:17:25 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0INHIP13302
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 15:17:18 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA03355;
	Fri, 18 Jan 2002 23:17:15 +0100 (MET)
Date: Fri, 18 Jan 2002 23:17:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ulrich Drepper <drepper@redhat.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <m3zo3b1ghf.fsf@myware.mynet>
Message-ID: <Pine.GSO.3.96.1020118224630.22923V-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 18 Jan 2002, Ulrich Drepper wrote:

> > Where did you get extraneous registers for the i386
> > from (especially given the usual register shortage there)?
> 
> %gs

 Ah well, then you just have it by an accident and not because it was
specifically designed to be spare...

> > Maybe we could use the same approach for MIPS.
> 
> I doubt it.

 Indeed.

> > Where to look for the code in glibc in a current snapshot?
> 
> %gs is used for a long time linuxthreads/sysdeps/386/useldt.h

 Thanks.

> >  One possible approach is to reserve GOT entries for thread registers. 
> > While not as fast as CPU's registers, if frequently accessed they would
> > stick in the cache.  Since the ABI mandates the code to keep a pointer to
> > the GOT in the gp register, accesses to got entries need only a single
> > instruction.  I haven't thought on it much -- someone might have a better
> > idea. 
> 
> How would you have different values for different threads?  It would
> mean having multiple GOTs which is a resource waste and a nightmare in
> resource management.

 OK, now I understand you need some kind of a tid, that needs not be
writeable.  A read-only register can be moderately easily provided by
either k0 or k1 if exit paths of exceptions reload the given one.  The
trail code of exceptions only needs one of them at most. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
