Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 16:03:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58376 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010483AbbAVPDSQc4Dw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 16:03:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D7A90189BF619;
        Thu, 22 Jan 2015 15:03:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 22 Jan 2015 15:03:12 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 22 Jan
 2015 15:03:11 +0000
Message-ID: <54C1112F.1010707@imgtec.com>
Date:   Thu, 22 Jan 2015 15:03:11 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 30/70] MIPS: kernel: proc: Add MIPS R6 support
 to /proc/cpuinfo
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-31-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501202336540.28301@eddie.linux-mips.org> <54BF709B.1080609@imgtec.com> <alpine.LFD.2.11.1501210936410.28301@eddie.linux-mips.org> <54C10C88.7060106@imgtec.com>
In-Reply-To: <54C10C88.7060106@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45434
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

On 01/22/2015 02:43 PM, Markos Chandras wrote:
> On 01/22/2015 02:08 PM, Maciej W. Rozycki wrote:
>> On Wed, 21 Jan 2015, Markos Chandras wrote:
>>
>>>>> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
>>>>> index 097fc8d14e42..a8fdf9685cad 100644
>>>>> --- a/arch/mips/kernel/proc.c
>>>>> +++ b/arch/mips/kernel/proc.c
>>>>> @@ -82,7 +82,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>>>>  		seq_printf(m, "]\n");
>>>>>  	}
>>>>>  
>>>>> -	seq_printf(m, "isa\t\t\t: mips1");
>>>>> +	seq_printf(m, "isa\t\t\t:"); 
>>>>> +	if (!cpu_has_mips_r6)
>>>>> +		seq_printf(m, " mips1");
>>>>
>>>>  I think define `cpu_has_mips_r1' instead and use it here.  It may turn 
>>>> out needed elsewhere too.  We probably don't need a new `MIPS_CPU_ISA_I' 
>>>> bit at this stage so this could be:
>>
>>  Typo here, I meant `cpu_has_mips_1' actually, sorry about that.
>>
>>> the change is simple enough and I see no reason to define the
>>> cpu_has_mips_r1 at the moment. If we ever need to explicitly handle r1,
>>> we can reconsider that.
>>
>>  It's a matter of code clarity, good code is self-explanatory.  Here the 
>> intent is to print `mips1' if it is supported.  By avoiding the extra 
>> definition you're detaching the intent from what code says.  Someone 
>> reading this code (who may not necessarily know the architecture documents 
>> by heart) has to scratch their head thinking: "why isn't `mips1' printed 
>> for R6, what the former has to do with the latter, and why is this case 
>> different to `mips2' and other ones that follow?"
>>
>>  Whereas the intent is clear with this:
>>
>> #define cpu_has_mips_1 (!cpu_has_mips_r6) // Aha, `mips1' is there if no R6!
>>
>> 	if (cpu_has_mips_1)
>> 		seq_printf(m, " mips1");  // Well, this is obvious...
> 
> however, someone may wonder then why not have
> 
> if (cpu_has_mips_1)
> print mips1
> if (cpu_has_mips_2)
> print mips2
> if (cpu_has_mips_3)
> print mips3
> 
> and only care about mips1.
oops that's already there. Then I guess your proposal makes the whole
thing consistent indeed.

-- 
markos
