Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 02:35:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:21739 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22055198AbYJVBfV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 02:35:21 +0100
Date:	Wed, 22 Oct 2008 02:35:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Question about rdhwr emulation.
In-Reply-To: <48FE7BEB.80906@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810220218310.29554@ftp.linux-mips.org>
References: <48FE7BEB.80906@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 21 Oct 2008, David Daney wrote:

> I was looking at the rdhwr emulation code in genex.S and wondering about the
> following:
> 
> If cpu_has_vtag_icache is true we run handle_ri_rdhwr_vivt() instead of
> handle_ri_rdhwr().
> 
> And handle_ri_rdhwr_vivt() probes the tlb to see if the faulting instruction
> can be reached through the TLB, if it can the 'fast path' is taken, otherwise
> the 'slow path'.
> 
> Why is this probe of the TLB necessary?  Or perhaps more concisely under which
> conditions can I set cpu_has_vtag_icache to false (noting that for our cpu
> this is the only place cpu_has_vtag_icache is tested)?

 Hmm, if the I-cache is physically tagged?

 This probe is necessary, because for a VIVT I-cache, code from there may 
be executed even if there is no mapping stored for the virtual address of 
the instruction in the TLB anymore.  However this trap handler wants to 
read the instruction word from the memory and obviously this goes through 
the D-cache which is not virtually tagged.  As such a TLB refill exception 
would happen if the mapping was indeed absent.

 However, please note that this piece of code runs at the exception level 
and therefore such a scenario would qualify as a nested exception.  Which 
means the general exception vector would be used and the TLBL or TLBS 
handler invoked as appropriate.  Neither of which are currently prepared 
to do a refill.  Changing that would be rather trivial as it boils down to 
checking the value of cp0.index.p and executiong TLBWR rather than TLBWI 
as usual, but that is in the fast path, so we do not want to waste cycles 
for such a corner case as RDHWR emulation.

 I hope this helps.

  Maciej
