Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 09:40:01 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:35516 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab0IWHj6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 09:39:58 +0200
Received: by qyk35 with SMTP id 35so7426356qyk.15
        for <multiple recipients>; Thu, 23 Sep 2010 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nES+7llkeG8pq8652Pa6DRmziB5bSY4s5wVMNlH5TAI=;
        b=RY7YOt1TNcRqSLuYdqGMc07tlH9JQ+0Gt7JQtcQEWIIKxWUNqUP3UWQWODRN40TUYI
         d4UaCBtoOE8nsRmip4Rg0kJZWyDRX1FUsjGAUQKYUxVUgN6kgiNip/q4TYjsW5wQZZfd
         zsDielN2tvICQ0hC3PWYKhdopjlIcOiYx8hlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wby6/0Ihak9tIkxCKsgUdUo1WQqVlDryLyVRGLlQgbFLO5Bfip26C4CbZeq+/P5e43
         YrgM915tIOuOfqZ4HBkfyiMucCycNWFOGFPCB0489EoSs0NEPWFhNyDyDn5NXRCY47V3
         osLBzqxpNJeUSs/DRdphrzOs43gyHYBeTkT0s=
MIME-Version: 1.0
Received: by 10.229.215.76 with SMTP id hd12mr1019630qcb.44.1285227591572;
 Thu, 23 Sep 2010 00:39:51 -0700 (PDT)
Received: by 10.229.25.208 with HTTP; Thu, 23 Sep 2010 00:39:51 -0700 (PDT)
In-Reply-To: <20100922122711.GB6392@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
        <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com>
        <20100922122711.GB6392@console-pimps.org>
Date:   Thu, 23 Sep 2010 15:39:51 +0800
Message-ID: <AANLkTinq+2LHgycDGyPgrEfkp3PSYxqagV1TfbjcQTwO@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] MIPS: add support for hardware performance events (skeleton)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18048

2010/9/22 Matt Fleming <matt@console-pimps.org>:
> I'm probably just being stupid but I can't figure out what this snippet
> of code is doing. You're checking to see if the counter has overflowed,
> and if it has then you just clear the overflow bit? I would have
> expected you to reset the counter to 0.
[DC]: Maybe my original code comment for the member msbs of the struct
cpu_hw_events is too simple. And here is more: Unlike the perf counters in
some other architectures, a 32bit MIPS perf counter, for example, will
generate an interrupt after 0x7fffffff. But we want the operation to look
like: 0x0 -> 0xffffffff -> interrupt. So there's a "pseudo" signal halfway.
Please also note that the counter value will be brought back to 0 soon
after it reaches 0x80000000 *each time*.


> Shouldn't you also clear the overflow bit in ->msbs here?
[DC]: See my comment above.


> Having conditional code like this is a pretty sure sign that you haven't
> separated support for the various performance hardware properly. Have
> you had a look at how SH uses a registration interface to register
> sh_pmus?  Ideally all the internals for each type of perfcounter
> hardware should be in their own file.
[DC]: It does look ugly. It should be easy to put conditional code into
perf_event_[mipsxx|loongson2|rm9000].c. I'll post a patch to fix it when
the whole thing is accepted.


> SH also has this problem that it doesn't have any sort of performance
> counter interrupt and so can't check for overflow. This lack of
> interrupt really needs to be solved generically in perf as it's a
> problem that effects quite a few architectures. I suspect that using a
> hrtimer instead of piggy-backing the timer interrupt would make the core
> perf guys happier. Writing support for this is on my ever-growing list
> of things todo. I've already started on some patches for the perf tool
> so that it's possible to sample counters even though there is no
> periodic interrupt (but that's a different problem).
[DC]: Please add me into your post list when your patches are ready :-)
Finally, thanks for your time to review the code.


Deng-Cheng
