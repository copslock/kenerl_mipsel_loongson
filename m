Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DIERP23625
	for linux-mips-outgoing; Fri, 13 Jul 2001 11:14:27 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DIEPV23622;
	Fri, 13 Jul 2001 11:14:25 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 20B73125BA; Fri, 13 Jul 2001 11:14:25 -0700 (PDT)
Date: Fri, 13 Jul 2001 11:14:25 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010713111424.B25902@lucon.org>
References: <20010712182402.A10768@lucon.org> <20010713112635.A32010@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010713112635.A32010@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Jul 13, 2001 at 11:26:36AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 11:26:36AM +0200, Ralf Baechle wrote:
> On Thu, Jul 12, 2001 at 06:24:02PM -0700, H . J . Lu wrote:
> 
> > In fact, DT_MIPS_MAP_BASE_ADDR is the same as the p_addr field of the
> > first loadable segment in the program header. I think it is included
> > in the MIPS ABI to give the dynamic linker easy access to it.
> 
> Afair there is no requirement for loadable segments to be sorted so you'd
> have to go through all the program header table to find the one with the
> lowest address which isn't necessarily the first segment.
> 
> As the ABI doesn't give any guarantee that the lowest address in the segment
> table is the value of DT_MIPS_BASE_ADDR I just tried to find a binary on
> my IRIX boxen that violates this rule but I didn't find any.  So please,
> go ahead.

It doesn't matter. DT_MIPS_BASE_ADDR is the "Base Address" in the gABI.
glibc has to get the "Base Address" right. Otherwise, it won't work
correctly for all cases. It is not mips specific.


H.J.
