Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 10:36:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62191 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011100AbbATJgHR8Pw8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 10:36:07 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9ABDAE3CDFDEB;
        Tue, 20 Jan 2015 09:35:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 09:36:01 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 20 Jan
 2015 09:35:57 +0000
Message-ID: <54BE217D.3060508@imgtec.com>
Date:   Tue, 20 Jan 2015 09:35:57 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS
 R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320FAC20A@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FAC20A@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45357
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

On 01/20/2015 09:11 AM, Matthew Fortune wrote:
> Maciej W. Rozycki <macro@linux-mips.org> writes:
>> On Fri, 16 Jan 2015, Markos Chandras wrote:
>>
>>> GCC versions supporting MIPS R6 use the ZC constraint to enforce a
>>> 9-bit offset for MIPS R6. We will use that for all MIPS R6 LL/SC
>>> instructions.
>>>
>>> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>  arch/mips/include/asm/compiler.h | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/include/asm/compiler.h
>> b/arch/mips/include/asm/compiler.h
>>> index c73815e0123a..8f8ed0245a09 100644
>>> --- a/arch/mips/include/asm/compiler.h
>>> +++ b/arch/mips/include/asm/compiler.h
>>> @@ -16,12 +16,20 @@
>>>  #define GCC_REG_ACCUM "accum"
>>>  #endif
>>>
>>> +#ifdef CONFIG_CPU_MIPSR6
>>> +/*
>>> + * GCC uses ZC for MIPS R6 to indicate a 9-bit offset although
>>> + * the macro name is a bit misleading
>>> + */
>>> +#define GCC_OFF12_ASM() "ZC"
>>> +#else
>>>  #ifndef CONFIG_CPU_MICROMIPS
>>>  #define GCC_OFF12_ASM() "R"
>>>  #elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
>>>  #define GCC_OFF12_ASM() "ZC"
>>>  #else
>>>  #error "microMIPS compilation unsupported with GCC older than 4.9"
>>> -#endif
>>> +#endif /* CONFIG_CPU_MICROMIPS */
>>> +#endif /* CONFIG_CPU_MIPSR6 */
>>>
>>>  #endif /* _ASM_COMPILER_H */
>>
>>  I'd prefer to have a GCC version trap here just like with the microMIPS
>> constraint.  What is the first upstream version to support R6?  5.0?
> 
> Correct.

We have tools out there based on 4.9. If we make gcc < 5.0 to fail with
R6, then nobody will be able to build it until 5.0 is released.
Perhaps it makes sense to add some checks in arch/mips/Makefile, see if
our gcc supports -mips32r6 or something and then decide what to do.

-- 
markos
