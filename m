Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2016 17:20:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28460 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992943AbcLEQUoB-bej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2016 17:20:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8103736C9BF4D;
        Mon,  5 Dec 2016 16:20:34 +0000 (GMT)
Received: from [10.20.78.176] (10.20.78.176) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 5 Dec 2016
 16:20:36 +0000
Date:   Mon, 5 Dec 2016 16:20:27 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Only change $28 to thread_info if coming from
 user mode
In-Reply-To: <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1612051605590.6743@tp.orcam.me.uk>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com> <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.176]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55943
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

On Fri, 2 Dec 2016, Matt Redfearn wrote:

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index eebf39549606..5782fa3d63be 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -216,12 +216,22 @@
>  		LONG_S	$25, PT_R25(sp)
>  		LONG_S	$28, PT_R28(sp)
>  		LONG_S	$31, PT_R31(sp)
> +
> +		/* Set thread_info if we're coming from user mode */
> +		.set	reorder
> +		mfc0	k0, CP0_STATUS
> +		sll	k0, 3		/* extract cu0 bit */
> +		.set	noreorder
> +		bltz	k0, 9f
> +		 nop

 This code is already `.set reorder', although a badly applied CONFIG_EVA 
change made things slightly less obvious.  So why do you need this `.set 
reorder' in the first place, and then why do you switch code that follows 
to `.set noreorder'?

 Overall I think all <asm/stackframe.h> code should be using the (default) 
`.set reorder' mode, perhaps forced explicitly in case these macros are 
pasted into `.set noreorder' code, to make it easier to avoid subtle data 
dependency bugs, and also to make R6 porting easier.  Except maybe for the 
RFE sequence, for readability's sake, although even there GAS will do the 
right thing.  Surely the BLTZ/MOVE piece does not have to be `.set 
noreorder' as GAS will schedule that delay slot automatically if allowed 
to.

  Maciej
