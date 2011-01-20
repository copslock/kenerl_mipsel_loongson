Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 13:46:29 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:45165 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491197Ab1ATMqZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jan 2011 13:46:25 +0100
Received: by wyf22 with SMTP id 22so578234wyf.36
        for <multiple recipients>; Thu, 20 Jan 2011 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wwT7IWJkVFuzjQfbLtjxjSLUdnV4neaIewoHvH4aPy4=;
        b=WqJqSmGCYDGb4iNDmorSOU6STCwOu5ceTRHg5yz8NFtECFioY5isvKXH6MAvJgz3f0
         JVX8UnmNP8jl8mvrpZtiwHiRNhvdcDz7XE9AiwwWXmgnhnot86bU6gDga1BoGh9UDzlh
         zF50urzjVlaXtn3tuRWYsUerwl02vPMrtkWNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C+GYz4SUDJduy5uPAyRqhptw/LAGn97MyMuRad6MHAH7TJQUhILz9sZxTsKlWKo/d+
         ddoC+qv9le/x2xmtBpo6MAJSSSl7F57Yh8kZ6U9zr25Iqt/mktKkpAjeN/qkmIHcpPHj
         1rC9pWbhVRl6ZriM5Xehc65U7VUO0tq1wrry4=
MIME-Version: 1.0
Received: by 10.216.87.131 with SMTP id y3mr3989195wee.3.1295527580253; Thu,
 20 Jan 2011 04:46:20 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Thu, 20 Jan 2011 04:46:20 -0800 (PST)
In-Reply-To: <4D381677.3000502@mvista.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
        <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
        <4D381677.3000502@mvista.com>
Date:   Thu, 20 Jan 2011 20:46:20 +0800
Message-ID: <AANLkTi=VV7d8F-z2hdPBFTmHPt_YJc_u-NycGizQqhf7@mail.gmail.com>
Subject: Re: [PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2011 at 7:03 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 19-01-2011 22:28, Wu Zhangjin wrote:
>
>> trace.func should be set to the recorded ip of the mcount calling site
>> in the __mcount_loc section to filter the function entries configured
>> through the tracing/set_graph_function interface, but before, this is
>> set to the self_ra(the return address of mcount), which has made
>> set_graph_function not work as expects.
>
>   Expected?

Yeah ;-)

>
>> This fixes it via calculating the right recorded ip in the __mcount_loc
>> section and assign it to trace.func.
>
>> Reported-by: Zhiping Zhong<xzhong86@163.com>
>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>> ---
>>  arch/mips/kernel/ftrace.c |   11 +++++++++--
>>  1 files changed, 9 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
>> index bc91e4a..62775d7 100644
>> --- a/arch/mips/kernel/ftrace.c
>> +++ b/arch/mips/kernel/ftrace.c
>
> [...]
>>
>> @@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long
>> *parent_ra_addr, unsigned long self_ra,
>>                return;
>>        }
>>
>> -       trace.func = self_ra;
>> +       /*
>> +        * Get the recorded ip of the current mcount calling site in the
>> +        * __mcount_loc section, which will be used to filter the function
>> +        * entries configured through the tracing/set_graph_function
>> interface.
>> +        */
>> +
>> +       insns = (in_kernel_space(self_ra)) ? 2 : (MCOUNT_OFFSET_INSNS +
>> 1);
>
>   Unneeded parens.

ok.

>
>> +       trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
>
>   Here too.

ok.

Thanks,
Wu Zhangjin

>
> WBR, Sergei
>
