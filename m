Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 12:29:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35221 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011153AbbATL3JNek5h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 12:29:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 027ADF38F71D4;
        Tue, 20 Jan 2015 11:29:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 11:29:03 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 20 Jan
 2015 11:29:01 +0000
Message-ID: <54BE3BFD.5070108@imgtec.com>
Date:   Tue, 20 Jan 2015 11:29:01 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub instruction
 with addiu
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/20/2015 01:04 AM, Maciej W. Rozycki wrote:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
> 
>> sub $reg, imm is not a real MIPS instruction. The assembler replaces
>> that with 'addi $reg, -imm'. However, addi has been removed from R6,
>> so we replace the 'sub' instruction with 'addiu' instead.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  arch/mips/include/asm/spinlock.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
>> index c6d06d383ef9..500050d3bda6 100644
>> --- a/arch/mips/include/asm/spinlock.h
>> +++ b/arch/mips/include/asm/spinlock.h
>> @@ -276,7 +276,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
>>  		do {
>>  			__asm__ __volatile__(
>>  			"1:	ll	%1, %2	# arch_read_unlock	\n"
>> -			"	sub	%1, 1				\n"
>> +			"	addiu	%1, -1				\n"
>>  			"	sc	%1, %0				\n"
>>  			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
>>  			: GCC_OFF12_ASM() (rw->lock)
> 
>  This integer overflow trap is deliberate here -- have you seen the note 
> just above:
> 
> /* Note the use of sub, not subu which will make the kernel die with an
>    overflow exception if we ever try to unlock an rwlock that is already
>    unlocked or is being held by a writer.  */
> 
> ?
> 
>  What this shows really is a GAS bug fix for the SUB macro is needed 
> similar to what I suggested in 12/70 for ADDI (from the situation I infer 
> there is some real work to do in GAS in this area; adding Matthew as a 
> recipient to raise his awareness) so that it does not expand to ADDI where 
> the architecture or processor selected do not support it.  Instead a 
> longer sequence involving SUB has to be produced.
> 
>  However, regardless, I suggest code like:
> 
> /* There's no R6 ADDI instruction so use the ADD register version instead. */
> #ifdef CONFIG_CPU_MIPSR6
> #define GCC_ADDI_ASM() "r"
> #else
> #define GCC_ADDI_ASM() "I"
> #endif
> 
> 			__asm__ __volatile__(
> 			"1:	ll	%1, %2	# arch_read_unlock	\n"
> 			"	sub	%1, %3				\n"
> 			"	sc	%1, %0				\n"
> 			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
> 			: GCC_OFF12_ASM() (rw->lock), GCC_ADDI_ASM() (1)
> 			: "memory");
> 
> (untested, but should work) so that there's still a single instruction 
> only in the LL/SC loop and consequently no increased lock contention risk.
> 
>  As a side note, this could be cleaned up to use a "+" input/output 
> constraint; such a clean-up will be welcome -- although to be complete, a 
> review of all the asms will be required (this may bump up the GCC version 
> requirement though, ISTR bugs in this area).
> 
>   Maciej
> 
CC'ing Matthew again for the GAS suggestions

-- 
markos
