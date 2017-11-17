Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 16:31:44 +0100 (CET)
Received: from resqmta-po-03v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:162]:42692
        "EHLO resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdKQPbh5lC00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 16:31:37 +0100
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id FiZle7Y4wiG8YFiZleYqw7; Fri, 17 Nov 2017 15:29:05 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-09v.sys.comcast.net with SMTP
        id FiZjekcPhelnrFiZkepKLY; Fri, 17 Nov 2017 15:29:05 +0000
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
 <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org>
 <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org>
 <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk>
 <39133ddb-6b10-4a7b-6739-6f52fe8aa6a6@gentoo.org>
 <alpine.DEB.2.00.1711162329430.3888@tp.orcam.me.uk>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <99b32188-75eb-35fc-6ce4-f028bfefd6ed@gentoo.org>
Date:   Fri, 17 Nov 2017 10:28:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1711162329430.3888@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKW16YByfI2tCBMOzb3DdJFobbx8wOHTXvZhY4rn8QoVMGQgx4QH8owwPLDLfYsyqrG5bSVY9qdupMDVOkJilrR4sLXrc9xMnJA3EEzZNa2Gu+QHFhu9
 ufZ5D1WOxGYXDkkvQ8dJxaOJOb01dLuvSa1Dvew4ja+zKPVljB47TtUjUHTTezzVAlcd26gPYNj79yv6f65lr9QieljRhpczjv3UxCjTM2Hl8m3YBTpdYxvq
 PDnLOa4z090z/VkcCuZGPN95JhocJEUZBJ5dMqc14ko=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60996
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

On 11/16/2017 19:31, Maciej W. Rozycki wrote:
> On Tue, 14 Nov 2017, Joshua Kinard wrote:
> 
>>>  So we do have to make the result of DSUBU available to SCD and I propose 
>>> to make an obvious update to the piece of code previously posted, which 
>>> still does not require `noreorder' hacks:
>>>
>>> 		__asm__ __volatile__(
>>> 		"	.set	"MIPS_ISA_LEVEL"			\n"
>>> 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>>> 		"	dsubu	%0, %1, %3				\n"
>>> 		"	move	%1, %0					\n"
>>> 		"	bltz	%0, 1f					\n"
>>> 		"	scd	%1, %2					\n"
>>> 		"\t" __scbeqz "	%1, 1b					\n"
>>> 		"1:							\n"
>>> 		"	.set	mips0					\n"
>>> 		: "=&r" (result), "=&r" (temp),
>>> 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>>> 		: "Ir" (i));
>>>
>>> and uses the same instruction count, in terms of both the code size and 
>>> the number of instructions actually executed, because previously BLTZ 
>>> would have its delay slot filled with a NOP and now the MOVE instruction 
>>> will go there.
>>
>> I thought the delay slot for branch instructions came after the instruction?
>> Shouldn't the "move" go after "bltz", or is this a case where "bltz" has its
>> delay slot before?
> 
>  In terms of the program flow you want the move operation ahead of the 
> branch.
> 
>  Of course we have the architectural peculiarity of branch delay slots, 
> but in the MIPS assembly language they have been intended to be generally 
> hidden from the programmer.  This is why the original MIPSCO assembler 
> scheduled delay slots, which included branch delay slots, but also load 
> delay slots, coprocessor transfer delay slots, etc., where the given 
> architecture level had them, so that the programmer could write code as if 
> there were no delay slots and let the tool optimise it.  
> 
>  And GAS normally does that as well, where possible by swapping a branch 
> with the preceding instruction, or otherwise, i.e. where there is a data 
> dependency or the instruction is not allowed in a delay slot for some 
> reason, by inserting a NOP.
> 
>  GAS also has a way to disable delay slot scheduling, with the `.set 
> noreorder' pseudo-op (with `.set reorder' undoing the effect).  In this 
> mode of operation, sometimes called the `noreorder' mode, GAS assembles 
> source code as it is and it is the programmer's responsibility to satisfy 
> various pipeline requirements, including branch delay slots in particular, 
> i.e. an instruction has to be put there explicitly, even if it is a NOP.
> 
>  This mode will typically be used by a compiler for its assembly output. 
> This mode is not recommended to use in handcoded assembly unless 
> specifically required for a good reason.  One such reason is optimising 
> code where there is a data dependency between a branch and its delay-slot 
> instruction, e.g.:
> 
> 	.set	noreorder
> 	bnez	$2, 0b
> 	 addiu	$2, -1
> 	.set	reorder
> 
> which avoids clobbering a temporary register and is smaller/quicker then a 
> functional equivalent that does not schedule the delay slot manually like:
> 
> 	move	$3, $2
> 	addiu	$2, -1
> 	bnez	$3, 0b
> 
> (in this case GAS will move the ADDIU instruction into the delay slot of 
> the BNEZ instruction, because there is no data dependency between the 
> two instructions).  And of course if you just write:
> 
> 	addiu	$2, -1
> 	bnez	$2, 0b
> 
> then the semantics of this sequence will be different from the first one 
> above, because the addition precedes rather than following the branch and 
> $2 is a data dependency between the two instructions.  This data 
> dependency will also make GAS put a NOP into the delay slot of the BNEZ 
> instruction instead of moving ADDIU there.
> 
>  So in the piece I proposed at the top GAS will move the MOVE instruction 
> into the delay slot of BLTZ -- that is unless it is in a dumb mode where 
> it always uses NOPs, as recently discovered in the discussion here: 
> <https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.DEB.2.00.1711151425100.3893%40tp.orcam.me.uk>.  
> But that's just been a bug in our build system, which will hopefully be 
> fixed soon; we ought to assume smart scheduling normally (delay-slot 
> scheduling makes debugging trickier sometimes, in which case using the 
> dumb mode can help).

Ah!  I thought that when writing inline assembler, it was taken as-is by the
compiler and not messed with.  I didn't think that gas would still move things
around w/o the 'noreorder' directive being set.  Thank you for the explanation.

And yes, appending CFLAGS to LDFLAGS is basically the required norm now if one
wants to use LTO in userland compiles.  Not sure if the kernel can use LTO yet,
but fixing this small bug will further open the door for that.


>> And I am safe in assuming the same change also applies for the non-64-bit case
>> earlier that uses sc and subu?  The changes to the rest of the code also look
>> good?  Don't want to miss any other quirky bugs :)
> 
>  Yeah, `atomic_sub_if_positive' suffers from the same problem, and the 
> rest looks good to me; also none of the other pieces of code uses the 
> `noreorder' mode.

I've sent v3 in and will mark v2 as superseded in patchwork.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
