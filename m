Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 03:21:04 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:38]:40336
        "EHLO resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdKSCU5PbVmo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 03:20:57 +0100
Received: from resomta-ch2-06v.sys.comcast.net ([69.252.207.102])
        by resqmta-ch2-06v.sys.comcast.net with ESMTP
        id GFBgeHC86Wg90GFBieVpiI; Sun, 19 Nov 2017 02:18:26 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-06v.sys.comcast.net with SMTP
        id GFBgeumVYCxytGFBheA3ER; Sun, 19 Nov 2017 02:18:26 +0000
Subject: Re: [PATCH v3] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
References: <23fb0d7b-347a-195d-38f3-383ac59cc69d@gentoo.org>
 <alpine.DEB.2.00.1711171715020.3888@tp.orcam.me.uk>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <ddc2ba6e-ab17-114c-fdc2-bdb2900bc57a@gentoo.org>
Date:   Sat, 18 Nov 2017 21:18:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1711171715020.3888@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGMoxodzhIl0E1c5P9P3HCuyT8hvQYRZcu8DrI3ssEpYq18gjZOGHnEcGDWo8Ik+46yfk//9PeNGgZ5eaap4mGYpBj+ZBIJRBVKMzEMBjtEsVpY/gXlz
 ykK1jfXa1MVbiuVh455fqCmkiO6HTMo53N7zOYZ0ByITFZLp4LfZzk1L5skU5Hng0SluDYKvkzFfn20bKxdxnqo75iQiSi/zKLdBCqB1g4xuGfqGyOqxC61J
 ULoBRKE5xKnFmJ1p2XPj4Yj7ivrfOp0gWDDXgbb2KGfu8kK6wXRTs9+USDcFh9v9Kj+qnAxOpaqplbmPVma69s76XE3OVdUF3QkYTZJU4YM=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61001
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

On 11/17/2017 12:45, Maciej W. Rozycki wrote:
> On Fri, 17 Nov 2017, Joshua Kinard wrote:
> 
>> This patch reduces down the conditionals in MIPS atomic code that deal
>> with a silicon bug in early R10000 cpus that required a workaround of
>> a branch-likely instruction following a store-conditional in order to
>> to guarantee the whole ll/sc sequence is atomic.  As the only real
>> difference is a branch-likely instruction (beqzl) over a standard
>> branch (beqz), the conditional is reduced down to down to a single
> 
>  s/down to down to/down to/

Will be fixed in v4


>> preprocessor check at the top to pick the required instruction.
>>
>> This requires writing the uses in assembler, thus we discard the
>> non-R10000 case that uses a mixture of a C do...while loop with
>> embedded assembler that was added back in commit 7837314d141c.  A note
>> found in the git log for empty commit 5999eca25c1f is also addressed
> 
>  Please use `commit 7837314d141c ("MIPS: Get rid of branches to 
> .subsections.")', `commit 5999eca25c1f ("[MIPS] Improve branch prediction 
> in ll/sc atomic operations.")' style in commit descriptions.  Please also 
> pass your changes through `scripts/checkpatch.pl', which would have 
> pointed it out.

I wasn't aware checkpatch actually looked at the commit descriptions.  I
thought it only dealt with the patch itself.  Learn something new every day!


>  Also why do you think commit 5999eca25c1f was empty?  It certainly does 
> not show up as empty for me.  Did you quote the correct commit ID?  I 
> think it would be good too if you clarified which note in that commit you 
> have specifically referred to.

I see what happened.  I accessed this URL:
https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=5999eca25c1fd4b9b9aca7833b04d10fe4bc877d

Which refers to the correct commit id, but the commit happened before the move
of include/asm-mips to arch/mips/include/asm, so git was showing me the commit
message, but no changes.  IMHO, that seems like a bug in cgit where it should
have redirected me to the right file path for the old commit, but then again,
git's never been the best at making it easy to find the history of files after
they have been moved.  I'll fix that bit in my commit message.


>> ---
>> Changes in v3:
>> - Make the result of subu/dsubu available to sc/scd in
>>   atomic_sub_if_positive and atomic64_sub_if_positive while still
>>   avoiding the use of 'noreorder'.
>>
>> Changes in v2:
>> - Incorporate suggestions from upstream to atomic_sub_if_positive
>>   and atomic64_sub_if_positive to avoid memory barriers, as those
>>   are already implied and to eliminate the '.noreorder' directive
>>   and corner case of subu/dsubu's output not getting used in the
>>   branch-likely case due to being in the branch delay slot.
> 
>  I think the BEQZL delay slot bug fixes to `atomic_sub_if_positive' and 
> `atomic64_sub_if_positive' should be split off and submitted separately as 
> a preparatory patch, so that they can be backported to stable branches; 
> please do so.  It'll also make your original clean up that follows 
> clearer.

I'll make it a stand-alone patch.  Will also CC stable for backporting.


>> @@ -563,42 +461,21 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
>>  
>>  	smp_mb__before_llsc();
>>  
>> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
>> -		long temp;
>> -
>> -		__asm__ __volatile__(
>> -		"	.set	arch=r4000				\n"
>> -		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>> -		"	dsubu	%0, %1, %3				\n"
>> -		"	bltz	%0, 1f					\n"
>> -		"	scd	%0, %2					\n"
>> -		"	.set	noreorder				\n"
>> -		"	beqzl	%0, 1b					\n"
>> -		"	 dsubu	%0, %1, %3				\n"
>> -		"	.set	reorder					\n"
>> -		"1:							\n"
>> -		"	.set	mips0					\n"
>> -		: "=&r" (result), "=&r" (temp),
>> -		  "=" GCC_OFF_SMALL_ASM() (v->counter)
>> -		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
>> -		: "memory");
>> -	} else if (kernel_uses_llsc) {
>> +	if (kernel_uses_llsc) {
>>  		long temp;
>>  
>>  		__asm__ __volatile__(
>>  		"	.set	"MIPS_ISA_LEVEL"			\n"
>>  		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>>  		"	dsubu	%0, %1, %3				\n"
>> +		"	move	%1, %0					\n"
>>  		"	bltz	%0, 1f					\n"
>> -		"	scd	%0, %2					\n"
>> -		"	.set	noreorder				\n"
>> -		"	beqz	%0, 1b					\n"
>> -		"	 dsubu	%0, %1, %3				\n"
>> -		"	.set	reorder					\n"
>> +		"	scd	%1, %2					\n"
>> +		"\t" __scbeqz "	%1, 1b					\n"
>>  		"1:							\n"
>>  		"	.set	mips0					\n"
>>  		: "=&r" (result), "=&r" (temp),
>> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>> +		  "=" GCC_OFF_SMALL_ASM() (v->counter)
> 
>  This is wrong, `v->counter' is both read and written, so `+' has to stay.
> 
>  Otherwise OK, I think.  Perhaps you can split off another patch, just to 
> fix up the mess with constraints, which should be either:
> 
> 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)
>                 : "Ir" (i));
> 
> if there is no result or:
> 
> 		: "=&r" (result), "=&r" (temp),
> 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> 		: "Ir" (i));
> 
> if there is one.  This would be patch #2 in the series then and would make 
> the final review easier I believe.

This is probably a mistake I made when eliminating the R10000_LLSC_WAR block, I
wasn't sure which bottom part to use.  In a few of the non-R10K cases, the
existing do...while loop uses "=" with the trailing "memory" bit, and I didn't
realize they went together.  I'll use the correct form in the main cleanup patch.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
