Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4VJHSa00529
	for linux-mips-outgoing; Thu, 31 May 2001 12:17:28 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4VJHKh00518;
	Thu, 31 May 2001 12:17:20 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA03791; Thu, 31 May 2001 12:17:19 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4VJHF014178;
	Thu, 31 May 2001 12:17:15 -0700
Message-ID: <3B169888.1F5DBDFF@mvista.com>
Date: Thu, 31 May 2001 12:16:24 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Joe deBlaquiere <jadb@redhat.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <3B0ED686.C1D85CE1@mvista.com> <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl> <20010531135454.A1195@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Mon, May 28, 2001 at 05:34:26PM +0200, Maciej W. Rozycki wrote:
> 
> > > Alright, I rolled my sleeve and digged into IRIX 6.5, and guess what?
> > > sysmips() does NOT have MIPS_ATOMIC_SET (2001) on IRIX!  See the header below.
> >
> >  I remember Ralf writing of this being a compatibility call with RISC/OS
> > (is it the original OS of MIPS, Inc.?), IIRC.  Ralf: am I right?
> 
> Yes; this function is also implemented for IRIX 5 which we have some
> binary compatibility code for.
> 

Is anybody at all still running IRIX binary on Linux?  My impression the
compatibility is broken a while back.

> > > So apparently MIPS_ATOMIC_SET was invented for Linux only, probably just to
> > > implement _test_and_set().  (It would be interesting to see how IRIX
> > > implement _test_and_set() on MIPS I machines.  However, the machine I
> > > have access uses ll/sc instructions).
> 
> I don't recall seeing a _test_and_set() in the IRIX API/ABI.
>

It is part of SYSV MIPS supplement spec.  IRIX 6.5 has it.
 
Jun
