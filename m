Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 19:59:13 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:41743 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007366AbaLRS7LISZ3X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 19:59:11 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 219D11538A; Thu, 18 Dec 2014 18:59:05 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains for MIPS R6 support
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
        <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
        <549321F3.1090704@gmail.com>
Date:   Thu, 18 Dec 2014 18:59:05 +0000
In-Reply-To: <549321F3.1090704@gmail.com> (David Daney's message of "Thu, 18
        Dec 2014 10:50:27 -0800")
Message-ID: <yw1xfvcchjie.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

David Daney <ddaney.cavm@gmail.com> writes:

> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
>> offset field to 9-bits. This has some undesired effects with the "m"
>> constrain since it implies a 16-bit immediate. As a result of which,
>> add a register ("r") constrain as well to make sure the entire address
>> is loaded to a register before the LL/SC operations. Also use macro
>> to set the appropriate ISA for the asm blocks
>>
>
> Has support for MIPS R6 been added to GCC?
>
> If so, that should include a proper constraint to be used with the new
> offset restrictions.  We should probably use that, instead of forcing
> to a "r" constraint.
>
>> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/include/asm/atomic.h | 50 +++++++++++++++++++++---------------------
>>   1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
>> index 6dd6bfc607e9..8669e0ec97e3 100644
>> --- a/arch/mips/include/asm/atomic.h
>> +++ b/arch/mips/include/asm/atomic.h
>> @@ -60,13 +60,13 @@ static __inline__ void atomic_##op(int i, atomic_t * v)				\
>>   										\
>>   		do {								\
>>   			__asm__ __volatile__(					\
>> -			"	.set	arch=r4000			\n"	\
>> -			"	ll	%0, %1		# atomic_" #op "\n"	\
>> +			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
>> +			"	ll	%0, 0(%3)	# atomic_" #op "\n"	\
>>   			"	" #asm_op " %0, %2			\n"	\
>> -			"	sc	%0, %1				\n"	\
>> +			"	sc	%0, 0(%3)			\n"	\
>>   			"	.set	mips0				\n"	\
>>   			: "=&r" (temp), "+m" (v->counter)			\
>> -			: "Ir" (i));						\
>> +			: "Ir" (i), "r" (&v->counter));				\
>
> You lost the "m" constraint, but are still modifying memory.  There is
> no "memory" clobber here, so we are no longer correctly describing
> what is happening.

Rather than add a blanket "memory" clobber, it's better to keep the old
memory operand even if it is never used.  GCC will still assume it has
been modified.

-- 
Måns Rullgård
mans@mansr.com
