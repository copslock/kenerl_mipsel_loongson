Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H2fcD06671
	for linux-mips-outgoing; Mon, 16 Jul 2001 19:41:38 -0700
Received: from fullass (matt.superweasel.com [216.36.92.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H2fRV06666;
	Mon, 16 Jul 2001 19:41:27 -0700
Received: from foo.inside ([10.0.1.1] helo=localhost)
	by fullass with esmtp (Exim 3.22 #1 (Debian))
	id 15MKlb-0007nL-00; Mon, 16 Jul 2001 22:39:19 -0400
Received: from gjohnson by localhost with local (Exim 3.22 #1 (Debian))
	id 15MKlK-0004G4-00; Mon, 16 Jul 2001 22:39:02 -0400
Date: Mon, 16 Jul 2001 22:39:02 -0400
From: Greg Johnson <gjohnson@superweasel.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux on a 100MHz r4000 indy?
Message-ID: <20010716223902.A16351@superweasel.com>
References: <20010716163712.B12104@superweasel.com> <20010717032055.A1236@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010717032055.A1236@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 03:20:55AM +0200, Ralf Baechle wrote:
> On Mon, Jul 16, 2001 at 04:37:12PM -0400, Greg Johnson wrote:
> 
> > I also have another indy with a 175MHz r4400.  This machine seems to
> > work fine even without the fast-sysmips patch.  
> 
> This could be explained if you have different libraries, the one compiled for
> MIPS II, the other one only for MIPS I on these two systems.  Sure you're
> running the very same binaries?

They're the same.

> Depends.  The older R4000s were really buggy silicon and we don't
> have all the workarounds needed to keep them happy.  So in theory if
> circumstances are just right that can explain why you have so much
> fun with the R4000 machine.

Interesting.

> When the kernel is booting it prints a a line "CPU revision is: xxx"
> where xxx is a 8 digit hex number.  What number?

For the r4000 indy:

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4000 FPU<MIPS-R4000FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000422
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 128 bytes.

For the r4400 indy:

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 128 bytes.


Thanks,

Greg
