Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48LJdo32535
	for linux-mips-outgoing; Tue, 8 May 2001 14:19:39 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48LJaF32531;
	Tue, 8 May 2001 14:19:36 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f48LJW017350;
	Tue, 8 May 2001 14:19:32 -0700
Message-ID: <3AF86306.343F53D0@mvista.com>
Date: Tue, 08 May 2001 14:20:06 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, macro@ds2.pg.gda.pl
CC: linux-mips@oss.sgi.com
Subject: Re: machine types for MIPS in ELF file
References: <3AF843F7.72BC47F0@mvista.com> <20010508164846.A1471@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Tue, May 08, 2001 at 12:07:35PM -0700, Jun Sun wrote:
> 
> > The e_machine field in ELF file standard defines two values for MIPS:
> >
> > 8     - MIPS RS3000 BE
> > 10    - MIPS RS4000 BE
> >
> > Naturally the question is: what about LE binaries?  And what about other
> > CPUs?  Is there any effort to clean up this thing?
> >
> > All the tools that I know of are using 8, pretty much for all CPUs and both
> > endians.  No real harm has been observed, but it causes some anonying "invalid
> > byte order" complains if you do "file" on a MIPS LE binary.  Of course, it
> > will also invariably reports "R3000" cpu as well.
> 
> EM_MIPS_RS4_BE was apparently only in use for a short time; EM_MIPS is
> being used for both byte order.  The byteorder is nowadays identified by
> EI_DATA.
> 

That makes a lot of sense.

BTW, where is the latest ELF spec that says so?  Maciej, which spec are you
referring to?

Jun
