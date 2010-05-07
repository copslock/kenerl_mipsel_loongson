Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2010 05:12:47 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:64246 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab0EGDMm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 May 2010 05:12:42 +0200
Received: by gyb11 with SMTP id 11so398741gyb.36
        for <multiple recipients>; Thu, 06 May 2010 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cjHROHrQAMq0Ym9a/eBHSbnHVtbJ6wHHwaekC4gYdqM=;
        b=bcCGTe7ppabznh/La7jU6U2dbVg0968HZIsYZBy5kwbeJ/EAMkIdWPJHh0D0tY/UE2
         x7GWwzTyLcZ8wHnl+eyIDZtN66HoBQX3VI9jyBthP5Nixl2p5n34FTQA6E94yP7c+lqk
         Z1WF6yk1VVN72jfTwi/t/kP8ZInXEYCxCoIiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nWH2+hb+qyR5W7jxc/q1xTVuT1TXd3/mrTU8LKT9V7RkxpQAAWj4I1I50oXqNJUvQZ
         9N7/fizpynlqzib1sxpImrJGzbhuqiqdSR9Y7+pT9TKcAUCuPUMejm+4S7UYjrx/5UMM
         HOeP4I9fRT0njp9WQIM5mSuLWlcqtf96rkgk4=
MIME-Version: 1.0
Received: by 10.150.250.42 with SMTP id x42mr2914976ybh.193.1273201955359; 
        Thu, 06 May 2010 20:12:35 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Thu, 6 May 2010 20:12:35 -0700 (PDT)
In-Reply-To: <1273164852.23734.6.camel@localhost>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
         <1273067734-4758-2-git-send-email-dengcheng.zhu@gmail.com>
         <1273162909.23734.4.camel@localhost>
         <1273164852.23734.6.camel@localhost>
Date:   Fri, 7 May 2010 11:12:35 +0800
Message-ID: <l2o1b4d75291005062012hd00ceb1cqe5045ac854212f38@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] MIPS/Oprofile: extract PMU defines/helper 
        functions for sharing
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

>> For we will use the save_perf_irq in the common function:
>> mipspmu_get_irq() of the next patch, so, we need to move the definition
>> of it out of the #if ... and put it before the #if:
>>
>> ...
>> +static int (*save_perf_irq)(void);
>>
>> #if defined(CONFIG_CPU_MIPS32)
>> ...
>
> oh, no, For Oprofile not use it, we can define it before
> mipspmu_get_irq() directly.
>

Thanks for your comments!

Just a correction: op_model_mipsxx.c will also use save_perf_irq. So
when taking your 2nd solution, we need to define another static
save_perf_irq in op_model_mipsxx.c.
