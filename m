Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 21:33:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48462 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab0JQTdY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 21:33:24 +0200
Date:   Sun, 17 Oct 2010 20:33:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
In-Reply-To: <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com> <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 17 Oct 2010, Kevin Cernekee wrote:

> > 1) In linux ,esspecially in TLB refilling,  is Context[PTEBase] used
> > to store cpuid? (refer to build_get_pgde32 in tlbex.c)
> 
> On 32-bit systems, PTEBase stores a byte offset that can be added to
> &pgd_current[0].  i.e. smp_processor_id() * sizeof(unsigned long)
> 
> So the TLB refill handler can find pgd for the current CPU using code
> that looks something like this:
> 
>    0:   401b2000        mfc0    k1,c0_context
>    4:   3c1a8054        lui     k0,0x8054
>    8:   001bddc2        srl     k1,k1,0x17
>    c:   035bd821        addu    k1,k0,k1
> ...
>   14:   8f7b5008        lw      k1,20488(k1)
> 
> where pgd_current is at 0x8054_5008, and PTEBase is 0, 4, 8, 12, ...

 It has been always making me wonder (though not as much to go and dig 
through our code ;) ) why Linux is uncapable of using the value presented 
by the CPU in the CP0 Context register as is, or perhaps after a trivial 
operation such as a left-shift by a constant number of bits (where the 
size of the page entry slot assumed by hardware turned out too small).  
There should be no need to add another constant as in the piece of code 
you have quoted -- this constant should already have been preloaded to 
this register when switching the context the last time.  The design of the 
TLB refill exception in the MIPS Architecture has been such as to allow 
this register to be readily used as an address into the page table.  
Hmm...

  Maciej
