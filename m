Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 21:02:56 +0100 (CET)
Received: from resqmta-po-12v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:171]:47110
        "EHLO resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKNUCqBpb2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 21:02:46 +0100
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id EhNEemalM9EcpEhNVezmxl; Tue, 14 Nov 2017 20:00:13 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-08v.sys.comcast.net with SMTP
        id EhNTeRrCp3fswEhNUeFyns; Tue, 14 Nov 2017 20:00:13 +0000
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
 <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org>
 <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org>
 <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <39133ddb-6b10-4a7b-6739-6f52fe8aa6a6@gentoo.org>
Date:   Tue, 14 Nov 2017 15:00:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOBZted3phgbHVEAgeA1P1fYZSsRvuTDiBjlqL80MzjdXAGfYEyrDPmBtXIIIp5Iid706927hgwX8pAAFse2hTkc8RXN1ohvh08nD6MumZxYx77fpjvb
 Sw/gfJdkAc5+DBA7M81CkVsSGRs/laK/2NXRGSBtqcruixdCgPsDbREWw09pR6YFWn7gKpWMstO1SkefdBN4ssffBsxu4YvXw9l1ehukYDVBfAyHFOaAqa0d
 IlDboQxvAarTxsU9pg3D+QWjuTh9LOUQ5b5hONP4ObA=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60934
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

On 11/14/2017 12:52, Maciej W. Rozycki wrote:
> On Mon, 6 Nov 2017, Joshua Kinard wrote:
> 
>>>> @@ -563,17 +464,17 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
>>>>
>>>>      smp_mb__before_llsc();
>>>>
>>>> -    if (kernel_uses_llsc && R10000_LLSC_WAR) {
>>>> +    if (kernel_uses_llsc) {
>>>>              long temp;
>>>>
>>>>              __asm__ __volatile__(
>>>> -            "       .set    arch=r4000                              \n"
>>>> +            "       .set    "MIPS_ISA_LEVEL"                        \n"
>>>>              "1:     lld     %1, %2          # atomic64_sub_if_positive\n"
>>>>              "       dsubu   %0, %1, %3                              \n"
>>>>              "       bltz    %0, 1f                                  \n"
>>>>              "       scd     %0, %2                                  \n"
>>>>              "       .set    noreorder                               \n"
>>>> -            "       beqzl   %0, 1b                                  \n"
>>>> +            "\t" __scbeqz " %0, 1b                                  \n"
>>>>              "        dsubu  %0, %1, %3                              \n"
>>>>              "       .set    reorder                                 \n"
>>>>              "1:                                                     \n"
>>>
>>>  This is obviously a preexisting bug, which has only been made more
>>> obvious with your merge of this code, but this can't be right, because the
>>> final DSUBU instruction which calculates `result', later returned, in %0
>>> will not be executed with BEQZL in the fall-through case, however it will
>>> be in the BEQZ case.
>>
>> Oh, I see.  Because the subu/dsubu hides in the branch-delay slot, and thus, in
>> a branch-likely case, gets skipped?
> 
>  AFAICT the only reason for the addition in the delay slot is to replay 
> the operation made on the value fetched with LLD, recalculating the result 
> of the subtraction lost due to SCD reusing the same register for its 
> result.  And it only matters for the fall-through case, because otherwise 
> the subtraction result is immediately overwritten by the value fetched by 
> LLD on the next iteration.
> 
>  Actually I overlooked how SCD handles its source again and made a bug in 
> the replacement code proposed, sorry.  See below for an update.
> 
>>>  It may make sense to split the temporary set by SCD from the result and
>>> then the final DSUBU won't be needed at all as the result will have
>>> already been calculated by the first DSUBU.  In fact ISTM %1 can simply be
>>> used, i.e.:
>>>
>>>               __asm__ __volatile__(
>>>               "       .set    "MIPS_ISA_LEVEL"                        \n"
>>>               "1:     lld     %1, %2          # atomic64_sub_if_positive\n"
>>>               "       dsubu   %0, %1, %3                              \n"
>>>               "       bltz    %0, 1f                                  \n"
>>>               "       scd     %1, %2                                  \n"
>>>               "\t" __scbeqz " %1, 1b                                  \n"
>>>               "1:                                                     \n"
>>>               "       .set    mips0                                   \n"
>>>               : "=&r" (result), "=&r" (temp),
>>>                 "+" GCC_OFF_SMALL_ASM() (v->counter)
>>>               : "Ir" (i));
>>>
>>> making this short and sweet, also avoiding the nasty `noreorder' piece and
>>> therefore making it one place less to concern about with porting Linux to
>>> the microMIPSr6 ISA.
>>>
>>>  I haven't gone through the remaining updates; it's just this piece that
>>> has caught my eye as I glanced over your change.
>>
>> I rolled these changes (and James' earlier suggestion to use the non-memory
>> barrier bottom bits) into a v2 patch that I just sent in (also for the
>> non-64bit case using subu).  I haven't tested the changes on my Octane yet, but
>> am assuming it'll work.  Saving an instruction or two on a heavily-executed bit
>> of code will likely yield some small benefits.
> 
>  So we do have to make the result of DSUBU available to SCD and I propose 
> to make an obvious update to the piece of code previously posted, which 
> still does not require `noreorder' hacks:
> 
> 		__asm__ __volatile__(
> 		"	.set	"MIPS_ISA_LEVEL"			\n"
> 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> 		"	dsubu	%0, %1, %3				\n"
> 		"	move	%1, %0					\n"
> 		"	bltz	%0, 1f					\n"
> 		"	scd	%1, %2					\n"
> 		"\t" __scbeqz "	%1, 1b					\n"
> 		"1:							\n"
> 		"	.set	mips0					\n"
> 		: "=&r" (result), "=&r" (temp),
> 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> 		: "Ir" (i));
> 
> and uses the same instruction count, in terms of both the code size and 
> the number of instructions actually executed, because previously BLTZ 
> would have its delay slot filled with a NOP and now the MOVE instruction 
> will go there.

I thought the delay slot for branch instructions came after the instruction?
Shouldn't the "move" go after "bltz", or is this a case where "bltz" has its
delay slot before?

And I am safe in assuming the same change also applies for the non-64-bit case
earlier that uses sc and subu?  The changes to the rest of the code also look
good?  Don't want to miss any other quirky bugs :)

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
