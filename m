Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ILoDa11145
	for linux-mips-outgoing; Fri, 18 Jan 2002 13:50:13 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ILo9P11141
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 13:50:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA01283;
	Fri, 18 Jan 2002 21:50:08 +0100 (MET)
Date: Fri, 18 Jan 2002 21:50:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ulrich Drepper <drepper@redhat.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <m3vgdz2yxo.fsf@myware.mynet>
Message-ID: <Pine.GSO.3.96.1020118213957.22923R-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 18 Jan 2002, Ulrich Drepper wrote:

> > But what about that Alpha's special code?  It could possibly be
> > reused given the large Alpha's similarity to MIPS.
> 
> No.  Alpha has certain builtin code which looks similar to calls or
> software interrupts but are executed in the CPU.  This allows access

 Yep, PALcode is possibly the most significant difference.

> to some memory in the CPU which is almost as fast as a normal register
> access.  MIPS doesn't have such hardware.  If you cannot find a
> register you're doomed.

 Hmm, why would an ABI reserve spare registers for a possible future use
that might never happen?  We can probably define a new ABI specifically
for Linux, though, if the gain surpasses the loss. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
