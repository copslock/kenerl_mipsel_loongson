Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:26:30 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46483 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010849AbbAIR02GHgE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 18:26:28 +0100
Received: by mail-ie0-f176.google.com with SMTP id tr6so16188447ieb.7;
        Fri, 09 Jan 2015 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3Z/TwtcOK+uTMkKckyJaQrWGRJk6QeFML/4xw4PfW98=;
        b=QEQiLdhg1L5XV7yIz5okVvPVRpl6gh7ClNAr887oHXwHGddChS+gE7WqinEpleGhDP
         wJI14xNBekrq8QdGuqPKsJMmoR6ya78EwCRUTyVimW9y4ncjgURsgilWY9r9wbSFZP8L
         e24w0HgJR5D7YpReUu5r5guMGM1AIpBsU31OFahMCdZevGZe1mOlBv3b2toAx6k2GZqd
         EH7qNjreqcnSwqHAmKlelhVLMKx/MiqgOIYLUWFI2oaLZJzosul0xuOE3kS08iDr1wpj
         H7M4wcUcrtsqBxOC9jK/aspQ3nsTCs5x/HpBqTH9DgpI8LGVniMZtFdrZ/8oBnw4JfF+
         1zwA==
X-Received: by 10.107.169.15 with SMTP id s15mr15579441ioe.34.1420824382240;
        Fri, 09 Jan 2015 09:26:22 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id qa8sm4376431igb.13.2015.01.09.09.26.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 09:26:21 -0800 (PST)
Message-ID: <54B00F3C.8030903@gmail.com>
Date:   Fri, 09 Jan 2015 09:26:20 -0800
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
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com> <54AFC6F3.1020300@cogentembedded.com> <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45037
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

On 01/09/2015 05:23 AM, Daniel Sanders wrote:
> Hi,
>
> Thanks for the quick reply.
>
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]
>> Sent: 09 January 2015 12:18
>> To: Daniel Sanders; linux-mips@linux-mips.org; Ralf Baechle
>> Cc: Paul Burton; Markos Chandras; James Hogan; Behan Webster
>> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
>> supported by both clang and GCC
>>
>> Hello.
>>
>> On 1/9/2015 3:06 PM, Daniel Sanders wrote:
>>
>>> Without this, a 'break' instruction is executed very early in the boot and
>>> the boot hangs.
>>
>>> The problem is that clang doesn't honour named registers on local variables
>>> and silently treats them as normal uninitialized variables. However, it
>>> does honour them on global variables.

Why not fix clang instead?

>>
>>> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
>>
>> [...]
>>
>>> diff --git a/arch/mips/include/asm/thread_info.h
>> b/arch/mips/include/asm/thread_info.h
>>> index 99eea59..2a2f3c4 100644
>>> --- a/arch/mips/include/asm/thread_info.h
>>> +++ b/arch/mips/include/asm/thread_info.h
>>> @@ -58,11 +58,11 @@ struct thread_info {
>>>    #define init_stack		(init_thread_union.stack)
>>>
>>>    /* How to get the thread information struct from C.  */
>>> +register struct thread_info *current_gp_register asm("$28");
>>
>>      *static* missing?
>>
>> WBR, Sergei
>
> Combining 'register' and 'static' is invalid.

Defining global variables in header files is also invalid.

>
> gcc gives:
> arch/mips/include/asm/thread_info.h:61:1: error: multiple storage classes in declaration specifiers
>   static register struct thread_info *current_gp_register asm("$28");
>   ^
>
> and clang gives:
> arch/mips/include/asm/thread_info.h:61:8: error: cannot combine with previous 'static' declaration specifier
> static register struct thread_info *current_gp_register asm("$28");
>         ^
>
>
