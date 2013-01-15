Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 23:42:54 +0100 (CET)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:63760 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832213Ab3AOWms7XiZS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 23:42:48 +0100
Received: by mail-qa0-f49.google.com with SMTP id r4so676136qaq.1
        for <multiple recipients>; Tue, 15 Jan 2013 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u6lTZo6rOHmqenH4v4yK3W42lJhYO2hlCOBbkohliQg=;
        b=xpxxhDKWA3ve0XGVRqTXFJwRSOk1GAjXKP70HxwAUvqEjPzUbMOU0uaGlhcveWJACp
         pirBeuZj1XE+1AS33WBMWjA3TZ9m0fUjXFOKcnyUGi/Ei9OW6tMUXR6zKR3DXiFJt3GQ
         j5oHfqaGOWc3GysqGjcNQc56TTX/bZmqj0dE4JAhL50Y/D7POwSFVesTc3QnW3NoBiiz
         YgPuEg4qpxc9NZxmbY5jsSQAzZMxXbadaZKY6ck5ZM2glanTwKjAsMtkDVctGSgdhoUX
         FUsn4rwzrxDUBZBndx95zrmRCHeQo0+Y0z8yIepVTVfcF4szqWvg6sVOn99FuMWj9luq
         KF8g==
MIME-Version: 1.0
Received: by 10.224.207.72 with SMTP id fx8mr36948786qab.66.1358289762605;
 Tue, 15 Jan 2013 14:42:42 -0800 (PST)
Received: by 10.49.117.161 with HTTP; Tue, 15 Jan 2013 14:42:42 -0800 (PST)
In-Reply-To: <50F5CB78.20800@gmail.com>
References: <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
        <50F0454D.5060109@gmail.com>
        <20130115034006.GA3854@home.goodmis.org>
        <50F59812.6040806@gmail.com>
        <1358284049.4068.21.camel@gandalf.local.home>
        <50F5CB78.20800@gmail.com>
Date:   Tue, 15 Jan 2013 17:42:42 -0500
Message-ID: <CAOGqxeXqsmczLA_DK6WFHTMeKBLF63fc6bV6tFJ3hxYuG0Woqw@mail.gmail.com>
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
From:   Alan Cooper <alcooperx@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

On Tue, Jan 15, 2013 at 4:34 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/15/2013 01:07 PM, Steven Rostedt wrote:
>>
>> On Tue, 2013-01-15 at 09:55 -0800, David Daney wrote:
>>
>>>> There's nothing that states what the ftrace caller must be. We can have
>>>> it do a proper stack update. That is, only at boot up do we need to
>>>> handle the defined mcount. After that, those instructions are just place
>>>> holders for our own algorithms. If the addiu was needed for the defined
>>>> mcount, there's no reason to keep it for our own ftrace_caller.
>>>>
>>>> Would that work?
>>>
>>>
>>> ... either do as you suggest and dynamically change the ABI of the
>>> target function.
>>
>>
>> We already change the ABI. We have it call ftrace_caller instead of
>> mcount.
>>
>> BTW, I've just compiled with gcc 4.6.3 against mips, and I don't see the
>> issue. I have:
>>
>> 0000000000000000 <account_kernel_stack>:
>>         0:       03e0082d        move    at,ra
>>         4:       0c000000        jal     0 <account_kernel_stack>
>>                          4: R_MIPS_26    _mcount
>>                          4: R_MIPS_NONE  *ABS*
>>                          4: R_MIPS_NONE  *ABS*
>>         8:       0000602d        move    t0,zero
>>         c:       2402000d        li      v0,13
>>        10:       3c030000        lui     v1,0x0
>>                          10: R_MIPS_HI16 mem_section
>>                          10: R_MIPS_NONE *ABS*
>>                          10: R_MIPS_NONE *ABS*
>>        14:       000216fc        dsll32  v0,v0,0x1b
>>        18:       64630000        daddiu  v1,v1,0
>>
>> Is it dependent on the config?
>
>
> Yes.
>
> You need to select a 32-bit kernel (which in turn may require selecting a
> board type that also supports it).
>
> The ABI is different for 32-bit and 64-bit _mcount.
>
> David Daney
>

Building for MIPS malta will show the problem.

>
>
>>
>>>
>>> Or add support to GCC for a better tracing ABI (as I already said we did
>>> for mips64).
>>
>>
>> I wouldn't waste time changing gcc for this. If you're going to change
>> gcc than please implement the -mfentry option. Look at x86_64 to
>> understand this more.
>
>
> A good point.  But I don't really plan on doing any work related to 32-bit
> mips things at this point, so any such change would have to be done by
> someone else.
>
> David Daney
>

I love the idea of removing the useless stack adjust stuff at run time!
The issue still remains for the initial writing of the 2 nops. It
looks like the initial call to write the nops is done from ftrace_init
which is called before SMP is up, so if I write the 2 nops via a
single call to a function with interrupts disabled it should be safe.
I also need to do this for modules at insmod time.

This has been GREAT feedback!

Thanks
