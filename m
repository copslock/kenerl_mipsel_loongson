Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PNxV818238
	for linux-mips-outgoing; Fri, 25 May 2001 16:59:31 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PNxVF18235
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 16:59:31 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4PNun028732;
	Fri, 25 May 2001 16:56:49 -0700
Message-ID: <3B0EF123.B1C6D480@mvista.com>
Date: Fri, 25 May 2001 16:56:19 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010524173937.19424A-100000@delta.ds2.pg.gda.pl> <3B0D8F51.6000100@redhat.com> <3B0ED686.C1D85CE1@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Oops!  I guess I forgot to include the sysmips.h header file from IRIX.

Jun

/*      Copyright (c) 1984 AT&T */
/*        All Rights Reserved   */

/*      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T     */
/*      The copyright notice above does not evidence any        */
/*      actual or intended publication of such source code.     */

#ident "$Revision: 3.12 $"

/*
 * Sysmips() system call commands.
 */

#define SETNAME         1       /* rename the system */
#define STIME           2       /* set time */
#define FLUSH_CACHE     3       /* flush caches */
#define MIPS_FPSIGINTR  5       /* generate a SIGFPE on every fp interrupt */
#define MIPS_FPU        6       /* turn on/off the fpu */
#define MIPS_FIXADE     7       /* fix address error (unaligned) */
#define POSTWAIT        8       /* post wait driver for Oracle */
#define PPHYSIO         9       /* parallel IO */
#define PPHYSIO64       10      /* parallel IO - big offsets */
