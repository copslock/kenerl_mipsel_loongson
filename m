Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4H0K1q26619
	for linux-mips-outgoing; Wed, 16 May 2001 17:20:01 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4H0K0F26616
	for <linux-mips@oss.sgi.com>; Wed, 16 May 2001 17:20:00 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id RAA04181;
	Wed, 16 May 2001 17:19:05 -0700
Date: Wed, 16 May 2001 17:19:05 -0700
From: Jun Sun <jsun@mvista.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, Linux-MIPS <linux-mips@oss.sgi.com>,
   Chuck Storey <Chuck_Storey@pmc-sierra.com>, Harry White <harry@momenco.com>
Subject: Re: PATCH: Extended Interrupt support for the RM7000-based Ocelot
Message-ID: <20010516171905.D2798@mvista.com>
References: <NEBBLJGMNKKEEMNLHGAICEHGCBAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICEHGCBAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, May 16, 2001 at 04:27:27PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 16, 2001 at 04:27:27PM -0700, Matthew Dharm wrote:
> Attached is a patch which adds support for extended interrupt devices
> to the Ocelot.  It was created against a current CVS snapshot.  Ralf,
> please apply.
> 
> The patch basically re-writes the interrupt handler to read the
> extended interrupt mask from the Set 1 registers on the QED RM7000.
> It also changes the support functions so that these interrupts can be
> masked and unmasked properly.
> 
> It occurs to me that this probably should go (eventually) into an
> RM7k-specific file, and not an Ocelot specific file.  But the current
> arch/mips/ tree doesn't seem to support this well, so I figured that
> for a first pass, keeping everything where it current is will cause
> the least confusion.
> 

The best way to support RM7K extended interrupts is to use the new
irq.c and write rm7k irq controller code, (e.g., irq_cpu_rm7k.c).
It should be similar to one I sent out (irq_cpu.c file) a while back.  
If you cannot find it, I can send you again.

The modification to the common files looks a little bit instrusive.
But I won't complain if Ralf does not - he usually has a higher
standard. :-)

Jun
