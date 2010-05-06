Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 06:23:52 +0200 (CEST)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:59195 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab0EFEXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 06:23:48 +0200
Received: by ywh39 with SMTP id 39so2475488ywh.21
        for <multiple recipients>; Wed, 05 May 2010 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3EwXFyCvzPxal1PAC+I1/kIhIf0nk4AYgkQL9nm6BzA=;
        b=DncThrMtvvIcx0/8d0R8kUowdyeW5G7TI+lwW7tQIwBd5HRQ9RyG4YRfUxCgGbErew
         AIH/Weul+or6naVcpYi5r6EZnJibvEi/cWIo6518MPpfoqg9tbQw9itS2bsOKNR3CB/X
         ImA3eZm3zvWZbp267RiIXXYQPnUHQwsT7cFd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mCAmN0c8KWcEH0smfHSgCbpEuqAaWBCr/HrWDB9FvAoYqp90uEn9EwsHRpDKLBbOgz
         B58FpqQM9CL7dlX/kVX9kXTqxuzNQys7umcAFAqwSH8mVJLXDqqqTP5HamhCe4R78ZCj
         1zLyB7PWg3pPDz0yBnjaqKIJ4xgyHXcIgzsYM=
MIME-Version: 1.0
Received: by 10.150.120.35 with SMTP id s35mr721546ybc.224.1273119820416; Wed, 
        05 May 2010 21:23:40 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Wed, 5 May 2010 21:23:40 -0700 (PDT)
In-Reply-To: <20100505151825.GF5971@wear.picochip.com>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
         <1273067734-4758-5-git-send-email-dengcheng.zhu@gmail.com>
         <20100505151825.GF5971@wear.picochip.com>
Date:   Thu, 6 May 2010 12:23:40 +0800
Message-ID: <j2i1b4d75291005052123n52131b71h41f919c3f11af826@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MIPS: add support for hardware performance events
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Jamie Iles <jamie.iles@picochip.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/5 Jamie Iles <jamie.iles@picochip.com>:
> On Wed, May 05, 2010 at 09:55:34PM +0800, Deng-Cheng Zhu wrote:
>> This patch is the HW perf event support. To enable this feature, we can
>> not choose the SMTC kernel; Oprofile should be disabled; kernel
>> performance events be selected. Then we can enable it in Kernel type menu.
>>
>> Oprofile for MIPS platforms initializes irq at arch init time. Currently
>> we do not change this logic to allow PMU reservation.
>>
>> If a platform has EIC, we can use the irq base and perf counter irq
>> offset defines for the interrupt controller in mipspmu_get_irq().
>>
>> Besides generic hardware events and cache events, raw events are also
>> supported by this patch. Please refer to processor core software user's
>> manual and the comments for mipsxx_pmu_map_raw_event() for more details.
>
> This looks good to me. I'm not familiar with MIPS so I can't offer many
> comments in that respect but as a general question, is there a reason that
> OProfile can't be enabled as well? In ARM we have a method to reserve the PMU
> so that we can build both but only one can run at the same time. Recently,
> Will Deacon has posted a patch series that makes OProfile use perf events
> as the counter backend so you could even use both at the same time.
>
> Jamie
>

Hi, Jamie


Thanks for your review!

Yes, I noticed ARM had a PMU reservation mechanism between Oprofile
and Perf. It's a run-time method (irqs are requested/freed in
start/stop), not an arch init method (requested/freed in init/exit).
And this mechanism is great for sure. But in current MIPS/Oprofile
code, this is done in init/exit. MIPS/Oprofile authors may have
special concerns to do so. So I'm adding Zhangjin and Ralf in the
TO-list, hoping to hear more comments about this. To reduce the risk
introduced by changing this mechanism, I didn't add the PMU
reservation/sharing and placed an extra comment in this patch's
introduction (see above).


Deng-Cheng
