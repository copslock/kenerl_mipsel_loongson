Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMZww12308
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:35:58 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMZqP12305
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:35:53 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA02307;
	Fri, 18 Jan 2002 22:35:49 +0100 (MET)
Date: Fri, 18 Jan 2002 22:35:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ulrich Drepper <drepper@redhat.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <m38zav2wzr.fsf@myware.mynet>
Message-ID: <Pine.GSO.3.96.1020118220734.22923S-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 18 Jan 2002, Ulrich Drepper wrote:

> I don't really care what is done for MIPS and there is no reason to
> find excuses for not having the foresight.  I just present the facts:

 Tell that to the SysV committee. ;-)

 BTW, the i386 ABI supplement defines no spare registers, either -- all
are already assigned.  Where did you get extraneous registers for the i386
from (especially given the usual register shortage there)?  Maybe we could
use the same approach for MIPS.  Where to look for the code in glibc in a
current snapshot?

 One possible approach is to reserve GOT entries for thread registers. 
While not as fast as CPU's registers, if frequently accessed they would
stick in the cache.  Since the ABI mandates the code to keep a pointer to
the GOT in the gp register, accesses to got entries need only a single
instruction.  I haven't thought on it much -- someone might have a better
idea. 

> if there is no thread register or something equally fast MIPS will be
> one of the platforms which will have only a subset of the
> functionality of the other Linux architectures and not all
> applications will be able to be compiled for MIPS.  That's all.  If
> this is fine (e.g., for MIPS on embedded platforms) then all is good.
> If somebody wants to use threads and MIPS there is a problem.

 I have only workstation/server MIPS systems and I do care. 

  Maciej

 PS. Too bad libc-hacker rejects my submissions...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
