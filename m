Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 22:59:11 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:50133 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22318763AbYJXV7H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 22:59:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OLx5FP001238;
	Fri, 24 Oct 2008 22:59:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OLx4e4001236;
	Fri, 24 Oct 2008 22:59:04 +0100
Date:	Fri, 24 Oct 2008 22:59:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: Question about rdhwr emulation.
Message-ID: <20081024215904.GM25297@linux-mips.org>
References: <48FE7BEB.80906@caviumnetworks.com> <alpine.LFD.1.10.0810220218310.29554@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810220218310.29554@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 22, 2008 at 02:35:21AM +0100, Maciej W. Rozycki wrote:

>  This probe is necessary, because for a VIVT I-cache, code from there may 
> be executed even if there is no mapping stored for the virtual address of 
> the instruction in the TLB anymore.  However this trap handler wants to 
> read the instruction word from the memory and obviously this goes through 
> the D-cache which is not virtually tagged.  As such a TLB refill exception 
> would happen if the mapping was indeed absent.
> 
>  However, please note that this piece of code runs at the exception level 
> and therefore such a scenario would qualify as a nested exception.  Which 
> means the general exception vector would be used and the TLBL or TLBS 
> handler invoked as appropriate.  Neither of which are currently prepared 
> to do a refill.  Changing that would be rather trivial as it boils down to 
> checking the value of cp0.index.p and executiong TLBWR rather than TLBWI 
> as usual, but that is in the fast path, so we do not want to waste cycles 
> for such a corner case as RDHWR emulation.

To clarify, this behaviour of hitting in an VIVT I-cache even though there
is no address translation in the TLB is allowed but not required by the
the MIPS architecture spec.  From a software perspective it's a bit
quirky but it allows faster pipeline implementations.  The currently
supported VIVT I-cache processors are the SB1, 20K and 25K.  The SB1
has this behaviour; of the 20K and 25K I don't know.

  Ralf
