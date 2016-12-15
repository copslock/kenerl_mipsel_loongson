Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2016 12:52:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14698 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991948AbcLOLwPPN0yy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2016 12:52:15 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7FF94E1FCFD61;
        Thu, 15 Dec 2016 11:52:06 +0000 (GMT)
Received: from [10.20.78.232] (10.20.78.232) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 15 Dec 2016
 11:52:08 +0000
Date:   Thu, 15 Dec 2016 11:51:54 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 3/5] MIPS: Only change $28 to thread_info if coming
 from user mode
In-Reply-To: <1481626745-4290-4-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1612150120400.6743@tp.orcam.me.uk>
References: <1481626745-4290-1-git-send-email-matt.redfearn@imgtec.com> <1481626745-4290-4-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.232]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56056
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

On Tue, 13 Dec 2016, Matt Redfearn wrote:

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index eebf39549606..e13164daf9c2 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -216,12 +216,20 @@
>  		LONG_S	$25, PT_R25(sp)
>  		LONG_S	$28, PT_R28(sp)
>  		LONG_S	$31, PT_R31(sp)
> +
> +		/* Set thread_info if we're coming from user mode */
> +		mfc0	k0, CP0_STATUS
> +		sll	k0, 3		/* extract cu0 bit */
> +		bltz	k0, 9f
> +		 nop
> +

 Have you actually verified the machine code generated as expected with 
such a change?  This supposedly delay-slot NOP can be dropped as this is 
`.set reorder' code, so GAS will have scheduled a NOP itself already, 
having found there is an SLL->BLTZ data dependency and consequently the 
two instructions cannot be swapped.  So now there'll be an extraneous NOP 
there, wasting code space and execution time.

  Maciej
