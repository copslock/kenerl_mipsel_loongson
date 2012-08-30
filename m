Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 16:06:42 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62877 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903264Ab2H3OGg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 16:06:36 +0200
Received: by lbbgf7 with SMTP id gf7so496539lbb.36
        for <multiple recipients>; Thu, 30 Aug 2012 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ds5dtQSS05ZFwRoHZDxfUXc+9Trd3qFK6v7+iFUn8+g=;
        b=0oDqDtkiP7xMjdKaBQJ4l1gKtQtSeAxGBqik//qtfZASivtznY7NEE8iEVfTVh5ZNA
         COjNPYt8aMdpXjmx2Pt5R1UBNtwXDU70PjZkSoKUznIHSSdNEfokvVPRAuDVipT51rrw
         Pt7gc3PR5gLkuuhK5dFc4DG37z83Oa3h0ur+O/le26V6sqjTDvr4M9nvEiwBFUkAJ7fn
         xhDiFafM8hTYORjVoXcdWHj/55TGKPs0TZarMb9NPfHNM3XX/Vt7UM33QmETvoYcbTAt
         eghNHLPob/V8ESQracm6BeVuYEOBEwfyWiNcR/SkzLWdrqEU0MhNX5BWqmn2Go7WTyiP
         NrSQ==
MIME-Version: 1.0
Received: by 10.112.88.2 with SMTP id bc2mr1423979lbb.61.1346335590548; Thu,
 30 Aug 2012 07:06:30 -0700 (PDT)
Received: by 10.114.23.98 with HTTP; Thu, 30 Aug 2012 07:06:30 -0700 (PDT)
In-Reply-To: <503E9F66.9030200@gmail.com>
References: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
        <503E9F66.9030200@gmail.com>
Date:   Thu, 30 Aug 2012 10:06:30 -0400
Message-ID: <CANCKTBsXhKNtNJxYhyn4Ygt=c3=4ZT-quB3L1XJVFC4y-mWM7Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] asm-offsets.c: adding #define to break circular dependency
From:   Jim Quinlan <jim2101024@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

I'm not sure the tangle is so easily undone.  The first dependency I see is

asm-offsets.c
asm/processors.h
linux/cpumask.h
linux/kernel.h
linux/bitops.h
asm/bitops.h
linux/irqflags.h
asm/irqflags.h

When compared to other architectures, the MIPS asm/bitops.h seems to
include more files at the top, including linux/irqflags.h.
Any suggestions?

On Wed, Aug 29, 2012 at 7:01 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 08/29/2012 03:34 PM, Jim Quinlan wrote:
>>
>> irqflags.h depends on asm-offsets.h, but asm-offsets.h depends
>> on irqflags.h when generating asm-offsets.h.
>
>
> What is there in irqflags.h that is required by asm-offsets.c?
>
> Why can't the include tangle be undone so that that part can be factored out
> to a separate file?
>
>
>
>
>> Adding a definition
>> to the top of asm-offsets.c allows us to break this circle.  There
>> is a similar define in bounds.c
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>   arch/mips/kernel/asm-offsets.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/kernel/asm-offsets.c
>> b/arch/mips/kernel/asm-offsets.c
>> index 6b30fb2..035f167 100644
>> --- a/arch/mips/kernel/asm-offsets.c
>> +++ b/arch/mips/kernel/asm-offsets.c
>> @@ -8,6 +8,7 @@
>>    * Kevin Kissell, kevink@mips.com and Carsten Langgaard,
>> carstenl@mips.com
>>    * Copyright (C) 2000 MIPS Technologies, Inc.
>>    */
>> +#define __GENERATING_OFFSETS_S
>>   #include <linux/compat.h>
>>   #include <linux/types.h>
>>   #include <linux/sched.h>
>>
>
