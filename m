Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 18:18:10 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:54508 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011260AbbATRSHsDqfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 18:18:07 +0100
Received: by mail-ig0-f173.google.com with SMTP id a13so18275656igq.0;
        Tue, 20 Jan 2015 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=en7MmxQPim1Hrh12oz0T1BiqsmbgptGO6y6Goo3S0pc=;
        b=Bc3aqLATkhe9ZQVzeOcS4eXp7gxtj/h3gKnrsnMgAiw2WInYH/tiP7HbKvu23BIe+U
         7RM7xgBq7y5y3zcRBO/sEaUh6BxHHV4/+dh+5E5qZks07SmoXeunxpRVXNmlEGNl83kP
         1MYiQxJggEdcnwDr+/W2r93D3NYfk6Pn+PL/o0WeHHiF40R43HZPhpL05uCcgsFD7+Nr
         oN2mMUY5irWpIYqXu462EMn+9xAP5f/mH+cNug8q+l9W8ngVpV1r0eLJV4AGQ9BL8UKs
         hG+tb0cQWCpMJ9//Gy4Ddekn5NxenWXNGD9nNjmn/fC8d2GEhfuc5qtW+t+dfqvHX28o
         EDUA==
X-Received: by 10.50.78.202 with SMTP id d10mr28052847igx.30.1421774281885;
        Tue, 20 Jan 2015 09:18:01 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id gd4sm3200738igd.11.2015.01.20.09.18.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 09:18:00 -0800 (PST)
Message-ID: <54BE8DC7.4030009@gmail.com>
Date:   Tue, 20 Jan 2015 09:17:59 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub instruction
 with addiu
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org> <54BE3BFD.5070108@imgtec.com>
In-Reply-To: <54BE3BFD.5070108@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/20/2015 03:29 AM, Markos Chandras wrote:
> On 01/20/2015 01:04 AM, Maciej W. Rozycki wrote:
>> On Fri, 16 Jan 2015, Markos Chandras wrote:
>>
>>> sub $reg, imm is not a real MIPS instruction. The assembler replaces
>>> that with 'addi $reg, -imm'. However, addi has been removed from R6,
>>> so we replace the 'sub' instruction with 'addiu' instead.
>>>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>   arch/mips/include/asm/spinlock.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
>>> index c6d06d383ef9..500050d3bda6 100644
>>> --- a/arch/mips/include/asm/spinlock.h
>>> +++ b/arch/mips/include/asm/spinlock.h
>>> @@ -276,7 +276,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
>>>   		do {
>>>   			__asm__ __volatile__(
>>>   			"1:	ll	%1, %2	# arch_read_unlock	\n"
>>> -			"	sub	%1, 1				\n"
>>> +			"	addiu	%1, -1				\n"
>>>   			"	sc	%1, %0				\n"
>>>   			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
>>>   			: GCC_OFF12_ASM() (rw->lock)
>>
>>   This integer overflow trap is deliberate here -- have you seen the note
>> just above:
>>
>> /* Note the use of sub, not subu which will make the kernel die with an
>>     overflow exception if we ever try to unlock an rwlock that is already
>>     unlocked or is being held by a writer.  */
>>

According to a comment on another thread from Ralf, this has been 
observed in the wild only once.  We can simplify the code and remove 
that comment.  Why not just use the ADDIU and be done with it?

There are many locking and atomic primitives that don't have any such 
error checking.  What makes the read lock so special that it needs this 
extra protection?

David Daney
