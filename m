Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 11:39:51 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:43914 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22284739AbYJXKjo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 11:39:44 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9EB8E3ECB; Fri, 24 Oct 2008 03:39:36 -0700 (PDT)
Message-ID: <4901A5E3.3090702@ru.mvista.com>
Date:	Fri, 24 Oct 2008 14:39:31 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 28/37] Cavium OCTEON FPU EMU exception as TLB exception
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-29-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1224809821-5532-29-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

ddaney@caviumnetworks.com wrote:

> The FPU exceptions come in as TLB exceptions -- see if this is
> one of them, and act accordingly.
>
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/fault.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index fa636fc..9ce503a 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -47,6 +47,21 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>  	       field, regs->cp0_epc);
>  #endif
>  
> +#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
>   

   Why this is not in the same patch that introduces this option?

> +	/*
> +	 * Normally the FPU emulator uses a load word from address one
> +	 * to retake control of the CPU after executing the
> +	 * instruction in the delay slot of an emulated branch. The
> +	 * Octeon hardware unaligned access fix changes this from an
> +	 * address exception into a TLB exception. This code checks to
> +	 * see if this page fault was caused by an FPU emulation.
> +	 *
> +	 * Terminate if exception was recognized as a delay slot return */
>   

   I'm back to nitpicking again, see chapter 8 for the preferred 
multiuline comment style (you almost got it right :-).

> +	extern int do_dsemulret(struct pt_regs *);
>   

   Won't this cause a warning about the declaration amidst of code? You 
should be able to put it in this function's declaration block painlessly...

WBR. Sergei
