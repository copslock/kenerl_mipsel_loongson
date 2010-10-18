Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 02:00:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47550 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491169Ab0JRAAe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Oct 2010 02:00:34 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9I00V5x015842;
        Mon, 18 Oct 2010 01:00:31 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9I00V7O015841;
        Mon, 18 Oct 2010 01:00:31 +0100
Date:   Mon, 18 Oct 2010 01:00:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
Message-ID: <20101018000030.GB31080@linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
 <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
 <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 17, 2010 at 08:33:24PM +0100, Maciej W. Rozycki wrote:

> > > 1) In linux ,esspecially in TLB refilling,  is Context[PTEBase] used
> > > to store cpuid? (refer to build_get_pgde32 in tlbex.c)
> > 
> > On 32-bit systems, PTEBase stores a byte offset that can be added to
> > &pgd_current[0].  i.e. smp_processor_id() * sizeof(unsigned long)
> > 
> > So the TLB refill handler can find pgd for the current CPU using code
> > that looks something like this:
> > 
> >    0:   401b2000        mfc0    k1,c0_context
> >    4:   3c1a8054        lui     k0,0x8054
> >    8:   001bddc2        srl     k1,k1,0x17
> >    c:   035bd821        addu    k1,k0,k1
> > ...
> >   14:   8f7b5008        lw      k1,20488(k1)
> > 
> > where pgd_current is at 0x8054_5008, and PTEBase is 0, 4, 8, 12, ...
> 
>  It has been always making me wonder (though not as much to go and dig 
> through our code ;) ) why Linux is uncapable of using the value presented 
> by the CPU in the CP0 Context register as is, or perhaps after a trivial 
> operation such as a left-shift by a constant number of bits (where the 
> size of the page entry slot assumed by hardware turned out too small).  
> There should be no need to add another constant as in the piece of code 
> you have quoted -- this constant should already have been preloaded to 
> this register when switching the context the last time.  The design of the 
> TLB refill exception in the MIPS Architecture has been such as to allow 
> this register to be readily used as an address into the page table.  
> Hmm...

The design of the R4000 c0_context / c0_xcontext register assumes 8 byte
ptes and a flat page table array.  You can map the pagetables into virtual
memory to get that and in fact very old Linux/MIPS versions did that but
that approach may result in aliases on some processors so I eventually
dropped it.  The implementation requires nested TLB refill implementations
and (Linux/MIPS was still using a.out in this days) I implemented a new
relocation type to squeeze a cycle out of the slow path.

The aliasing problem is solvable and it may be worth to revisit that old
piece of code again now 15 years later.

  Ralf
