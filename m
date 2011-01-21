Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 10:09:25 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37040 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491769Ab1AUJJW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jan 2011 10:09:22 +0100
Received: by wyf22 with SMTP id 22so1559270wyf.36
        for <multiple recipients>; Fri, 21 Jan 2011 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=swmR9407BeWmXSd/s7Qo+zFIIRyl17UwX3cN32FWOSs=;
        b=I6yXfmQEn13ZZmm7b7ZzrtBhtmYCBvQojcqvlV+k9mUZVGjCdAUNtts0tlTsPmLiFJ
         4QmvhFcWOAGqIVbTnQZft+DKFBxTDbHsmNOaDeTHajBOamJ/5Icnv5UWaNEyHNqmm9ys
         UL33jcKNGIRd38IXdVZeZXLbiyYtUDuEWNPHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SGuWZ/O8TBP0RyoqMETmUk/dG8COWU7zP06CXfmQF9CgGm5N052+3izDfmyIl1Xpij
         /LGBIYuc34mw5xa4oihIhMdYZljwz8Oi324QOscdmMSDdzFQqyBiUe7+dg1m/k/1Daj7
         SLez+ZVjXWhbdJnxA6axBqDwCSi8koRnIk/j4=
MIME-Version: 1.0
Received: by 10.216.164.14 with SMTP id b14mr382532wel.33.1295600957069; Fri,
 21 Jan 2011 01:09:17 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Fri, 21 Jan 2011 01:09:17 -0800 (PST)
In-Reply-To: <1295532278.19789.12.camel@fedora>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
        <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
        <4D381677.3000502@mvista.com>
        <1295532278.19789.12.camel@fedora>
Date:   Fri, 21 Jan 2011 17:09:17 +0800
Message-ID: <AANLkTinRxh9hAKCrLfqLoOOwU8bkun800zEp_8A=ryWx@mail.gmail.com>
Subject: Re: [PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <srostedt@redhat.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2011 at 10:04 PM, Steven Rostedt <srostedt@redhat.com> wrote:
[...]
>> > +
>> > +   insns = (in_kernel_space(self_ra)) ? 2 : (MCOUNT_OFFSET_INSNS + 1);
>>
>>     Unneeded parens.
>
> agreed
>
>>
>> > +   trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
>>
>>     Here too.
>
> I like the parens here. Yes, it is basic math precedence, but it stands
> out to a reviewer who has their brain more focused on correct code than
> thinking about which op has precedence.
>
> Reviewing code that has:
>
>        trace.func = self_ra - MCOUNT_INSN_SIZE * insns;
>
> And as I my mother language reads left to right, my thought process
> goes: subtract MCOUNT_INSN_SIZE from self_ra and then times insns... oh
> wait, times goes first; stop reset, restart... subtract MCOUNT_INSN_SIZE
> times insns from self_ra.  That stop reset and restart of the thought
> process breaks the train of thought and could waste a lot more time than
> just the moment it happened. All this is avoided by the parenthesis that
> automatically trigger the brain to think those go first.
>
> I say, leave these in.

Yeah, agree ;-)

parens have become one important part of my coding style for it have
saved me from being confused by the problems like you mentioned above.

This is similar to using "a=++i" or "i++; a=i;", the latter is longer
but clearer, although If we put them together, the former is also
clear, but If we encounter "a=++i;" and "a=i++;" at the same time, we
may have a headache ;-)

Will resend it asap with your feedback.

Thanks,
Wu Zhangjin

>
> -- Steve
>
>
>
