Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 23:56:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55045 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab0JQV4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 23:56:31 +0200
Date:   Sun, 17 Oct 2010 22:56:31 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
In-Reply-To: <AANLkTima9n88kAXJbYSr-m_vJnxbEod3VEeW4gLgYyj8@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010172247180.15889@eddie.linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>        <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>        <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
 <AANLkTima9n88kAXJbYSr-m_vJnxbEod3VEeW4gLgYyj8@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 17 Oct 2010, Kevin Cernekee wrote:

> On plain old 32-bit MIPS:
> 
> The pgd entry for "va" is at address: (unsigned long)pgd + ((va >> 22) << 2)
> 
> i.e. each 4-byte entry in the pgd table represents 4MB of virtual address space.
> 
> PTEBase only gives you 9 bits to work with.  If you use it to store
> pgd[31:23] directly, that means every pgd needs to be 8MB-aligned -
> ouch.

 Good point!  I believe the original idea behind the Context and XContext 
registers was to put page tables somewhere within KSEG2/3 or XKSSEG which 
would make this alignment restriction not a problem, but I realise the 
overhead of placing page tables in paged memory may be higher than that of 
our current arrangement.

 I wonder however if such performance evaluation was actually ever made or 
whether it was the complexity of having page tables paged alone that 
scared people off. ;)

  Maciej
