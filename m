Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 17:53:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012309AbbA3QxtwoTzX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 17:53:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 832CF9BD10CBA;
        Fri, 30 Jan 2015 16:53:41 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 16:53:44 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 16:53:43 +0000
Message-ID: <54CBB717.7000106@imgtec.com>
Date:   Fri, 30 Jan 2015 16:53:43 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Makefile: Set correct ISA level for MIPS ASEs
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501301606470.28301@eddie.linux-mips.org> <54CBB0D4.1040506@imgtec.com> <alpine.LFD.2.11.1501301638050.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501301638050.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45586
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

On 01/30/2015 04:50 PM, Maciej W. Rozycki wrote:
> On Fri, 30 Jan 2015, Markos Chandras wrote:
> 
>>>>  cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
>>>>  				   -fno-omit-frame-pointer
>>>>  
>>>>  ifeq ($(CONFIG_CPU_HAS_MSA),y)
>>>> -toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64
>> -Wa$(comma)-mmsa)
>>>> +toolchain-msa	:= $(call cc-option-yn,-march=mips32r2 -mhard-float
>> -mfp64 -Wa$(comma)-mmsa)
>>>>  cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
>>>>  endif
>>>
>>>  Similarly here, is CPU_HAS_MSA incompatible with `-march=mips64r2'?
>> I am not sure but like I explained above, it does not have to be 100%
>> accurate. Just something to keep your toolchain happy and really enable
>> MSA support even if you happen and old ISA level as the default one for
>> your toolchain.
>>
>> for example, if your toolchain has -march=mips2 as default then
>>
>> -mhard-float -mfp64 will fail
>>
>> but
>>
>> -march=mips32r2 -mhard-float -mfp64
>>
>> will pass. Your toolchain does support MSA, but because you combined the
>> check with incompatible flags, then the end result is not what you want.
> 
>  Hmm doesn't `cc-option-yn' pull options accumulated in $(cflags-y) 
> already for the check it makes?  If not, then it's rather less than useful 
> for us and I can see two options here:

I think it does but IIRC at this point no -march=XXXX was set. Perhaps
moving the ASEs checks after the CPU_* code in Makefile to fix this
problem indirectly.

-- 
markos
