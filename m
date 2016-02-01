Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 17:04:02 +0100 (CET)
Received: from mail-io0-f194.google.com ([209.85.223.194]:33543 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011931AbcBAQEAsTO9N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 17:04:00 +0100
Received: by mail-io0-f194.google.com with SMTP id f81so12105498iof.0;
        Mon, 01 Feb 2016 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L0mzpn9Xee7gnES4Hxgx6pxIDY4Ct4c3rhp+/gW36zM=;
        b=goBEzZG+SBM4fm0RHFvdQJHFrj+MabWLoAv0TJRHrpjsSKb9Yz1ekU2JyaqWFfXsxb
         PX1wVGE8hnOYa6BztZfQAVPGv9m7VpIAYBH9g9XHIxiff6XIIPPxBAUnKMchjDO1ypZt
         2IoEjNMc9jn/AqQz+46V23z/ctQwXHwWKkWyXiQuUrkvjrBujyVbVnRCxaZ4MFLHmeUh
         uXtIpNZg8ara0yMX+BE39WDKz28FkSmUUlHEnjWRBS8mmvt3u2QXCLiYz8EAMHmG+SwT
         9M7W66FeL/Jkz7xUaNBtEg7ajWReGAfuTdWmutyvE8BItQv8iqsQf4k/ej1ggr0FwyFg
         CRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L0mzpn9Xee7gnES4Hxgx6pxIDY4Ct4c3rhp+/gW36zM=;
        b=Ra3ksdO+hIctD0FDpAQiO2NLFwg+k4iwiKMtZxl09PhrVY0dvTkytb0Cs08Lg4R3vN
         r6WKT4HyR63jFcKYm5I1ZpynS6PbXT/tkmhIqMabSkcqjP0QfqfroFoUDmN9NbjmD43m
         WBWFjC4Jyqgs2NV/1WuscUdtu6jQk0Da+NqDk/46zJ+ughk6FrO+3V6kg7P71YVznRAZ
         mq9XVU+JztCJvJJwVfgg8E/zp0WzUnLMwBCA9SgT6emVZrmv1/bTUDVxx33tzpP//h+b
         P2IvLgO2B/1LzI4q6qG0/9Qo7Gq7tswN8UmPoGhCkZT/5nYM9FtvFYgdoLK2MNOmKoXY
         VZiQ==
X-Gm-Message-State: AG10YOT5UejO4YNFgvg0TmA865XdqtF8pcai+pKbyeWUV6NL8HWvP+znYSppTK5vBvsuymQfflpfXTxRc7WfvQ==
MIME-Version: 1.0
X-Received: by 10.107.198.14 with SMTP id w14mr23019056iof.83.1454342634875;
 Mon, 01 Feb 2016 08:03:54 -0800 (PST)
Received: by 10.79.75.69 with HTTP; Mon, 1 Feb 2016 08:03:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602011150380.15885@tp.orcam.me.uk>
References: <1454010437-29265-1-git-send-email-jeffmerkey@gmail.com>
        <alpine.DEB.2.00.1602011150380.15885@tp.orcam.me.uk>
Date:   Mon, 1 Feb 2016 09:03:54 -0700
Message-ID: <CAO6TR8U1m+7ALr8kbrWp8qkH0NsAVnaj4edyYTfOa+BJ22gDtA@mail.gmail.com>
Subject: Re: [PATCH 21/31] Add debugger entry points for MIPS
From:   Jeff Merkey <linux.mdb@gmail.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Jeffrey Merkey <jeffmerkey@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <linux.mdb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux.mdb@gmail.com
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

On 2/1/16, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Thu, 28 Jan 2016, Jeffrey Merkey wrote:
>
>> This patch series adds an export which can be set by system debuggers to
>> direct the hard lockup and soft lockup detector to trigger a breakpoint
>> exception and enter a debugger if one is active.  It is assumed that if
>> someone sets this variable, then an breakpoint handler of some sort will
>> be actively loaded or registered via the notify die handler chain.
>>
>> This addition is extremely useful for debugging hard and soft lockups
>> real time and quickly from a console debugger.
>
>  What's the intended use case for this hook and what do you call a console
> debugger?
>
>  I'm asking because from the debugging perspective the Linux kernel is a
> bare metal application and for such the BREAK instruction is not the usual
> choice on the MIPS target.  This instruction is normally used for userland
> debugging, it traps to the kernel and is handled there.  Furthermore there
> are a few other applications of this instruction defined as a part of the
> MIPS ABI, also handled by the kernel, determined by the breakpoint code
> embedded with the instruction word, e.g. to trap integer division errors.
> See arch/mips/include/uapi/asm/break.h for the codes defined so far.
>
>  All this means the trap may not be appropriate for debugging the kernel
> itself as you don't want to intercept it or the system won't run
> correctly.  You'd have to hook into the kernel itself to intercept it too.
>
>  But if you do have a working debug environment already set up around this
> arrangement, then it might be fine after all.  In that case I think using
> a non-zero breakpoint code would make sense though, as 0 is often treated
> as a random (spurious) trap (it was used by IRIX though).  Or do you
> detect it by the symbol name somehow?
>
>  I've got a couple of further notes on the patch itself below.
>
>> diff --git a/arch/mips/include/asm/kdebug.h
>> b/arch/mips/include/asm/kdebug.h
>> index 8e3d08e..af5999e 100644
>> --- a/arch/mips/include/asm/kdebug.h
>> +++ b/arch/mips/include/asm/kdebug.h
>> @@ -16,4 +16,16 @@ enum die_val {
>>  	DIE_UPROBE_XOL,
>>  };
>>
>> +
>> +void arch_breakpoint(void)
>> +{
>> +	__asm__ __volatile__(
>> +		".globl breakinst\n\t"
>
>  Please keep formatting consistent -- the rest of code below uses `\t' as
> the separator, so use it here as well.  We don't have an established
> inline assembly formatting style, so please just keep your chosen one
> consistent.
>
>> +		".set\tnoreorder\n\t"
>> +		"nop\n"
>> +		"breakinst:\tbreak\n\t"
>> +		"nop\n\t"
>> +		".set\treorder");
>> +}
>> +
>>  #endif /* _ASM_MIPS_KDEBUG_H */
>
>  Why do you need these NOPs around the breakpoint?  You also need to mark
> `breakinst' as a function symbol (`.aent' might do) or otherwise you'll
> get garbled disassembly if this is built as microMIPS code.
>
>   Maciej
>

You can drop this patch series, I am rethinking a better way to do this.

Jeff
