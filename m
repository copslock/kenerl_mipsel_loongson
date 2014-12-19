Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 09:52:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3516 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007783AbaLSIwA0f48u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 09:52:00 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 474358A7472B9;
        Fri, 19 Dec 2014 08:51:53 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 08:51:54 +0000
Received: from [192.168.154.125] (192.168.154.125) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 19 Dec
 2014 08:51:52 +0000
Message-ID: <5493E728.7010400@imgtec.com>
Date:   Fri, 19 Dec 2014 08:51:52 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 24/67] MIPS: asm: spinlock: Replace sub instruction
 with addiu
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-25-git-send-email-markos.chandras@imgtec.com> <54932291.1040509@gmail.com>
In-Reply-To: <54932291.1040509@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44828
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

On 12/18/2014 06:53 PM, David Daney wrote:
> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>> sub $reg, imm is not a real MIPS instruction. The assembler replaces
>> that with 'addi $reg, -imm'.
> 
> That is a bug right there.  We cannot have faulting instructions like
> this in the kernel.
> 
>> However, addi has been removed from R6,
>> so we replace the 'sub' instruction with 'addiu' instead.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/include/asm/spinlock.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/spinlock.h
>> b/arch/mips/include/asm/spinlock.h
>> index f63b3543c1a4..c82fc0eefbec 100644
>> --- a/arch/mips/include/asm/spinlock.h
>> +++ b/arch/mips/include/asm/spinlock.h
>> @@ -277,7 +277,7 @@ static inline void arch_read_unlock(arch_rwlock_t
>> *rw)
>>           do {
>>               __asm__ __volatile__(
>>               "1:    ll    %1, 0(%2)# arch_read_unlock    \n"
>> -            "    sub    %1, 1                \n"
>> +            "    addiu    %1, -1                \n"
> 
> Instead, how about fixing the real bug by s/sub/subu/.
> 
> Would that work for R6 too?  If so, just do that.

subu is supported by R6 but i am not sure what the assembler will do in
case of "subu $reg, #imm". It will probably replace that with addiu

-- 
markos
