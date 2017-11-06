Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 16:11:07 +0100 (CET)
Received: from resqmta-ch2-11v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:43]:34624
        "EHLO resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdKFPK6cff9q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 16:10:58 +0100
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id BiztebCUxDrnfBj0keoHhA; Mon, 06 Nov 2017 15:08:26 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-20v.sys.comcast.net with SMTP
        id Bj0ieuv9sXtd9Bj0jeSQPX; Mon, 06 Nov 2017 15:08:26 +0000
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
 <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org>
Date:   Mon, 6 Nov 2017 10:08:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLIsJwOMUiQ8RXIOtJ+WeB85HkjDhnIXlW9248Bd1nRUzumEVkiYWB3+QXoKxNQ4I2L5lv4DpNmnBvKfWW/wiNCByNB2OvLQGk6kA54Vclp2Lqs+1p22
 8QIM3B2/tU9V+LIfhA4n/i0DWHKS4gRF2ec2hRg9TqKGQ7yxHSbI3uAWCkfu8N+WKeN5UlxEUJDO5m7ciLdh1H4Oqgh6S8uBOZqgQDbaOQX0cJo6Rh0LCHX9
 i9wWcbYes4QrOTv6qyYOdGnOTt5f0OU8CUUBdwuGl/8=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60721
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

On 11/04/2017 10:40, Maciej W. Rozycki wrote:
> On Tue, 17 Oct 2017, Joshua Kinard wrote:
> 
>> @@ -563,17 +464,17 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
>>  
>>  	smp_mb__before_llsc();
>>  
>> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
>> +	if (kernel_uses_llsc) {
>>  		long temp;
>>  
>>  		__asm__ __volatile__(
>> -		"	.set	arch=r4000				\n"
>> +		"	.set	"MIPS_ISA_LEVEL"			\n"
>>  		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>>  		"	dsubu	%0, %1, %3				\n"
>>  		"	bltz	%0, 1f					\n"
>>  		"	scd	%0, %2					\n"
>>  		"	.set	noreorder				\n"
>> -		"	beqzl	%0, 1b					\n"
>> +		"\t" __scbeqz "	%0, 1b					\n"
>>  		"	 dsubu	%0, %1, %3				\n"
>>  		"	.set	reorder					\n"
>>  		"1:							\n"
> 
>  This is obviously a preexisting bug, which has only been made more 
> obvious with your merge of this code, but this can't be right, because the 
> final DSUBU instruction which calculates `result', later returned, in %0 
> will not be executed with BEQZL in the fall-through case, however it will 
> be in the BEQZ case.

Oh, I see.  Because the subu/dsubu hides in the branch-delay slot, and thus, in
a branch-likely case, gets skipped?


>  It may make sense to split the temporary set by SCD from the result and 
> then the final DSUBU won't be needed at all as the result will have 
> already been calculated by the first DSUBU.  In fact ISTM %1 can simply be 
> used, i.e.:
> 
> 		__asm__ __volatile__(
> 		"	.set	"MIPS_ISA_LEVEL"			\n"
> 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> 		"	dsubu	%0, %1, %3				\n"
> 		"	bltz	%0, 1f					\n"
> 		"	scd	%1, %2					\n"
> 		"\t" __scbeqz "	%1, 1b					\n"
> 		"1:							\n"
> 		"	.set	mips0					\n"
> 		: "=&r" (result), "=&r" (temp),
> 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> 		: "Ir" (i));
> 
> making this short and sweet, also avoiding the nasty `noreorder' piece and 
> therefore making it one place less to concern about with porting Linux to 
> the microMIPSr6 ISA.
> 
>  I haven't gone through the remaining updates; it's just this piece that 
> has caught my eye as I glanced over your change.

I rolled these changes (and James' earlier suggestion to use the non-memory
barrier bottom bits) into a v2 patch that I just sent in (also for the
non-64bit case using subu).  I haven't tested the changes on my Octane yet, but
am assuming it'll work.  Saving an instruction or two on a heavily-executed bit
of code will likely yield some small benefits.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
