Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4TMcb813732
	for linux-mips-outgoing; Tue, 29 May 2001 15:38:37 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4TMcXd13728
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 15:38:34 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4TMbr025239;
	Tue, 29 May 2001 15:37:53 -0700
Message-ID: <3B142495.66677A18@mvista.com>
Date: Tue, 29 May 2001 15:37:09 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010528190412.15200Q-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Mon, 28 May 2001, Kevin D. Kissell wrote:
> 
> > Use a global variable testable by the inline code?
> 
>  With both variants inlined?  Now that's really ugly.

I think system V requires _test_and_set() being included in the libsys dynamic
library.  Does Linux want to be sysv compatible?  If so, we should removed the
inlined _test_and_set().

> 
> > >  Are vr41xx plain ISA I or crippled ISA II+ CPUs?
> >
> > Actually, they are crippled MIPS III+ 64-bit CPUs
> 
>  Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
> don't think we want to add _test_and_set() to mips64*-linux.
> 

64 bit is a overkill for the pityful vr41xx CPUs.

The need for kernel emulated test_and_set() in 64bit kernel is not obvious
yet, and hopefully will never come.

Jun
