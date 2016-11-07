Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 13:05:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGMFOJc9ks (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 13:05:14 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AC616613952BF;
        Mon,  7 Nov 2016 12:05:05 +0000 (GMT)
Received: from [10.20.78.46] (10.20.78.46) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 7 Nov 2016
 12:05:07 +0000
Date:   Mon, 7 Nov 2016 12:04:58 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 02/10] MIPS: tlbex: Clear ISA bit when writing to
 handle_tlb{l,m,s}
In-Reply-To: <20161107111417.11486-3-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.20.17.1611071145260.10580@tp.orcam.me.uk>
References: <20161107111417.11486-1-paul.burton@imgtec.com> <20161107111417.11486-3-paul.burton@imgtec.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.46]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55706
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

On Mon, 7 Nov 2016, Paul Burton wrote:

> When generating TLB exception handling code we write to memory reserved
> at the handle_tlbl, handle_tlbm & handle_tlbs symbols. Up until now the
> ISA bit has always been clear simply because the assembly code reserving
> the space for those functions places no instructions in them. In
> preparation for marking all LEAF functions as containing code,
> explicitly clear the ISA bit when calculating the addresses at which to
> write TLB exception handling code.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---

 You can avoid this extra code and unnecessary run-time calculation by 
defining a data alias and using that instead.  E.g. (expanding LEAF):

		.globl	handle_tlbl
		.globl	handle_tlbl_data
		.align	2
		.type	handle_tlbl, @function
		.ent	handle_tlbl, 0
handle_tlbl:
handle_tlbl_data = .
		.frame  sp, 0, ra

will make `handle_tlbl' and `handle_tlbl_data' both refer to the same 
location, hovewer the latter not being a (code) label will have the ISA 
bit clear, so you'll be able to use it in `build_r4000_tlb_load_handler' 
without a need to clear the ISA bit explicitly as it won't have been set 
in the first place.  See how this comes out in `objdump'.

 You might want to wrap the above piece in a macro, I suppose, maybe even 
do it implicitly in LEAF, etc, or maybe just follow the path of least 
resistance and use:

LEAF(handle_tlbl)
ABS(handle_tlbl_data, .)

etc. in arch/mips/mm/tlb-funcs.S, relying on both macros' internals -- 
being a pseudo `.frame' should not affect the value of `handle_tlbl_data' 
whether it precedes or follows the assignment operation.

 You could use `.set' or `.equ' in place of `=' too; there's also `.equiv' 
with a slightly different semantics as it bails out on an attempt of 
symbol redefinition while the other three ways do not.

 HTH,

  Maciej
