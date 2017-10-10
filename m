Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2017 04:27:49 +0200 (CEST)
Received: from resqmta-ch2-11v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:43]:52864
        "EHLO resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbdJJC1macUlY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2017 04:27:42 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id 1kEDeGVdhksXb1kEGeLqDt; Tue, 10 Oct 2017 02:25:08 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-19v.sys.comcast.net with SMTP
        id 1kEEeVc640htf1kEFeXRqp; Tue, 10 Oct 2017 02:25:08 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Question regarding atomic ops
To:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
Date:   Mon, 9 Oct 2017 22:24:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGj/zyQBkHZueSMIHIpOHmPD6Ip4qLdQjXKB7JZzfN+g5vZrZ0Hh/cgR9/Xi5kk4mt//k0TwDYd0aPYV/6sy3Hb2nSsbyNpCUhRNUDpZWE5Z5YIc9MrJ
 x6k6CHzycMozo3f78oyDgnKIMop3oxP7+PwCZ+MP00kLJuifTV2Md78YSBnNICfB+dcJOCF3axsyGQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Regarding the issues with IP27, one thing I am noticing a lot when I
disassemble an address found in epc or ErrEPC of a "stuck" kernel, is that
sometimes, I keep getting directed back to arch/mips/include/asm/atomic.h:181:

#define ATOMIC_OPS(op, c_op, asm_op)					      \
	ATOMIC_OP(op, c_op, asm_op)					      \
	ATOMIC_OP_RETURN(op, c_op, asm_op)				      \
	ATOMIC_FETCH_OP(op, c_op, asm_op)

ATOMIC_OPS(add, +=, addu)   <-- HERE
ATOMIC_OPS(sub, -=, subu)


So looking at the code, what stands out to me is that the "(kernel_uses_llsc &&
R10000_LLSC_WAR)" inline asm code:

	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
		int temp;						      \
									      \
		__asm__ __volatile__(					      \
		"	.set	arch=r4000				\n"   \
		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
		"	" #asm_op " %0, %2				\n"   \
		"	sc	%0, %1					\n"   \
		"	beqzl	%0, 1b					\n"   \
		"	.set	mips0					\n"   \
		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
		: "Ir" (i));						      \


Is substantially different from the standard "kernel_uses_llsc" inline asm:

	} else if (kernel_uses_llsc) {					      \
		int temp;						      \
									      \
		do {							      \
			__asm__ __volatile__(				      \
			"	.set	"MIPS_ISA_LEVEL"		\n"   \
			"	ll	%0, %1		# atomic_" #op "\n"   \
			"	" #asm_op " %0, %2			\n"   \
			"	sc	%0, %1				\n"   \
			"	.set	mips0				\n"   \
			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  \
			: "Ir" (i));					      \
		} while (unlikely(!temp));				      \


(Above is from "atomic_##op" -> #define ATOMIC_OP, starting on line 44 in
current git)


My understanding of what R10000_LLSC_WAR handles, in most cases, is the use of
a "beqzl" instruction over "beqz", due to a silicon bug in earlier R10000 CPUs.
 R10K CPUs with silicon rev >~3.0, R12K, R14K, and R16K are all unaffected and
should be able to safely use the non-R10000_LLSC_WAR branch.  Current upstream
however, does not distinguish between different members of the R10K family,
thus it forces ALL R10K CPUs to take the R10000_LLSC_WAR path.

I've got a patch that splits R10000 support up into plain "R10000" and then
"R12K/R14K/R16K", with the latter case //disabling// the R10000_LLSC_WAR flag.
Thus, because of this change, on my systems, I am executing the standard
"kernel_uses_llsc" inline asm code and this newer code probably does not play
very nicely on these older CPUs.

Checking through a couple of git logs, it looks like the development on later
MIPS ISAs (R2+) on the newer CPUs has been tweaking the atomic ops case for
standard "kernel_uses_llsc", and ignoring the R10000_LLSC_WAR block entirely.
I suspect this is in an attempt by some to not break what is probably assumed
to be working code for systems few people have access to.

Does this sound accurate?

I found that the first of these changes occurred almost 7 years ago this month
between 2.6.36 and 2.6.37 w/ commit 7837314d141c:

https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=7837314d141c661c70bc13c5050694413ecfe14a

This raises the question of why was the standard "kernel_uses_llsc" case
changed but not the R10000_LLSC_WAR case?  The changes seem like they would be
applicable to the older R10K CPUs regardless, since this is before a lot of the
code for the newer ISAs (R2+) was added.  I am getting a funny feeling that a
lot of these templates need to be re-written (maybe even in plain C, given
newer gcc's better intelligence) and other useful cleanups done.  I am not
fluent in MIPS asm enough, though, to know what to change.

I'm going to experiment with backing out some of the more recent changes
specific to the newer ISAs/CPUs and set it up so that the main difference
between the R10000_LLSC_WAR case and the standard case is just plain "beqzl"
versus "beqz" and see if this makes my issues on IP27 go away.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
