Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4VCgPG09960
	for linux-mips-outgoing; Thu, 31 May 2001 05:42:25 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4VCgCh09943
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 05:42:12 -0700
Received: from dea.waldorf-gmbh.de (u-238-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.238]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAB02859
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 05:42:10 -0700 (PDT)
	mail_from (ralf@dea.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4VBstT30532;
	Thu, 31 May 2001 13:54:55 +0200
Date: Thu, 31 May 2001 13:54:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, Joe deBlaquiere <jadb@redhat.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010531135454.A1195@bacchus.dhis.org>
References: <3B0ED686.C1D85CE1@mvista.com> <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, May 28, 2001 at 05:34:26PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 28, 2001 at 05:34:26PM +0200, Maciej W. Rozycki wrote:

> > Alright, I rolled my sleeve and digged into IRIX 6.5, and guess what? 
> > sysmips() does NOT have MIPS_ATOMIC_SET (2001) on IRIX!  See the header below.
> 
>  I remember Ralf writing of this being a compatibility call with RISC/OS
> (is it the original OS of MIPS, Inc.?), IIRC.  Ralf: am I right? 

Yes; this function is also implemented for IRIX 5 which we have some
binary compatibility code for.

> > So apparently MIPS_ATOMIC_SET was invented for Linux only, probably just to
> > implement _test_and_set().  (It would be interesting to see how IRIX
> > implement _test_and_set() on MIPS I machines.  However, the machine I
> > have access uses ll/sc instructions).

I don't recall seeing a _test_and_set() in the IRIX API/ABI.

>  Does IRIX actually run on anything below ISA II?

Well, it ran.  A loong time ago.  IRIX dropped support for MIPS I in IRIX 6.
That makes sense as IRIX 6 is only running on R4000 and better, that is
MIPS III CPUs.

  Ralf
