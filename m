Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 17:00:50 +0100 (BST)
Received: from pop.gmx.de ([IPv6:::ffff:213.165.64.20]:10379 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225617AbVFNQAc>;
	Tue, 14 Jun 2005 17:00:32 +0100
Received: (qmail 21476 invoked by uid 0); 14 Jun 2005 16:00:25 -0000
Received: from 129.13.186.3 by www21.gmx.net with HTTP;
	Tue, 14 Jun 2005 18:00:26 +0200 (MEST)
Date:	Tue, 14 Jun 2005 18:00:26 +0200 (MEST)
From:	madprops@gmx.net
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
References: <17069.62407.584863.185198@mips.com>
Subject: Re: tlb magic
X-Priority: 3 (Normal)
X-Authenticated: #24801140
Message-ID: <18788.1118764826@www21.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <madprops@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madprops@gmx.net
Precedence: bulk
X-list: linux-mips


> 
> Thomas,
> 
> > I'm trying to understand how to implement an TLB Exception handler for a
> > MIPS32 ( 4KC ). As far as I got it, it makes sense to locate the user
> > process page tables in kseg2 to save physical memory. The book I'm
> reading
> > states another advantage using kseg2. I'm not quite sure what they mean,
> > stating that
> > 
> > "It provides an easy mechanism for remapping a new user page table when
> > changing context, without having to find enough virtual addresses in the
> OS
> > to map all the page tables at once. Instead, you just change the ASID
> value,
> > and the kseg2 pointer to the page table is now automatically remapped
> onto
> > the correct page table. It's nearly magic."
> 
> Sounds familiar.  Are you reading "See MIPS Run"?  If so, it has
> pictures and further explanation.  If not - well, no wonder you're
> confused (run down to Amazon and see if they have any copies left!)
> 
> > 1. Is there only one kseg2 containing all page tables for 256 processes,
> > i.e. only one ASID is used or
> > 
> > 2. Has each page table it's own address space ( using different ASID for
> > those addresses in kseg2 )
> 
> MIPS TLBs can be loaded with "global" entries which map regardless of
> ASID.  Linux (which doesn't use kseg2 for page tables) only ever uses
> global mappings to kseg2, which is therefore a shared space for all
> kernel threads.
> 
> I think the early BSD ports, for which the kseg2 trick was invented,
> did use per-process mappings in kseg2 for BSD's per-process data area
> and the page table.  The idea of using software to maintain the TLB
> freaked out potential customers back in 1987, so it was important to
> be able to show them a very short user-address TLB miss handler.
> 
> > 3. Will I need another untranslated page table in kseg0/kseg1 to
> translate
> > kseg2 addresses ?
> 
> Well, of course you don't *need* any particular format of page table,
> it's all done by software.  The only constraint here is that while
> special tricks on the R3000 allow the user-mode-address TLB-miss
> handler to take a nested exception (to fix up a missing translation
> for the page table), those tricks won't work for the
> kernel-mode-address TLB miss handler.
> 
> The BSD systems used kseg0 information to resolve kseg2
> translation misses, or kept the crucial 2nd-level information in
> places accessible through 'wired' (non-replaceable) TLB entries.
> 
> > 4. What is this kseg2 pointer they are talking about ?
> 
> It's probably a reference to the base of the page table, which is kept
> in the high-order bits of the CP0 register "Context".  
> 
> > 5. Are they talking about the ASID in EntryHi ?
> 
> Yes.  The ASID in EntryHi does double-duty: it is the "current" ASID
> for the running process, and also the place where the ASID field of a
> TLB entry gets lodged when the TLB is read/written.
> 
> > 6. Where is the magic ?
> 
> In the eye of the beholder.
> 
> Was that any help?
> 
> --
> Dominic Sweetman
> MIPS Technologies
> 

Hi,

yes, I'm reading "See MIPS Run". So thanks for the online support that comes
with it. Now, if I got it correctly, the exception routing described in
section 6.7 uses per-process mappings for kseg2, i.e. that e.g. the first
2MB of (each) kseg2 are used  as page table of the corresponding process and
maybe another few kb for process related stuff. Provided the page tables are
continuously at the same address ( e.g. KSEG2_BASE ) a change of ASID in
EntryHi would indeed make a change of the kseg2 pointer in Context
unnecessary ( it always points to KSEG2_BASE ). The mapping of kseg2 would
automatically change as the global bit is set to zero. 

Using the standard page table approach I would now need an additional page
table for each process in order to map those 2+x MB in kseg2 which I could
put in kseg0/1 or in kseg2 with 'wired' TLB entries.

If that's the way to go - why is it only used in early BSD ports of like
1987 ? Are there any troubles with it or have other mechanisms turned out to
be better for any reason ?

Regards,

Thomas

 

-- 
Geschenkt: 3 Monate GMX ProMail gratis + 3 Ausgaben stern gratis
++ Jetzt anmelden & testen ++ http://www.gmx.net/de/go/promail ++
