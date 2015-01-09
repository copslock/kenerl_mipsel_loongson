Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 00:53:01 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:61228 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008709AbbAIXw7RxpeN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 00:52:59 +0100
Received: by mail-ig0-f177.google.com with SMTP id z20so4331571igj.4;
        Fri, 09 Jan 2015 15:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ljx7/Y1Gk3HPb/+MYbAxHF9WFNhkFk51qSXcABWKXx8=;
        b=YRGISUcsMkn7qcMeAc3LujvG1mLLmS8PhaZ5e7c6MfzZBSUk+LiGJgU1k41SUdZsd2
         6Flvpw9z4iUfxeGvsnLJlIu206+vz02vl7EI/yhNJeo/RLhTMb2VueMtjvIgoV8mJ+xk
         iA96oba+pfUoo3fLub+mzb8vMHLsQC3ccxFkjaU6lZ2UOqOVVgFjEKnxxtAE00RqHemW
         WyKh/OJFv/Frjfamib+XlSTjh1TeJMh2Z7QsOfv6MYXOnMJ3AQ7R/6/GBvoGzHr3EO0E
         DKHzLgfL5zBdjRG5kEV0SgXp92uVHY5DdyDEEheUC+nnaRt5RKRwDaHI6l2FLn3Kw8/n
         FfEg==
X-Received: by 10.50.137.68 with SMTP id qg4mr5229681igb.9.1420847573631;
        Fri, 09 Jan 2015 15:52:53 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id v83sm4540660iov.30.2015.01.09.15.52.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 15:52:53 -0800 (PST)
Message-ID: <54B069D4.4090608@gmail.com>
Date:   Fri, 09 Jan 2015 15:52:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Daniel Sanders <Daniel.Sanders@imgtec.com>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com> <54AFC6F3.1020300@cogentembedded.com> <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org> <54B00F3C.8030903@gmail.com> <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45047
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

On 01/09/2015 12:06 PM, Daniel Sanders wrote:
>> -----Original Message-----
>> From: David Daney [mailto:ddaney.cavm@gmail.com]
[...]

>
>>>>> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/arch/mips/include/asm/thread_info.h
>>>> b/arch/mips/include/asm/thread_info.h
>>>>> index 99eea59..2a2f3c4 100644
>>>>> --- a/arch/mips/include/asm/thread_info.h
>>>>> +++ b/arch/mips/include/asm/thread_info.h
>>>>> @@ -58,11 +58,11 @@ struct thread_info {
>>>>>     #define init_stack		(init_thread_union.stack)
>>>>>
>>>>>     /* How to get the thread information struct from C.  */
>>>>> +register struct thread_info *current_gp_register asm("$28");
>>>>
>>>>       *static* missing?
>>>>
>>>> WBR, Sergei
>>>
>>> Combining 'register' and 'static' is invalid.
>>
>> Defining global variables in header files is also invalid.
>
> I agree with that statement but named register globals are not the same as normal global variables. In particular, they do not take up space in the data section and they do not have an entry in the symbol table. They can therefore be included in multiple objects without causing link errors.
>

Well, the GCC manual seems to bless your usage, so I withdraw my 
objection on making this global.  But, changing the name to 
"current_gp_register" removes information about what it is used for.

Can you resend that patch so that it still has the name 
"__current_thread_info", and only moves it to the global scope?

Thanks,
David Daney


>
