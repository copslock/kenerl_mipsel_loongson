Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CJclg03882
	for linux-mips-outgoing; Tue, 12 Jun 2001 12:38:47 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CJciV03878;
	Tue, 12 Jun 2001 12:38:44 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7CD59125BA; Tue, 12 Jun 2001 12:38:43 -0700 (PDT)
Date: Tue, 12 Jun 2001 12:38:43 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010612123843.A23567@lucon.org>
References: <20010611210311.A8768@lucon.org> <20010612133925.B5106@bacchus.dhis.org> <20010612094055.B20012@lucon.org> <20010612211151.A27552@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612211151.A27552@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jun 12, 2001 at 09:11:51PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 09:11:51PM +0200, Ralf Baechle wrote:
> On Tue, Jun 12, 2001 at 09:40:55AM -0700, H . J . Lu wrote:
> 
> > FYI, my glibc includes
> > 
> >         * sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Commented out.
> 
> That means elf/dl-load.c will assume zero for the load address.  That will
> crash static programs which expect a value of 0x5ffe0000 and are trying to
> dlopen a shared library which uses a different value.  Most popular
> example is rpm.  So we need to keep ``#define MAP_BASE_ADDR(l) 0x5ffe0000''
> in there until we've got a real fix, unfortunately.
> 
> ABI requires us to properly support DT_MIPS_BASE_ADDRESS, so that needs
> to fixed for real anyway ...
> 

Please provide me some testcases. I will look into them.


H.J.
