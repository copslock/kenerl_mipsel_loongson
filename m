Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 06:05:19 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60815 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009730AbbAKFFRw--ym (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 06:05:17 +0100
Date:   Sun, 11 Jan 2015 05:05:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Mans Rullgard <mans@mansr.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant
 divisor
In-Reply-To: <1415290998-10328-1-git-send-email-mans@mansr.com>
Message-ID: <alpine.LFD.2.11.1501110448011.22270@eddie.linux-mips.org>
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 6 Nov 2014, Mans Rullgard wrote:

> This is an adaptation of the optimised do_div() for ARM by
> Nicolas Pitre implementing division by a constant using a
> multiplication by the inverse.  Ideally, the compiler would
> do this internally as it does for 32-bit operands, but it
> doesn't.
> 
> This version of the code requires an assembler with support
> for the DSP ASE syntax since accessing the hi/lo registers
> sanely from inline asm is impossible without this.  Building
> for a CPU without this extension still works, however.

 Well it also requires MADDU that is not always there; only added with 
MIPS32/MIPS64 and scarcely present as a vendor extension beforehand.  
However...

> +		} else {						\
> +			__t = __m;					\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q2, %L3, %L4	\n"             \
> +                                "mflo	%L0, %q2	\n"             \
> +                                "mfhi	%M0, %q2	\n"             \

[Some formatting issue here.]

> +				"sltu	%1,  %L0, %L3	\n"		\
> +				"addu	%L0, %M0, %1	\n"		\
> +				"sltu	%M0, %L0, %M3	\n"		\
> +				".set	pop		\n"		\
> +				: "=&r"(__res), "=&r"(__c), "+&ka"(__t) \
> +				: "r"(__m), "r"(__n));			\
> +		}							\
> +		if (!(__m & ((1ULL << 63) | (1ULL << 31)))) {		\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q0, %M2, %L3	\n"		\
> +				"maddu	%q0, %L2, %M3	\n"		\
> +				"mfhi	%1,  %q0	\n"		\
> +				"mthi	$0,  %q0	\n"		\
> +				"mtlo	%1,  %q0	\n"		\
> +				"maddu	%q0, %M2, %M3	\n"		\
> +				".set	pop		\n"		\
> +				: "+&ka"(__res), "=&r"(__c)		\
> +				: "r"(__m), "r"(__n));			\
> +		} else {						\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q0, %M3, %L4	\n"		\
> +				"mfhi	%2,  %q0	\n"		\
> +				"maddu	%q0, %L3, %M4	\n"		\
> +				"mfhi	%1,  %q0	\n"		\
> +				"sltu	%2,  %1,  %2	\n"		\
> +				"mtlo	%1,  %q0	\n"		\
> +				"mthi	%2,  %q0	\n"		\
> +				"maddu	%q0, %M3, %M4	\n"		\
> +				".set	pop		\n"		\
> +				: "+&ka"(__res), "=&r"(__z), "=&r"(__c) \
> +				: "r"(__m), "r"(__n));			\
> +		}							\

 ... is there actually a need to implement these blocks as inline assembly 
code?  It looks to me like these are straightforward operations, GCC 
should be able to produce reasonable code easily.

 Plus using the extra DSP accumulators in the kernel is not allowed with 
our code structure as it stands, they are not saved/restored on a kernel 
entry/return and are not call-saved registers in the ABI, so their user 
values will get clobbered here.

  Maciej
