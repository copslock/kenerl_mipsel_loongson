Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IJJJ005681
	for linux-mips-outgoing; Fri, 18 Jan 2002 11:19:19 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IJJBP05674
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 11:19:12 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 04274125C1; Fri, 18 Jan 2002 10:19:09 -0800 (PST)
Date: Fri, 18 Jan 2002 10:19:08 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020118101908.C23887@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3elkoa5dw.fsf@myware.mynet>; from drepper@redhat.com on Thu, Jan 17, 2002 at 04:07:23PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 17, 2002 at 04:07:23PM -0800, Ulrich Drepper wrote:
> The time is near when we (well, I) well start a drastic move toward
> generally using thread registers.  Even in non-threaded code.
> 
> This means that unless all architectures get thread registers (or
> equivalent things like Alpha's special code) we'll have a two class
> society of platforms where all code written for the platforms without
> thread register can be run on the other systems, but not vice versa.
> 
> >From what I see today we have thread registers only on Alpha, x86,
> IA-64, SH, and x86_64.  SPARC shouldn't be too much of a problem.  Sun
> is using %g6 or %g7 (forgot which one) and since they define the ABI
> no big complications are expected.
> 
> Now, what is about the rest?  I assume cris isn't much of a problem
> since it's a purely embedded machine.
> 
> 
> Arm: don't know whether this should fall in the same category.
> Philip?
> 
> 
> m68k: Well, maybe it's time to retire these machines.  But on the
> other hand, there are those useless address registers.  Andreas, Jes?
> 
> 
> PPC (32-bit) is known to be a problem.  I've seen several proposals as
> to what register to use but haven't seen a final decision.  Problems
> with the different PPC implementations are probably hindering this.
> Geoff, could you please make a decision?  I hope the PPC64 ABI already
> allocated a thread register.
> 
> 
> S390: I have no idea.  Martin, please comment and make a decision.
> 
> 
> MIPS: Who feels responsible?  Andreas, HJ?
> 

I don't see there are any registers we can use without breaking ABI.
On the other hand, can we change the mips kernel to save k0 or k1 for
user space?

> 
> PA: no idea.  HP has no 32-bit ELF so.  But they have 64-bit ELF and
> it definitely has a thread register.
> 
> 
> 
> Please consider this a high priority task now.  I've been warning
> about this for a long time.  Jakub is working on some code and once
> this is ready for me to use I'll make lots of changes to ld.so and the
> locale handling and from that point on we have the two classes of
> architectures.
> 
> Oh, this now also concerns Hurd.  So, Roland, how far is using LDTs on
> Hurd/x86?
> 


H.J.
