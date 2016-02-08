Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 19:25:09 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33096 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012049AbcBHSZHvcgAy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 19:25:07 +0100
Received: by mail-pa0-f50.google.com with SMTP id cy9so77476257pac.0;
        Mon, 08 Feb 2016 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Mq+0JiQZE62D40pUQ4w/J8X3Bs/N4+pNSgkY+UxhcBw=;
        b=yQgnLiCTwDJJHuHvi6NiXfE62rKS2FYkb/ltPeodJ7vL6u0eOv9jks4dzeYDlvGP4F
         bmKi5+a5UK4BL6N1WMdHXrnbsPCPACBviB2vOVinyoVQtnI4RFH0Ot1I7cBxC/htcCnp
         miU86pKnoKFwyMRrmYygBD5P5wJ9Ca7MuHnHlDaJvk8yEDe2Z8N6PWpp1OQ/TzUAGVFn
         0YgBaCMaG8nqyhoXt+h2AH/atZZct/9xX39Q4a/HL/7HeOtyLtBfIlO80zjGBt6RGa1o
         cN6vOZkEo7Og+lDtP3L/EdCeJoV3Qw+ZRN7wXk1xG1XUtptkHqkwKeToRvxXG+X+aqY0
         K6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Mq+0JiQZE62D40pUQ4w/J8X3Bs/N4+pNSgkY+UxhcBw=;
        b=RRt5FLlwO05Q0qhF7diNjAPn/sHkTBb5h+cbfAWU2XDWGqCSs8/fawOxAN1EzNk8Tn
         48AC4S2LqlSKpqpPrCfjga+3wbs3I40eydvBqiGEgXibsu7IwznCBPDOqIWEPYGG9SXG
         gFKPL94UX5XzVwMypgObA+e6oaPDzkOxzPh7bEelLh/FGLnO+CewGU0cdQ+thUn/cROE
         Pj0ULxi7C6y8QMiQC/MOs0065dDx4aAoR26Je8LUFyFLBFACQwlR4O3qSUY9GgawU9hk
         EWukLcC7Y40PiCis2aYJbHq0tczkJOcKs30SmJZZ0ZZTcyvg4A3X99qBcZLLrif8Mc2I
         FJMQ==
X-Gm-Message-State: AG10YOQ/gW0H47sFEITezHc34IMFgfIpxCACWn+KZKodmGTZtnNV6YEH0H07OFcJO/yLgw==
X-Received: by 10.66.216.7 with SMTP id om7mr43949446pac.90.1454955901548;
        Mon, 08 Feb 2016 10:25:01 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id 76sm45003283pft.44.2016.02.08.10.24.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Feb 2016 10:24:59 -0800 (PST)
Message-ID: <56B8DD7A.1010303@gmail.com>
Date:   Mon, 08 Feb 2016 10:24:58 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Harvey Hunt <harvey.hunt@imgtec.com>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, David Daney <david.daney@cavium.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Always page align TASK_SIZE
References: <1454954723-24887-1-git-send-email-harvey.hunt@imgtec.com> <56B8DA56.9020108@caviumnetworks.com> <56B8DB2D.3070604@imgtec.com>
In-Reply-To: <56B8DB2D.3070604@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51863
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

On 02/08/2016 10:15 AM, Harvey Hunt wrote:
> Hi David,
>
> On 02/08/2016 10:11 AM, David Daney wrote:
>> On 02/08/2016 10:05 AM, Harvey Hunt wrote:
>>> STACK_TOP_MAX is aligned on a 32k boundary. When __bprm_mm_init()
>>> creates an
>>> initial stack for a process, it does so using STACK_TOP_MAX as the end
>>> of the
>>> vma. A process's arguments and environment information are placed on
>>> the stack
>>> and then the stack is relocated and aligned on a page boundary. When
>>> using a 32
>>> bit kernel with 64k pages, the relocated stack has the process's args
>>> erroneously stored in the middle of the stack. This means that processes
>>> receive no arguments or environment variables, preventing them from
>>> running
>>> correctly.
>>>
>>> Fix this by aligning TASK_SIZE on a page boundary.
>>>
>>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>>> Cc: David Daney <david.daney@cavium.com>
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Cc: James Hogan <james.hogan@imgtec.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   arch/mips/include/asm/processor.h | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/processor.h
>>> b/arch/mips/include/asm/processor.h
>>> index 3f832c3..b618b40 100644
>>> --- a/arch/mips/include/asm/processor.h
>>> +++ b/arch/mips/include/asm/processor.h
>>> @@ -39,13 +39,13 @@ extern unsigned int vced_count, vcei_count;
>>>   #ifdef CONFIG_32BIT
>>>   #ifdef CONFIG_KVM_GUEST
>>>   /* User space process size is limited to 1GB in KVM Guest Mode */
>>> -#define TASK_SIZE    0x3fff8000UL
>>> +#define TASK_SIZE    (0x40000000UL - PAGE_SIZE)
>>>   #else
>>>   /*
>>>    * User space process size: 2GB. This is hardcoded into a few places,
>>>    * so don't change it unless you know what you are doing.
>>>    */
>>> -#define TASK_SIZE    0x7fff8000UL
>>> +#define TASK_SIZE    (0x7fff8000UL & PAGE_SIZE)
>>
>> Can you check your math here.  This doesn't seem correct.
>
> Thanks for spotting that - it should have been:
>
> (0x7fff8000UL & PAGE_MASK)

This brings up an interesting point.  How was this tested?  Please note 
that in the change log.

Also look at the definition of PAGE_MASK in page.h

Is that correct?  Most of the other related symbols have an "_AC(1,UL)" 
in them.  Why is this not also appropriate for PAGE_MASK?

It may also be a good idea to prepare and test a patch that defines 
PAGE_MASK much in the same way HPAGE_MASK is defined.

David Daney


>
> I'll do a v2 now.
>
>>
>>>   #endif
>>>
>>>   #define STACK_TOP_MAX    TASK_SIZE
>>> @@ -62,7 +62,7 @@ extern unsigned int vced_count, vcei_count;
>>>    * support 16TB; the architectural reserve for future expansion is
>>>    * 8192EB ...
>>>    */
>>> -#define TASK_SIZE32    0x7fff8000UL
>>> +#define TASK_SIZE32    (0x7fff8000UL & PAGE_SIZE)
>>
>> Same here.
>
> As above.
>
>>
>>>   #define TASK_SIZE64    0x10000000000UL
>>>   #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
>>> TASK_SIZE64)
>>>   #define STACK_TOP_MAX    TASK_SIZE64
>>>
>>
>
> Thanks,
>
> Harvey
