Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15LD5Z14875
	for linux-mips-outgoing; Tue, 5 Feb 2002 13:13:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15LD1A14871
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 13:13:02 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g15LAoB19474;
	Tue, 5 Feb 2002 13:10:50 -0800
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
From: Pete Popov <ppopov@pacbell.net>
To: sjhill@cotw.com
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C6044A7.13FEB2E2@cotw.com>
References: <200202051747.SAA21696@copsun18.mips.com> 
	<3C6044A7.13FEB2E2@cotw.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 05 Feb 2002 13:15:09 -0800
Message-Id: <1012943709.10659.106.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-02-05 at 12:46, Steven J. Hill wrote:
> Hartvig Ekner wrote:
> > 
> > You have to distinguish between physical and virtual memory. The MIPS32
> > architecture supports implementations with up to 36 bits of physical
> > address space, however the virtual address space in kernel and user mode
> > is as you describe below.
> > 
> I wasn't talking about the MIP32[tm] cores specifically, I was using a
> generalization of 32bit. However, this is good to know. All of the data
> sheets that I just downloaded from the MIPS site for the R4k[X] cores
> don't mention the 36-bit PA item. Care to elaborate?
> 
> > One note: Many MIPS32 implementations choose not to implement all 36 PA
> > bits, but limit themselves to 32 bits. This saves a few bits in the TLB
> > and a few address lines.
> > 
> So, if someone did want 36 PA bits on Linux, the TLB exception handlers
> and a little of the page table construction/management code would have to
> change. The userspace contraints and such would still remain. Cool.

I'm not sure if it's a "little" though.  Ralf has already done the work
for 64bit memory support on 32bit kernels, but that only works currently
on 64bit CPUs.  I started hacking on the 64bit memory patch to get it to
work on 32bit processors, but had to put that aside for a few weeks. I
hope to get back to it soon.

Pete
