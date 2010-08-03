Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 22:54:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44702 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492840Ab0HCUyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 22:54:39 +0200
Date:   Tue, 3 Aug 2010 21:54:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com, linux-kernel@vger.kernel.org,
        hschauhan@nulltrace.org
Subject: Re: [PATCH 2/5] MIPS: Add instrunction format for BREAK and
 SYSCALL
In-Reply-To: <1280859742-26364-3-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1008032150060.20999@eddie.linux-mips.org>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com> <1280859742-26364-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 3 Aug 2010, David Daney wrote:

> diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
> index 6489f00..444ff71 100644
> --- a/arch/mips/include/asm/inst.h
> +++ b/arch/mips/include/asm/inst.h
> @@ -247,6 +247,12 @@ struct ma_format {	/* FPU multipy and add format (MIPS IV) */
>  	unsigned int fmt : 2;
>  };
>  
> +struct b_format { /* BREAK and SYSCALL */
> +	unsigned int opcode:6;
> +	unsigned int code:20;
> +	unsigned int func:6;
> +};
> +
>  #elif defined(__MIPSEL__)
>  
>  struct j_format {	/* Jump format */

 Please note the code field of the BREAK instruction is by toolchain 
convention (bug-compatibility with the original MIPS assembler or 
suchlike) treated as a pair of swapped 10-bit fields -- you may want to 
double-check consistency of interpretation with usage elsewhere.

  Maciej
