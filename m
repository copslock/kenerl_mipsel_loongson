Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Apr 2010 03:49:51 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:60665 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492503Ab0DQBts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Apr 2010 03:49:48 +0200
Received: by gwaa12 with SMTP id a12so57334gwa.36
        for <multiple recipients>; Fri, 16 Apr 2010 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=CejXxCE5xrL4YK178BOov5KeV0oJeNG9GFF14a810hI=;
        b=no3n3WfAqD3wTxY3+Jjvpi6zHTFIiavyNPY6hkAbLR6i0J+m8oAFvgSpTlG2HpKrxk
         VIcqUZS1FuHT0tpsMmgpKKFHCyztbmzK28OqKcDqSYe0hOphlTQANbCHv37ksfzV2FUf
         i1NvbS5lOdTnsHcOJ0BE/QXAnOdVp+lt+QtJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DYRs/B+3eRnF6nJoEdsTuHV6E2zUsHYpkCLQk9gFn0BRAWufGhYGuxCI1Ab7YSzr0h
         ZMpEa9GZyJajBuFunTdFrx10f48K4x/fHYMTjAv08sD0DuWf01rVuI3afiBjWCC92hZ1
         qTd+VhM8Q7cG/uGUlArOzsorouFF11YVBSHSM=
MIME-Version: 1.0
Received: by 10.151.42.5 with HTTP; Fri, 16 Apr 2010 18:49:40 -0700 (PDT)
In-Reply-To: <1271353636.20625.99.camel@falcon>
References: <1271349557.7467.424.camel@fun-lab>
         <1271353636.20625.99.camel@falcon>
Date:   Sat, 17 Apr 2010 09:49:40 +0800
Received: by 10.150.117.17 with SMTP id p17mr2354882ybc.305.1271468980290; 
        Fri, 16 Apr 2010 18:49:40 -0700 (PDT)
Message-ID: <u2p1b4d75291004161849z3e9ff5afw8dc64226e82fb1ac@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: implement hardware perf event support
From:   "dengcheng.zhu" <dengcheng.zhu@gmail.com>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Zhangjin


Thanks for your feedback!

2010/4/16 Wu Zhangjin <wuzhangjin@gmail.com>:
> Seems you only copied the contents from
> arch/mips/oprofile/op_model_mipsxx.c and handle the mipsxx, what about
> rm9000(arch/mips/oprofile/op_model_rm9000.c) and
> loongson2(arch/mips/oprofile/op_model_loongson2.c)?
>
> I think it will not work on rm9000 and loongson2 for their performance
> counters are different from mipsxx. so suggest you only enable this for
> mipsxxx(refer to arch/mips/oprofile/Makefile) via #ifdef and renaming
> the current perf_event.c to perf_event_mipsxx.c.
OK, I'll try to move the control/count help functions/defines and the
specific mips_pmu stuff into a file called perf_event_mipsxx.c, and leave
the common things in perf_event.c, so that when we implement Perf for
loongson2 or rm9000, we can simply add new files like
perf_event_loongson2.c.

> And to reduce the source code duplication, perhaps we need a solution to
> share the source code between Oprofile and Perf, and also among mipsxx,
> rm9000 and loongson2.
I think there is almost nothing for the count/control things which can be
shared among mipsxx/rm9000/loongson2. As for sharing between Oprofile and
Perf, how about moving mipsxx/rm9000/loongson2 count/control things into a
new file asm/pmu.h, where we use #ifdef's.


Deng-Cheng
