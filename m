Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ILD0X09516
	for linux-mips-outgoing; Fri, 18 Jan 2002 13:13:00 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ILCsP09510
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 13:12:54 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA00406
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 12:08:24 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA00311;
	Fri, 18 Jan 2002 21:03:38 +0100 (MET)
Date: Fri, 18 Jan 2002 21:03:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Ulrich Drepper <drepper@redhat.com>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <20020118101908.C23887@lucon.org>
Message-ID: <Pine.GSO.3.96.1020118204144.22923P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 18 Jan 2002, H . J . Lu wrote:

> > This means that unless all architectures get thread registers (or
> > equivalent things like Alpha's special code) we'll have a two class
> > society of platforms where all code written for the platforms without
> > thread register can be run on the other systems, but not vice versa.
[...]
> On the other hand, can we change the mips kernel to save k0 or k1 for
> user space?

 No way.  MIPS doesn't predefine any stack-switching hardware and it
doesn't save any registers on exceptions (except from copying pc to cp0's
epc or errorepc).  The k0, k1 registers are defined as reserved for the
kernel use to switch to a kernel stack and save current values of other
registers upon a kernel entry due to an exception.  The general exception
handler (used for almost everything, including interrupts for most
systems) uses the registers this way to "bootstrap" itself.

 The dedicated TLB exception handler, which needs to be very fast for any
reasonable performance to achieve, uses these two registers solely,
without even touching anything else.

 As a result, anything written to k0 or k1 is lost immediately after the
first exception to happen afterwards. 

 Of course, this use of k0, k1 is purely conventional -- they are ordinary
32-bit general-purpose registers from the hardware point of view.  Only
zero and, to some extent, ra registers are different on MIPS. 

 The usage of all 32 registers is fixed in the ABI for MIPS.  But what
about that Alpha's special code?  It could possibly be reused given the
large Alpha's similarity to MIPS. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
