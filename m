Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JN8ah28560
	for linux-mips-outgoing; Tue, 19 Feb 2002 15:08:36 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JN8V928557;
	Tue, 19 Feb 2002 15:08:31 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03364; Tue, 19 Feb 2002 14:08:29 -0800 (PST)
	mail_from (jsun@orion.mvista.com)
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id OAA25805;
	Tue, 19 Feb 2002 14:02:57 -0800
Date: Tue, 19 Feb 2002 14:02:57 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, carstenl@mips.com,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219140257.B25739@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <006d01c1b606$21929c80$0deca8c0@Ulysses> <20020215115711.A26798@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215115711.A26798@dea.linux-mips.net>; from ralf@oss.sgi.com on Fri, Feb 15, 2002 at 11:57:11AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 11:57:11AM +0100, Ralf Baechle wrote:
> On Fri, Feb 15, 2002 at 09:14:52AM +0100, Kevin D. Kissell wrote:
> 
> > I submitted a series of patches a year or so ago, the
> > last of which really should have been a comprehensive
> > fix to the FPU context switch and signal problems.
> > The last time I looked, that patch had never made it into
> > the OSS repository, but neither had anyone reported
> > any holes in it.
> 
> I was actually beliving that the bundle of patches I received from
> Carsten maybe 3 months ago did fix all the issues?
>

False alarm - I did some tests and kgdb trace, and confirmed that the 
the current FPU code indeed solved all the fpu/signal problems that 
I know of.  Good to know we can actually make things work!

Jun 
