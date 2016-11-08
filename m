Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 12:17:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47597 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbcKHLRTlQUtg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2016 12:17:19 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9DED86A1511A4;
        Tue,  8 Nov 2016 11:17:10 +0000 (GMT)
Received: from [10.20.78.54] (10.20.78.54) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 8 Nov 2016
 11:17:12 +0000
Date:   Tue, 8 Nov 2016 11:17:02 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] MIPS: R2-on-R6 emulation bugfix of BLEZL and BGTZL
 instructions
In-Reply-To: <20161107183928.27456.13089.stgit@ubuntu-yegoshin>
Message-ID: <alpine.DEB.2.20.17.1611080426360.10580@tp.orcam.me.uk>
References: <20161107183928.27456.13089.stgit@ubuntu-yegoshin>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.54]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 7 Nov 2016, Leonid Yegoshin wrote:

> MIPS R2 emulation doesn't take into account that BLEZL and BGTZL instructions
> require register RT = 0. If it is not zero it can be some legitimate MIPS R6
> instruction.

 Well, it *is* rather than just can be -- one of BLEZC/BGEZC/BGEC or 
BGTZC/BLTZC/BLTC, respectively, according to the bit patterns in RS/RT, 
all these instructions being compact branches, so we can stop emulation 
rather than decoding them.

 Also please line-wrap your description at 75 columns, as per 
Documentation/SubmittingPatches.

> diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
> index 22dedd62818a..b0c86b08c0b9 100644
> --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
> +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
> @@ -919,6 +919,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
>  		BUG();
>  		return SIGEMT;
>  	}
> +	err = 0;
>  	pr_debug("Emulating the 0x%08x R2 instruction @ 0x%08lx (pass=%d))\n",
>  		 inst, epc, pass);

 Is this because of BRANCH_LIKELY_TAKEN?  It has to be a separate patch 
then, with a suitable description.

> @@ -1096,10 +1097,16 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst,
> unsigned long *fcr31)
>  		}
>  		break;
>  
> -	case beql_op:
> -	case bnel_op:
>  	case blezl_op:
>  	case bgtzl_op:
> +		/* return MIPS R6 instruction to CPU execution */
> +		if (MIPSInst_RT(inst)) {
> +			err = SIGILL;
> +			break;
> +		}

 Please add:

		/* Fall through.  */

here so that it is clear it's not a bug; also GCC 7 will catch such cases 
and issue warnings, which I expect according to our settings will cause a 
build failure here if this is missing.

> +
> +	case beql_op:
> +	case bnel_op:

 This part looks fine to me otherwise.

  Maciej
