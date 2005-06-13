Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 22:02:02 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:31757 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225893AbVFMVBq>;
	Mon, 13 Jun 2005 22:01:46 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DhwLz-0002ns-00; Mon, 13 Jun 2005 22:20:19 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Dhw2y-0007c6-00; Mon, 13 Jun 2005 22:00:41 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17069.62407.584863.185198@mips.com>
Date:	Mon, 13 Jun 2005 21:59:51 +0100
To:	"Mad Props" <madprops@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: tlb magic
In-Reply-To: <31886.1118671594@www68.gmx.net>
References: <31886.1118671594@www68.gmx.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.835,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Thomas,

> I'm trying to understand how to implement an TLB Exception handler for a
> MIPS32 ( 4KC ). As far as I got it, it makes sense to locate the user
> process page tables in kseg2 to save physical memory. The book I'm reading
> states another advantage using kseg2. I'm not quite sure what they mean,
> stating that
> 
> "It provides an easy mechanism for remapping a new user page table when
> changing context, without having to find enough virtual addresses in the OS
> to map all the page tables at once. Instead, you just change the ASID value,
> and the kseg2 pointer to the page table is now automatically remapped onto
> the correct page table. It's nearly magic."

Sounds familiar.  Are you reading "See MIPS Run"?  If so, it has
pictures and further explanation.  If not - well, no wonder you're
confused (run down to Amazon and see if they have any copies left!)

> 1. Is there only one kseg2 containing all page tables for 256 processes,
> i.e. only one ASID is used or
> 
> 2. Has each page table it's own address space ( using different ASID for
> those addresses in kseg2 )

MIPS TLBs can be loaded with "global" entries which map regardless of
ASID.  Linux (which doesn't use kseg2 for page tables) only ever uses
global mappings to kseg2, which is therefore a shared space for all
kernel threads.

I think the early BSD ports, for which the kseg2 trick was invented,
did use per-process mappings in kseg2 for BSD's per-process data area
and the page table.  The idea of using software to maintain the TLB
freaked out potential customers back in 1987, so it was important to
be able to show them a very short user-address TLB miss handler.

> 3. Will I need another untranslated page table in kseg0/kseg1 to translate
> kseg2 addresses ?

Well, of course you don't *need* any particular format of page table,
it's all done by software.  The only constraint here is that while
special tricks on the R3000 allow the user-mode-address TLB-miss
handler to take a nested exception (to fix up a missing translation
for the page table), those tricks won't work for the
kernel-mode-address TLB miss handler.

The BSD systems used kseg0 information to resolve kseg2
translation misses, or kept the crucial 2nd-level information in
places accessible through 'wired' (non-replaceable) TLB entries.

> 4. What is this kseg2 pointer they are talking about ?

It's probably a reference to the base of the page table, which is kept
in the high-order bits of the CP0 register "Context".  

> 5. Are they talking about the ASID in EntryHi ?

Yes.  The ASID in EntryHi does double-duty: it is the "current" ASID
for the running process, and also the place where the ASID field of a
TLB entry gets lodged when the TLB is read/written.

> 6. Where is the magic ?

In the eye of the beholder.

Was that any help?

--
Dominic Sweetman
MIPS Technologies
